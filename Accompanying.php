<html>
<head>
<title>Database connection </title>
</head>
<?php  // creating a database connection 

	  $db_sid = 
   "(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST =  DESKTOP-PKTE2SQ)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = orcl)
    )
  )";            // Your oracle SID, can be found in tnsnames.ora  ((oraclebase)\app\Your_username\product\11.2.0\dbhome_1\NETWORK\ADMIN) 
  
   $db_user = "scott";   // Oracle username e.g "scott"
   $db_pass = "hamza123";    // Password for user e.g "1234"
   $con = oci_connect($db_user,$db_pass,$db_sid); 
   if($con) 
      { echo "Oracle Connection Successful.<br>"; 
		
		} 
   else 
      { die('Could not connect to Oracle: '); } 

    if(isset($_POST["button"])){

			$sql_select="select * from student where s_rollnumber='".$_POST["s_roll"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);

		 
		  if(!$row9)
		 {
			echo "sorry this student donot belong to our school:";
		 }
		 else{
		 $sql_select="select m_id from mother where m_id='".$_POST["g_ID"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
			  $sql_select="select * from guardian where g_id='".$_POST["g_ID"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row91 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
		  if(!$row9 and !$row91)
		 {
			echo "sorry this Person donot belong to our school:";
		 }
		 else{
	echo "<br>";
	 echo "<br>";
		if(!$_POST["reason"]=="")
			$sql_select="insert into Accompanier (s_rollnumber,id,a_date,a_reason,a_pregnant) values ('".$_POST["s_roll"]."','".$_POST["g_ID"]."',sysdate,'".$_POST["reason"]."','".$_POST["G_isP"]."')";
		else	
		$sql_select="insert into Accompanier (s_rollnumber,id,a_date,a_reason,a_pregnant) values ('".$_POST["s_roll"]."','".$_POST["g_ID"]."',sysdate,'N.R','".$_POST["G_isP"]."')";

			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			 if($runselect)
				 {

						 echo "Accompanier Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Accompanier Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			
	 echo "<br><br><br>";

			 }
		 }
		 
	}

?>
</body>
</html>

