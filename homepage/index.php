<?php
include "util.php";

echo "hello, this is php";
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

$sql =
    "SELECT Ssn AS 'SSN', FirstName AS 'First', LastName AS 'Last' FROM Professor;";
$result = $mysqli->query($sql);

if ($result === false) {
    error_log("MYSQL query failed: " . $mysqli->error);
    exit();
}

$table = format_sql_result($result);

echo $table;

// cleanup
$result->free_result();
$mysqli->close();
?>

<html>
<head>
	<title>Hello World</title>
</head>
<body>
	<form action="sample.php" method="POST">
	Enter First Name: <input type="text" name="fname">
	<input type="submit">
	</form>

</body>
</html>
