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
    <?php
    $resp = $mysqli->query("SELECT * FROM Professor;");
    echo format_sql_result($resp);
    $resp->close();
    ?>

    <h2>Department<h2>
    <?php
    $resp = $mysqli->query("SELECT * FROM Department;");
    echo format_sql_result($resp);
    $resp->close();
    ?>
</body>
</html>
