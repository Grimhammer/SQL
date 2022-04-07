set serveroutput on;
-- create/replace procedure Restaurant_Reservation
CREATE OR REPLACE PROCEDURE Restaurant_Reservation(
-- inputs from user for reservation
last_name       IN varchar2,
party_size      IN number,
res_date_time   IN varchar2)

IS
-- variables for use in function body
party_table         number;
party_time_val      number;
table_max           number;
res_date_begin      date;
res_date_end        date;
res_count           number;
reserved_tables     number;
remaining_tables    number;
reserved_end_time   number;
cust_id             number;

BEGIN
-- set max tables and how many tables the party would use
table_max       := 20;
party_table     := CEIL(party_size/4);
-- assign party_time_val to a number of minutes that fits party size
CASE 
  WHEN party_size < 7 THEN party_time_val := 90;
  WHEN party_size BETWEEN 7 AND 12 THEN party_time_val := 90 + 15*(party_size-6);
  WHEN party_size > 12 THEN party_time_val := 180;
END CASE;
-- set out reservation time start and end using NUMTODSINTERVAL to add
-- party_time_val minutes to the reservation begin date
res_date_begin  := to_date(res_date_time,'DD/MON/YY HH24:MI:SS');
res_date_end    := (res_date_begin + NUMTODSINTERVAL(party_time_val, 'MINUTE'));
-- get the number of reservations during the time
select sum(NO_OF_TABLES) into reserved_tables from rest_res
where res_date_begin 
  NOT BETWEEN start_time AND start_time + NUMTODSINTERVAL(NO_OF_TABLES*4, 'MINUTE') ;

remaining_tables := table_max - reserved_tables;

CASE
  WHEN party_table = 1 THEN dbms_output.put_line('Only 1 table is needed.');
    reserved_tables := reserved_tables + 1;
    select customer_id into cust_id from cust where CUSTOMER_LAST = last_name;
    insert into rest_res
    values (5,cust_id,1,res_date_begin);
    dbms_output.put_line('Your reservation begins ' || res_date_begin);
    dbms_output.put_line('Your reservation ends ' || res_date_end);
  WHEN party_table < remaining_tables THEN 
    dbms_output.put_line('Your reservation is for ' || party_table || ' tables.');
    reserved_tables := reserved_tables + party_table;
    select customer_id into cust_id from cust where CUSTOMER_LAST = last_name;
    insert into rest_res
    values (6,cust_id,1,res_date_begin);
    dbms_output.put_line('Your reservation begins ' || res_date_begin);
    dbms_output.put_line('Your reservation ends ' || res_date_end);
  WHEN party_table > reserved_tables THEN
    dbms_output.put_line('Your reservation for ' || party_table || ' tables ' ||
    'is too large. There are ' || remaining_tables || 
    ' tables available at ' || substr(res_date_time,11,5));
END CASE;

END;

exec Restaurant_Reservation('Farr',13,'09-FEB-21 18:30');

desc cust;
desc rest_res

select * from cust;
select * from rest_res;