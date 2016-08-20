CREATE OR REPLACE PACKAGE about_movies AS
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE)
  RETURN NUMBER;
END about_movies;
/
CREATE OR REPLACE PACKAGE BODY about_movies AS
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
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
      AND SHOW_TIMES.FORMAT = p_movie_format
      AND SHOW_TIMES.HALLNO = p_hall_no
      AND TO_DATE(SHOW_TIMES.SHOWDATETIME, 'DD-MON-YY') = TO_DATE(p_show_date, 'DD-MON-YY')
      AND TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'HH12: MI AM')  = p_show_time
      AND ROWNUM = 1;
    
    IF l_row_count >0 THEN
      l_playing := 1;
    ELSE
      l_playing := 0;
    END IF;
    RETURN l_playing;
  END is_movie_playing;
END about_movies;
/

--|| Testing about_movies.is_movie_playing ||--
SET SERVEROUTPUT ON;
DECLARE
  l_result NUMBER(1);
BEGIN
  l_result := about_movies.is_movie_playing(p_movie_name => 'Zootopia(2016)',
                              p_show_date => '31-JUL-16',
                              p_show_time => '11: 40 AM',
                              p_movie_format => 3,
                              p_hall_no => 1);
  IF l_result = 1 THEN 
    DBMS_OUTPUT.put_line('Playing.');
  ELSE
    DBMS_OUTPUT.put_line('Not Playing.');
  END IF;
   EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/