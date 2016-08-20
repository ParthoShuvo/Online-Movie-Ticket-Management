--|| Package Specification:
CREATE OR REPLACE PACKAGE search_movies AS
  PROCEDURE get_movies (search_key IN VARCHAR2, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
  PROCEDURE get_movies (search_key IN NUMBER, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
  PROCEDURE get_movies (search_key IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
END search_movies;
/
--|| Body of the Package
CREATE OR REPLACE PACKAGE BODY search_movies AS
  l_statement VARCHAR2(255);
  ex_search_key_can_not_be_null EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_search_key_can_not_be_null, -20002);
  ex_r_yr_cn_nt_be_lss_thn_1990 EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_r_yr_cn_nt_be_lss_thn_1990, -20003);
  PROCEDURE get_movies(search_key IN VARCHAR2, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR) AS
  BEGIN  
    IF search_key IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Search-key can not be NULL.');
    END IF;
    l_statement := 'SELECT MOVIES.MOVIENAME, MOVIES.RELEASEDATE, MOVIES.DURATION, MOVIES.GENRE, MOVIES.MATURITY, MOVIES.SUMMARY, MOVIES.TRAILER, MOVIES.IMAGE FROM MOVIES';
    IF  key_type = 'release-date' THEN 
      IF TO_DATE(search_key) < TO_DATE('01-JAN-1990') THEN
        RAISE_APPLICATION_ERROR(-20003, 'The release-year can not be less than 1900.');
      END IF;
      l_statement := l_statement || ' WHERE MOVIES.RELEASEDATE = ''' || search_key || '''';
    ELSIF key_type = 'maturity' THEN 
      l_statement := l_statement || ' WHERE MOVIES.MATURITY = ''' || search_key || '''';
    END IF;
    OPEN c_movie_list FOR l_statement;
  END get_movies;

  PROCEDURE get_movies(search_key IN NUMBER, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR) AS
  BEGIN
    IF search_key IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Search-key can not be NULL.');
    END IF;
    l_statement := 'SELECT MOVIES.MOVIENAME, MOVIES.RELEASEDATE, MOVIES.DURATION, MOVIES.GENRE, MOVIES.MATURITY, MOVIES.SUMMARY, MOVIES.TRAILER, MOVIES.IMAGE FROM MOVIES';

    IF key_type = 'genre' THEN 
    l_statement := l_statement || ' WHERE MOVIES.GENRE = ' || search_key;
    ELSIF key_type = 'release-year' THEN
      IF search_key < 1900 THEN
        RAISE_APPLICATION_ERROR(-20003, 'The release-year can not be less than 1900.');
      END IF;
      l_statement := l_statement || ' WHERE to_char(RELEASEDATE, ''YYYY'') = ' || search_key;
    END IF;

    OPEN c_movie_list FOR l_statement;
  END get_movies;
  
  PROCEDURE get_movies (search_key IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR) AS
      keys_array apex_application_global.vc_arr2;
      l_statement VARCHAR2(500) := 'SELECT MOVIES.MOVIENAME, MOVIES.RELEASEDATE, MOVIES.DURATION, MOVIES.GENRE, MOVIES.MATURITY, MOVIES.SUMMARY, MOVIES.TRAILER, MOVIES.IMAGE FROM MOVIES';
    BEGIN
      IF search_key IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Search-key can not be NULL.');
      END IF;
    
      keys_array := apex_util.string_to_table(search_key, ' ');
      FOR i IN 1..keys_array.count
      LOOP
        IF i = 1 THEN
          l_statement := l_statement || ' WHERE' || ' MOVIENAME LIKE ''%'|| keys_array(i) ||'%''';
        ELSE
          l_statement := l_statement || ' OR ' || ' MOVIENAME LIKE ''%'|| keys_array(i) ||'%''';
        END IF;
      END LOOP;
      OPEN c_movie_list FOR l_statement;
 END get_movies; 
END search_movies;
/





SET SERVEROUTPUT ON
DECLARE
  l_cursor  SYS_REFCURSOR;
  l_movie_name   MOVIES.MOVIENAME%TYPE;
  l_movie_releasedate   MOVIES.RELEASEDATE%TYPE;
  l_movie_duration   MOVIES.DURATION%TYPE;
  l_movie_genre   MOVIES.GENRE%TYPE;
  l_movie_maturity   MOVIES.MATURITY%TYPE;
  l_movie_summary   MOVIES.SUMMARY%TYPE;
  l_movie_trailer   MOVIES.TRAILER%TYPE;
  l_movie_image   MOVIES.IMAGE%TYPE;


BEGIN
  
  --search_movies.GET_MOVIES( search_key => 1, key_type => 'genre', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => 'PG-13', key_type => 'maturity', c_movie_list => l_cursor);
  search_movies.GET_MOVIES( search_key => '04-MAR-16', key_type => 'release-date', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => 1972, key_type => 'release-year', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => 'god father', c_movie_list => l_cursor);
  --|| TESTING the Exception-Handling ||--
  --search_movies.GET_MOVIES( search_key => '', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => '', key_type => 'maturity', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => '04-MAR-1816', key_type => 'release-date', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => 1872, key_type => 'release-year', c_movie_list => l_cursor);
  --search_movies.GET_MOVIES( search_key => 'god father', c_movie_list => l_cursor);          
  LOOP 
    FETCH l_cursor INTO  l_movie_name, l_movie_releasedate, l_movie_duration, l_movie_genre, l_movie_maturity, l_movie_summary, l_movie_trailer, l_movie_image;
    
    --FETCH l_cursor INTO  l_movie_name;
        
    EXIT WHEN l_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(l_movie_name || '(' || l_movie_releasedate || ') ' || l_movie_maturity);
    DBMS_OUTPUT.PUT_LINE('     Duration: ' || l_movie_duration || ' Genre: ' || l_movie_genre);
    DBMS_OUTPUT.PUT_LINE('     Summary: ' || l_movie_summary);
    DBMS_OUTPUT.PUT_LINE('     Trailer ID: ' || l_movie_trailer);
    DBMS_OUTPUT.PUT_LINE('     Poster: ' || l_movie_image);
  END LOOP;
  CLOSE l_cursor;
END;
/