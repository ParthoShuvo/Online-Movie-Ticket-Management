--------------------------------------------------------
--  File created - Saturday-August-20-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SEQ_CUSTOMERS_ID
--------------------------------------------------------

   CREATE SEQUENCE  "MOVIE"."SEQ_CUSTOMERS_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1080 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SEQ_PURCHASE_ID
--------------------------------------------------------

   CREATE SEQUENCE  "MOVIE"."SEQ_PURCHASE_ID"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 180 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOOKED_SEATS
--------------------------------------------------------

  CREATE TABLE "MOVIE"."BOOKED_SEATS" 
   (	"SEATNO" VARCHAR2(30 BYTE), 
	"SHOWDATETIME" DATE, 
	"HALLNO" NUMBER(2,0), 
	"PURCHASEID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CINEMA_HALLS
--------------------------------------------------------

  CREATE TABLE "MOVIE"."CINEMA_HALLS" 
   (	"HALLNO" NUMBER(2,0), 
	"CAPACITY" NUMBER(3,0), 
	"UPPER_SEATS" NUMBER(3,0), 
	"LOWER_SEATS" NUMBER(4,0), 
	"CATEGORY" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table CUSTOMERS
--------------------------------------------------------

  CREATE TABLE "MOVIE"."CUSTOMERS" 
   (	"CUSTOMERID" NUMBER(*,0), 
	"NAME" VARCHAR2(100 BYTE), 
	"EMAILID" VARCHAR2(100 BYTE), 
	"PHONE" VARCHAR2(11 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MOVIES
--------------------------------------------------------

  CREATE TABLE "MOVIE"."MOVIES" 
   (	"MOVIEID" NUMBER(*,0), 
	"MOVIENAME" VARCHAR2(100 BYTE), 
	"RELEASEDATE" DATE, 
	"DURATION" NUMBER(3,0), 
	"GENRE" NUMBER(2,0), 
	"MATURITY" VARCHAR2(6 BYTE), 
	"SUMMARY" VARCHAR2(1000 BYTE), 
	"TRAILER" VARCHAR2(100 BYTE), 
	"IMAGE" VARCHAR2(30 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table MOVIES_IN_THEATER
--------------------------------------------------------

  CREATE TABLE "MOVIE"."MOVIES_IN_THEATER" 
   (	"MOVIEID" NUMBER(*,0), 
	"PREMEREDATE" DATE, 
	"NOW_PLAYING" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table NOW_SHOWING_MOVIES
--------------------------------------------------------

  CREATE TABLE "MOVIE"."NOW_SHOWING_MOVIES" 
   (	"MOVIEID" NUMBER(*,0), 
	"FORMAT" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table PURCHASE_TICKETS
--------------------------------------------------------

  CREATE TABLE "MOVIE"."PURCHASE_TICKETS" 
   (	"PURCHASEID" NUMBER(*,0), 
	"CUSTOMERID" NUMBER(*,0), 
	"SHOWDATETIME" DATE, 
	"HALLNO" NUMBER(2,0), 
	"CATEGORY" NUMBER(1,0), 
	"FORMAT" NUMBER(1,0), 
	"TOTALTICKETS" NUMBER(*,0), 
	"TOTALCOST" FLOAT(126), 
	"PURCHASEDATE" DATE, 
	"MOVIEID" NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table SHOW_TIMES
--------------------------------------------------------

  CREATE TABLE "MOVIE"."SHOW_TIMES" 
   (	"SHOWDATETIME" DATE, 
	"HALLNO" NUMBER(2,0), 
	"MOVIEID" NUMBER(*,0), 
	"FORMAT" NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table TICKET_PRICES
--------------------------------------------------------

  CREATE TABLE "MOVIE"."TICKET_PRICES" 
   (	"CATEGORY" NUMBER(1,0), 
	"FORMAT" NUMBER(1,0), 
	"PRICE" FLOAT(126)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_TICKET_PRICES
--------------------------------------------------------

  CREATE UNIQUE INDEX "MOVIE"."PK_TICKET_PRICES" ON "MOVIE"."TICKET_PRICES" ("CATEGORY", "FORMAT") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_NOW_SHOWING_MOVIES
--------------------------------------------------------

  CREATE UNIQUE INDEX "MOVIE"."PK_NOW_SHOWING_MOVIES" ON "MOVIE"."NOW_SHOWING_MOVIES" ("MOVIEID", "FORMAT") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_PERBOOKED_SEATS
--------------------------------------------------------

  CREATE UNIQUE INDEX "MOVIE"."PK_PERBOOKED_SEATS" ON "MOVIE"."BOOKED_SEATS" ("SEATNO", "SHOWDATETIME", "HALLNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_SHOW_TIMES
--------------------------------------------------------

  CREATE UNIQUE INDEX "MOVIE"."PK_SHOW_TIMES" ON "MOVIE"."SHOW_TIMES" ("SHOWDATETIME", "HALLNO") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table MOVIES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."MOVIES" ADD UNIQUE ("IMAGE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."MOVIES" ADD UNIQUE ("TRAILER")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."MOVIES" ADD PRIMARY KEY ("MOVIEID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."MOVIES" MODIFY ("MATURITY" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."MOVIES" MODIFY ("GENRE" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."MOVIES" MODIFY ("DURATION" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."MOVIES" MODIFY ("RELEASEDATE" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."MOVIES" MODIFY ("MOVIENAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table NOW_SHOWING_MOVIES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."NOW_SHOWING_MOVIES" ADD CONSTRAINT "PK_NOW_SHOWING_MOVIES" PRIMARY KEY ("MOVIEID", "FORMAT")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."NOW_SHOWING_MOVIES" MODIFY ("FORMAT" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."NOW_SHOWING_MOVIES" MODIFY ("MOVIEID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table SHOW_TIMES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."SHOW_TIMES" ADD CONSTRAINT "PK_SHOW_TIMES" PRIMARY KEY ("SHOWDATETIME", "HALLNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."SHOW_TIMES" MODIFY ("FORMAT" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."SHOW_TIMES" MODIFY ("MOVIEID" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."SHOW_TIMES" MODIFY ("HALLNO" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."SHOW_TIMES" MODIFY ("SHOWDATETIME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CUSTOMERS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."CUSTOMERS" ADD UNIQUE ("PHONE")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."CUSTOMERS" ADD UNIQUE ("EMAILID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."CUSTOMERS" ADD PRIMARY KEY ("CUSTOMERID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."CUSTOMERS" MODIFY ("PHONE" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."CUSTOMERS" MODIFY ("EMAILID" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."CUSTOMERS" MODIFY ("NAME" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PURCHASE_TICKETS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" ADD PRIMARY KEY ("PURCHASEID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("PURCHASEDATE" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("TOTALCOST" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("TOTALTICKETS" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("FORMAT" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("HALLNO" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("SHOWDATETIME" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" MODIFY ("CUSTOMERID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table CINEMA_HALLS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."CINEMA_HALLS" ADD PRIMARY KEY ("HALLNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."CINEMA_HALLS" MODIFY ("CATEGORY" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."CINEMA_HALLS" MODIFY ("LOWER_SEATS" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."CINEMA_HALLS" MODIFY ("UPPER_SEATS" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."CINEMA_HALLS" MODIFY ("CAPACITY" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BOOKED_SEATS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."BOOKED_SEATS" ADD CONSTRAINT "PK_PERBOOKED_SEATS" PRIMARY KEY ("SEATNO", "SHOWDATETIME", "HALLNO")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."BOOKED_SEATS" MODIFY ("PURCHASEID" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."BOOKED_SEATS" MODIFY ("HALLNO" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."BOOKED_SEATS" MODIFY ("SHOWDATETIME" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."BOOKED_SEATS" MODIFY ("SEATNO" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table MOVIES_IN_THEATER
--------------------------------------------------------

  ALTER TABLE "MOVIE"."MOVIES_IN_THEATER" ADD PRIMARY KEY ("MOVIEID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."MOVIES_IN_THEATER" MODIFY ("NOW_PLAYING" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table TICKET_PRICES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."TICKET_PRICES" ADD CONSTRAINT "PK_TICKET_PRICES" PRIMARY KEY ("CATEGORY", "FORMAT")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
  ALTER TABLE "MOVIE"."TICKET_PRICES" MODIFY ("PRICE" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."TICKET_PRICES" MODIFY ("FORMAT" NOT NULL ENABLE);
  ALTER TABLE "MOVIE"."TICKET_PRICES" MODIFY ("CATEGORY" NOT NULL ENABLE);
--------------------------------------------------------
--  Ref Constraints for Table BOOKED_SEATS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."BOOKED_SEATS" ADD CONSTRAINT "FK_PER1BOOKED_SEATS" FOREIGN KEY ("SHOWDATETIME", "HALLNO")
	  REFERENCES "MOVIE"."SHOW_TIMES" ("SHOWDATETIME", "HALLNO") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MOVIE"."BOOKED_SEATS" ADD CONSTRAINT "FK_PERBOOKED_SEATS" FOREIGN KEY ("PURCHASEID")
	  REFERENCES "MOVIE"."PURCHASE_TICKETS" ("PURCHASEID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table MOVIES_IN_THEATER
--------------------------------------------------------

  ALTER TABLE "MOVIE"."MOVIES_IN_THEATER" ADD CONSTRAINT "FK_PERMOVIES_IN_THEATERS" FOREIGN KEY ("MOVIEID")
	  REFERENCES "MOVIE"."MOVIES" ("MOVIEID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table NOW_SHOWING_MOVIES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."NOW_SHOWING_MOVIES" ADD CONSTRAINT "FK_PERNOW_SHOWING_MOVIES" FOREIGN KEY ("MOVIEID")
	  REFERENCES "MOVIE"."MOVIES_IN_THEATER" ("MOVIEID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table PURCHASE_TICKETS
--------------------------------------------------------

  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" ADD CONSTRAINT "FK_PER1PURCHASE_TICKETS" FOREIGN KEY ("SHOWDATETIME", "HALLNO")
	  REFERENCES "MOVIE"."SHOW_TIMES" ("SHOWDATETIME", "HALLNO") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" ADD CONSTRAINT "FK_PER2PURCHASE_TICKETS" FOREIGN KEY ("CATEGORY", "FORMAT")
	  REFERENCES "MOVIE"."TICKET_PRICES" ("CATEGORY", "FORMAT") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" ADD CONSTRAINT "FK_PERPURCHASE_TICKETS" FOREIGN KEY ("CUSTOMERID")
	  REFERENCES "MOVIE"."CUSTOMERS" ("CUSTOMERID") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MOVIE"."PURCHASE_TICKETS" ADD CONSTRAINT "PURCHASE_TICKETS_MOVIENAME_FK" FOREIGN KEY ("MOVIEID")
	  REFERENCES "MOVIE"."MOVIES" ("MOVIEID") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table SHOW_TIMES
--------------------------------------------------------

  ALTER TABLE "MOVIE"."SHOW_TIMES" ADD CONSTRAINT "FK_PER1SHOW_TIMES" FOREIGN KEY ("HALLNO")
	  REFERENCES "MOVIE"."CINEMA_HALLS" ("HALLNO") ON DELETE CASCADE ENABLE;
  ALTER TABLE "MOVIE"."SHOW_TIMES" ADD CONSTRAINT "FK_PERSHOW_TIMES" FOREIGN KEY ("MOVIEID", "FORMAT")
	  REFERENCES "MOVIE"."NOW_SHOWING_MOVIES" ("MOVIEID", "FORMAT") ON DELETE CASCADE ENABLE;
--------------------------------------------------------
--  DDL for Trigger CINEMAHALLNO_GENERATE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MOVIE"."CINEMAHALLNO_GENERATE_TRIGGER" 
BEFORE INSERT ON CINEMA_HALLS
FOR EACH ROW
DECLARE
  cnt NUMBER;
  next NUMBER;
BEGIN
  SELECT COUNT(HALLNO) INTO cnt from CINEMA_HALLS;
  IF cnt > 0 AND cnt < 20 THEN
    SELECT MAX(HALLNO) INTO NEXT FROM CINEMA_HALLS;
    next:=next+1;
    :new.HALLNO:=next;
  ELSIF cnt = 0 THEN
    :new.HALLNO:=1;
  end if;
  end;
/
ALTER TRIGGER "MOVIE"."CINEMAHALLNO_GENERATE_TRIGGER" DISABLE;
--------------------------------------------------------
--  DDL for Trigger CUSTOMERID_GENERATE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MOVIE"."CUSTOMERID_GENERATE_TRIGGER" 
BEFORE INSERT ON CUSTOMERS
FOR EACH ROW
DECLARE
  cnt INTEGER;
  next INTEGER;
BEGIN
  SELECT COUNT(customerId) INTO cnt from CUSTOMERS;
  IF cnt > 0 THEN
    SELECT MAX(customerId) INTO NEXT FROM CUSTOMERS;
    next:=next+1;
    :new.customerId:=next;
  else
    :new.customerId:=1;
  end if;
  end;
/
ALTER TRIGGER "MOVIE"."CUSTOMERID_GENERATE_TRIGGER" DISABLE;
--------------------------------------------------------
--  DDL for Trigger MOVIEID_GENERATE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MOVIE"."MOVIEID_GENERATE_TRIGGER" 
BEFORE INSERT ON MOVIES
FOR EACH ROW
DECLARE
  cnt INTEGER;
  next INTEGER;
BEGIN
  SELECT COUNT(movieId) INTO cnt from MOVIES;
  IF cnt > 0 THEN
    SELECT MAX(movieId) INTO NEXT FROM MOVIES;
    next:=next+1;
    :new.movieId:=next;
  else
    :new.movieId:=1;
  end if;
  end;
/
ALTER TRIGGER "MOVIE"."MOVIEID_GENERATE_TRIGGER" DISABLE;
--------------------------------------------------------
--  DDL for Trigger PURCHASEID_GENERATE_TRIGGER
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "MOVIE"."PURCHASEID_GENERATE_TRIGGER" 
BEFORE INSERT ON PURCHASE_TICKETS
FOR EACH ROW
DECLARE
  cnt INTEGER;
  next INTEGER;
BEGIN
  SELECT COUNT(PURCHASEID) INTO cnt from PURCHASE_TICKETS;
  IF cnt > 0 THEN
    SELECT MAX(PURCHASEID) INTO NEXT FROM PURCHASE_TICKETS;
    next:=next+1;
    :new.PURCHASEID:=next;
  else
    :new.PURCHASEID:=1;
  end if;
  end;
/
ALTER TRIGGER "MOVIE"."PURCHASEID_GENERATE_TRIGGER" DISABLE;
--------------------------------------------------------
--  DDL for Function CUSTOM_HASH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "MOVIE"."CUSTOM_HASH" (p_username in varchar2, p_password in varchar2)
return varchar2
is
  l_password varchar2(4000);
  l_salt varchar2(4000) := 'I9V48SDUTY466SR1O484B8AWYF39R3';
begin

-- This function should be wrapped, as the hash algorhythm is exposed here.
-- You can change the value of l_salt or the method of which to call the
-- DBMS_OBFUSCATOIN toolkit, but you much reset all of your passwords
-- if you choose to do this.

l_password := utl_raw.cast_to_raw(dbms_obfuscation_toolkit.md5
  (input_string => p_password || substr(l_salt,10,13) || p_username ||
    substr(l_salt, 4,10)));
return l_password;
end;

/
--------------------------------------------------------
--  DDL for Function GET_LATEST_MOVIE_TRAILERS
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "MOVIE"."GET_LATEST_MOVIE_TRAILERS" 
RETURN SYS_REFCURSOR IS
trailer_cursor SYS_REFCURSOR;
BEGIN
  OPEN trailer_cursor FOR SELECT M.MOVIENAME, M.TRAILER, M.IMAGE FROM MOVIES M, MOVIES_IN_THEATER T WHERE M.MOVIEID = T.MOVIEID AND ( T.MOVIEID IN (
  SELECT DISTINCT N.MOVIEID FROM NOW_SHOWING_MOVIES N) OR T.NOW_PLAYING = 0);
  RETURN trailer_cursor;
END;

/
--------------------------------------------------------
--  DDL for Package ABOUT_MOVIES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."ABOUT_MOVIES" AS
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                          p_show_date IN VARCHAR2,
                                          p_show_time IN VARCHAR2,
                                          p_hall_no IN SHOW_TIMES.HALLNO%TYPE)
  RETURN NUMBER;
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE)
  RETURN NUMBER;
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE,
                                            p_category IN CINEMA_HALLS.CATEGORY%TYPE
                                            )
  RETURN NUMBER;

END about_movies;

/
--------------------------------------------------------
--  DDL for Package EDIT_DATA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."EDIT_DATA" AS
  PROCEDURE insert_row(table_name IN VARCHAR2, input_data IN VARCHAR2, new_row OUT SYS_REFCURSOR);
  PROCEDURE get_reflection(p_table_name IN VARCHAR2, p_data IN VARCHAR2, reflected_row OUT SYS_REFCURSOR);
END edit_data;

/
--------------------------------------------------------
--  DDL for Package P_GET_SCHEDULE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."P_GET_SCHEDULE" AS
  PROCEDURE for_date(date_input IN VARCHaR2, refc_result_set OUT SYS_REFCURSOR);
  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE, date_input IN VARCHAR2, refc_result_set OUT SYS_REFCURSOR);
  PROCEDURE for_movie(movie_name IN MOVIES.MOVIENAME%TYPE, date_input IN VARCHAR2, format_input IN SHOW_TIMES.FORMAT%TYPE, refc_result_set OUT SYS_REFCURSOR);
END p_get_schedule;

/
--------------------------------------------------------
--  DDL for Package SEARCH_MOVIES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."SEARCH_MOVIES" AS
  PROCEDURE get_movies (search_key IN VARCHAR2, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
  PROCEDURE get_movies (search_key IN NUMBER, key_type IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
  PROCEDURE get_movies (search_key IN VARCHAR2, c_movie_list OUT SYS_REFCURSOR);
END search_movies;

/
--------------------------------------------------------
--  DDL for Package SEAT_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."SEAT_BOOKING" AS
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
  PROCEDURE book_seats( cust_data IN VARCHAR2,
                        seats_list IN VARCHAR2,
                        show_date IN VARCHAR2,
                        show_time IN VARCHAR2,
                        hall_no BOOKED_SEATS.HALLNO%TYPE,
                        movie_name IN MOVIES.MOVIENAME%TYPE,
                        movie_format IN PURCHASE_TICKETS.FORMAT%TYPE,
                        p_new_purchase_id OUT PURCHASE_TICKETS.CUSTOMERID%TYPE);
END seat_booking;

/
--------------------------------------------------------
--  DDL for Package UTIL
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "MOVIE"."UTIL" AS
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
--------------------------------------------------------
--  DDL for Package Body ABOUT_MOVIES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."ABOUT_MOVIES" AS
  FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                          p_show_date IN VARCHAR2,
                                          p_show_time IN VARCHAR2,
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
    AND TO_CHAR(SHOW_TIMES.SHOWDATETIME, 'HH12: MI AM')  = p_show_time;

  IF l_row_count >0 THEN
    l_playing := 1;
  ELSE
    l_playing := 0;
  END IF;
  RETURN l_playing;
END is_movie_playing;
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
   FUNCTION is_movie_playing(p_movie_name IN MOVIES.MOVIENAME%TYPE,
                                            p_show_date IN VARCHAR2,
                                            p_show_time IN VARCHAR2,
                                            p_movie_format IN SHOW_TIMES.FORMAT%TYPE,
                                            p_hall_no IN SHOW_TIMES.HALLNO%TYPE,
                                            p_category IN CINEMA_HALLS.CATEGORY%TYPE
                                            )
  RETURN NUMBER AS
    l_playing NUMBER(1) := 0;
    l_row_count NUMBER;
  BEGIN
    UTIL.EXPN_HANDLE_DATE_AND_TIME(p_show_date, p_show_time);
    SELECT COUNT(*) INTO l_row_count
      FROM MOVIES JOIN SHOW_TIMES 
        ON MOVIES.MOVIEID = SHOW_TIMES.MOVIEID JOIN CINEMA_HALLS
        ON SHOW_TIMES.HALLNO = CINEMA_HALLS.HALLNO
      WHERE MOVIES.MOVIENAME = p_movie_name
      AND SHOW_TIMES.FORMAT = p_movie_format
      AND SHOW_TIMES.HALLNO = p_hall_no
      AND CINEMA_HALLS.CATEGORY = p_category
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
--------------------------------------------------------
--  DDL for Package Body EDIT_DATA
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."EDIT_DATA" AS
  PROCEDURE verify_customer_data(customer_data IN VARCHAR2)AS
  l_num_of_required_columns NUMBER(2) := 3;
  ex_not_enough_CUSTOMERS_data EXCEPTION;
  PRAGMA EXCEPTION_INIT( ex_not_enough_CUSTOMERS_data, -20007 );
BEGIN
  IF NOT REGEXP_COUNT(customer_data, ',') = l_num_of_required_columns-1 THEN
    /*DBMS_OUTPUT.PUT_LINE('Ok');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Not ok');*/
    RAISE_APPLICATION_ERROR( -20007, 'There is more or less than enough data for inserting into CUSTOMERS table.' );  
  END IF;
END verify_customer_data;
  PROCEDURE insert_row(table_name IN VARCHAR2, input_data IN VARCHAR2,
                       new_row OUT SYS_REFCURSOR) AS
    data_array apex_application_global.vc_arr2;
    new_pk NUMBER;
  BEGIN
    data_array := apex_util.string_to_table(input_data, ',');
    IF table_name = 'CUSTOMERS' OR table_name = 'customers' THEN
      verify_customer_data(customer_data => input_data);
      INSERT INTO CUSTOMERS(CUSTOMERID, NAME, EMAILID, PHONE)
      VALUES (SEQ_CUSTOMERS_ID.NEXTVAL, data_array(1), data_array(2), data_array(3))
      RETURNING CUSTOMERID INTO new_pk;
      OPEN new_row FOR SELECT * FROM CUSTOMERS WHERE CUSTOMERID = new_pk;
    ELSIF table_name = 'PURCHASE_TICKETS' OR table_name = 'purchase_tickets' THEN
      INSERT INTO PURCHASE_TICKETS(PURCHASEID, CUSTOMERID, SHOWDATETIME, HALLNO, CATEGORY, FORMAT, TOTALTICKETS, TOTALCOST, PURCHASEDATE, MOVIEID)
      VALUES (SEQ_PURCHASE_ID.NEXTVAL, data_array(1), TO_DATE(data_array(2), 'DD-MON-YYYY HH24:MI:SS'), data_array(3), data_array(4), data_array(5), data_array(6), data_array(7), TO_DATE(data_array(8), 'DD-MON-YYYY HH24:MI:SS'), data_array(9))
      RETURNING PURCHASEID INTO new_pk;
      OPEN new_row FOR SELECT * FROM PURCHASE_TICKETS WHERE PURCHASEID = new_pk;
    ELSIF table_name = 'BOOKED_SEATS' OR table_name = 'booked_seats' THEN
      INSERT INTO BOOKED_SEATS(SEATNO, SHOWDATETIME, HALLNO, PURCHASEID)
      VALUES (data_array(1), TO_DATE(data_array(2), 'DD-MON-YYYY HH24:MI:SS'), data_array(3), data_array(4))
      RETURNING PURCHASEID INTO new_pk;
      OPEN new_row FOR SELECT * FROM BOOKED_SEATS WHERE PURCHASEID = new_pk;
    END IF;
  END insert_row;
  PROCEDURE get_reflection(p_table_name IN VARCHAR2, p_data IN VARCHAR2, reflected_row OUT SYS_REFCURSOR)
  AS 
  data_array apex_application_global.vc_arr2;
    new_pk NUMBER;
    num_of_rows_found NUMBER := 0;
  BEGIN
    verify_customer_data(customer_data => p_data);
    data_array := apex_util.string_to_table(p_data, ',');
    IF p_table_name = 'CUSTOMERS' OR p_table_name = 'customers' THEN
      SELECT COUNT(*) INTO num_of_rows_found
        FROM CUSTOMERS 
        WHERE EMAILID = data_array(2)
        OR PHONE = data_array(3);
        --DBMS_OUTPUT.put_line(num_of_rows_found);
        IF num_of_rows_found > 0 THEN
          OPEN reflected_row FOR
            SELECT *
              FROM CUSTOMERS 
              WHERE EMAILID = data_array(2)
              OR PHONE = data_array(3);
        ELSE
          edit_data.insert_row(table_name => p_table_name,
                      input_data => p_data,
                      new_row => reflected_row);
        END IF;
      END IF;
  END get_reflection;
END edit_data;

/
--------------------------------------------------------
--  DDL for Package Body P_GET_SCHEDULE
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."P_GET_SCHEDULE" AS
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
      ORDER BY SHOW_TIMES.HALLNO, TO_CHAR(SHOW_TIMES.SHOWDATETIME , 'HH24:MI AM');
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
--------------------------------------------------------
--  DDL for Package Body SEARCH_MOVIES
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."SEARCH_MOVIES" AS
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
--------------------------------------------------------
--  DDL for Package Body SEAT_BOOKING
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."SEAT_BOOKING" AS
  
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
      ORDER BY SUBSTR(bs.SEATNO, 3, 1), TO_NUMBER(SUBSTR(bs.SEATNO, 4), '999') ASC
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
  PROCEDURE book_seats(cust_data IN VARCHAR2,
                                      seats_list IN VARCHAR2,
                                      show_date IN VARCHAR2,
                                      show_time IN VARCHAR2,
                                      hall_no BOOKED_SEATS.HALLNO%TYPE,
                                      movie_name IN MOVIES.MOVIENAME%TYPE,
                                      movie_format IN PURCHASE_TICKETS.FORMAT%TYPE,
                                      p_new_purchase_id OUT PURCHASE_TICKETS.CUSTOMERID%TYPE)AS
    ex_bad_attempt_to_book_seats EXCEPTION;
    PRAGMA EXCEPTION_INIT( ex_bad_attempt_to_book_seats, -20008 );
    temp_new_purchase_ID PURCHASE_TICKETS.PURCHASEID%TYPE;
    l_all_seats_available NUMBER(1);
    l_today_date DATE := SYSDATE;
    l_cust_res_row SYS_REFCURSOR;
    l_cust_row CUSTOMERS%ROWTYPE;
    new_purchase_ticket SYS_REFCURSOR;
    l_booked_seats_cs SYS_REFCURSOR;
    l_unavailable_seats VARCHAR2(250);
    l_purchase_tkt_row PURCHASE_TICKETS%ROWTYPE;
    l_category PURCHASE_TICKETS.CATEGORY%TYPE;
    l_ticket_price TICKET_PRICES.PRICE%TYPE; 
    l_total_cost NUMBER := 0;
    l_num_of_seats NUMBER;
    l_purchase_ticket_data VARCHAR2(500);
    l_booked_seats_data VARCHAR2(200);
    l_movie_id MOVIES.MOVIEID%TYPE;
    seat_array apex_application_global.vc_arr2;
    l_schedule_valid NUMBER(1);
  BEGIN
    --| Verify if the schedule is valid |--
    l_schedule_valid := util.is_the_movie_schedule_valid(p_movie_name => movie_name,
                                                    p_show_date => TO_DATE(show_date, 'DD-MON-YY'),
                                                    p_show_time => show_time,
                                                    p_movie_format => movie_format,
                                                    p_hall_no => hall_no);
  
  IF NOT l_schedule_valid = 1 THEN
    RAISE_APPLICATION_ERROR( -20009, 'There is no such schedule for the movie inserted.' ); 
  ELSE
    --DBMS_OUTPUT.PUT_LINE('Schedule-valid.');
    --| Verify if the selected seats are available ||--
    seat_booking.are_seats_available(show_date => TO_DATE(show_date, 'DD-MON-YY'),
                      show_time => show_time,
                      hall_no => hall_no,
                      seat_no_list => seats_list,
                      availability => l_all_seats_available,
                      already_booked_seats => l_unavailable_seats);
    IF l_all_seats_available = 1 THEN
        --DBMS_OUTPUT.PUT_LINE('Seats-valid.');
        --| Collecting moive_id |--
        SELECT MOVIES.MOVIEID INTO l_movie_id FROM MOVIES WHERE MOVIES.MOVIENAME = movie_name; 
        DBMS_OUTPUT.PUT_LINE('Movie-id: ' || l_movie_id);
        --| Fetching CUSTOMERID |--
        edit_data.get_reflection(p_table_name => 'CUSTOMERS', p_data => cust_data, reflected_row => l_cust_res_row);
        FETCH l_cust_res_row INTO l_cust_row;
        --| Fetching CATEGORY |--
        SELECT CATEGORY INTO l_category
        FROM CINEMA_HALLS WHERE HALLNO = hall_no;
        --| Fetching TOTALTICKETS |--
        l_num_of_seats := REGEXP_COUNT(seats_list, ',')+1;
        --| Calculating TOTALCOST |--
        seat_array := apex_util.string_to_table(seats_list, ',');
        FOR i IN 1..seat_array.COUNT
        LOOP
          seat_booking.get_ticket_price(p_hall_no => hall_no,
                       p_format => movie_format, 
                       p_ticket_price => l_ticket_price);
          l_total_cost := l_total_cost +  l_ticket_price;
        END LOOP;
        l_purchase_ticket_data := l_cust_row.customerId||','||TO_CHAR(TO_DATE(show_date|| ' ' ||show_time, 'DD-MON-YYYY HH12:MI AM'), 'DD-MON-YYYY HH24:MI:SS')
        ||','||hall_no||','||l_category||','||movie_format||','||l_num_of_seats||','||l_total_cost||','||TO_CHAR(l_today_date, 'DD-MON-YYYY HH24:MI:SS')||','||l_movie_id;
        edit_data.insert_row(table_name => 'PURCHASE_TICKETS',
                  input_data => l_purchase_ticket_data,
                  new_row => new_purchase_ticket);
        --| Getting the PURCHASE_TICKETS.PURCHASEID |--
        FETCH new_purchase_ticket INTO l_purchase_tkt_row;
        seat_array := apex_util.string_to_table(seats_list, ',');
        FOR i IN 1..seat_array.COUNT
        LOOP
          l_booked_seats_data := seat_array(i)||','||TO_CHAR(TO_DATE(show_date|| ' ' ||show_time, 'DD-MON-YYYY HH12:MI AM'), 'DD-MON-YYYY HH24:MI:SS')
          ||','||hall_no||','||l_purchase_tkt_row.PURCHASEID;
          edit_data.insert_row(table_name => 'BOOKED_SEATS',
                    input_data => l_booked_seats_data,
                    new_row => l_booked_seats_cs);
          --new_purchase_ticket := l_purchase_tkt;
        END LOOP;
        --| Preparing the newly entered row to be returned |--
        temp_new_purchase_ID := l_purchase_tkt_row.PURCHASEID;
        --DBMS_OUTPUT.PUT_LINE('New ID: '||temp_new_purchase_ID);
        p_new_purchase_id := temp_new_purchase_ID;
        
    ELSE
      RAISE_APPLICATION_ERROR( -20007, 'Illegal attempt to reserve seats since one or all of the selected seats are already reserved.' );
      p_new_purchase_id := 0;
    END IF;
  END IF;
                                     
    
  END book_seats;
END seat_booking;

/
--------------------------------------------------------
--  DDL for Package Body UTIL
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE BODY "MOVIE"."UTIL" AS
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
--------------------------------------------------------
--  DDL for Procedure GET_MOVIE_INFO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "MOVIE"."GET_MOVIE_INFO" (movie_name IN MOVIES.MOVIENAME%TYPE, p_recordset OUT SYS_REFCURSOR) AS
BEGIN
    OPEN p_recordset FOR 
    SELECT M.* 
    FROM MOVIES M
    WHERE M.MOVIENAME = movie_name AND 
    ROWNUM = 1;
END get_movie_info;

/
--------------------------------------------------------
--  DDL for Procedure GET_MOVIE_LIST
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "MOVIE"."GET_MOVIE_LIST" (v_flag IN MOVIES_IN_THEATER.NOW_PLAYING%TYPE,
                      p_recordset OUT SYS_REFCURSOR) AS
BEGIN
   IF v_flag = 1 THEN
    OPEN p_recordset FOR 
    SELECT M.* 
    FROM MOVIES M, MOVIES_IN_THEATER T
    WHERE M.MOVIEID=T.MOVIEID AND T.MOVIEID IN (
      SELECT DISTINCT N.MOVIEID FROM NOW_SHOWING_MOVIES N)
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
