<html>

<head>
<title>Database connection </title>
</head>
<?php  // creating a database connection 
$target_dir = "";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));

// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
  $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
  if($check !== false) {
    echo "File is an image - " . $check["mime"] . ".<br>";
    $uploadOk = 1;
  } else {
    echo "File is not an image.<br>";
    $uploadOk = 0;
  }
}

// Check if file already exists
if (file_exists($target_file)) {
  echo "Sorry, file already exists.";
  $uploadOk = 0;
}

// Check file size
if ($_FILES["fileToUpload"]["size"] > 500000) {
  echo "Sorry, your file is too large.<br>";
  $uploadOk = 0;
}

// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
  echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.<br>";
  $uploadOk = 0;
}

// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
  echo "Sorry, your file was not uploaded.<br>";
// if everything is ok, try to upload file
} else {
  if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
    echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.<br>";
  } else {
    echo "Sorry, there was an error uploading your file.<br>";
  }
}
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
	$now = time();
	//echo $now;
	$h  = strtotime($_POST["DOB"]);
	$difference = $now - $h ;
	$ag =$difference/31556926;	 
	 if($ag<5 && $_POST["G_Gender"]=='M'){
		
			 echo "please select a female Guardian!!!!";
			 
	 }
	 
	 else{
			$sql_select="select * from Father" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row9 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);

			
		 
		  if(!$row9)
		 {

				 echo "NO Father Record Available!!!";
				 echo "<br>";
				 
				  $q="insert into Father(f_name,f_cnic,f_num,f_address,f_mail,f_income,f_isalive,f_emp_ID) values('".$_POST["F_name"]."','".$_POST["F_CNIC"]."','".$_POST["F_contact"]."','".$_POST["F_add"]."','".$_POST["F_email"]."','".$_POST["F_inc"]."','".$_POST["F_isalive"]."','".$_POST["F_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Father Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Father Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
				 
		 }
		 else
		 {

			 $q="select * from Father where f_cnic=".$_POST["F_CNIC"] ;
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			 $row21 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);
				
			 if (!$row21)
			 {
				 echo "Father Record not inserted Before!<br>";
				 
				 $q="insert into Father(f_name,f_cnic,f_num,f_address,f_mail,f_income,f_isalive,f_emp_ID) values('".$_POST["F_name"]."','".$_POST["F_CNIC"]."','".$_POST["F_contact"]."','".$_POST["F_add"]."','".$_POST["F_email"]."','".$_POST["F_inc"]."','".$_POST["F_isalive"]."','".$_POST["F_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Father Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Father Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			 }
			 
			 else
			 {

					 echo "Father Record Available!!!";
					 echo "<br>";
			 }
			 
		 } 
	 
			$sql_select="select * from Mother" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row10 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
			
			 if(!$row10)
			{

				 echo "NO Mother Record Available!!!";
				 echo "<br>";
	 
				 $q="insert into Mother(m_name,m_cnic,m_num,m_address,m_mail,m_income,m_isalive,m_emp_ID) values('".$_POST["M_name"]."','".$_POST["M_CNIC"]."','".$_POST["M_contact"]."','".$_POST["M_add"]."','".$_POST["M_email"]."','".$_POST["M_inc"]."','".$_POST["M_isalive"]."','".$_POST["M_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Mother Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Mother Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
	 
			}
			 else
			{

			 $q = "select * from Mother where m_name = '" .$_POST["M_name"]."' and m_cnic = '" .$_POST["M_CNIC"]."' " ;
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			$row21 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);

			 if($row21)
			 {

					 echo "Mother Record Available!!!";
					 echo "<br>";
			 }
			 else
			 {
				 echo "Mother Record not inserted Before!<br>";
				 
				 $q="insert into Mother(m_name,m_cnic,m_num,m_address,m_mail,m_income,m_isalive,m_emp_ID) values('".$_POST["M_name"]."','".$_POST["M_CNIC"]."','".$_POST["M_contact"]."','".$_POST["M_add"]."','".$_POST["M_email"]."','".$_POST["M_inc"]."','".$_POST["M_isalive"]."','".$_POST["M_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Mother Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Mother Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			 }
			}
	 
	 
			$sql_select="select * from Guardian" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row11 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);

			
			 if(!$row11)
			{

				 echo "NO Guardian Record Available!!!";
				 echo "<br>";

				 $q="insert into Guardian(g_name,g_cnic,g_gender,g_num,g_address,g_mail,g_income,g_emp_ID) values('".$_POST["G_name"]."','".$_POST["G_CNIC"]."','".$_POST["G_Gender"]."','".$_POST["G_contact"]."','".$_POST["G_Address"]."','".$_POST["G_email"]."','".$_POST["G_inc"]."','".$_POST["G_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Guardian Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Guardian Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			}
			else
			{

			 $q = "select * from Guardian where g_name = '" .$_POST["G_name"]."' and g_cnic = '" .$_POST["G_CNIC"]."' " ;
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			$row11 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);
			 
			 if($row11)
			 {

					 echo "Guardian Record Available!!!";
					 echo "<br>";
			 }
			 else
			 {
				 echo "Guardian Record not inserted Before!<br>";
				 $q="insert into Guardian(g_name,g_cnic,g_gender,g_num,g_address,g_mail,g_income,g_emp_ID) values('".$_POST["G_name"]."','".$_POST["G_CNIC"]."','".$_POST["G_Gender"]."','".$_POST["G_contact"]."','".$_POST["G_Address"]."','".$_POST["G_email"]."','".$_POST["G_inc"]."','".$_POST["G_eid"]."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Guardian Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Guardian Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			 }
			}
	
	
			$sql_select="select f_ID from Father where f_cnic='" .$_POST["F_CNIC"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
        	$runselect = oci_execute($query_id3);
			$row1 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
		 
		  	$sql_select="select m_ID from Mother where m_cnic='" .$_POST["M_CNIC"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
        	$runselect = oci_execute($query_id3); 
			$row2 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
		 
		  	$sql_select="select g_ID from Guardian where g_cnic='" .$_POST["G_CNIC"]."'" ;
			$query_id3 = oci_parse($con, $sql_select);
        	$runselect = oci_execute($query_id3);
			$row3 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
	
			
			$sql_select="select * from Student" ;
			$query_id3 = oci_parse($con, $sql_select);
			$runselect = oci_execute($query_id3);
			$row12 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
			
			 if(!$row12)
			{

				 echo "NO Student Record Available!!!";
				 echo "<br>";
				 $hamza = $_POST["DOB"];
				 echo $hamza;
	
			$q="insert into Student(s_name,s_bayformno,s_gender,DOB,f_ID,m_id,g_id,relation,s_pid) 
			values( '". $_POST["Name"]."',".$_POST["bform"].",'".$_POST["gender"]."',to_date('".$_POST["DOB"]."','yyyy/mm/dd'),'".$row1[0]."','".$row2[0]."','".$row3[0]."','".$_POST["G_relation"]."','".basename($_FILES["fileToUpload"]["name"])."')";

				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Student Insertion Successful!!!";
						 echo "<br>";
						 $sql_select="select s_rollnumber from student where s_bayformno='".$_POST["bform"]."'";
			$query_id3 = oci_parse($con, $sql_select);
        	$runselect = oci_execute($query_id3);
			$row3 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
			$q="insert into Registration(challanNumber,s_rollnumber,R_status) values (".$_POST["fFinal"].",'".$row3[0]."',0)";
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
				 else
				 {
					 echo "Student Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			}
			else
			{

			 $q = "select * from Student where s_name = '" .$_POST["Name"]."' and s_bayformno = " .$_POST["bform"] ;
			 $query_id = oci_parse($con, $q); 		
			 $r = oci_execute($query_id); 
			$row11 = oci_fetch_array($query_id, OCI_BOTH+OCI_RETURN_NULLS);

			 if($row11)
			 {

					 echo "Student Record Available!!!";
					 echo "<br>";
			 }
			 else
			 {
				 echo "Student Record not inserted Before!<br>";
			
				 
				 $q="insert into Student(s_name,s_bayformno,s_gender,DOB,f_ID,m_ID,g_ID,relation,s_pid) values( '". $_POST["Name"]."','".$_POST["bform"]."','".$_POST["gender"]."', to_date('".$_POST["DOB"]."','yyyy/MM/dd'),'".$row1[0]."'  , '".$row2[0]."', '".$row3[0]."' ,'".$_POST["G_relation"]."' ,'".basename($_FILES["fileToUpload"]["name"])."')";
				 $query_id = oci_parse($con, $q); 		
				 $r = oci_execute($query_id); 

				 // Selected the Inserted Record and shows on the webpage 
				 if($r)
				 {

						 echo "Student Insertion Successful!!!";
						 echo "<br>";
				 }
				 else
				 {
					 echo "Student Record not inserted!<br>";
					 $e = oci_error($query_id);  
					 echo $e['message'];
				 }
			 
			 	$sql_select="select s_rollnumber from student where s_bayformno='".$_POST["bform"]."'";
			$query_id3 = oci_parse($con, $sql_select);
        	$runselect = oci_execute($query_id3);
			$row3 = oci_fetch_array($query_id3, OCI_BOTH+OCI_RETURN_NULLS);
			$q="insert into Registration(challanNumber,s_rollnumber,R_status) values (".$_POST["fFinal"].",'".$row3[0]."',0)";
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
			
			
		

			
	 
	 echo "<br><br><br>";

	 }
$q="commit";
			$query_id = oci_parse($con, $q); 		
			$r = oci_execute($query_id);
	}

?>
</body>
</html>

