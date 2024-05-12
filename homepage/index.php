<?php
// startup script
include "view.php"; // contains code for formatting sql result into grid
$host_name = "mariadb";
$username = "USERNAME";
$password = "PASSWORD";
$db_name = "USERNAME";

date_default_timezone_set("America/Los_Angeles");

$mysqli = new mysqli($host_name, $username, $password, $db_name);

// check connection
if ($mysqli->connect_errno) {
    error_log("MYSQL Connection failed: " . $mysqli->connect_error);
    exit();
}
?>

<html>
<head>
	<title>University DB</title>
</head>
<body>
    <h1 style="text-align:center">Welcome To University Database</h1>
    <p style="text-align:center">Developed by Ryan Hellwege, Luke Zapp</p>
    <p style="text-align:center"><em>Accessed on <?php echo date(
        "F j, Y, g:i a"
    ); ?></em></p>
    <a style="text-align:center" href="./test.php">Test page</a>
    <hr>
    <div>
        <h2 style="text-align:center">Professor Interface</h2>
        <hr>
        <h3>Meeting Information</h3>
        <p>
            Access a professor's section meeting locations and times by inputting their social security number below.
        </p>
        <!-- display results on the same page, so redirect here -->
        <form method=POST>
            <em>Enter Professor Ssn: </em><br><input type = "text" name="professor_ssn" placeholder="123456789"></input>
                <input type="submit">
        </form>
        <?php if (isset($_POST["professor_ssn"])) {
            $professor_ssn = $_POST["professor_ssn"];
            $name_query = "SELECT FirstName, LastName FROM Professor WHERE Ssn = '$professor_ssn'";
            try {
                $name_resp = $mysqli->query($name_query);
                $row = $name_resp->fetch_assoc();
                $first_name = $row["FirstName"];
                $last_name = $row["LastName"];
                echo "<h3>Results for $professor_ssn ($first_name $last_name)</h3>";
                $name_resp->close();
            } catch (Exception $e) {
                printf("<p>SQL ERROR: %s</p>", $e->getMessage());
            }

            $sql_query = "
                SELECT Title, Classroom, Days, BeginTime, EndTime
                FROM (
                    SELECT CS.CourseNumber, CS.SectionNumber, C.Title, CS.Classroom,
                        GROUP_CONCAT(CSD.Day SEPARATOR ' ') AS Days, CS.BeginTime, CS.EndTime
                    FROM
                        Professor AS P JOIN Course_Section AS CS
                            ON P.Ssn = CS.Professor_Ssn
                        JOIN Course AS C
                            ON CS.CourseNumber = C.CourseNumber
                        JOIN Course_Section_Days AS CSD
                            ON CSD.SectionNumber = CS.SectionNumber
                            AND CSD.CourseNumber = CS.CourseNumber
                    WHERE
                        P.Ssn = '$professor_ssn'
                    GROUP BY C.CourseNumber, CS.SectionNumber
                ) AS Subquery;
            ";
            try {
                $meeting_resp = $mysqli->query($sql_query);
                echo format_sql_result($meeting_resp);
                $meeting_resp->close();
                echo "<br><form style='display: inline' method=GET>
                        <button>Reset</button>
                      </form>";
            } catch (Exception $e) {
                printf("<p>SQL ERROR: %s</p>", $e->getMessage());
            }
        } ?>
        <hr>
        <h3>Section Grades</h3>
        <p>
            See how many students got each grade in a section.
        </p>
        <!-- display results on the same page, so redirect here -->
        <form method=POST>
            <em>Enter Course Number: </em><br><input type = "text" name="prof_course_number" placeholder="1"></input><br><br>
            <em>Enter Section Number: </em><br><input type = "text" name="prof_section_number" placeholder="1"></input>
                <input type="submit">
        </form>
        <?php if (
            isset($_POST["prof_course_number"]) &&
            isset($_POST["prof_section_number"])
        ) {
            $course_number = $_POST["prof_course_number"];
            $section_number = $_POST["prof_section_number"];
            echo "<h3>Results for Course $course_number Section $section_number</h3>";
            $sql_query = "
                SELECT Grade, COUNT(*) AS 'Student Count'
                FROM Student_Section_Enrollment AS E
                WHERE
                    E.CourseNumber = '$course_number'
                    AND E.SectionNumber = '$section_number'
                GROUP BY Grade;
            ";
            try {
                $grades_resp = $mysqli->query($sql_query);
                echo format_sql_result($grades_resp);
                $grades_resp->close();
                echo "<br><form style='display: inline' method=GET>
                        <button>Reset</button>
                      </form>";
            } catch (Exception $e) {
                printf("<p>SQL ERROR: %s</p>", $e->getMessage());
            }
        } ?>
    </div>
    <hr>
    <div>
        <h2 style="text-align:center">Student Interface</h2>
        <hr>
        <h3>Course Section Information</h3>
        <p>
            See the meeting information for all sections of a course as well as how many students are enrolled.
        </p>
        <form method=POST>
            <em>Enter Course Number: </em><br><input type = "text" name="stu_course_number" placeholder="1"></input><br><br>
                <input type="submit">
        </form>
        <?php if (isset($_POST["stu_course_number"])) {
            $course_number = $_POST["stu_course_number"];
            $title_query = "SELECT Title FROM Course WHERE CourseNumber = $course_number";
            try {
                $title_resp = $mysqli->query($title_query);
                $row = $title_resp->fetch_assoc();
                $course_title = $row["Title"];
                echo "<h3>Results for Course Number $course_number ($course_title)</h3>";
                $title_resp->close();
            } catch (Exception $e) {
                printf("<p>SQL ERROR: %s</p>", $e->getMessage());
            }
            $sql_query = "
            SELECT CS.SectionNumber, CS.Classroom, CS.BeginTime, CS.EndTime,
                GROUP_CONCAT(DISTINCT CSD.Day SEPARATOR ' ') AS Days,
                COUNT(DISTINCT E.CWID) AS 'Enrollment Count'
            FROM Course_Section AS CS
                JOIN Course_Section_Days AS CSD
                    ON CS.CourseNumber = CSD.CourseNumber
                    AND CS.SectionNumber = CSD.SectionNumber
                JOIN Student_Section_Enrollment AS E
                    ON CS.CourseNumber = E.CourseNumber
                    AND CS.SectionNumber = E.SectionNumber
            WHERE CS.CourseNumber = $course_number
            GROUP BY CS.SectionNumber;
            ";
            try {
                $grades_resp = $mysqli->query($sql_query);
                echo format_sql_result($grades_resp);
                $grades_resp->close();
                echo "<br><form style='display: inline' method=GET>
                        <button>Reset</button>
                      </form>";
            } catch (Exception $e) {
                printf("<p>SQL ERROR: %s</p>", $e->getMessage());
            }
        } ?>
        <hr>
    </div>
</body>
</html>
