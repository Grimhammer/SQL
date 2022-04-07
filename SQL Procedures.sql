desc student;

Create or Replace PROCEDURE student_type_t(STUDENT_ID_PASS_IN IN VARCHAR2) IS
    
  rec_STUDENT_ID            varchar2(20);
  rec_STUDENT_FIRST_NAME    varchar2(20);
  rec_FK_STUDENT_TYPE_ID    varchar2(20);
   
  invalid_student EXCEPTION; 
    
BEGIN

  select s.STUDENT_ID, s.STUDENT_FIRST_NAME, s.FK_STUDENT_TYPE_ID
  into rec_STUDENT_ID, rec_STUDENT_FIRST_NAME, rec_FK_STUDENT_TYPE_ID
  from STUDENT s
  where s.STUDENT_ID = STUDENT_ID_PASS_IN;

  dbms_output.put_line(rec_STUDENT_FIRST_NAME || ' ' || rec_FK_STUDENT_TYPE_ID);
  
  IF rec_FK_STUDENT_TYPE_ID
    NOT IN ('F','S','J','S')
    THEN
      RAISE invalid_student;
  END IF;
  
  EXCEPTION 
    WHEN invalid_student 
      THEN dbms_output.put_line('This student type is not a valid selection.');
    
END;

exec student_type_t('L1421737');