<?php
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
  
   $q="drop table class cascade constraints";
	 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);


$q="create table Class(
class_Id  number(10) ,
Section  varchar(1) NOT NULL,
Gender  varchar (5) NOT NULL,
class_Name  varchar(20) NOT NULL
)";
$query_id = oci_parse($con, $q); 		
$r = oci_execute($query_id);


$q="insert into Class(class_id,Section,Gender,Class_Name)
values (100,'A','M','1')";
$q1="insert into Class(class_id,Section,Gender,Class_Name)
values (200,'A','M','2')";
$q2="insert into Class(class_id,Section,Gender,Class_Name)
values (300,'A','M','3')";
$q3="insert into Class(class_id,Section,Gender,Class_Name)
values (400,'A','M','4')";
$q4="insert into Class(class_id,Section,Gender,Class_Name)
values (500,'A','M','5')";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
	  $query_id = oci_parse($con, $q1); 		
	 $r = oci_execute($query_id);
	  $query_id = oci_parse($con, $q2); 		
	 $r = oci_execute($query_id);
	  $query_id = oci_parse($con, $q3); 		
	 $r = oci_execute($query_id);
	  $query_id = oci_parse($con, $q4); 		
	 $r = oci_execute($query_id);
	 

$q="delete from registration";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);

	 
$q="drop package class_id11";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="drop package class_id22";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="drop package class_id33";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="drop package class_id44";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="drop package class_id55";
 $query_id = oci_parse($con, $q); 		
 $r = oci_execute($query_id);
	 
	 
$q="create package class_id11
as cl_id number(3) default 100;
end class_id11;";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);


$q="create package class_id22
as cl_id number(3) default 200;
end class_id22;";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="create package class_id33
as cl_id number(3) default 300;
end class_id33;
";
 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
$q="create package class_id44
as cl_id number(3) default 400;
end class_id44;";
 $query_id = oci_parse($con, $q); 		
$r = oci_execute($query_id);
$q="create package class_id55
as cl_id number(3) default 500;
end class_id55;";
$query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
	 
	 $q="
CREATE OR REPLACE TRIGGER reg_1
  BEFORE INSERT ON Registration
  FOR EACH ROW
declare
noOf number(3);
fa_id varchar(30);
ma_id varchar(30);
empid varchar(30);
age number(5);
con number(3);
counter number(2);
section varchar (3);
class_id1 number(3) default class_id11.cl_id;
class_id2 number(3) default class_id22.cl_id;
class_id3 number(3) default  class_id33.cl_id;
class_id4 number(3) default class_id44.cl_id;
class_id5 number(3) default class_id55.cl_id;
BEGIN
select f.f_emp_id
  into empid
  from student s, father f where s.f_id = f.f_id and s.s_rollnumber = :new.s_rollnumber;
  if empid !='0' then 
    :new.Discount_Percentage:=100;
  else
  select m.m_emp_id
  into empid
  from student s, mother m where s.m_id = m.m_id  and s.s_rollnumber = :new.s_rollnumber;
  end if;
  if empid != '0' then
    :new.Discount_Percentage:=100;
    else
    :new.Discount_Percentage:=0;
      end if;  
      select s.f_id,s.m_id
    into fa_id,ma_id
    from student s where s.s_rollnumber = :new.s_rollnumber;
    select count(*)
    into noOf
    from student s
    where (s.f_id = fa_id) and (s.m_id = ma_id)
    group by s.f_id,s.m_id;

    if(noOf>3) and (:new.Discount_Percentage = 0) then
        :new.Discount_Percentage:=50;
    else
        if (:new.Discount_Percentage = 0) then
        :new.Discount_Percentage:=0;
        end if;
    end if;
:new.R_date := sysdate; 
select (sysdate-dob)/365 
into age
from Student
where student.s_rollnumber=:new.s_rollnumber;
dbms_output.put_line(age);
if age>= 2 and age <=4  then
  BEGIN
       select co_id 
      into :new.co_id
      from course
      where age >=2 and age <=4
      and status = 1;
      :new.feeamount := 10000;
      select max(s.class_count)
      into counter
      from Registration s
      where s.class_id = class_id1;
    exception
      WHEN NO_DATA_FOUND THEN
        counter:=NULL;
         END;
   if counter = 5 then
      counter:=NULL;      
      select c.section into section from Class c where CLASS_ID=class_id1; 
      con:=ascii(section);
      section:=chr(con+1);
      class_id11.cl_id:=class_id11.cl_id+1;
       class_id1:=class_id11.cl_id;

       insert into CLASS values(class_id1,section,'M','1');
       end if;
     IF counter is NULL then
        counter :=1;
        :new.class_count := counter;
        :new.class_id := class_id1;
      ELSE
      counter:=counter+1;
      :new.class_count := counter;
      :new.class_id := class_id1;
     END IF;
