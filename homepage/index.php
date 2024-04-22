<?php 
	echo "hello, this is php";
	$hostName = 'mariadb';
	$userName = 'username';
	$password = 'password';
	$dbName = 'database';

	$link = mysqli_connect($hostName, $userName, $password, $dbName) or die("Unable to connect to host $hostName");

	$SQL = "SELECT FirstName, LastName, DOB, Gender
	FROM Patients WHERE Gender = 'M' ORDER BY
	FirstName DESC";

	$Patients = $link->query($SQL);

	// $SQL = "INSERT INTO Patients (FirstName, LastName)
	// VALUES('$firstName', '$lastName')";	
	// display results
	if ($Patients->num_rows > 0) {
	    echo "<table>";
	    // Output table header
	    echo "<tr><th>First Name</th><th>Last Name</th><th>Date of Birth</th><th>Gender</th></tr>";

	    // Output data of each row
	    while($row = $Patients->fetch_assoc()) {
		// Step 4: Output the results within an HTML grid structure
		echo "<tr><td>".$row["FirstName"]."</td><td>".$row["LastName"]."</td><td>".$row["DOB"]."</td><td>".$row["Gender"]."</td></tr>";
	    }
	    echo "</table>";
	} else {
	    echo "0 results";
	}
?>
<html>
<head>
	<title>Hello World</title>
	<script>

	</script>
</head>
<body>


</body>
