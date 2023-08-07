CREATE TABLE students (
  student_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  address VARCHAR(100),
  phone_number VARCHAR(20),
  email VARCHAR(50),
  date_of_birth DATE
);
ALTER TABLE students
ADD pass VARCHAR(50);

CREATE TABLE courses (
  course_id INT PRIMARY KEY,
  course_name VARCHAR(50),
  instructor_name VARCHAR(50),
  start_time TIME,
  end_time TIME,
  room_number VARCHAR(20)
);
ALTER TABLE courses
ADD COLUMN department_id INT,
ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

ALTER TABLE courses
ADD COLUMN professor_ID INT,
ADD FOREIGN KEY (professor_ID) REFERENCES professors(professor_ID);

CREATE TABLE enrollments (
enrollment_id INT PRIMARY KEY,
student_id INT,
course_id INT,
grade VARCHAR(2),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE schedules (
student_id INT,
course_id INT,
start_time TIME,
end_time TIME,
room_number VARCHAR(20),
PRIMARY KEY (student_id, course_id),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

CREATE TABLE departments (
department_id INT PRIMARY KEY,
department_name VARCHAR(50)
);

CREATE TABLE professors (
professor_id INT PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
address VARCHAR(100),
phone_number VARCHAR(20),
email VARCHAR(50)
);

INSERT INTO students VALUES
(6187231, 'Camron', 'Cisneros', '9393 Elm St', '561-587-5123','camron.cisneros@gmail.com', '2001-08-03'),
(1234567, 'Sierra', 'Justus', '8181 Yahoo Ave', '978-489-9959','sierra.justus@gmail.com', '2001-08-17'),
(8765432, 'Evan', 'Cisneros', '8989 Glee St', '561-587-5124','evan.cisneros@gmail.com', '2005-04-07'),
(0234567, 'Alex', 'Justus', '8987 Yahoo Ave', '978-489-918','sierra.justus@gmail.com', '2001-08-17');

INSERT INTO courses VALUES
  (1, 'Introduction to Computer Science', 'Dr. Smith', '09:00:00', '10:30:00', 'Room 101'),
  (2, 'Data Science Fundamentals', 'Dr. Johnson', '13:00:00', '14:30:00', 'Room 201'),
  (3, 'Database Management Systems', 'Prof. Adams', '11:00:00', '12:30:00', 'Room 301')

INSERT INTO enrollments VALUES
  (1, 6187231, 1, 'A'),
  (2, 8765432, 1, 'B'),
  (3, 1234567, 2, 'A'),
  (4, 0234567, 3, 'A+');

INSERT INTO schedules VALUES
  (6187231, 1, '09:00:00', '10:30:00', 'Room 101'),
  (8765432, 1, '09:00:00', '10:30:00', 'Room 101'),
  (1234567, 2, '13:00:00', '14:30:00', 'Room 201'),
  (0234567, 3, '17:00:00', '19:00:00', 'Room 305');

INSERT INTO departments VALUES
  (1, 'Computer Science'),
  (2, 'Data Science'),
  (3, 'Business Administration');

INSERT INTO professors VALUES
  (1, 'Alex', 'Doe', '123 Elm St.', '555-9876', 'alex.doe@email.com'),
  (2, 'Emily', 'Smith', '456 Oak St.', '555-5432', 'emily.smith@email.com'),
  (3, 'Jake', 'Longley', '789 Tree Ave.', '555-1597', 'jake.longley@aol.com');

UPDATE courses
SET instructor_name = 'Alex Doe'
WHERE course_id = 1;
UPDATE courses
SET instructor_name = 'Emily Smith'
WHERE course_id = 2;
UPDATE courses
SET instructor_name = 'Jake Longley', 
start_time = '17:00:00',
end_time = '19:00:00',
room_number = 'Room 305'
WHERE course_id = 3;

UPDATE courses
SET professor_ID = 1, 
department_ID = 1
WHERE course_ID = 1;
UPDATE courses
SET professor_ID = 2, 
department_ID = 2
WHERE course_ID = 2;
UPDATE courses
SET professor_ID = 3, 
department_ID = 3
WHERE course_ID = 3;

UPDATE courses
SET department_id = 1
WHERE course_id = 1;
UPDATE courses
SET department_id = 2
WHERE course_id = 2;
UPDATE courses
SET department_id = 3
WHERE course_id = 3;

UPDATE students
SET last_name = 'Cisneros'
WHERE student_id = 1234567;
UPDATE students
SET address = '11750 14th St'
WHERE student_id = 6187231;
DELETE FROM students
WHERE student_id = 1234567;

INSERT INTO enrollments (enrollment_id, student_id, course_id, grade)
VALUES (5, 6187231, 2, 'C');
INSERT INTO schedules (student_id, course_id, start_time, end_time, room_number)
VALUES (6187231, 2, '13:00:00', '14:30:00', 'Room 201');

UPDATE students
SET pass = 'pass'
WHERE last_name = 'Cisneros' OR last_name= 'Justus';


SELECT first_name AS "First",last_name AS "Last Name"
FROM students;

SELECT * 
FROM students
WHERE last_name = 'Cisneros';

SELECT s.student_id, s.first_name, s.last_name, d.department_name
FROM students s
JOIN enrollments e ON s.student_ID = e.student_ID
JOIN courses c ON e.course_ID = c.course_ID
JOIN departments d ON c.department_id = d.department_id;

SELECT p.first_name "First", p.last_name "Last", c.course_name "Course"
FROM professors p
JOIN courses c ON p.professor_id = c.professor_id;

SELECT c.course_name, s.start_time, s.end_time, s.room_number 
FROM schedules s
JOIN courses c ON s.course_id = c.course_id
WHERE s.student_id = 6187231;

SELECT c.course_name, e.grade, d.department_name AS Department, CONCAT(p.first_name, ' ', p.last_name) AS Teacher
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
JOIN departments d ON c.department_id = d.department_id
JOIN professors p ON c.professor_id = p.professor_id
WHERE e.student_id = 6187231;

DELETE FROM schedules
WHERE student_ID = 6187231;
DELETE FROM enrollments
WHERE student_ID = 6187231;
DELETE FROM students
WHERE student_ID = 6187231;