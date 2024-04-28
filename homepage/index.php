<?php
include "util.php";

echo "hello, this is php";
$host_name = "mariadb";
$username = "cs332e7";
$password = "password";
$db_name = "cs332e7";

$mysqli = new mysqli($host_name, $username, $password, $db_name);

// check connection
if ($mysqli->connect_errno) {
    printf("MYSQL Connection failed: %s\n", $mysqli->connect_error);
    exit();
}

$sql = "SELECT * FROM Professor;";
$result = $mysqli->query($sql);

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
