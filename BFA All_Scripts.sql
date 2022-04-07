set worksheetname BFA_Allscripts;

drop table VISITOR cascade constraints;
drop table EMPLOYEE cascade constraints;
drop table BIWEEKLY_SCHEDULE cascade constraints;
drop table MASTER_SCHEDULE cascade constraints;
drop table SHOP cascade constraints;
drop table ROSTER cascade constraints;
drop table RESERVATION cascade constraints;
drop table PRODUCT cascade constraints;
drop table GUEST_HOUSE cascade constraints;
drop table HOUSE_ROTATION cascade constraints;
drop table RENTAL cascade constraints;
drop table VISITOR_ORDER cascade constraints;
drop table LINE_ITEM cascade constraints;
drop table PAYCHECK cascade constraints;
drop table PAYROLL cascade constraints;
drop table INVENTORY cascade constraints;

commit;

create table EMPLOYEE (
Employee_ID      number  primary key,
Employee_Lname   varchar2(25),
Employee_Fname   varchar2(20),
Employee_Type    varchar2(20),
Vow_of_Silence   varchar2(1),
emp_hourly_rate  number
);

create table BIWEEKLY_SCHEDULE (
Biweekly_ID         number  primary key,
FK_Schedule_ID      number,
FK_Employee_ID      number,
BWS_Start_Date      date,
BWS_End_Date        date,
Hours_Per_Schedule  number   
);

create table MASTER_SCHEDULE (
Schedule_ID     number  primary key,
Duty_Type       varchar2(15)
);

create table PAYCHECK (
Paycheck_ID      number  primary key,
FK_Payroll_ID    number,
FK_Employee_ID   number,
Begin_Pay_Date   date,
End_Pay_Date     date
);

create table PAYROLL (
Payroll_ID           number  primary key,
Begin_Pay_Period     date,
End_Pay_Period       date
);

create table HOUSE_ROTATION (
Rotation_ID           number  primary key,
FK_Guesthouse_ID      number,
FK_Employee_ID        number,
Rotation_Start_Date   date,
Rotation_End_Date     date
);

create table GUEST_HOUSE (
Guesthouse_ID           number  primary key,
Guesthouse_Rental_Cost  number,
Room_1                  number,
Room_2                  number,
Room_3                  number,
Room_4                  number
);

create table INVENTORY (
Inventory_ID      number  primary key,
FK_Product_ID     number,
FK_Shop_ID        number,
Product_Count     number
);

-- ask about this
create table PRODUCT (
Product_ID              number  primary key,
Product_Cost            number,
Product_Name            varchar2(50),
Prod_Delivery_Interval  number,
Prod_Delivery_Day       date
);

create table SHOP (
Shop_ID           number  primary key,
Shop_Type         varchar2(15),
Shop_Name         varchar2(30)
);

-- ask about structure of roster as mediator table
create table ROSTER (
Roster_ID         number  primary key,
FK_Employee_ID    number,
FK_Shop_ID        number,
Roster_Decription varchar2(25)
);

create table LINE_ITEM (
Line_Item_ID     number  primary key,
FK_Inventory_ID  number,
FK_Order_ID      number
);

create table VISITOR (
Visitor_ID        number  primary key,
Visitor_Fname     varchar2(20),
Visitor_Lname     varchar2(25),
Visitor_Address   varchar2(25),
Visitor_Phone     varchar2(20)
);

create table RENTAL (
Rental_ID           number  primary key,
FK_Visitor_ID       number,
FK_Guesthouse_ID    number,
Booked_Room_Num     number,
Rental_Start_Date   date,
Rental_End_Date     date
);

create table RESERVATION (
Reservation_ID          number  primary key,
FK_Visitor_ID           number,
FK_Shop_ID              number,
Guest_Total             number,
Reservation_Start_Time  date,
Reservation_End_Time    date,
Reservation_Cost        number
);

create table VISITOR_ORDER (
Order_ID        number  primary key,
FK_Visitor_ID   number
);

commit;

commit;

alter table BIWEEKLY_SCHEDULE
add constraint FK_biw_emp
foreign key (FK_Employee_ID)
references EMPLOYEE(Employee_ID);

alter table PAYCHECK
add constraint FK_paycheck_emp
foreign key (FK_Employee_ID)
references EMPLOYEE(Employee_ID);

alter table PAYCHECK
add constraint FK_payroll_payc
foreign key (FK_Payroll_ID)
references PAYROLL(Payroll_ID);

