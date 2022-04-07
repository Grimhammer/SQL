-- Use Case #1

select visitor_fname || ' ' || visitor_lname as "Visitor Name"
from visitor join rental on Visitor_ID = FK_Visitor_ID
where Rental_Start_Date = to_date('07/01/2019','MM/DD/YYYY')
  AND Rental_End_Date = to_date('07/14/2019','MM/DD/YYYY');

-- Use Case #1

select  v.Visitor_Fname || ' ' || v.Visitor_Lname as "Visitor Name", 
        g.Guesthouse_ID as "Guesthouse Number",
        e.Employee_Fname || ' ' || e.Employee_Lname as "Monk Name"
from VISITOR v join RENTAL r on v.Visitor_ID = r.FK_Visitor_ID
join GUEST_HOUSE g on g.Guesthouse_ID = r.FK_Guesthouse_ID
join HOUSE_ROTATION h on g.Guesthouse_ID = h.FK_Guesthouse_ID
join EMPLOYEE e on e.Employee_ID = h.FK_Employee_ID
where Rental_Start_Date = to_date('07/01/2019','MM/DD/YYYY')
  AND Rental_End_Date = to_date('07/14/2019','MM/DD/YYYY')
order by v.Visitor_Fname;
  
  
select  VISITOR_FNAME || ' ' || VISITOR_LNAME as "Visitor Name", 
        count(*) as "Number of Rentals" 
from VISITOR join RENTAL on Visitor_ID = FK_Visitor_ID
group by VISITOR_FNAME, VISITOR_LNAME
HAVING COUNT(*) > 1;

select  v.Visitor_Fname || ' ' || v.Visitor_Lname as "Visitor Name",
        r.Booked_Room_Num as "Booked Room"
from GUEST_HOUSE g join RENTAL r on g.Guesthouse_ID = r.FK_Guesthouse_ID
join VISITOR V on v.Visitor_ID = r.FK_Visitor_ID
where to_date('06/07/2019','MM/DD/YYYY') 
BETWEEN Rental_Start_Date AND Rental_End_Date;

select e.Employee_Fname, e.Employee_Lname
from PAYCHECK p join EMPLOYEE e on e.Employee_ID = p.FK_Employee_ID
join BIWEEKLY_SCHEDULE b on e.Employee_ID = b.FK_Employee_ID
where p.Begin_Pay_Date = to_date('06/01/2019','MM/DD/YYYY')
  AND p.End_Pay_Date = to_date('06/14/2019','MM/DD/YYYY');
  
select e.Employee_Fname, e.Employee_Lname, (w.Hours_Per_Schedule * e.emp_hourly_rate) as "Pay"
from PAYCHECK p join EMPLOYEE e on e.Employee_ID = p.FK_Employee_ID
join BIWEEKLY_SCHEDULE w on e.Employee_ID = w.FK_Employee_ID
where p.Begin_Pay_Date = to_date('06/01/2019','MM/DD/YYYY')
  AND p.End_Pay_Date = to_date('06/14/2019','MM/DD/YYYY');
  
select  v.Visitor_Fname || ' ' || v.Visitor_Lname as "Visitor Name",
        r.Booked_Room_Num as "Booked Room"
from GUEST_HOUSE g join RENTAL r on g.Guesthouse_ID = r.FK_Guesthouse_ID
join VISITOR V on v.Visitor_ID = r.FK_Visitor_ID
where to_date('06/07/2019','MM/DD/YYYY') 
BETWEEN Rental_Start_Date AND Rental_End_Date;

select * from GUEST_HOUSE;
select * from RENTAL
where to_date('06/08/2019','MM/DD/YYYY') BETWEEN Rental_Start_Date AND Rental_End_Date;

select e.Employee_Fname, e.Employee_Lname, r.Booked_Room_Num
from HOUSE_ROTATION h join EMPLOYEE e on e.Employee_ID = h.FK_Employee_ID
join GUEST_HOUSE g on g.Guesthouse_ID = h.FK_Guesthouse_ID
join RENTAL r on g.Guesthouse_ID = r.FK_Guesthouse_ID
where to_date('06/08/2019','MM/DD/YYYY') BETWEEN h.Rotation_Start_Date AND h.Rotation_End_Date
AND to_date('06/08/2019','MM/DD/YYYY') > Rental_End_Date;
