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
			 $q = "select * from Student where s_rollnumber = '" .$_POST["s_roll"]."'";
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			$row11 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);
			
			if($row11){
				 $q = "select * from registration_history where s_rollnumber = '" .$_POST["s_roll"]."' and R_status = 1";
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			$row1 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);
				
				if(!$row1){
					
					echo "<br>Sorry This Student Haven't completed previous course<br>";
				}
				else{
				
			$q="insert into Registration(challanNumber,s_rollnumber,R_status) values (".$_POST["fFinal"].",'".$_POST["s_roll"]."',0)";
			$query_id = oci_parse($con, $q); 		
			$r = oci_execute($query_id); 
			 if($r)
	 {

			 echo "Registered<br>";
			 echo "<br>";
	 }
	 else
	 {
		 echo "Not Registered!<br>";
		 $e = oci_error($query_id);  
		 echo $e['message'];
	 }
			
				}
			}
			
			else{
				
				echo "<br>Sorry!!! No Record Found For This Student<br>";
			}
			}


?>
</body>
</html>

