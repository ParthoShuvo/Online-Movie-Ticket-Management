--1>Trigger for AUTO INCREMENT MOVIES TABLE
CREATE OR REPLACE TRIGGER movieId_generate_trigger
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


--2>Trigger for AUTO INCREMENT CUSTOMER TABLE
CREATE OR REPLACE TRIGGER customerId_generate_trigger
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

--3> Trigger for AUTO INCREMENT PURCHASE_TICKETS TABLE
CREATE OR REPLACE TRIGGER purchaseId_generate_trigger
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

--4>Trigger for AUTO INCREMENT CINEMA_HALLS TABLE
CREATE OR REPLACE TRIGGER cinemaHallNo_generate_trigger
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

--5>
