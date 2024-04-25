USE cpsc332e7;

CREATE TABLE Professor (
	Ssn       INT NOT NULL,
	FirstName VARCHAR(255),
	LastName  VARCHAR(255),

	PRIMARY KEY (Ssn)
);

CREATE TABLE Professor_Degrees (
	Degree VARCHAR(255) NOT NULL,
	Professor_Ssn INT NOT NULL,

	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (Degree, Professor_Ssn)
);

CREATE TABLE Department (
	DepartmentNumber INT NOT NULL,
	DepartmentName VARCHAR(255),
	OfficeLocation VARCHAR(255),
	DepartmentPhone VARCHAR(255),
	Chairperson_Ssn INT,

	FOREIGN KEY (Chairperson_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (DepartmentNumber)
);

CREATE TABLE Course (
	CourseNumber INT NOT NULL,
	Textbook VARCHAR(255),
	Units INT,
	Title VARCHAR(255),
	OfferedBy_DepartmentNumber INT,

	FOREIGN KEY (OfferedBy_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CourseNumber)
);

CREATE TABLE Course_Prerequisites (
	CourseNumber INT NOT NULL,
	Prerequisite_CourseNumber INT NOT NULL,

	PRIMARY KEY (CourseNumber, Prerequisite_CourseNumber),
	FOREIGN KEY (CourseNumber) REFERENCES Course(CourseNumber),
	FOREIGN KEY (Prerequisite_CourseNumber) REFERENCES Course(CourseNumber)
);

CREATE TABLE Course_Section (
	SectionNumber INT NOT NULL,
	Course_Number INT NOT NULL,
	Classroom VARCHAR(255),
	Seats INt,
	BeginTime TIMESTAMP,
	EndTime TIMESTAMP,
	Professor_Ssn INT,

	PRIMARY KEY (SectionNumber, Course_Number),
	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	FOREIGN KEY (Course_Number) REFERENCES Course(CourseNumber)
);

CREATE TABLE Course_Section_Days (
	Section_Number INT NOT NULL,
	Day VARCHAR(10),

	FOREIGN KEY (Section_Number) REFERENCES Course_Section(SectionNumber),
	PRIMARY KEY (Section_Number, Day)
);

CREATE TABLE Student (
	CWID INT NOT NULL,
	Address VARCHAR(255),
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	Phone CHAR(7),
	Major_DepartmentNumber INT NOT NULL,

	PRIMARY KEY (CWID),
	FOREIGN KEY (Major_DepartmentNumber) REFERENCES Department(DepartmentNumber)
);

CREATE TABLE Student_Minor (
	CWID INT NOT NULL,
	Minor_DepartmentNumber INT NOT NULL,

	PRIMARY KEY (CWID, Minor_DepartmentNumber),
	FOREIGN KEY (CWID) REFERENCES Student(CWID),
	FOREIGN KEY (Minor_DepartmentNumber) REFERENCES Department(DepartmentNumber)
);

