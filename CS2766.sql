drop table driver;

Create table driver
(DRIVER_LICENSE varchar2(6),
Driver_first		varchar2(25),
Driver_last		   varchar2(50),
State_located		varchar2(2));

Insert into driver
Values
('123456','Pamela','Farr','OR');

Insert into driver
Values
('234567','Greta','Murphy','KS');

Insert into driver
Values
('891012','Gayle','Morgan','AZ');

-- function header with name Get_DL_State
create or replace function Get_DL_State 
-- input passed to function
(DL_Number  varchar2)
-- return type of function
RETURN varchar2
-- syntax is magic
IS
-- return variable
driver_state  varchar2(2);
-- begin execution
BEGIN
-- selection the driver state when given a DL#
  select State_located into driver_state from driver
  where DL_Number = DRIVER_LICENSE;
-- return the state
return driver_state;

END;

set serveroutput on;

DECLARE

Drivers_ID    varchar2(6) := '&Drivers_ID';
Drivers_State varchar2(2);

BEGIN

dbms_output.put_line('You are searching for DL# ' || Drivers_ID);
select Get_DL_State(Drivers_ID) into Drivers_State from dual;
dbms_output.put_line('This driver is in ' || Drivers_State);

END;
drop table product;
create table product
(product_id     varchar(12),
product_name    varchar(25),
product_price   decimal(12,5));

insert into product values ('1','Flashlight',5.25);
insert into product values ('2','Paint Brush',10.50);
insert into product values ('3','Paint',21.35);

-- function header with name Calc_State_Tax
create or replace function Calc_State_Tax 
-- input passed to function
(state_code   varchar2,
 prod_id      varchar2)
-- return type of function
RETURN decimal
-- syntax is magic
IS
-- return variables
final_cost  decimal(12,5);
tax_rate    decimal(12,5);
-- begin execution
BEGIN
-- selection the product price
  select product_price into final_cost from product
  where product_id = prod_id;
-- case to assign tax rate based on state
CASE
  WHEN state_code = 'WA' THEN tax_rate := 1.05;
    dbms_output.put_line('Your tax rate is ' || (tax_rate - 1) || '%');
  WHEN state_code = 'OR' THEN tax_rate := 1.08;
    dbms_output.put_line('Your tax rate is ' || (tax_rate - 1) || '%');
  WHEN state_code = 'CA' THEN tax_rate := 1.10;
    dbms_output.put_line('Your tax rate is ' || (tax_rate - 1) || '%');
END CASE;
-- calculate final cost, return, and display
final_cost := final_cost * tax_rate;
dbms_output.put_line('Your final cost is ' || final_cost);
return final_cost;

END;

set serveroutput on;
-- anonymous block used for calling function
DECLARE
-- varaibles for passing into function and assignment
State_Ind    varchar2(2) := '&State_Ind';
product      varchar2(2) := '&product';
total_cost   decimal(12,5);

BEGIN
-- output what we're calculating, where, and call Calc_State_Tax function.  
dbms_output.put_line('You are searching for product ' || product || ' in state '
                     || State_Ind);
select Calc_State_Tax(State_Ind,product) into total_cost from dual;

END;
