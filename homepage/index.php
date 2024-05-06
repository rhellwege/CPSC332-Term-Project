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
    <h1>Welcome To University Database</h1>
    <a href="/test.php">Test page</a>
    <div>
        <h2>Professor Interface</h2>
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
    </div>
    <div>
        <h2>Student Interface</h2>

    </div>
    <form action="sample.php" method="POST">
	Enter First Name: <input type="text" name="fname">
	<input type="submit">
	</form>

</body>
</html>
