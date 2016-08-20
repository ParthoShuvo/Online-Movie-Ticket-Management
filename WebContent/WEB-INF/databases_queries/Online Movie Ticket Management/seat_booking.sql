CREATE OR REPLACE
PACKAGE seat_booking AS
  PROCEDURE get_booked_seats ( p_movie_name IN MOVIES.MOVIENAME%TYPE, 
                p_format IN NOW_SHOWING_MOVIES.FORMAT%TYPE, p_show_date IN VARCHAR2, p_show_time IN VARCHAR2, p_seat_numbers OUT SYS_REFCURSOR);
  PROCEDURE get_booked_seats_with_prices( hall_no IN CINEMA_HALLS.HALLNO%TYPE, p_show_date IN VARCHAR2,
                             p_show_time IN VARCHAR2, p_format IN TICKET_PRICES.FORMAT%TYPE, seat_numbers_with_price OUT SYS_REFCURSOR);
  PROCEDURE is_hall_full(p_show_date IN VARCHAR2, p_show_time IN VARCHAR2, p_hall_no IN VARCHAR2, p_housefull OUT NUMBER);
  PROCEDURE is_seat_available(p_show_date IN VARCHAR2,
                            p_show_time IN VARCHAR2,
                            p_hall_no IN BOOKED_SEATS.HALLNO%TYPE,
                            p_seat_no IN BOOKED_SEATS.SEATNO%TYPE,
                            p_availability OUT NUMBER);
  PROCEDURE are_seats_available(show_date IN VARCHAR2,
                            show_time IN VARCHAR2,
                            hall_no IN BOOKED_SEATS.HALLNO%TYPE,
                            seat_no_list VARCHAR2,
                            availability OUT NUMBER,
                            already_booked_seats OUT VARCHAR2);
  PROCEDURE get_ticket_price(p_hall_no IN CINEMA_HALLS.HALLNO%TYPE, p_format IN TICKET_PRICES.FORMAT%TYPE, p_ticket_price OUT TICKET_PRICES.PRICE%TYPE);
