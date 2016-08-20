create or replace PACKAGE p_get_schedule AS
  PROCEDURE for_date(date_input IN VARCHaR2, refc_result_set OUT SYS_REFCURSOR);
  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE, date_input IN VARCHAR2, refc_result_set OUT SYS_REFCURSOR);
  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE, date_input IN VARCHAR2, format_input IN SHOW_TIMES.FORMAT%TYPE, refc_result_set OUT SYS_REFCURSOR);
END p_get_schedule;
/
CREATE OR REPLACE
PACKAGE BODY p_get_schedule AS
  ex_invalid_date_format EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_invalid_date_format, -20001 );
  
  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE,
                      date_input IN VARCHAR2,
                      format_input IN SHOW_TIMES.FORMAT%TYPE,
                      refc_result_set OUT SYS_REFCURSOR) AS
  BEGIN
    IF REGEXP_LIKE (date_input, '^\d{2}-\w{3}-\d{2}$') THEN
      OPEN refc_result_set FOR 
      SELECT SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH12:MI AM') AS "SHOWTIME", CINEMA_HALLS.CATEGORY
      FROM MOVIES JOIN SHOW_TIMES
        ON MOVIES.MOVIEID = SHOW_TIMES.MOVIEID JOIN CINEMA_HALLS
        ON SHOW_TIMES.HALLNO = CINEMA_HALLS.HALLNO
      WHERE TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = date_input
      AND MOVIES.MOVIENAME = movie_name
      AND SHOW_TIMES.FORMAT = format_input
      ORDER BY SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH12:MI AM');
  
    ELSE
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;
  END for_movie;

  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE,
                      date_input IN VARCHAR2,
                      refc_result_set OUT SYS_REFCURSOR) AS
  BEGIN
    IF REGEXP_LIKE (date_input, '^\d{2}-\w{3}-\d{2}$') THEN
      OPEN refc_result_set FOR 
      SELECT SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH12:MI AM') AS "SHOWTIME", SHOW_TIMES.FORMAT, CINEMA_HALLS.CATEGORY
      FROM MOVIES, SHOW_TIMES, CINEMA_HALLS
      WHERE MOVIES.MOVIEID = SHOW_TIMES.MOVIEID 
      AND SHOW_TIMES.HALLNO = CINEMA_HALLS.HALLNO
      AND TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = date_input
      AND MOVIES.MOVIENAME LIKE '%'||movie_name||'%'
      ORDER BY SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH12:MI AM');
    ELSE
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;
  END for_movie;


  PROCEDURE for_date(date_input IN VARCHaR2,
                                refc_result_set OUT SYS_REFCURSOR) AS
    
  BEGIN
    IF REGEXP_LIKE (date_input, '^\d{2}-\w{3}-\d{2}$') THEN
      OPEN refc_result_set FOR
      SELECT SHOW_TIMES.HALLNO, MOVIES.MOVIENAME, SHOW_TIMES.FORMAT, TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'HH12:MM AM') AS "SHOWTIME"
      FROM SHOW_TIMES, MOVIES
      WHERE MOVIES.MOVIEID = SHOW_TIMES.MOVIEID
      AND TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = date_input
      ORDER BY SHOW_TIMES.SHOWDATETIME ASC;
    ELSE
      RAISE_APPLICATION_ERROR( -20001, 'The date inserted is not in the correct format. The correct format is ''DD-MON-YY'' e.g. ''30-JUL-16''.' ); 
    END IF;
  END for_date;
END p_get_schedule;
/

--|| Testing the package ||--
----|| Testing the procedure for_movie with format ||---
SET SERVEROUTPUT ON;
DECLARE
  result_set SYS_REFCURSOR;
  l_hall_no SHOW_TIMES.HALLNO%TYPE;
  l_showtime VARCHAR2(10);
  l_format SHOW_TIMES.FORMAT%TYPE := 2;
  l_category CINEMA_HALLS.HALLNO%TYPE;
BEGIN
      /*SELECT SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH12:MI AM') AS "SHOWTIME"
      FROM MOVIES JOIN SHOW_TIMES
        ON MOVIES.MOVIEID = SHOW_TIMES.MOVIEID
      WHERE TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = '19-AUG-16'
      AND MOVIES.MOVIENAME = 'The Conjuring 2'
      AND SHOW_TIMES.FORMAT = 2
      ORDER BY SHOW_TIMES.SHOWDATETIME;*/
  P_GET_SCHEDULE.FOR_MOVIE( movie_name => 'Zootopia(2016)',
                          date_input => '13-AUG-16',  --Change the date with invalid one or in the wrong format and it will be caught!
                          format_input => 3,
                          refc_result_set => result_set);
  LOOP                      
    FETCH result_set INTO l_hall_no, l_showtime, l_category;
    EXIT WHEN result_set%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Hall No: '|| l_hall_no || ' Showtime: ' || l_showtime || ' Category: ' || l_category);
  END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(sqlerrm );
END;
/

----|| Testing the procedure for_movie ||---
SET SERVEROUTPUT ON;
DECLARE
  result_set SYS_REFCURSOR;
  l_hall_no SHOW_TIMES.HALLNO%TYPE;
  l_showtime VARCHAR2(10);
  l_format SHOW_TIMES.FORMAT%TYPE;
  l_category CINEMA_HALLS.HALLNO%TYPE;
BEGIN
  P_GET_SCHEDULE.FOR_MOVIE( movie_name => 'The Godfather',
                          date_input => '04-AUG-16',  --Change the date with invalid one or in the wrong format and it will be caught!
                          refc_result_set => result_set);
  LOOP                      
    FETCH result_set INTO l_hall_no, l_showtime, l_format, l_category;
    EXIT WHEN result_set%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Hall No: '|| l_hall_no || ' Showtime: ' || l_showtime || ' Format: ' ||l_format||'D ' || 'Category: ' || l_category);
  END LOOP;
  EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(sqlerrm );
END;
/
----|| Testing the procedure for_date ||---
SET SERVEROUTPUT ON;
DECLARE
  l_date_input VARCHAR2(15) := '30-JUL-16' ;--Change the date with invalid one or in the wrong format and it will be caught!
  l_result_set SYS_REFCURSOR;
  l_hall_no SHOW_TIMES.HALLNO%TYPE;
  l_movie_name MOVIES.MOVIENAME%TYPE;
  l_format VARCHAR2(5);
  l_showtime VARCHAR2(10);
BEGIN
  P_GET_SCHEDULE.FOR_DATE(date_input => l_date_input,
                        refc_result_set => l_result_set);
  LOOP
    FETCH l_result_set INTO l_hall_no, l_movie_name, l_format, l_showtime;
    EXIT WHEN l_result_set%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Date: '||l_date_input || ' || Hall no: '|| l_hall_no 
    || ' || Movie name: ' || l_movie_name || ' || Format: ' 
    || l_format || 'D || Showtime: ' || l_showtime);
  END LOOP;
    EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(sqlerrm );
END;
/