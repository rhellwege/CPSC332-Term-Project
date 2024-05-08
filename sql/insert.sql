USE USERNAME;

INSERT INTO Professor (Ssn,FirstName,LastName,StreetAdress,City,State,ZipCode,Sex,PhoneArea,PhoneSeven,Title,Salary)
VALUES
  ("423734389","Chanda","Patterson","Ap #475-7284 Non Avenue","Bear","Pennsylvania","86723","F","691","4573131","Associate Professor",59089.33),
  ("860586050","Victor","Whitley","756-3193 Ac Av.","Hilo","Indiana","46662","F","543","0123073","Research Associate",79418.09),
  ("564570095","Peter","Day","Ap #415-1894 Dapibus Av.","Norman","Kansas","27128","F","983","4538895","Professor",160442.57),
  ("282926719","Tanya","Roy","P.O. Box 456, 2829 Risus. Ave","Nampa","Virginia","92935","M","315","9475466","Adjunct Professor",91522.74),
  ("843477602","Sonya","Stevenson","851-1765 Ut Rd.","Huntsville","Maryland","86747","M","684","5272757","Research Associate",144264.93),
  ("582948103","Matthew","Dewalt","ll51-1765 Luna Rd.","Chino Hills","California","74921","M","290","5739879","Professor",200264.93);

INSERT INTO Professor_Degrees (Professor_Ssn, Degree)
VALUES
    ("843477602", "Bachelor of Science in Mathematics"),
    ("843477602", "Doctorate in Mathematics"),
    ("860586050", "Master of Science in Mathematics"),
    ("860586050", "Bachelor of Science in Mathematics"),
    ("582948103", "Bachelor of Science in Mathematics"),
    ("582948103", "Doctorate in Mathematics"),
    ("282926719", "Bachelor of Science in Computer Science"),
    ("282926719", "Doctorate in Computer Science"),
    ("564570095", "Bachelor of Science in Computer Science"),
    ("564570095", "Master of Science in Computer Science"),
    ("423734389", "Bachelor of Science in Computer Science"),
    ("423734389", "Doctorate in Computer Science");

INSERT INTO Department (ChairPerson_Ssn,Name,OfficeLocation,PhoneArea,PhoneSeven)
VALUES
    ("282926719","Computer Science","Ap #828-7733 Justo Ave","337","1560455"),
    ("582948103","Math","Ap #601-2300 Duis Road","544","0852558");


INSERT INTO Course (CourseNumber, OfferedBy_DepartmentNumber, Units, Textbook, Title)
VALUES
    (1, 1, 3, "Introduction to Networking Systems ISBN 37432", "CPSC 421 Introduction to Network Architecture"),
    (2, 1, 3, "Operating Systems Essentials ISBN 4848483", "CPSC 351 Operating Systems"),
    (3, 1, 3, "Introduction to Programming in C++ ISBN 49995", "CPSC 101 Introduction to Computer Science"),
    (4, 2, 4, "Solving Differential Equations ISBN 3234324", "MATH 256 Differential Equations"),
    (5, 2, 4, "Core Principles in Applied Mathematics ISBN 1209309", "MATH 502 Applied Mathematics"),
    (6, 2, 3, "College Algebra Basics ISBN 404222", "MATH 101 College Algebra");

INSERT INTO Course_Prerequisites (CourseNumber, Prerequisite_CourseNumber)
VALUES
    (1, 2),
    (1, 3),
    (2, 3),
    (3, 6),
    (4, 6),
    (5, 4),
    (5, 6);