END seat_booking;
/
CREATE OR REPLACE
PACKAGE BODY seat_booking AS
  
  PROCEDURE get_hall_no (p_movie_name_input IN MOVIES.MOVIENAME%TYPE, 
                p_format_input IN NOW_SHOWING_MOVIES.FORMAT%TYPE, 
                p_show_date_input IN VARCHAR2, p_show_time_input IN VARCHAR2, 
                p_hall_no_ouput OUT CINEMA_HALLS.HALLNO%TYPE)AS
  BEGIN
    SELECT st.HALLNO
    INTO p_hall_no_ouput
    FROM SHOW_TIMES st, MOVIES m
    WHERE  m.MOVIENAME = p_movie_name_input
    AND m.MOVIEID = st.MOVIEID
    AND st.FORMAT = p_format_input
    AND TO_CHAR(st.SHOWDATETIME, 'DD-MON-YY') = p_show_date_input
    AND TO_CHAR(st.SHOWDATETIME, 'HH12: MI AM') = p_show_time_input;
  END get_hall_no;
  PROCEDURE get_booked_seats_for_hn_n_t( hall_no IN CINEMA_HALLS.HALLNO%TYPE, show_date IN VARCHAR2,
                             show_time IN VARCHAR2, seat_numbers OUT SYS_REFCURSOR) AS
  BEGIN
    OPEN seat_numbers FOR
    SELECT SEATNO
    FROM BOOKED_SEATS
    WHERE TO_DATE(SHOWDATETIME) = TO_DATE(show_date)
    AND TO_CHAR(SHOWDATETIME, 'HH12: MI AM') = show_time
    AND HALLNO = hall_no
    ORDER BY SEATNO;
  END get_booked_seats_for_hn_n_t;
  PROCEDURE get_booked_seats ( p_movie_name IN MOVIES.MOVIENAME%TYPE, 
                p_format IN NOW_SHOWING_MOVIES.FORMAT%TYPE, p_show_date IN VARCHAR2, p_show_time IN VARCHAR2, p_seat_numbers OUT SYS_REFCURSOR) AS
    l_hall_no CINEMA_HALLS.HALLNO%TYPE;
    ex_invalid_time_format EXCEPTION;
    PRAGMA EXCEPTION_INIT( ex_invalid_time_format, -20001 );
  BEGIN
    IF NOT REGEXP_LIKE (p_show_time, '^\d{2}:\s{1}\d{2}\s{1}[AP]M$') THEN
      RAISE_APPLICATION_ERROR( -20004, 'The time inserted is not in the correct format. The correct format is ''HH: MI AM'' e.g. ''11: 40 AM''.' ); 
    END IF;
    IF NOT REGEXP_LIKE (p_show_date, '^\d{2}-\w{3}-\d{2}$') THEN
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;  
    seat_booking.get_hall_no (p_movie_name_input => p_movie_name, 
                            p_format_input => p_format, 
                            p_show_date_input => p_show_date, 
                            p_show_time_input => p_show_time, 
                            p_hall_no_ouput => l_hall_no);
    get_booked_seats_for_hn_n_t(hall_no => l_hall_no, 
                                    show_date => p_show_date,
                                    show_time => p_show_time,
                                    seat_numbers => p_seat_numbers);
  END get_booked_seats;
  PROCEDURE get_booked_seats_with_prices( hall_no IN CINEMA_HALLS.HALLNO%TYPE, p_show_date IN VARCHAR2,
                             p_show_time IN VARCHAR2, p_format IN TICKET_PRICES.FORMAT%TYPE, seat_numbers_with_price OUT SYS_REFCURSOR) AS
  BEGIN
    IF NOT REGEXP_LIKE (p_show_time, '^\d{2}:\s{1}\d{2}\s{1}[AP]M$') THEN
      RAISE_APPLICATION_ERROR( -20004, 'The time inserted is not in the correct format. The correct format is ''HH: MI AM'' e.g. ''11: 40 AM''.' ); 
    END IF;
    IF NOT REGEXP_LIKE (p_show_date, '^\d{2}-\w{3}-\d{2}$') THEN
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;
    OPEN seat_numbers_with_price FOR
    SELECT bs.SEATNO, tp.PRICE
      FROM BOOKED_SEATS bs
      JOIN CINEMA_HALLS ch 
          ON bs.HALLNO = ch.HALLNO
      JOIN TICKET_PRICES tp 
          ON ch.CATEGORY= tp.CATEGORY
      WHERE TO_DATE(bs.SHOWDATETIME) = TO_DATE(p_show_date)
      AND TO_CHAR(bs.SHOWDATETIME, 'HH12: MI AM') = p_show_time
      AND bs.HALLNO = hall_no
      AND tp.FORMAT = p_format
      /*GROUP BY bs.SEATNO, tp.PRICE, tp.FORMAT
      HAVING COUNT(*) = 1
      ORDER BY bs.SEATNO*/;
  END get_booked_seats_with_prices;
  PROCEDURE is_hall_full(p_show_date IN VARCHAR2, p_show_time IN VARCHAR2, p_hall_no IN VARCHAR2, p_housefull OUT NUMBER)
  AS
   l_valid_time NUMBER;
   l_number_of_booked_seats NUMBER;
   l_capacity_of_hall CINEMA_HALLS.CAPACITY%TYPE;
   /*ex_invalid_time EXCEPTION;
   PRAGMA EXCEPTION_INIT( ex_invalid_time, -20001 );*/
  BEGIN
    IF NOT REGEXP_LIKE (p_show_time, '^\d{2}:\s{1}\d{2}\s{1}[AP]M$') THEN
      RAISE_APPLICATION_ERROR( -20004, 'The time inserted is not in the correct format. The correct format is ''HH: MI AM'' e.g. ''11: 40 AM''.' ); 
    END IF;
    IF NOT REGEXP_LIKE (p_show_date, '^\d{2}-\w{3}-\d{2}$') THEN
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;
    util.is_time_valid(p_show_time, l_valid_time);
    IF l_valid_time = 0 THEN 
      RAISE_APPLICATION_ERROR( -20006, 'The time is not valid.' ); 
    END IF;
    SELECT CAPACITY INTO l_capacity_of_hall
      FROM CINEMA_HALLS
      WHERE HALLNO = p_hall_no;
    SELECT COUNT(*) INTO l_number_of_booked_seats
      FROM BOOKED_SEATS 
      WHERE HALLNO = p_hall_no
      AND TO_CHAR(SHOWDATETIME, 'DD-MON-YY') = p_show_date
      AND TO_CHAR(SHOWDATETIME, 'HH12: MI AM') = p_show_time;
    IF l_capacity_of_hall = l_number_of_booked_seats THEN
      p_housefull := 1;
    ELSE 
      p_housefull := 0;
    END IF;
  END is_hall_full;
  PROCEDURE is_seat_available(p_show_date IN VARCHAR2,
                            p_show_time IN VARCHAR2,
                            p_hall_no IN BOOKED_SEATS.HALLNO%TYPE,
                            p_seat_no IN BOOKED_SEATS.SEATNO%TYPE,
                            p_availability OUT NUMBER) AS
    no_of_rows NUMBER;
  BEGIN
      util.expn_handle_date_and_time(p_date_in => p_show_date, p_time_in => p_show_time);
      SELECT COUNT(*) INTO no_of_rows
        FROM BOOKED_SEATS
        WHERE SEATNO = p_seat_no
        AND TO_CHAR(SHOWDATETIME, 'DD-MON-YY') = TO_DATE(p_show_date, 'DD-MON-YY')
        AND TO_CHAR(SHOWDATETIME, 'HH12: MI AM') = p_show_time
        AND HALLNO = p_hall_no;
      IF no_of_rows<1 THEN
        p_availability := 1;
      ELSE
        p_availability := 0;
      END IF;
  END is_seat_available;
  PROCEDURE are_seats_available(show_date IN VARCHAR2,
                                show_time IN VARCHAR2,
                                hall_no IN BOOKED_SEATS.HALLNO%TYPE,
                                seat_no_list VARCHAR2,
                                availability OUT NUMBER,
                                already_booked_seats OUT VARCHAR2) AS
     seats_array apex_application_global.vc_arr2;
     t_availablity NUMBER(1);
  BEGIN
    availability := 1;
    already_booked_seats := '';
    seats_array := apex_util.string_to_table(seat_no_list, ',');
    FOR i IN 1..seats_array.COUNT
    LOOP
      is_seat_available(p_show_date => show_date,
                        p_show_time => show_time,
                        p_hall_no => hall_no,
                        p_seat_no => seats_array(i),
                        p_availability => t_availablity);
      IF t_availablity = 0 THEN
        availability := 0;
        already_booked_seats := already_booked_seats || ' ' ||seats_array(i);
      END IF;
    END LOOP;
  END are_seats_available;
  PROCEDURE get_ticket_price(p_hall_no IN CINEMA_HALLS.HALLNO%TYPE, p_format IN TICKET_PRICES.FORMAT%TYPE, p_ticket_price OUT TICKET_PRICES.PRICE%TYPE)AS
  BEGIN
    SELECT TICKET_PRICES.PRICE INTO p_ticket_price
      FROM CINEMA_HALLS JOIN TICKET_PRICES
        ON CINEMA_HALLS.CATEGORY = TICKET_PRICES.CATEGORY
      WHERE CINEMA_HALLS.HALLNO = p_hall_no
      AND TICKET_PRICES.FORMAT = p_format;
  END get_ticket_price;
