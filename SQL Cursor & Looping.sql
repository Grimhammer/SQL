-- output so we can use dbms_output
set serveroutput on;

DECLARE
-- declare variables for 
point_count          number(5);
GPA                  decimal(5,2);
total_classes        number(5);
-- declare cursor statements
CURSOR students
IS

  select student_first_name, student_last_name, student_id
  from student;

CURSOR grades
IS

  select e.fk_student_id, e.grade
  from enrollment e;
  
BEGIN
-- Start loop using students cursor
  FOR current_student IN students
  LOOP
  -- declaring variables for use and re-initialization in each loop
    point_count   := 0;
    GPA           := 0;
    total_classes := 0;
    -- second loop that iterates through grades for each student
    FOR current_grade in grades
    LOOP
      IF current_student.student_id = current_grade.fk_student_id
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
    -- conditional output so we avoid div/0 
    if total_classes = 0
    then  dbms_output.put_line(current_student.student_first_name || ' ' || current_student.student_last_name);
          dbms_output.put_line('No GPA');
    else  GPA := point_count/total_classes;
          dbms_output.put_line(current_student.student_first_name || ' ' || current_student.student_last_name);
          dbms_output.put_line('GPA: ' || GPA);
    end if;      
  END LOOP;
END;
