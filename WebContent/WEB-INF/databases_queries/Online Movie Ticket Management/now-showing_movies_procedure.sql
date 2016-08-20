--## Defining the Procedure ##--

CREATE OR REPLACE
PROCEDURE get_movie_list (v_flag IN MOVIES_IN_THEATER.NOW_PLAYING%TYPE,
                      p_recordset OUT SYS_REFCURSOR) AS
BEGIN
  OPEN p_recordset FOR
    SELECT  MOVIES.MOVIENAME, MOVIES.RELEASEDATE, MOVIES.DURATION, MOVIES.GENRE, MOVIES.MATURITY, MOVIES.SUMMARY, MOVIES.TRAILER, MOVIES.IMAGE
    FROM MOVIES, MOVIES_IN_THEATER
    WHERE MOVIES.MOVIEID = MOVIES_IN_THEATER.MOVIEID
    AND MOVIES_IN_THEATER.NOW_PLAYING = v_flag
    ORDER BY MOVIES.MOVIEID;
END get_movie_list;
/

--## Using the Procedure ##--
SET SERVEROUTPUT ON
DECLARE
  l_flag INTEGER := 1;
  l_cursor  SYS_REFCURSOR;
  --l_movie_id   MOVIES.MOVIEID%TYPE;
  l_movie_id MOVIES.MOVIEID%TYPE;
  l_movie_name   MOVIES.MOVIENAME%TYPE;
  l_movie_releasedate   MOVIES.RELEASEDATE%TYPE;
  l_movie_duration   MOVIES.DURATION%TYPE;
  l_movie_genre   MOVIES.GENRE%TYPE;
  l_movie_maturity   MOVIES.MATURITY%TYPE;
  l_movie_summary   MOVIES.SUMMARY%TYPE;
  l_movie_trailer   MOVIES.TRAILER%TYPE;
  l_movie_image   MOVIES.IMAGE%TYPE;

BEGIN

  IF l_flag = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Up-coming movies are :');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Movies that are being showed in theaters now:');
  END IF;

  get_movie_list (v_flag => l_flag,
              p_recordset => l_cursor);

  LOOP
    FETCH l_cursor INTO  l_movie_id, l_movie_name, l_movie_releasedate, l_movie_duration, l_movie_genre, l_movie_maturity, l_movie_summary, l_movie_trailer, l_movie_image;
    EXIT WHEN l_cursor%NOTFOUND;
    --DBMS_OUTPUT.PUT_LINE('Printing...');
    DBMS_OUTPUT.PUT_LINE(l_movie_name || '(' || l_movie_releasedate || ') ' || l_movie_maturity);
    DBMS_OUTPUT.PUT_LINE('     Duration: ' || l_movie_duration || ' Genre: ' || l_movie_genre);
    DBMS_OUTPUT.PUT_LINE('     Summary: ' || l_movie_summary);
    DBMS_OUTPUT.PUT_LINE('     Trailer ID: ' || l_movie_trailer);
    DBMS_OUTPUT.PUT_LINE('     Poster: ' || l_movie_image);
  END LOOP;
  CLOSE l_cursor;
END;
/


--2>Shuvo my modification of this PROCEDURE
DROP PROCEDURE get_movie_list;

create or replace PROCEDURE get_movie_list (v_flag IN MOVIES_IN_THEATER.NOW_PLAYING%TYPE,
                      p_recordset OUT SYS_REFCURSOR) AS
BEGIN
   IF v_flag = 1 THEN
    OPEN p_recordset FOR
    SELECT M.*, N.FORMAT
    FROM MOVIES M, MOVIES_IN_THEATER T, NOW_SHOWING_MOVIES N
    WHERE M.MOVIEID=T.MOVIEID AND T.MOVIEID = N.MOVIEID AND  T.MOVIEID IN (
      SELECT N.MOVIEID FROM  NOW_SHOWING_MOVIES N)
    ORDER BY M.MOVIEID;
  ELSE
    OPEN p_recordset FOR
    SELECT  M.*
    FROM MOVIES M, MOVIES_IN_THEATER T
    WHERE M.MOVIEID = T.MOVIEID
    AND T.NOW_PLAYING = v_flag
    ORDER BY M.MOVIEID;
  END IF;
END get_movie_list;
/
