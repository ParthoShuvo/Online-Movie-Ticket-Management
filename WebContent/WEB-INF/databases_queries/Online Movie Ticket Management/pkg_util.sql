CREATE OR REPLACE PACKAGE util AS
  PROCEDURE is_time_valid(p_time IN VARCHAR2, p_validity OUT NUMBER);
  PROCEDURE is_date_format_valid(p_date IN VARCHAR2, p_validity OUT NUMBER);
  PROCEDURE is_time_format_valid(p_time IN VARCHAR2, p_validity OUT NUMBER);
  PROCEDURE expn_handle_date_and_time(p_date_in IN VARCHAR2, p_time_in IN VARCHAR2);
  FUNCTION is_the_movie_schedule_valid(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE)
  RETURN NUMBER;
  PROCEDURE expn_validate_schedule_format(movie_name IN MOVIES.MOVIENAME%TYPE,
                                                          show_date IN varchar2,
                                                          show_time IN varchar2,
                                                          movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                                          hall_no IN SHOW_TIMES.HALLNO%TYPE);
END util;
/

CREATE OR REPLACE PACKAGE BODY util AS
 PROCEDURE is_time_valid(p_time IN VARCHAR2, p_validity OUT NUMBER) AS
  BEGIN
    IF REGEXP_LIKE(p_time, '((1[012])|(0[1-9])):\s?[0-5][0-9]\s?((AM)|(PM))|((am)|(pm))') THEN
      p_validity := 1;
    ELSE
      p_validity := 0;
    END IF;
  END is_time_valid;
 PROCEDURE is_date_format_valid(p_date IN VARCHAR2, p_validity OUT NUMBER) AS
 BEGIN
  IF REGEXP_LIKE (p_date, '^\d{2}-\w{3}-\d{2}$') THEN
    p_validity := 1;
  ELSE
    p_validity := 0;
    --RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
  END IF;
 END is_date_format_valid;
 PROCEDURE is_time_format_valid(p_time IN VARCHAR2, p_validity OUT NUMBER) AS
 BEGIN
  IF REGEXP_LIKE (p_time, '^\d{2}:\s{1}\d{2}\s{1}[AP]M$') THEN
    p_validity := 1;
  ELSE
    p_validity := 0;
    --RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
  END IF;
 END is_time_format_valid;
 PROCEDURE expn_handle_date_and_time(p_date_in IN VARCHAR2, p_time_in IN VARCHAR2) AS
  l_date_format_validity NUMBER(1);
  l_time_format_validity NUMBER(1);
  l_time_validity NUMBER(1);
  
  ex_invalid_date_format EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_invalid_date_format, -20001 );
  ex_invalid_time_format EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_invalid_time_format, -20004 );
  ex_invalid_time EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_invalid_time, -20006 );
 BEGIN
  util.is_date_format_valid(p_date => p_date_in, p_validity => l_date_format_validity);
  IF l_date_format_validity = 0 THEN
    RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
  END IF;
  
  util.is_time_format_valid(p_time => p_time_in, p_validity => l_time_format_validity);
  IF l_time_format_validity = 0 THEN
    RAISE_APPLICATION_ERROR( -20004, 'The time inserted is not in the correct format. The correct format is ''HH: MI AM'' e.g. ''11: 40 AM''.' );  
  END IF;
  
  util.is_time_valid(p_time_in, l_time_validity);
  IF l_time_validity = 0 THEN
    RAISE_APPLICATION_ERROR( -20006, 'The time is not valid.' );  
  END IF;
  
 END expn_handle_date_and_time;
 FUNCTION is_the_movie_schedule_valid(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE)
  RETURN NUMBER AS
    l_playing NUMBER(1) := 0;
    l_row_count NUMBER;
  BEGIN
    UTIL.EXPN_HANDLE_DATE_AND_TIME(p_show_date, p_show_time);
    SELECT COUNT(*) INTO l_row_count
      FROM MOVIES JOIN SHOW_TIMES 
        ON MOVIES.MOVIEID = SHOW_TIMES.MOVIEID
      WHERE MOVIES.MOVIENAME = p_movie_name
      AND SHOW_TIMES.HALLNO = p_hall_no
      AND TO_DATE(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = TO_DATE(p_show_date, 'DD-MON-YY')
      AND TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'HH12: MI AM')  = p_show_time
      AND SHOW_TIMES.FORMAT =  p_movie_format;
    
    IF l_row_count >0 THEN
      l_playing := 1;
    ELSE
      l_playing := 0;
    END IF;
    RETURN l_playing;
  END is_the_movie_schedule_valid;
 PROCEDURE expn_validate_schedule_format(movie_name IN MOVIES.MOVIENAME%TYPE,
                                                          show_date IN varchar2,
                                                          show_time IN varchar2,
                                                          movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                                          hall_no IN SHOW_TIMES.HALLNO%TYPE) AS
  ex_invalid_movie_schedule EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_invalid_movie_schedule, -20009 );
  l_result NUMBER(1);
  BEGIN
  --DBMS_OUTPUT.PUT_LINE('Movie-name: '||movie_name || ' show-date: '|| show_date || ' show-time: ' || show_time || 'movie-format: ' || movie_format || ' hall-no: ' || hall_no);
  l_result := is_the_movie_schedule_valid(p_movie_name => movie_name,
                              p_show_date => show_date,
                              p_show_time => show_time,
                              p_movie_format => movie_format,
                              p_hall_no => hall_no);
  
  IF NOT l_result = 1 THEN
    RAISE_APPLICATION_ERROR( -20009, 'There is no such schedule for the movie inserted.' ); 
  END IF;
   EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
  
  END expn_validate_schedule_format;
END util;
/
--|| Testing expn_validate_schedule_format ||--
SET SERVEROUTPUT ON;
BEGIN
  util.expn_validate_schedule_format(movie_name => 'The Godfather',
                                     show_date => '31-JUL-16',
                                     show_time => '11: 40 AM',
                                     movie_format => 2,
                                     hall_no => 6);
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/  

--|| Testing util.expn_handle_date_and_time ||--
SET SERVEROUTPUT ON;
BEGIN
  util.expn_handle_date_and_time(p_date_in => '31-JUL-16', p_time_in => '10: 40 AM');
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

--|| Testing util.is_time_format_valid ||--
SET SERVEROUTPUT ON;
DECLARE
  p_result NUMBER(1);
BEGIN
  util.is_time_format_valid(p_time => '05: 40 PM', p_validity => p_result);
  DBMS_OUTPUT.put_line(p_result);
END;
/
--|| Testing util.is_date_format_valid ||--
SET SERVEROUTPUT ON;
DECLARE
  p_result NUMBER(1);
BEGIN
  util.is_date_format_valid(p_date => '30-JUL-10', p_validity => p_result);
  DBMS_OUTPUT.put_line(p_result);
END;
/
--|| Testing util.is_time_valid ||--
SET SERVEROUTPUT ON;
DECLARE
  l_validity NUMBER;
BEGIN
  util.is_time_valid('21: 40 AM', l_validity);
  IF l_validity = 1 THEN 
    DBMS_OUTPUT.PUT_LINE('Valid');
  ELSIF l_validity = 0 THEN 
    DBMS_OUTPUT.PUT_LINE('Invalid');
  END IF;
END;
/