END seat_booking;
/
--|| Testing get_ticket_price ||--
SET SERVEROUTPUT ON;
DECLARE
  l_ticket_price TICKET_PRICES.PRICE%TYPE;
BEGIN
  seat_booking.get_ticket_price(p_hall_no => 1,
                   p_format => 3, 
                   p_ticket_price => l_ticket_price 
                   );
  DBMS_OUTPUT.put_line('Price: '||l_ticket_price);
END;
/
--|| Testing are_seats_availabe ||--
SET SERVEROUTPUT ON;
DECLARE
  l_avaibility NUMBER(2);
  l_bad_seats VARCHAR2(300);
  p_seat_list VARCHAR2(300) := 'LA01,LA02,LA03,LA04';
BEGIN
  seat_booking.are_seats_available(show_date => '31-JUL-16',
                      show_time => '11: 40 AM',
                      hall_no => 6,
                      seat_no_list => p_seat_list,
                      availability => l_avaibility,
                      already_booked_seats => l_bad_seats);
  DBMS_OUTPUT.put_line('Seats you queried for:'||chr(10)||p_seat_list);
  IF l_avaibility = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Available');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Not available.'||chr(10)||'Seats that were already booked:'||chr(10)||l_bad_seats);
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
--|| Testing is_seat_availabe ||--
SET SERVEROUTPUT ON;
DECLARE
  l_avaibility NUMBER(2);
