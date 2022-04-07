-- create/replace our package
CREATE OR REPLACE PACKAGE student_processing AS 
  -- define student_data_rec as a record type containing the student information
  TYPE student_data_rec IS RECORD (
    rec_STUDENT_ID          STUDENT.STUDENT_ID%TYPE,
    rec_STUDENT_FIRST_NAME  STUDENT.STUDENT_FIRST_NAME%TYPE,
    rec_STUDENT_LAST_NAME   STUDENT.STUDENT_LAST_NAME%TYPE,
    rec_FK_STUDENT_TYPE_ID  STUDENT.FK_STUDENT_TYPE_ID%TYPE);

    student_record_info student_data_rec;
-- declare procedures to follow in package body
PROCEDURE student_type(STUDENT_ID_PASS_IN IN VARCHAR2);
PROCEDURE student_gpa(student_grade_id IN VARCHAR2);
-- end package declaration
END student_processing;
-- create the body of the package
CREATE OR REPLACE PACKAGE BODY student_processing AS
-- definition of first procedure
  PROCEDURE student_type(STUDENT_ID_PASS_IN IN VARCHAR2) IS
-- variables declarations for use in body
  rec_STUDENT_ID            varchar2(20);
  rec_FK_STUDENT_TYPE_ID    varchar2(20);
-- exception definition
  invalid_student EXCEPTION; 

BEGIN
-- get the students ID and type
  select s.STUDENT_ID, s.FK_STUDENT_TYPE_ID
  into rec_STUDENT_ID, rec_FK_STUDENT_TYPE_ID
  from STUDENT s
  where s.STUDENT_ID = STUDENT_ID_PASS_IN;
-- if their ID is not in the list, raise the exception
  IF rec_FK_STUDENT_TYPE_ID
    NOT IN ('F','S','J','S')
    THEN
      RAISE invalid_student;
-- if their ID is in the list, call the student_GPA procedure
    ELSE
    student_gpa(rec_STUDENT_ID);
  END IF;
-- exception calls you out for being a foo' 
  EXCEPTION 
    WHEN invalid_student 
      THEN dbms_output.put_line('This student type is not a valid selection.');
    
END;
-- compile next procedure
  PROCEDURE student_gpa(student_grade_id IN VARCHAR2) IS
-- variables declarations for use in body
    point_count      number(5);
    GPA              decimal(5,2);
    total_classes    number(5);
    student_fname    varchar2(25);
    student_lname    varchar2(25);
-- cursor for iterating through enrollments 
  CURSOR grades
  IS
    select e.fk_student_id, e.grade, s.student_first_name, s.student_last_name
    from enrollment e join student s
    on s.STUDENT_ID = e.FK_STUDENT_ID;
    
  BEGIN
-- get the students name for display purposes
    select student_first_name, student_last_name into student_fname, student_lname
    from student where student_id = student_grade_id;
-- initialze variables
    point_count   := 0;
    GPA           := 0;
    total_classes := 0;
-- open for loop using cursor
    FOR current_grade in grades
    LOOP
-- if the students ID matches an ID on the enrollment table, do the case 
      IF current_grade.fk_student_id = student_grade_id
      THEN
      -- case that assigns point values for each grade
          CASE 
            WHEN current_grade.grade like '%A%' THEN point_count := point_count + 4;
            WHEN current_grade.grade like '%B%' THEN point_count := point_count + 3;
            WHEN current_grade.grade like '%C%' THEN point_count := point_count + 2;
            WHEN current_grade.grade like '%D%' THEN point_count := point_count + 1;
            WHEN current_grade.grade like '%F%' THEN point_count := point_count + 0;
            ELSE point_count := point_count + 0;
          END CASE;  
          -- iterate the class counter. this assumes each class is max 4 credits. 
          total_classes := total_classes + 1;
      END IF;
    END LOOP;
    -- conditional output so we avoid the dreaded div/0 & display names, and then
    -- display GPA if there is one. 
    if total_classes = 0
      then  dbms_output.put_line(student_fname || ' ' || student_lname ||' has no GPA');
    else  GPA := point_count/total_classes;
          dbms_output.put_line('The GPA for ' || student_fname || ' ' || student_lname
                               || ' is ' || GPA);
    end if;      
  
  END;
END;

set serveroutput on;

select * from student;

DECLARE

  lnumber varchar2(9);

BEGIN
  lnumber := 'L3201551';
  student_processing.student_type(lnumber);

END;