alter table HOUSE_ROTATION
add constraint FK_rota_employee
foreign key (FK_Employee_ID)
references EMPLOYEE(Employee_ID);

alter table HOUSE_ROTATION
add constraint FK_guest_house_rotation
foreign key (FK_Guesthouse_ID)
references GUEST_HOUSE(Guesthouse_ID);

alter table ROSTER
add constraint fk_employee_roster
foreign key (FK_Employee_ID)
references EMPLOYEE(Employee_ID);

alter table ROSTER
add constraint FK_shop_roster
foreign key (FK_Shop_ID)
references SHOP(Shop_ID);

alter table RESERVATION
add constraint FK_restaraunt_reservation
foreign key (FK_Shop_ID)
references SHOP(Shop_ID);

alter table INVENTORY
add constraint FK_shop_inventory
foreign key (FK_Shop_ID)
references SHOP(Shop_ID);

alter table LINE_ITEM
add constraint FK_line_order
foreign key (FK_Order_ID)
references VISITOR_ORDER(Order_ID);

alter table VISITOR_ORDER
add constraint FK_visitor_order
foreign key (FK_Visitor_ID)
references VISITOR(Visitor_ID);

alter table RESERVATION
add constraint FK_visitor_reservation
foreign key (FK_Visitor_ID)
references VISITOR(Visitor_ID);

alter table RENTAL
add constraint FK_visitor_rental
foreign key (FK_Visitor_ID)
references VISITOR(Visitor_ID);

alter table RENTAL
add constraint FK_guest_house_rental
foreign key (FK_Guesthouse_ID)
references GUEST_HOUSE(Guesthouse_ID);

commit;

insert into EMPLOYEE
values (1,'Leblanc','Flory','Monk','N',0);
insert into EMPLOYEE
values (2,'Lefleur','Margarie','Nun','N',0);
insert into EMPLOYEE
values (3,'Grohl','David','Lay','N',20);
insert into EMPLOYEE
values (4,'Dean','Seamus','Lay','N',12);
insert into EMPLOYEE
values (5,'Lefleur','Renee','Monk','Y',0);
insert into EMPLOYEE
values (6,'Frankl','Viktor','Monk','N',0);
insert into EMPLOYEE
values (101,'Stein','Franken','Lay','N',15);

insert into MASTER_SCHEDULE
values (1,'House');

insert into MASTER_SCHEDULE
values (2,'Shop');

insert into MASTER_SCHEDULE
values (3,'Vow');

insert into MASTER_SCHEDULE
values (4,'Part-time');

