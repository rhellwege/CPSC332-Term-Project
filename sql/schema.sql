USE cpsc332e7;

DROP TABLE IF EXISTS Professor;
CREATE TABLE Professor (
	Ssn       CHAR(9) NOT NULL,
	FirstName VARCHAR(255),
	LastName  VARCHAR(255),

	PRIMARY KEY (Ssn)
);

DROP TABLE IF EXISTS Professor_Degrees;
CREATE TABLE Professor_Degrees (
	Degree        VARCHAR(255) NOT NULL,
	Professor_Ssn CHAR(9)      NOT NULL,

	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (Degree, Professor_Ssn)
);

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	DepartmentNumber INT NOT NULL AUTO_INCREMENT,
	Chairperson_Ssn  CHAR(9),
	DepartmentName   VARCHAR(255),
	OfficeLocation   VARCHAR(255),
	DepartmentPhone  VARCHAR(255),

	FOREIGN KEY (Chairperson_Ssn) REFERENCES Professor(Ssn),
	PRIMARY KEY (DepartmentNumber)
);

DROP TABLE IF EXISTS Course;
CREATE TABLE Course (
	CourseNumber               INT NOT NULL AUTO_INCREMENT,
	Textbook                   VARCHAR(255),
	Units                      INT,
	Title                      VARCHAR(255),
	OfferedBy_DepartmentNumber INT,

	FOREIGN KEY (OfferedBy_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CourseNumber)
);

DROP TABLE IF EXISTS Course_Prerequisites;
CREATE TABLE Course_Prerequisites (
	CourseNumber              INT NOT NULL,
	Prerequisite_CourseNumber INT NOT NULL,

	FOREIGN KEY (CourseNumber)              REFERENCES Course(CourseNumber),
	FOREIGN KEY (Prerequisite_CourseNumber) REFERENCES Course(CourseNumber),
	PRIMARY KEY (CourseNumber, Prerequisite_CourseNumber)
);

DROP TABLE IF EXISTS Course_Section;
CREATE TABLE Course_Section (
	SectionNumber INT NOT NULL AUTO_INCREMENT,
	CourseNumber  INT NOT NULL,
	Professor_Ssn CHAR(9),
	Classroom     VARCHAR(255),
	Seats         INT,
	BeginTime     TIME,
	EndTime       TIME,

	FOREIGN KEY (Professor_Ssn) REFERENCES Professor(Ssn),
	FOREIGN KEY (CourseNumber)  REFERENCES Course(CourseNumber),
	PRIMARY KEY (SectionNumber, CourseNumber)
);

DROP TABLE IF EXISTS Course_Section_Days;
CREATE TABLE Course_Section_Days (
	SectionNumber INT NOT NULL,
	Day           VARCHAR(2),

	CONSTRAINT  CHK_DayFormat = CHECK Day IN ("M", "T", "W", "Th", "F", "Sa", "Su"),
	FOREIGN KEY (SectionNumber) REFERENCES Course_Section(SectionNumber),
	PRIMARY KEY (SectionNumber, Day)
);

DROP TABLE IF EXISTS Student;
CREATE TABLE Student (
	CWID                   INT NOT NULL AUTO_INCREMENT,
	Major_DepartmentNumber INT NOT NULL,
	Address                VARCHAR(255),
	FirstName              VARCHAR(255),
	LastName               VARCHAR(255),
	StudentPhone           CHAR(7),

	FOREIGN KEY (Major_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CWID)
);

DROP TABLE IF EXISTS Student_Minor;
CREATE TABLE Student_Minor (
	CWID                   INT NOT NULL,
	Minor_DepartmentNumber INT NOT NULL,

	FOREIGN KEY (CWID)                   REFERENCES Student(CWID),
	FOREIGN KEY (Minor_DepartmentNumber) REFERENCES Department(DepartmentNumber),
	PRIMARY KEY (CWID, Minor_DepartmentNumber)
);

DROP TABLE IF EXISTS Student_Section_Enrollment;
CREATE TABLE Student_Section_Enrollment (
	CWID         INT NOT NULL,
	CourseNumber INT NOT NULL,
	Grade        VARCHAR(2),

	CONSTRAINT  CHK_GradeFormat = CHECK Grade IN ("A", "A-", "A+", "B", "B-", "B+", "C", "C-", "C+", "D", "D-", "D+", "F")
	FOREIGN KEY (CWID)            REFERENCES Student(CWID),
	FOREIGN KEY (CourseNumber)    REFERENCES Course(CourseNumber),
	PRIMARY KEY(CWID, CourseNumber)
);
