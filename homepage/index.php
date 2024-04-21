<?php 
	echo "hello, this is php";
	$hostName = 'mariadb';
	$userName = 'username';
	$password = 'password';
	$dbName = 'database';

	$link = mysqli_connect($hostName, $userName, $password, $dbName) or die("Unable to connect to host $hostName");
	$SQL = "SELECT FirstName, LastName, DOB, Gender
	FROM Patients WHERE Gender = '$Gender' ORDER BY
	FirstName DESC";
	$Patients = $link->query($SQL);
	 $SQL = "INSERT INTO Patients (FirstName, LastName)
	VALUES('$firstName', '$lastName')";	
?>
<html>
<head>
	<title>Hello World</title>
	<script>

	</script>
</head>
<body>


</body>
