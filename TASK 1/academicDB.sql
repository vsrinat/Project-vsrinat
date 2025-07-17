Create database academicDB;
use academicDB;


-- Create StudentInfo table
CREATE TABLE StudentInfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME VARCHAR(100),
    DOB DATE,
    PHONE_NO VARCHAR(15),
    EMAIL_ID VARCHAR(100),
    ADDRESS VARCHAR(255)
);

-- Create CoursesInfo table
CREATE TABLE CoursesInfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME VARCHAR(100),
    COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

-- Create EnrollmentInfo table
CREATE TABLE EnrollmentInfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT,
    COURSE_ID INT,
    ENROLL_STATUS ENUM('Enrolled', 'Not Enrolled'),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- Insert students
INSERT INTO StudentInfo VALUES
(1, 'Alice', '2001-05-20', '9876543210', 'alice@example.com', 'Chennai'),
(2, 'Bob', '2000-11-10', '8765432109', 'bob@example.com', 'Delhi'),
(3, 'Charlie', '2002-03-15', '7654321098', 'charlie@example.com', 'Mumbai');

-- Insert courses
INSERT INTO CoursesInfo VALUES
(101, 'Data Science', 'Dr. Ramesh'),
(102, 'Database Systems', 'Prof. Anita'),
(103, 'Machine Learning', 'Dr. Rahul');

-- Insert enrollments
INSERT INTO EnrollmentInfo VALUES
(1, 1, 101, 'Enrolled'),
(2, 1, 102, 'Enrolled'),
(3, 2, 101, 'Enrolled'),
(4, 3, 103, 'Not Enrolled');

-- 3a) Student details with enrollment status
SELECT s.STU_NAME, s.PHONE_NO, s.EMAIL_ID, e.ENROLL_STATUS
FROM StudentInfo s
LEFT JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID;

-- 3b) List of courses a specific student is enrolled in (e.g., Alice - ID 1)
SELECT c.COURSE_NAME
FROM EnrollmentInfo e
JOIN CoursesInfo c ON e.COURSE_ID = c.COURSE_ID
WHERE e.STU_ID = 1 AND e.ENROLL_STATUS = 'Enrolled';

-- 3c) Retrieve course info (name & instructor)
SELECT COURSE_NAME, COURSE_INSTRUCTOR_NAME
FROM CoursesInfo;

-- 3d) Retrieve info for a specific course (e.g., ID 101)
SELECT * FROM CoursesInfo WHERE COURSE_ID = 101;


-- 3e) Retrieve info for multiple courses (e.g., IDs 101, 102)
SELECT * FROM CoursesInfo WHERE COURSE_ID IN (101, 102);

-- 4a) Number of students enrolled in each course
SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Enrolled_Students
FROM CoursesInfo c
LEFT JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME;

-- 4b) List of students in a specific course (e.g., Course ID 101)
SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.COURSE_ID = 101 AND e.ENROLL_STATUS = 'Enrolled';

-- 4c) Count of enrolled students per instructor
SELECT c.COURSE_INSTRUCTOR_NAME, COUNT(e.STU_ID) AS Enrolled_Count
FROM CoursesInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_INSTRUCTOR_NAME;

-- 4d) Students enrolled in multiple courses
SELECT s.STU_NAME
FROM StudentInfo s
JOIN EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY s.STU_ID
HAVING COUNT(e.COURSE_ID) > 1;

-- 4e) Courses with highest number of enrollments (descending order)
SELECT c.COURSE_NAME, COUNT(e.STU_ID) AS Total_Enrolled
FROM CoursesInfo c
JOIN EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE e.ENROLL_STATUS = 'Enrolled'
GROUP BY c.COURSE_NAME
ORDER BY Total_Enrolled DESC;