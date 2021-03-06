CREATE OR REPLACE PACKAGE STUDENT_REGISTRATION_SYSTEM AS

  /*
    Global Types
  */
  TYPE REF_CURSOR IS REF CURSOR;

  -- COMMON EXCEPTION

  EXCP_INVALID_B#                EXCEPTION;
  EXCP_INVALID_CLASSID           EXCEPTION;
  EXCP_INVALID_STUDENT_ENROLL    EXCEPTION;
  EXCP_INVALID_SEM_CLASS         EXCEPTION;
  EXCP_INVALID_DROP_PREREQ       EXCEPTION;
  EXCP_INVALID_DROP_LAST_CLASS   EXCEPTION;
  EXCP_INVALID_DROP_LAST_STUDENT EXCEPTION;
  EXCP_CLASS_IS_FULL             EXCEPTION;
  EXCP_EXCEEDED_ENROLLMENT       EXCEPTION;
  EXCP_PREREQ_NOT_SATISFIED      EXCEPTION;
  EXCP_INVALID_DEPTCODE_COURSE#  EXCEPTION;

  /*
   * Procedures to display the tuples in each of the seven tables for this project.
   */
  PROCEDURE SHOW_STUDENTS(REF_CURSOR_STUDENTS OUT REF_CURSOR);
  PROCEDURE SHOW_TAS(REF_CURSOR_TAS OUT REF_CURSOR);
  PROCEDURE SHOW_COURSES(REF_CURSOR_COURSES OUT REF_CURSOR);
  PROCEDURE SHOW_CLASSES(REF_CURSOR_CLASSES OUT REF_CURSOR);
  PROCEDURE SHOW_ENROLLMENTS(REF_CURSOR_ENROLLMENTS OUT REF_CURSOR);
  PROCEDURE SHOW_PREREQUISITES(REF_CURSOR_PREREQUISITES OUT REF_CURSOR);
  PROCEDURE SHOW_LOGS(REF_CURSOR_LOGS OUT REF_CURSOR);

  /*
   * Procedure to list B#, first name and last name of the TA of the class for a given class
   */
  PROCEDURE CLASS_TA(CLASSID_IN     IN CLASSES.CLASSID%TYPE,
                     TA_B#_OUT      OUT CLASSES.TA_B#%TYPE,
                     FIRST_NAME_OUT OUT STUDENTS.FIRST_NAME%TYPE,
                     LAST_NAME_OUT  OUT STUDENTS.LAST_NAME%TYPE);

  /*
   * Procedure to list all prerequisite courses for given course (with dept_code and course#)
   * Including both direct and indirect prerequisite courses
   */
  PROCEDURE CLASS_PREREQ(DEPT_CODE_IN IN PREREQUISITES.DEPT_CODE%TYPE,
                         COURSE#_IN   IN PREREQUISITES.COURSE#%TYPE,
                         PRE_REQ_OUT  OUT VARCHAR2);

  /*
   * Procedure to Enroll Student for given class
   */
  PROCEDURE ENROLL_STUDENT(B#_IN      IN STUDENTS.B#%TYPE,
                           CLASSID_IN IN CLASSES.CLASSID%TYPE);

  /*
   * Procedure to drop a student from a class
   */
  PROCEDURE DELETE_STUDENT_ENROLLMENT(B#_IN      IN STUDENTS.B#%TYPE,
                                      CLASSID_IN IN CLASSES.CLASSID%TYPE);

  /*
   * Procedure to delete Student
   */
  PROCEDURE DELETE_STUDENT(B#_IN IN STUDENTS.B#%TYPE);
END;
/