insert into BIWEEKLY_SCHEDULE
values (1,1,1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'),40);

insert into BIWEEKLY_SCHEDULE
values (2,2,1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'),40);

insert into BIWEEKLY_SCHEDULE
values (3,3,1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'),40);

insert into BIWEEKLY_SCHEDULE
values (4,4,1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'),20);

insert into BIWEEKLY_SCHEDULE
values (5,5,101,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/14/2019','MM/DD/YYYY'),40);

insert into PAYROLL
values(1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));

insert into PAYCHECK
values(1,1,1,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));
insert into PAYCHECK
values(2,1,2,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));
insert into PAYCHECK
values(3,1,3,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));
insert into PAYCHECK
values(4,1,4,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));
insert into PAYCHECK
values(5,1,5,to_date('02/01/2021','MM/DD/YYYY'),to_date('02/14/2021','MM/DD/YYYY'));
insert into PAYCHECK
values(6,1,101,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/14/2019','MM/DD/YYYY'));

insert into GUEST_HOUSE
values(1,60,1,2,3,4);
insert into GUEST_HOUSE
values(2,60,1,2,3,4);
insert into GUEST_HOUSE
values(3,60,1,2,3,4);
insert into GUEST_HOUSE
values(4,60,1,2,3,4);
insert into GUEST_HOUSE
values(5,60,1,2,3,4);
insert into GUEST_HOUSE
values(6,60,1,2,3,4);
insert into GUEST_HOUSE
values(7,60,1,2,3,4);
insert into GUEST_HOUSE
values(8,60,1,2,3,4);
insert into GUEST_HOUSE
values(9,60,1,2,3,4);
insert into GUEST_HOUSE
values(10,60,1,2,3,4);
insert into GUEST_HOUSE
values(11,60,1,2,3,4);
insert into GUEST_HOUSE
values(12,60,1,2,3,4);

insert into HOUSE_ROTATION
values(1,1,1,to_date('07/01/2019','MM/DD/YYYY'),to_date('07/07/2019','MM/DD/YYYY'));
insert into HOUSE_ROTATION
values(2,1,6,to_date('07/08/2019','MM/DD/YYYY'),to_date('07/14/2019','MM/DD/YYYY'));
insert into HOUSE_ROTATION
values(3,12,1,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/07/2019','MM/DD/YYYY'));
insert into HOUSE_ROTATION
values(4,12,6,to_date('06/08/2019','MM/DD/YYYY'),to_date('06/14/2019','MM/DD/YYYY'));

insert into SHOP
values(1,'Bookshop','Abbey Bookshop');
insert into SHOP
values(2,'Gift Shop','Abbey Gift Shop');
insert into SHOP
values(3,'Candy Shop','Abbey Candy Shop');
insert into SHOP
values(4,'Restaraunt','Abbey Restaurant');

insert into ROSTER
values(1,3,4,'Restaurant');
insert into ROSTER
values(2,4,3,'Candy Shop');

insert into PRODUCT
values(1,10,'Beeswax Candle',7,to_date('02/02/2021','MM/DD/YYYY'));
insert into PRODUCT
values(2,35,'Book',14,to_date('02/04/2021','MM/DD/YYYY'));
insert into PRODUCT
values(3,4,'Candied Honeycomb',14,to_date('02/02/2021','MM/DD/YYYY'));
insert into PRODUCT
values(4,12,'Food',7,to_date('02/02/2021','MM/DD/YYYY'));

insert into INVENTORY
values(1,2,1,134);
insert into INVENTORY
values(2,1,2,85);
insert into INVENTORY
values(3,3,3,45);
insert into INVENTORY
values(4,4,4,120);

insert into VISITOR
values(1,'James','Macavoy','123 Cheshire St','1234567891');
insert into VISITOR
values(2,'Bernice','Macavoy','123 Cheshire St','1234567891');
insert into VISITOR
values(3,'Dustin','Gavile','124 Cheshire St','9876543291');
insert into VISITOR
values(4,'Marcus','Aurelius','1 Rome Way','9876798143');

insert into VISITOR_ORDER
values(1,1);
insert into VISITOR_ORDER
values(2,1);
insert into VISITOR_ORDER
values(3,2);
insert into VISITOR_ORDER
values(4,4);

insert into LINE_ITEM
values(1,1,1);
insert into LINE_ITEM
values(2,2,3);
insert into LINE_ITEM
values(3,2,2);
insert into LINE_ITEM
values(4,1,4);

insert into RENTAL
values(1,1,1,2,to_date('02/07/2021','MM/DD/YYYY'),to_date('02/09/2021','MM/DD/YYYY'));
insert into RENTAL
values(2,3,1,2,to_date('02/07/2021','MM/DD/YYYY'),to_date('02/09/2021','MM/DD/YYYY'));
insert into RENTAL
values(3,4,2,1,to_date('02/09/2021','MM/DD/YYYY'),to_date('02/10/2021','MM/DD/YYYY'));
insert into RENTAL
values(4,4,1,1,to_date('07/01/2019','MM/DD/YYYY'),to_date('07/14/2019','MM/DD/YYYY'));
insert into RENTAL
values(5,3,1,1,to_date('07/01/2019','MM/DD/YYYY'),to_date('07/14/2019','MM/DD/YYYY'));
insert into RENTAL
values(6,4,12,1,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/14/2019','MM/DD/YYYY'));
insert into RENTAL
values(7,3,12,2,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/14/2019','MM/DD/YYYY'));
insert into RENTAL
values(8,1,12,3,to_date('06/01/2019','MM/DD/YYYY'),to_date('06/07/2019','MM/DD/YYYY'));

insert into RESERVATION
values(1,1,4,2,to_date('02/09/2021 18:30','MM/DD/YYYY HH24:MI'),to_date('02/09/2021 18:30','MM/DD/YYYY HH24:MI'),100);

commit;

select * from EMPLOYEE;
select * from MASTER_SCHEDULE;
select * from BIWEEKLY_SCHEDULE;
select * from PAYROLL;
select * from PAYCHECK;
select * from GUEST_HOUSE;
select * from HOUSE_ROTATION;
select * from SHOP;
select * from ROSTER;
select * from PRODUCT;
select * from INVENTORY;
select * from VISITOR;
select * from VISITOR_ORDER;
select * from LINE_ITEM;
select * from RENTAL;
select * from RESERVATION;