INSERT INTO Course_Section (CourseNumber, SectionNumber, Professor_Ssn, Classroom, Seats, BeginTime, EndTime)
VALUES
    (1, 1, "564570095", "CS 202 Lecture Room", 30, TIME("12:30:00"), TIME("14:00:00")),
    (1, 2, "564570095", "CS 104 Lecture Room", 25, TIME("17:30:00"), TIME("19:00:00")),
    (2, 1, "282926719", "CS 210 Lecture Room", 25, TIME("19:00:00"), TIME("20:30:00")),
    (2, 2, "423734389", "CS 210 Lecture Room", 25, TIME("15:00:00"), TIME("16:30:00")),
    (3, 1, "423734389", "CS 106 Lecture Room", 25, TIME("16:00:00"), TIME("17:30:00")),
    (3, 2, "282926719", "CS 106 Lecture Room", 25, TIME("15:30:00"), TIME("17:00:00")),
    (4, 1, "843477602", "E 103 Lecture Room", 25, TIME("18:30:00"), TIME("20:00:00")),
    (4, 2, "860586050", "E 103 Lecture Room", 25, TIME("18:30:00"), TIME("20:00:00")),
    (5, 1, "582948103", "LH 103 Lecture room", 25, TIME("13:30:00"), TIME("15:00:00")),
    (5, 2, "582948103", "LH 103 Lecture room", 25, TIME("13:30:00"), TIME("15:00:00")),
    (6, 1, "860586050", "MH 207a Lecture Room", 28, TIME("13:00:00"), TIME("14:30:00")),
    (6, 2, "843477602", "LH 402 Lecture Hall", 80, TIME("14:30:00"), TIME("16:00:00"));

INSERT INTO Course_Section_Days (CourseNumber, SectionNumber, Day)
VALUES
    (1, 1, 'M'),
    (1, 1, 'W'),
    (1, 2, 'T'),
    (1, 2, 'Th'),
    (2, 1, 'M'),
    (2, 1, 'W'),
    (2, 2, 'T'),
    (2, 2, 'Th'),
    (3, 1, 'M'),
    (3, 1, 'W'),
    (3, 2, 'T'),
    (3, 2, 'Th'),
    (4, 1, 'M'),
    (4, 1, 'W'),
    (4, 2, 'T'),
    (4, 2, 'Th'),
    (5, 1, 'M'),
    (5, 1, 'W'),
    (5, 2, 'T'),
    (5, 2, 'Th'),
    (6, 1, 'M'),
    (6, 1, 'W'),
    (6, 2, 'T'),
    (6, 2, 'Th');

INSERT INTO Student (Major_DepartmentNumber, FirstName, LastName, StreetAddress, City, State, ZipCode, Sex, PhoneArea, PhoneSeven)
VALUES
    (1, 'Mohammad', 'Miranda', '1675 Commodo Road', 'Zamboanga City', 'CA', '90210', 'M', '152', '8621042'),
    (1, 'Beatrice', 'Elliott', '2470 Ad Road', 'Sevsk', 'TX', '98101', 'F', '941', '3163508'),
    (1, 'Cole', 'Robbins', '6737 Ut Street', 'North-Eastern Islands', 'FL', '60611', 'M', '949', '4201207'),
    (1, 'Ignatius', 'Henson', '681-7276 Cursus Av', 'Ålesund', 'NY', '10001', 'M', '016', '1438048'),
    (1, 'Noble', 'Mcpherson', '275-2111 Iaculis Av', 'Puerto Nariño', 'IL', '33139', 'F', '222', '3806292'),
    (2, 'Rebecca', 'Hicks', '2053 Ante Av', 'Tumaco', 'PA', '75201', 'F', '531', '4340244'),
    (2, 'Martin', 'Solis', '734-9344 Dis Rd', 'Iquitos', 'OH', '94110', 'M', '123', '6555316'),
    (2, 'Quinlan', 'Bowers', '524-7633 Consectetuer Rd', 'Cork', 'GA', '90265', 'M', '654', '5351232'),
    (2, 'Sonya', 'Mann', '725-9403 Iaculis Road', 'Kryvyi Rih', 'MI', '20001', 'F', '263', '5415153'),
    (2, 'Barclay', 'Tyson', 'Ap #934-7943 Auctor St', 'Heredia', 'NC', '02116', 'M', '876', '9299322');

INSERT INTO Student_Minor (CWID, Minor_DepartmentNumber)
VALUES
    (1, 2),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 1),
    (7, 1),
    (8, 1),
    (9, 1),
    (10, 1);

INSERT INTO Student_Section_Enrollment (CWID, CourseNumber, SectionNumber, Grade)
VALUES
    (1, 1, 1, 'A'),
    (2, 1, 2, 'B'),
    (3, 2, 1, 'C'),
    (4, 2, 2, 'B+'),
    (5, 3, 1, 'F'),
    (6, 3, 2, 'A+'),
    (7, 4, 1, 'D'),
    (8, 4, 2, 'C-'),
    (9, 5, 1, 'B-'),
    (10, 5, 2, 'A-');
