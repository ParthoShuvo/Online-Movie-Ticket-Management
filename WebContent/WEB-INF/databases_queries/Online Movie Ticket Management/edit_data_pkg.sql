CREATE OR REPLACE
PACKAGE edit_data AS
  PROCEDURE insert_row(table_name IN VARCHAR2, input_data IN VARCHAR2, new_row OUT SYS_REFCURSOR);
  PROCEDURE get_reflection(p_table_name IN VARCHAR2, p_data IN VARCHAR2, reflected_row OUT SYS_REFCURSOR);
END edit_data;
/

CREATE OR REPLACE
PACKAGE BODY edit_data AS
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
--|| Tresting get_reflection ||--
SET SERVEROUTPUT ON;
DECLARE
  res_row SYS_REFCURSOR;
  l_id CUSTOMERS.CUSTOMERID%TYPE;
  l_name CUSTOMERS.NAME%TYPE;
  l_email CUSTOMERS.EMAILID%TYPE;
  l_phone CUSTOMERS.PHONE%TYPE;
BEGIN
  edit_data.get_reflection(p_table_name => 'CUSTOMERS', p_data => 'auzchowdhury,auzchowdhury@Gmail.com,02557446802', reflected_row => res_row);
  LOOP
    FETCH res_row INTO l_id, l_name, l_email, l_phone;
    EXIT WHEN res_row%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: '||l_id||' | Name: '||l_name||' | Email: '||l_email || ' | Phone: '||l_phone);
  END LOOP;
END;
/
--|| Testing edit_data.insert_row ||--
SET SERVEROUTPUT ON;
DECLARE
  l_new_row SYS_REFCURSOR;
  customer_row CUSTOMERS%ROWTYPE;
BEGIN
  edit_data.insert_row(table_name => 'customers',
                      input_data => 'hbjbddv0,kjs0kvcbj@hh.com, 0488542154',
                      new_row => l_new_row);
  LOOP
    FETCH l_new_row INTO customer_row;
    EXIT WHEN l_new_row%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('ID: '||customer_row.CUSTOMERID || ' Name: ' || customer_row.NAME || ' Email: ' || customer_row.EMAILID || ' Phone: ' || customer_row.PHONE);
  END LOOP;
END;
/