-- Create the database
CREATE DATABASE EventsManagement;

-- Use the database
USE EventsManagement;

-- Create Events table
CREATE TABLE Events (
    Event_Id INT PRIMARY KEY,
    Event_Name VARCHAR(100),
    Event_Date DATE,
    Event_Location VARCHAR(100),
    Event_Description TEXT
);

-- Create Attendees table
CREATE TABLE Attendees (
    Attendee_Id INT PRIMARY KEY,
    Attendee_Name VARCHAR(100),
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(100),
    Attendee_City VARCHAR(100)
);

-- Create Registrations table
CREATE TABLE Registrations (
    Registration_id INT PRIMARY KEY,
    Event_Id INT,
    Attendee_Id INT,
    Registration_Date DATE,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- Insert Events
INSERT INTO Events VALUES
(1, 'Tech Conference', '2025-08-10', 'Chennai', 'Annual tech summit'),
(2, 'Startup Meetup', '2025-08-15', 'Bangalore', 'Networking for entrepreneurs'),
(3, 'Data Science Workshop', '2025-08-20', 'Hyderabad', 'Hands-on training session');

-- Insert Attendees
INSERT INTO Attendees VALUES
(101, 'Alice', '9876543210', 'alice@mail.com', 'Chennai'),
(102, 'Bob', '8765432109', 'bob@mail.com', 'Bangalore'),
(103, 'Charlie', '7654321098', 'charlie@mail.com', 'Hyderabad');

-- Insert Registrations
INSERT INTO Registrations VALUES
(1001, 1, 101, '2025-07-01', 500.00),
(1002, 1, 102, '2025-07-02', 500.00),
(1003, 2, 103, '2025-07-03', 300.00);

---- 3a) Insert New Event
INSERT INTO Events VALUES
(4, 'AI Conference', '2025-09-01', 'Mumbai', 'Focus on AI advancements');
SELECT * FROM Events WHERE Event_Id = 4;

---3b) Update an Event
UPDATE Events
SET Event_Location = 'Pune'
WHERE Event_Id = 2;
SELECT * FROM Events WHERE Event_Id = 2;

---3c) Delete an Event
DELETE FROM Events
WHERE Event_Id = 4;

SELECT * FROM Events WHERE Event_Id = 4;

---4a) Insert New Attendee
INSERT INTO Attendees VALUES
(104, 'Diana', '9123456780', 'diana@mail.com', 'Pune');
SELECT * FROM Attendees WHERE Attendee_Id = 104;

---4b) Register Attendee for an Event
INSERT INTO Registrations VALUES
(1004, 3, 104, '2025-07-05', 400.00);
SELECT * FROM Registrations WHERE Registration_id = 1004;

5a) Retrieve All Event Information
SELECT * FROM Events;

5b) List of Attendees for a Specific Event
SELECT a.Attendee_Name, a.Attendee_Email
FROM Attendees a
JOIN Registrations r ON a.Attendee_Id = r.Attendee_Id
WHERE r.Event_Id = 1;

---5c) Count of Registrations per Event
SELECT e.Event_Name, COUNT(r.Registration_id) AS Total_Registrations
FROM Events e
JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;

---5d) Total Registration Amount per Event
SELECT e.Event_Name, SUM(r.Registration_Amount) AS Total_Revenue
FROM Events e
JOIN Registrations r ON e.Event_Id = r.Event_Id
GROUP BY e.Event_Name;