end if;
 if age>4 and age <= 6 then
  BEGIN
      select co_id 
      into :new.co_id
      from course
      where age <=6 and age >4
      and status = 1;    
      :new.feeamount := 20000;

      select max(s.class_count)
      into counter
      from Registration s
      where s.class_id = class_id2;
    exception
      WHEN NO_DATA_FOUND THEN
        counter:=NULL;
    
     END;
   if counter = 5 then
      counter:=NULL;      
        select c.section into section from Class c where CLASS_ID=class_id2; 
      con:=ascii(section);
      section:=chr(con+1);
     class_id22.cl_id := class_id22.cl_id+1;
       class_id2:=class_id22.cl_id;
       insert into class values (class_id2,section,'M','2');
    end if;
     IF counter is NULL then
        counter :=1;
        :new.class_count := counter;
        :new.class_id := class_id2;
      ELSE
      counter:=counter+1;
      :new.class_count := counter;
      :new.class_id := class_id2;
     END IF;
  end if;
   if age>6 and age <=9 then
  BEGIN
        select co_id 
      into :new.co_id
      from course
      where age <=9 and age >6
      and status = 1;  
      :new.feeamount := 30000;

      select max(s.class_count)
      into counter
      from Registration s
      where s.class_id = class_id3;
    exception
      WHEN NO_DATA_FOUND THEN
        counter:=NULL;
    
     END;
   if counter = 5 then
      counter:=NULL;      
      select c.section into section from Class c where CLASS_ID=class_id3; 
      con:=ascii(section);
      section:=chr(con+1);
      class_id33.cl_id:=class_id33.cl_id+1;
       class_id3:=class_id33.cl_id;
       insert into class values(class_id3,section,'M','3');
    end if;
     IF counter is NULL then
        counter :=1;
        :new.class_count := counter;
        :new.class_id := class_id3;
      ELSE
      counter:=counter+1;
      :new.class_count := counter;
      :new.class_id := class_id3;
     END IF;
  end if;
  
   if age>9 and age <=13 then
  BEGIN
          select co_id 
      into :new.co_id
      from course
      where age <=13 and age >9
      and status = 1;  
      :new.feeamount := 40000;

      select max(s.class_count)
      into counter
      from Registration s
      where s.class_id = class_id4;
    exception
      WHEN NO_DATA_FOUND THEN
        counter:=NULL;
    
     END;
   if counter = 5 then
      counter:=NULL;      
        select c.section into section from Class c where CLASS_ID=class_id4; 
      con:=ascii(section);
      section:=chr(con+1);
      class_id44.cl_id:=class_id44.cl_id+1;
       class_id4:=class_id44.cl_id;
       insert into class values (class_id4,section,'M','4');
    end if;
     IF counter is NULL then
        counter :=1;
        :new.class_count := counter;
        :new.class_id := class_id4;
      ELSE
      counter:=counter+1;
      :new.class_count := counter;
      :new.class_id := class_id4;
     END IF;
  end if;
  
   if age<=16 and age >13 then
  BEGIN
      select co_id 
      into :new.co_id
      from course
      where age <=16 and age >13
      and status = 1;     
      :new.feeamount := 50000;

      select max(s.class_count)
      into counter
      from Registration s
      where s.class_id = class_id5;
    exception
      WHEN NO_DATA_FOUND THEN
        counter:=NULL;
    
     END;
   if counter = 5 then

      counter:=NULL;      
      select c.section into section from Class c where CLASS_ID=class_id5; 
      con:=ascii(section);
      section:=chr(con+1);
      class_id55.cl_id:=class_id55.cl_id+1;
       class_id5:=class_id55.cl_id;
       insert into class values (class_id5,section,'M','5');
    end if;
     IF counter is NULL then
        counter :=1;
        :new.class_count := counter;
        :new.class_id := class_id5;
      ELSE
      counter:=counter+1;
      :new.class_count := counter;
      :new.class_id := class_id5;
     END IF;
  end if;
  
  DBMS_OUTPUT. PUT_LINE( counter );
END;
";
	 
	 
	 $query_id = oci_parse($con, $q); 		
	 $r = oci_execute($query_id);
	 
	 

?>