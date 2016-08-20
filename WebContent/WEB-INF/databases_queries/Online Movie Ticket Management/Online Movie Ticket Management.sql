SET SERVEROUTPUT ON
DECLARE
 cursor_test SYS_REFCURSOR;
 movie_name MOVIES.MOVIENAME%TYPE;
 movie_image MOVIES.IMAGE%TYPE;
 movie_trailer MOVIES.TRAILER%TYPE;
BEGIN
  cursor_test := GET_LATEST_MOVIE_TRAILERS(); 
  LOOP
    FETCH cursor_test INTO movie_name, movie_image, movie_trailer;
    EXIT WHEN cursor_test%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(movie_name || ' ' || movie_image || ' ' || movie_trailer);
  END LOOP;
  CLOSE cursor_test;
END;
/