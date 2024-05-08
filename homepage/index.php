<?php
// startup script
include "util.php"; // contains code for formatting sql result into grid
$host_name = "mariadb";
$username = "USERNAME";
$password = "PASSWORD";
$db_name = "USERNAME";

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
    <a href="/test.php">Test page</a>
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
                SELECT C.Title, CS.Classroom, CSD.Day, CS.BeginTime, CS.EndTime
                FROM
                    Professor AS P JOIN Course_Section AS CS
                    ON P.Ssn = CS.Professor_Ssn
                    JOIN Course AS C
                    ON C.CourseNumber = CS.CourseNumber
                    JOIN Course_Section_Days AS CSD
                    ON CSD.SectionNumber = CS.SectionNumber
                        AND CSD.CourseNumber = CS.SectionNumber
                WHERE
                P.Ssn = '$professor_ssn';
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
            <em>Enter Course Number: </em><br><input type = "text" name="course_number" placeholder="1"></input><br><br>
            <em>Enter Section Number: </em><br><input type = "text" name="section_number" placeholder="1"></input>
                <input type="submit">
        </form>
        <?php if (
            isset($_POST["course_number"]) &&
            isset($_POST["section_number"])
        ) {
            $course_number = $_POST["course_number"];
            $section_number = $_POST["section_number"];
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

    </div>
    <form action="sample.php" method="POST">
	Enter First Name: <input type="text" name="fname">
	<input type="submit">
	</form>

</body>
</html>