BEGIN
  seat_booking.is_seat_available(p_show_date => '31-JUL-16',
                    p_show_time => '05: 00 PM',
                    p_hall_no => 5,
                    p_seat_no => 'LB34',
                    p_availability => l_avaibility);
  IF l_avaibility = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Available');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Not available');
  END IF;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
--|| Testing is_hall_full ||--
SET SERVEROUTPUT ON;
DECLARE
  l_hosefull NUMBER(1);
BEGIN
  seat_booking.is_hall_full(p_show_date => '31-JUL-16',
                    p_show_time => '11: 40 AM',
                    p_hall_no => 6, --|<-- Enter hallNo: 6 to experiment with a hall which has no available seats. Otherwise enter 1. -->|--
                    p_housefull => l_hosefull);
  IF l_hosefull = 1 THEN
    DBMS_OUTPUT.PUT_LINE('Full');
  ELSIF l_hosefull = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Not Full');
  END IF;
END;
/
--|| Testing the get_booked_seats_with_prices ||--
SET SERVEROUTPUT ON;
DECLARE
  rc_seats_prices SYS_REFCURSOR;
  l_seat_no BOOKED_SEATS.SEATNO%TYPE;
  l_price TICKET_PRICES.PRICE%TYPE;
  l_format TICKET_PRICES.FORMAT%TYPE := 3;
BEGIN
  seat_booking.get_booked_seats_with_prices(hall_no => 01,
                              p_show_date => '31-JUL-16',
                              p_show_time => '11: 40 AM',
                              p_format => l_format,
                              seat_numbers_with_price => rc_seats_prices);
  LOOP
    FETCH rc_seats_prices INTO l_seat_no, l_price;
    EXIT WHEN rc_seats_prices%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE('Seat-no: ' || l_seat_no || ' | Price: ' || l_price);
    DBMS_OUTPUT.PUT_LINE('Seat-no: ' || l_seat_no || ' | Price: ' || l_price || ' | Format: ' || l_format);
  END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(sqlerrm );
END;
/
--|| Test get_booked_seats||--
SET SERVEROUTPUT ON;
DECLARE
  l_booked_seats SYS_REFCURSOR;
  seat_no VARCHAR2(4);
BEGIN
  seat_booking.get_booked_seats(p_movie_name => 'Zootopia(2016)', 
                                p_format => 3,
                                p_show_date => '31-JUL-16',
                                p_show_time => '11: 40 AM',
                                p_seat_numbers => l_booked_seats);
  LOOP
    FETCH l_booked_seats INTO seat_no;
    EXIT WHEN l_booked_seats%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Seat no: '||seat_no);
  END LOOP;
END;
/