DROP TABLE AUTOMOBILE;
DROP TYPE DRIVERS_VA;
DROP TYPE DRIVER_TY;
DROP TYPE OWNERS_NT;
DROP TYPE OWNER_TY;

select * from AUTOMOBILE;

-- Create DRIVER_TY object for storing information about drivers

CREATE TYPE DRIVER_TY AS OBJECT (
  first_name      varchar2(20),
  last_name       varchar2(25),
  date_of_birth   date
);

-- create VARRAY for holding up to 5 DRIVER_TY objects

CREATE TYPE DRIVERS_VA IS VARRAY(5) OF DRIVER_TY;

-- Create OWNER_TY object for storing information about owners

CREATE TYPE OWNER_TY AS OBJECT (
  first_name      varchar2(20),
  last_name       varchar2(25),
  date_purchased  date
);

-- create OWNER_NT as a type of OWNER_TY objects

CREATE TYPE OWNERS_NT AS TABLE OF OWNER_TY;

-- create automobile table, used for storing info about the vehicle, drivers, 
-- and owners, declaring nested table owners

CREATE TABLE AUTOMOBILE (
  vehicle_identification_number varchar2(17) PRIMARY KEY,
  drivers DRIVERS_VA,
  owners OWNERS_NT
)

NESTED TABLE owners
STORE AS owners_nested;

-- inserts, using methods to access varrays and nested table

INSERT INTO AUTOMOBILE
VALUES ('101',  DRIVERS_VA(DRIVER_TY('Erin','Smalltalk',to_date('05/23/1957','MM/DD/YYYY')),
                           DRIVER_TY('Max','Lucids',to_date('02/12/1989','MM/DD/YYYY'))),
                OWNERS_NT(OWNER_TY('Lance','Smalltalk',to_date('1/19/2003','MM/DD/YYYY'))));
                
INSERT INTO AUTOMOBILE
VALUES ('102',  DRIVERS_VA(DRIVER_TY('Julie','Goldstein',to_date('06/19/1977','MM/DD/YYYY')),
                           DRIVER_TY('Max','Lucids',to_date('02/12/1989','MM/DD/YYYY'))),
                OWNERS_NT(OWNER_TY('Lance','Smalltalk',to_date('01/19/2003','MM/DD/YYYY')),
                          OWNER_TY('Max','Lucids',to_date('08/19/2009','MM/DD/YYYY'))));
     
-- query selecting first, last, and vin from our abominable table  
                          
select d.first_name as "First Name", d.last_name as "Last Name", 
       a.vehicle_identification_number as "VIN"
from automobile a, TABLE(a.drivers) d;
  