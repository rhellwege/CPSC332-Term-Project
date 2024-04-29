<?php
include "util.php";
$host_name = "mariadb";
$username = "cs332e7";
$password = "2wJ3Nbfa";
$db_name = "cs332e7";

$mysqli = new mysqli($host_name, $username, $password, $db_name);

// check connection
if ($mysqli->connect_errno) {
    error_log("MYSQL Connection failed: " . $mysqli->connect_error);
    exit();
}

function test_table(mysqli $mysqli, string $table): string
{
    $resp = $mysqli->query("SELECT * FROM $table;");
    $output = format_sql_result($resp);
    $resp->close();
    return $output;
}
?>
<html>
<head>
    <title>Test Suite</title>
</head>
<body>
    <h1>Debug / Testing Page</h1>
    <a href="/">Go back</a>


    <?php if (isset($_POST["sql_query"])) {
        $sql_query = $_POST["sql_query"];
        echo "<h2>Test Output</h2>";
        echo "<span>Last Command:<br>$sql_query</span>";
        try {
            $test_resp = $mysqli->query($sql_query);
            echo format_sql_result($test_resp);
            $test_resp->close();
        } catch (Exception $e) {
            printf("<p>SQL ERROR: %s</p>", $e->getMessage());
        }
    } ?>
    <h2>Test Input</h1>
    <form method=post>
        Enter SQL command: <br><textarea name="sql_query" rows="5" cols="50"></textarea><br>
        <input type="submit">
    </form>
    <h1>All Tables<h1>
    <h2>Professor<h2>
    <?php echo test_table($mysqli, "Professor"); ?>
    <h2>Professor Degrees<h2>
    <?php echo test_table($mysqli, "Professor_Degrees"); ?>
    <h2>Department<h2>
    <?php echo test_table($mysqli, "Department"); ?>
    <h2>Course<h2>
    <?php echo test_table($mysqli, "Course"); ?>
    <h2>Course_Prerequisites<h2>
    <?php echo test_table($mysqli, "Course_Prerequisites"); ?>
    <h2>Course_Section<h2>
    <?php echo test_table($mysqli, "Course_Section"); ?>
    <h2>Course_Section_Days<h2>
    <?php echo test_table($mysqli, "Course_Section_Days"); ?>
    <h2>Student<h2>
    <?php echo test_table($mysqli, "Student"); ?>
    <h2>Student_Minor<h2>
    <?php echo test_table($mysqli, "Student_Minor"); ?>
    <h2>Student_Section_Enrollment<h2>
    <?php echo test_table($mysqli, "Student_Section_Enrollment"); ?>
</body>
</html>
