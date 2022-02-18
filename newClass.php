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

	 
	 echo "<br>";
	 echo "<br>";
	 
			$sql_select="select class_id from class where class_id=".$_POST["new_class"] ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);

		
		 
		  if(!$row9)
		 {

				 echo "Sorry the section donot exist!!!";
				 echo "<br>";
				 
		 }
		 else
		 {
			
			$sql_select="select class_id from registration where class_id= ".$_POST["cur_Class"]." and s_rollnumber = '".$_POST["s_roll"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
		 
		  if(!$row9)
		 {

				 echo "Sorry the student donot exist in that section!!!";
				 echo "<br>";
				 
		 }
		 else{
			
			$sql_select="select count(*) from registration where class_id=".$_POST["new_class"] ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);

		 
		  if($row9[0] < 5)
		 {
			 $sql_select="update Registration set class_id = '".$_POST["new_class"]."' where s_rollnumber ='".$_POST["s_roll"]."' and class_id='".$_POST["cur_Class"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3); 
			$sql_select="update Registration_history set SECTION_CHANGE ='". $_POST["r_change"]."' where s_rollnumber ='".$_POST["s_roll"]."' and cl_id ='".$_POST["cur_Class"]."'";
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3); 
			echo "<br> Updation successfull!!!<br>";

				
				 
		 }
		 else
		 {
			  echo "<br>Sorry the section is full!!!";
				 echo "<br>";
			 
		 }
			 
			
		 }
			
		 }
	 echo "<br><br><br>";



	}

?>
</body>
</html>

