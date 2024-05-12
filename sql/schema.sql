USE USERNAME;

CREATE TABLE Professor (
	Ssn           CHAR(9) NOT NULL,
	FirstName     VARCHAR(255),
	LastName      VARCHAR(255),
	StreetAddress VARCHAR(255),
	City          VARCHAR(255),
	State         VARCHAR(255),
	ZipCode       CHAR(5),
	Sex           CHAR,
	PhoneArea     CHAR(3),
	PhoneSeven    CHAR(7),
	Title         VARCHAR(255),
	Salary        DECIMAL,

	PRIMARY KEY (Ssn)
);

CREATE TABLE Professor_Degrees (
	Professor_Ssn CHAR(9)      NOT NULL,
	Degree        VARCHAR(255) NOT NULL,

	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (Degree, Professor_Ssn)
);

CREATE TABLE Department (
	DepartmentNumber INT NOT NULL AUTO_INCREMENT,
	Chairperson_Ssn  CHAR(9),
	Name             VARCHAR(255),
	OfficeLocation   VARCHAR(255),
	PhoneArea    CHAR(3),
	PhoneSeven   CHAR(7),

	FOREIGN KEY (Chairperson_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (DepartmentNumber)
);

CREATE TABLE Course (
	CourseNumber               INT NOT NULL AUTO_INCREMENT,
	OfferedBy_DepartmentNumber INT,
	Units                      INT,
	Textbook                   VARCHAR(255),
	Title                      VARCHAR(255),

	FOREIGN KEY (OfferedBy_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CourseNumber)
);

CREATE TABLE Course_Prerequisites (
	CourseNumber              INT NOT NULL,
	Prerequisite_CourseNumber INT NOT NULL,

	FOREIGN KEY (CourseNumber)              REFERENCES Course(CourseNumber),
	FOREIGN KEY (Prerequisite_CourseNumber) REFERENCES Course(CourseNumber),
	PRIMARY KEY (CourseNumber, Prerequisite_CourseNumber)
);

CREATE TABLE Course_Section (
	SectionNumber INT NOT NULL,
	CourseNumber  INT NOT NULL,
	Professor_Ssn CHAR(9),
	Classroom     VARCHAR(255),
	Seats         INT,
	BeginTime     TIME,
	EndTime       TIME,

	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	FOREIGN KEY (CourseNumber)  REFERENCES Course(CourseNumber),
	PRIMARY KEY (SectionNumber, CourseNumber),
	UNIQUE  KEY (SectionNumber, CourseNumber)
);

CREATE TABLE Course_Section_Days (
    CourseNumber  INT NOT NULL,
	SectionNumber INT NOT NULL,
	Day           ENUM('M', 'T', 'W', 'Th', 'F', 'Sa', 'Su'),

	FOREIGN KEY (CourseNumber, SectionNumber)  REFERENCES Course_Section(CourseNumber, SectionNumber),
	PRIMARY KEY (CourseNumber, SectionNumber, Day)
);

CREATE TABLE Student (
	CWID                   INT NOT NULL AUTO_INCREMENT,
	Major_DepartmentNumber INT NOT NULL,
	FirstName     VARCHAR(255),
	LastName      VARCHAR(255),
	StreetAddress VARCHAR(255),
	City          VARCHAR(255),
	State         VARCHAR(255),
	ZipCode       CHAR(5),
	Sex           CHAR,
	PhoneArea     CHAR(3),
	PhoneSeven    CHAR(7),

	FOREIGN KEY (Major_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CWID)
);

CREATE TABLE Student_Minor (
	CWID                   INT NOT NULL,
	Minor_DepartmentNumber INT NOT NULL,

	FOREIGN KEY (CWID)                   REFERENCES Student(CWID),
	FOREIGN KEY (Minor_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CWID, Minor_DepartmentNumber)
);

CREATE TABLE Student_Section_Enrollment (
	CWID          INT NOT NULL,
	CourseNumber  INT NOT NULL,
	SectionNumber INT NOT NULL,
	Grade         ENUM('A', 'A-', 'A+', 'B', 'B-', 'B+', 'C', 'C-', 'C+', 'D', 'D-', 'D+', 'F'),

	FOREIGN KEY (CWID)                        REFERENCES Student(CWID),
	FOREIGN KEY (CourseNumber, SectionNumber) REFERENCES Course_Section(CourseNumber, SectionNumber),
	PRIMARY KEY(CWID, CourseNumber, SectionNumber)
);
