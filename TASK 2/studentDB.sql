-- Create the database
CREATE DATABASE student_database;

-- Select the database
USE student_database;

-- Create the table
CREATE TABLE student_table (
    Student_id INT PRIMARY KEY,
    Stu_name VARCHAR(100),
    Department VARCHAR(100),
    email_id VARCHAR(100),
    Phone_no BIGINT,
    Address VARCHAR(255),
    Date_of_birth DATE,
    Gender VARCHAR(10),
    Major VARCHAR(100),
    GPA DECIMAL(3,2),
    Grade CHAR(1) -- e.g. A, B, C
);

INSERT INTO student_table VALUES
(1, 'Alice', 'CS', 'alice@uni.com', 9876543210, 'Chennai', '2001-05-20', 'Female', 'AI', 8.5, 'A'),
(2, 'Bob', 'IT', 'bob@uni.com', 8765432109, 'Delhi', '2000-11-10', 'Male', 'Networking', 6.8, 'B'),
(3, 'Charlie', 'ECE', 'charlie@uni.com', 7654321098, 'Mumbai', '2002-03-15', 'Male', 'Robotics', 4.9, 'C'),
(4, 'Diana', 'EEE', 'diana@uni.com', 9123456780, 'Hyderabad', '2001-08-11', 'Female', 'Power Systems', 7.5, 'B'),
(5, 'Ethan', 'CS', 'ethan@uni.com', 9988776655, 'Pune', '2003-01-22', 'Male', 'AI', 9.1, 'A'),
(6, 'Fiona', 'IT', 'fiona@uni.com', 8899776655, 'Bangalore', '2000-04-10', 'Female', 'Web Dev', 5.4, 'C'),
(7, 'George', 'ECE', 'george@uni.com', 9877899999, 'Chennai', '1999-12-01', 'Male', 'Signal Processing', 6.2, 'B'),
(8, 'Hannah', 'EEE', 'hannah@uni.com', 9555123456, 'Delhi', '2002-06-07', 'Female', 'VLSI', 8.0, 'A'),
(9, 'Ian', 'CS', 'ian@uni.com', 9666233344, 'Kolkata', '2001-09-18', 'Male', 'Cyber Security', 4.5, 'C'),
(10, 'Julia', 'IT', 'julia@uni.com', 9111998877, 'Ahmedabad', '2000-02-28', 'Female', 'Mobile Dev', 7.8, 'B');

--- Student Information Retrieval
SELECT * FROM student_table
ORDER BY Grade DESC;

--- Query for Male Students:
SELECT * FROM student_table
WHERE Gender = 'Male';

---Students with GPA < 5.0
SELECT * FROM student_table
WHERE GPA < 5.0;

--- Update Email and Grade for a Specific Student
UPDATE student_table
SET email_id = 'charlie_new@uni.com',
    Grade = 'B'
WHERE Student_id = 3;
SELECT * FROM student_table

---Students with Grade 'B' — Names and Ages
SELECT Stu_name,
       TIMESTAMPDIFF(YEAR, Date_of_birth, CURDATE()) AS Age
FROM student_table
WHERE Grade = 'B';

--- Group by Department & Gender → Avg GPA
SELECT Department, Gender, AVG(GPA) AS Avg_GPA
FROM student_table
GROUP BY Department, Gender;

--- Rename Table to student_info
RENAME TABLE student_table TO student_info;

select * from student_info;

---Student with Highest GPA
SELECT Stu_name, GPA
FROM student_info
ORDER BY GPA DESC
LIMIT 1;




