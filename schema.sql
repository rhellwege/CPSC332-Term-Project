USE cpsc332e7;

CREATE TABLE Professor (
	Ssn       INT,
	FirstName VARCHAR(255),
	LastName  VARCHAR(255),

	PRIMARY KEY (Ssn)
);

CREATE TABLE Professor_Degrees (
	Degree VARCHAR(255),
	Professor_Ssn INT,

	FOREIGN KEY (Professor_Ssn) Professor,
	PRIMARY KEY (Degree, Professor_Ssn)
)

CREATE TABLE Department (
	DepartmentNumber INT,
	DepartmentName VARCHAR(255),
	OfficeLocation VARCHAR(255),
	DepartmentPhone VARCHAR(255),
	Chairperson_Ssn INT,

	PRIMARY KEY (DepartmentNumber),
	FOREIGN KEY (Chairperson_Ssn) REFERENCES (Professor)
);

CREATE TABLE Course (
	CourseNumber INT,
	Textbook VARCHAR(255),
	Units INT,
	Title VARCHAR(255),
	OfferedBy_DepartmentNumber INT,

	FOREIGN KEY (OfferedBy_DepartmentNumber) REFERENCES (Department),
	PRIMARY KEY (CourseNumber)
);

CREATE TABLE Course_Prerequisites (
	CourseNumber INT,
	Prerequisite_CourseNumber INT,

	PRIMARY KEY (CourseNumber, PrerequisiteCourseNumber),
	FOREIGN KEY (CourseNumber) REFERENCES (Course),
	FOREIGN KEY (PrerequisiteCourseNumber) REFERENCES (Course),

);

CREATE TABLE Course_Section (
	SectionNumber INT,
	Course_Number INT,
	Classroom VARCHAR(255),
	Seats INt,
	BeginTime TIMESTAMP,
	EndTime TIMESTAMP,
	Professor_Ssn INT,

	PRIMARY KEY (SectionNumber, Course_Number)
	FOREIGN KEY (Professor_Ssn) REFERENCES (Professor),
	FOREIGN KEY (Course_Number) REFERENCES (Course),

);

CREATE TABLE Course_Section_Days (
	Section_Number INT,
	Day VARCHAR(10),

	FOREIGN KEY (Section_Number) REFERENCES (Course_Section),
	PRIMARY KEY (Section_Number, Day)

);

CREATE TABLE Student (
	CWID INT,
	Address VARCHAR(255),
	FirstName VARCHAR(255),
	LastName VARCHAR(255),
	Phone CHAR(7),
	Major_DepartmentNumber INT,

	PRIMARY KEY (CWID),
	FOREIGN KEY (Major_DepartmentNumber) REFERENCES (Department)
);

CREATE TABLE Student_Minor (
	CWID INT,
	Minor_DepartmentNumber INT,

	PRIMARY KEY (CWID, Minor_DepartmentNumber),
	FOREIGN KEY (CWID) REFERENCES (Student),
	FOREIGN KEY (Minor_DepartmentNumber) REFERENCES (Department),
);

