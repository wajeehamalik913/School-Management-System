drop table Student cascade constraints;
drop table Student_History cascade constraints;
drop table Class cascade constraints;
drop table Registration cascade constraints;
drop table Registration_History cascade constraints;
drop table Course cascade constraints;
drop table Mother cascade constraints;
drop table Mother_History cascade constraints;
drop table Father cascade constraints;
drop table Father_History cascade constraints;
drop table Guardian cascade constraints;
drop table Guardian_History cascade constraints;
drop table Accompanier cascade constraints;

drop sequence Student_Sequence;
drop sequence course_Sequence;
drop sequence father_sequence;
drop sequence mother_sequence;
drop sequence guardian_sequence;



drop view siblings;
drop view unique_parents;
drop view male1;
drop view female1;
drop view un_male;
drop view boht;
drop view un_female;

create sequence Student_sequence;
create sequence course_Sequence;
create sequence father_sequence;
create sequence mother_sequence;
create sequence guardian_sequence;

drop package class_id11;
drop package class_id22;
drop package class_id33;
drop package class_id44;
drop package class_id55;


create package class_id11
as cl_id number(3) default 100;
end class_id11;
/
create package class_id22
as cl_id number(3) default 200;
end class_id22;
/
create package class_id33
as cl_id number(3) default 300;
end class_id33;
/
create package class_id44
as cl_id number(3) default 400;
end class_id44;
/
create package class_id55
as cl_id number(3) default 500;
end class_id55;
/
create table Guardian(
g_ID varchar2(9) Primary Key,
g_name varchar2(30) NOT NULL,
g_cnic varchar2(13) NOT NULL,
g_gender varchar2(1) NOT NULL,
g_num number(11) NOT NULL,
g_address varchar2(100) NOT NULL,
g_mail varchar2(50) NOT NULL,
g_income number(10) NOT NULL,
g_emp_ID varchar2(30) NOT NULL
);


create table Guardian_History(
sno number,
g_ID varchar2(9) NOT NULL,
g_name varchar2(30) NOT NULL,
constraint G_Pk Primary Key (g_ID,sno),
g_cnic varchar2(13) NOT NULL,
g_gender varchar2(1) NOT NULL,
g_num number(11) NOT NULL,
g_address varchar2(100) NOT NULL,
g_mail varchar2(50) NOT NULL,
g_income number(10) NOT NULL,
g_emp_ID varchar2(30) NOT NULL
);

create table Mother(
m_ID varchar2(9) Primary Key,
m_name varchar2(30) NOT NULL,
m_cnic varchar2(13) NOT NULL,
m_num number(11) NOT NULL,
m_address varchar2(100) NOT NULL,
m_mail varchar2(50) NOT NULL,
m_income number(10) NOT NULL,
m_isalive varchar2(1) NOT NULL,
m_emp_ID varchar2(30) NOT NULL
);

    

create table Mother_History(
sno number,
m_ID varchar2(9) NOT NULL,
constraint m_pk Primary Key(m_ID,sno), 
m_name varchar2(30) NOT NULL,
m_cnic varchar2(13) NOT NULL,
m_num number(11) NOT NULL,
m_address varchar2(100) NOT NULL,
m_mail varchar2(50) NOT NULL,
m_income number(10) NOT NULL,
m_isalive varchar2(1) NOT NULL,
m_emp_ID varchar2(30) NOT NULL
);


create table Father(
f_ID varchar2(9) Primary Key,
f_name varchar2(30) NOT NULL,
f_cnic varchar2(13) NOT NULL,
f_num number(11) NOT NULL,
f_address varchar2(100) NOT NULL,
f_mail varchar2(50) NOT NULL,
f_income number(10) NOT NULL,
f_isalive varchar2(1) NOT NULL,
f_emp_ID varchar2(30) NOT NULL
);


create table Father_History(
sno number,
f_ID varchar2(9) NOT NULL,
Primary Key(f_ID,sno),
f_name varchar2(30) NOT NULL,
f_cnic varchar2(13) NOT NULL,
f_num number(11) NOT NULL,
f_address varchar2(100) NOT NULL,
f_mail varchar2(50) NOT NULL,
f_income number(10) NOT NULL,
f_isalive varchar2(1) NOT NULL,
f_emp_ID varchar2(30) NOT NULL
);

create table Student(
s_rollnumber varchar2(9) Primary Key,
s_name varchar2(30) ,
s_bayformno number(12) ,
s_gender varchar2(1) ,
DOB Date ,
s_yearenrolled Date ,
f_ID varchar2(9) ,
Constraint fFK FOREIGN KEY(f_ID) REFERENCES Father(f_ID),
m_ID varchar2(9) ,
Constraint mFK FOREIGN KEY(m_ID) REFERENCES Mother(m_ID),
g_ID varchar2(9),
relation varchar(10),
Constraint gFK FOREIGN KEY(g_ID) REFERENCES Guardian(g_ID),
s_pid varchar2(100)
);

create table Student_History(
sno number,
s_rollnumber varchar2(9) ,
s_name varchar2(30) NOT NULL,
s_bayformno number(12) NOT NULL,
s_gender varchar2(1) NOT NULL,
DOB Date NOT NULL,
s_yearenrolled Date NOT NULL,
f_ID varchar2(9) NOT NULL,
m_ID varchar2(9) NOT NULL,
g_ID varchar2(9),
relation varchar(10),
constraint pk primary key (sno,s_rollnumber),
s_pid varchar2(100)
);

create table Course(
co_ID varchar2(9) Primary Key,
co_name varchar2(30) NOT NULL,
co_type varchar2(10) NOT NULL,
co_dur varchar2(10) NOT NULL,
age number(3),
status number(3)
);
Create table Accompanier(
s_rollnumber varchar2(9) NOT NULL,
Constraint saFK FOREIGN KEY(s_rollnumber) REFERENCES Student(s_rollnumber),
a_date Date NOT NULL,
Primary Key(s_rollnumber,a_date),
ID varchar2(9) NOT NULL,
a_reason varchar2(50) NOT NULL,
a_Pregnant varchar2(1) NOT NULL
);


create table Class(
class_Id  number(10) ,
Section  varchar(1) NOT NULL,
Gender  varchar (5) NOT NULL,
class_Name  varchar(20) NOT NULL
);



create table Registration(
class_count number,
ChallanNumber varchar2(9) ,
s_rollnumber varchar2(9) ,
Constraint srollnumberFK FOREIGN KEY(s_rollnumber) REFERENCES Student(s_rollnumber),
constraint pk_43 primary key (s_rollnumber,challanNumber),
class_id number ,
co_ID varchar2(9) NOT NULL,
Constraint coIDFK FOREIGN KEY(co_ID) REFERENCES Course(co_ID),
FeeAmount number(5) NOT NULL,
Discount_Percentage number(3) NOT NULL,
R_Date Date NOT NULL,
R_Status varchar2(10) NOT NULL
);
create table Registration_History(
sno number,
ChallanNumber varchar2(9) NOT NULL,
s_rollnumber varchar2(9) NOT NULL,
Primary Key(s_rollnumber,sno),
cl_ID number NOT NULL,
co_ID varchar2(9) NOT NULL,
FeeAmount number(5) NOT NULL,
Discount_Percentage number(3) NOT NULL,
R_Date Date NOT NULL,
R_Status varchar2(10) NOT NULL,
section_change varchar2(200),
dateOfChange date
);


--sequence for course
CREATE OR REPLACE TRIGGER course_1
  BEFORE INSERT ON Course
  FOR EACH ROW
BEGIN
  SELECT course_sequence.nextval
  INTO :new.Co_id
  FROM dual;
END;
/


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
/
--registration history
CREATE OR REPLACE TRIGGER regisration_2
Before update or delete
   ON registration
   FOR EACH ROW
declare sno number(3);
BEGIN
    BEGIN
      select max(s.sno)
      into sno
      from registration_history s
      where s.s_rollnumber=:new.s_rollnumber;
    exception
      WHEN NO_DATA_FOUND THEN
        sno:=NULL;
     END;
    
     IF sno is NULL then
        sno :=1;
      ELSE
      sno:=sno+1;
     END IF;
   
   -- Insert record into student_history table
   INSERT INTO registration_history
(
sno,
ChallanNumber,
s_rollnumber ,
cl_ID ,
co_ID ,
FeeAmount ,
Discount_Percentage ,
R_Date ,
R_Status,
dateofchange)
VALUES
(
sno,
:old.ChallanNumber,
:old.s_rollnumber ,
:old.class_ID ,
:old.co_ID ,
:old.FeeAmount ,
:old.Discount_Percentage ,
:old.R_Date ,
:old.R_Status,
sysdate);
END;
/


--sequence for mother
CREATE OR REPLACE TRIGGER father_1
  BEFORE INSERT ON father
  FOR EACH ROW
declare
counter number;

BEGIN
  SELECT father_sequence.nextval
  INTO counter
  FROM dual;
 :new.f_ID:='F_'||to_char(counter);
END;
/

--father history
CREATE OR REPLACE TRIGGER father_2
Before update or delete
   ON father
   FOR EACH ROW
declare sno number(3);
BEGIN
    BEGIN
      select max(s.sno)
      into sno
      from father_history s
      where s.f_id=:new.f_id;
    exception
      WHEN NO_DATA_FOUND THEN
        sno:=NULL;
     END;
    
     IF sno is NULL then
        sno :=1;
      ELSE
      sno:=sno+1;
     END IF;
   
   -- Insert record into student_history table
   INSERT INTO father_history
(
sno,
f_ID ,
f_name,
f_cnic,
f_num ,
f_address ,
f_mail ,
f_income ,
f_isalive ,
f_emp_ID )
VALUES
(
sno,
:old.f_ID ,
:old.f_name,
:old.f_cnic,
:old.f_num ,
:old.f_address ,
:old.f_mail ,
:old.f_income ,
:old.f_isalive ,
:old.f_emp_ID );
END;
/


--sequence for mother
CREATE OR REPLACE TRIGGER mother_1
  BEFORE INSERT ON mother
  FOR EACH ROW
declare
counter number;

BEGIN
  SELECT mother_sequence.nextval
  INTO counter
  FROM dual;
 :new.m_ID:='M_'||to_char(counter);
END;
/

--mother history
CREATE OR REPLACE TRIGGER mother_2
Before update or delete
   ON mother
   FOR EACH ROW
declare sno number(3);
BEGIN
    BEGIN
      select max(s.sno)
      into sno
      from mother_history s
      where s.m_id=:new.m_id;
    exception
      WHEN NO_DATA_FOUND THEN
        sno:=NULL;
     END;
    
     IF sno is NULL then
        sno :=1;
      ELSE
      sno:=sno+1;
     END IF;
   
   -- Insert record into student_history table
   INSERT INTO mother_history
(
sno,
m_ID ,
m_name ,
m_cnic,
m_num ,
m_address ,
m_mail ,
m_income ,
m_isalive ,
m_emp_ID  )
VALUES
(
sno,
:old.m_ID ,
:old.m_name ,
:old.m_cnic,
:old.m_num ,
:old.m_address ,
:old.m_mail ,
:old.m_income ,
:old.m_isalive ,
:old.m_emp_ID  );
END;
/



--sequence for guardian
CREATE OR REPLACE TRIGGER guardian_1
  BEFORE INSERT ON Guardian
  FOR EACH ROW
declare
counter number;

BEGIN
  SELECT Guardian_sequence.nextval
  INTO counter
  FROM dual;
 :new.g_ID:='G_'||to_char(counter);
END;
/
--Guradian history
CREATE OR REPLACE TRIGGER Guardian_2
Before update or delete
   ON Guardian
   FOR EACH ROW
declare sno number(3);
BEGIN
    BEGIN
      select max(s.sno)
      into sno
      from Guardian_history s
      where s.g_id=:new.g_id;
    exception
      WHEN NO_DATA_FOUND THEN
        sno:=NULL;
     END;
    
     IF sno is NULL then
        sno :=1;
      ELSE
      sno:=sno+1;
     END IF;
   
   -- Insert record into student_history table
   INSERT INTO Guardian_history
(
sno,
g_ID,
g_name ,
g_cnic,
g_gender ,
g_num ,
g_address ,
g_mail ,
g_income ,
g_emp_ID   )
VALUES
(
sno,
:old.g_ID,
:old.g_name ,
:old.g_cnic,
:old.g_gender ,
:old.g_num ,
:old.g_address ,
:old.g_mail ,
:old.g_income ,
:old.g_emp_ID  );
END;
/



--sequence for student
CREATE OR REPLACE TRIGGER Students_1
  BEFORE INSERT ON Student
  FOR EACH ROW
declare
year number;
counter number;

BEGIN
  SELECT Student_sequence.nextval
  INTO counter
  FROM dual;
  select substr(extract(year from sysdate),2) 
  into year
  from dual;
 :new.s_rollnumber:=to_char(year)||'S-'||to_char(counter);
END;
/
--for year enrolled
CREATE OR REPLACE TRIGGER student_2
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN 
    :new.s_yearenrolled := to_date(sysdate);
END;
/

--student trigger for saving history
CREATE OR REPLACE TRIGGER student_3
Before update or delete
   ON Student
   FOR EACH ROW
declare sno number(3);
BEGIN
    BEGIN
      select max(s.sno)
      into sno
      from student_history s
      where s.s_rollnumber=:new.s_rollnumber;
    exception
      WHEN NO_DATA_FOUND THEN
        sno:=NULL;
     END;
    
     IF sno is NULL then
        sno :=1;
      ELSE
      sno:=sno+1;
     END IF;
   
   -- Insert record into student_history table
   INSERT INTO student_history
(
sno,
s_rollnumber ,
s_name,
s_bayformno ,
s_gender ,
DOB ,
s_yearenrolled,  
f_ID ,
relation,
m_ID ,
g_ID
)
   VALUES
(
sno,
:old.s_rollnumber ,
:old.s_name,
:old.s_bayformno ,
:old.s_gender ,
:old.DOB ,
:old.s_yearenrolled,
:old.f_ID ,
:old.m_ID ,
:old.g_ID,
:old.relation
);
END;
/


insert into Class(class_id,Section,Gender,Class_Name)
values (100,'A','M','1');
insert into Class(class_id,Section,Gender,Class_Name)
values (200,'A','M','2');
insert into Class(class_id,Section,Gender,Class_Name)
values (300,'A','M','3');
insert into Class(class_id,Section,Gender,Class_Name)
values (400,'A','M','4');
insert into Class(class_id,Section,Gender,Class_Name)
values (500,'A','M','5');

insert into course (co_name,co_type,co_dur,age,status)
values ('algebra','m/f','1',4,1);
insert into course (co_name,co_type,co_dur,age,status)
values ('algebra','m/f','1',5,1);
insert into course (co_name,co_type,co_dur,age,status)
values ('algebra','m/f','1',8,1);
insert into course (co_name,co_type,co_dur,age,status)
values ('algebra','m/f','1',13,1);
insert into course (co_name,co_type,co_dur,age,status)
values ('algebra','m/f','1',15,1);
commit;

--mother insertion
insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive,m_emp_id  )
VALUES('Saima','3320231121',03026688384,'AHQ','saima@gmail.com',12345,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Aqsa','3320651121',03026688124,'GHQ','aqsa@gmail.com',432211,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Azqa','33202319931',03226688184,'AHQ','Azqa@hotmail.com',54321,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Alizah','33206232121',03026688914,'NHQ','Sarah@yahoo.com',123122,1,'0');


insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Sarah','3333331121',03012688384,'AHQ','sarah@outlook.com',7565,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Farah','3311651131',03021088124,'GHQ','Farah@gmail.com',112211,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Sundus','33202222931',03221111184,'AHQ','sundus@hotmail.com',54737,1,'0');

insert into mother(m_name,m_cnic,m_num ,m_address ,m_mail ,m_income ,m_isalive ,m_emp_ID )
VALUES('Farzana','33206111121',03026011914,'NHQ','farzana@yahoo.com',553122,1,'0');


insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Ali','3320342323',03012311914,'Bahria','Ali@yahoo.com',1002323,1,'0');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Aslam','3223234323',03012375214,'Defence','Aslam@yahoo.com',4324234,1,'9999');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Piyare Afzal','354534544',030176711914,'Defence phase 4','Piyare@yahoo.com',432434,1,'0');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Bhola','34343343',03012312214,'Landhi','Bhola@outlook.com',32422,1,'1122');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Ahsan','35454522',03012312111,'Jhang','Ahsan@yahoo.com',321323,1,'1092');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('Ahmad','3211114323',030545475214,'Sargodha','ahmad@yahoo.com',32342,1,'0');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('basit','354534224',030119911914,'Defence phase 3','basit@yahoo.com',432342,1,'0');

insert into father(f_name,f_cnic,f_num ,f_address ,f_mail ,f_income ,f_isalive ,f_emp_ID )
VALUES('saqib','34312343',030131232214,'Landhi','saqib@outlook.com',32342,1,'0');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Raja','34413422','M',03021134214,'Korangi','Raja@outlook.com',332442,'1142');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Haseeb','32132322','M',0302757414,'Lahore','Haseeb@yahoo.com',3311142,'1421');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Hassan','33543433','M',03021453314,'Islamabad','Hassan@outlook.com',332221,'0');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('waseem','32444442','M',0301010414,'Jhang','waseem@gmail.com',3366662,'1166');


insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Aiza','324243534','F',0302100004,'Islamabad','Aliza@outlook.com',454543,'76554');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Uzma','3213324432','F',03024657655,'Islamabad','uzma@yahoo.com',36543242,'84987');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('Zainish','3321311','F',03021423411,'Jhang','zinish@outlook.com',366661,'21111');

insert into Guardian(g_name,g_cnic,g_gender,g_num ,g_address ,g_mail ,g_income ,g_emp_ID )
VALUES('hibba','3211111','F',0399990414,'Jhang','hibba@gmail.com',3223662,'1996');


 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('hamza',1232132,'M','17-dec-2015','F_1','Uncle','M_8','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('haroon',432423432,'M','17-dec-2016','F_2','Aunt','M_7','G_5');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('faraz',4324234232,'M','17-dec-2011','F_1','Uncle','M_8','G_2');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('Ahnuf',432446777,'M','17-dec-2016','F_2','Aunt','M_7','G_6');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('momin',423432432,'M','7-Nov-2014','F_3','Uncle','M_6','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('shaheer',432423432,'M','4-July-2011','F_4','Aunt','M_5','G_7');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('mudassir',432748327,'M','9-Aug-2012','F_5','G.father','M_4','G_4');

INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('saram',432446777,'M','17-Oct-2007','F_2','G.mother','M_7','G_8');


 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('mariyam',1232132,'F','17-dec-2015','F_1','Uncle','M_8','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('jannat',432423432,'F','17-dec-2016','F_2','Aunt','M_7','G_5');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('arfa',4324234232,'F','17-dec-2011','F_1','Uncle','M_8','G_2');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('sumaya',3423423,'F','17-dec-2016','F_2','Aunt','M_7','G_6');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('sadia',342342,'F','7-Nov-2010','F_3','Uncle','M_6','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('nimra',432423432,'F','4-July-2009','F_8','Aunt','M_2','G_7');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('hadia',432748327,'F','9-Aug-2005','F_5','G.father','M_4','G_4');

INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('wajeeha',432446777,'F','17-Oct-2007','F_5','G.mother','M_3','G_8');


 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('huzaifa',1232132,'M','17-dec-2015','F_1','Uncle','M_8','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('rohail',432423432,'M','17-dec-2016','F_2','Aunt','M_7','G_5');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('ruhaan',4324234232,'M','17-dec-2011','F_1','Uncle','M_8','G_2');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('zayn',432446777,'M','17-dec-2016','F_2','Aunt','M_7','G_6');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('humayu',423432432,'M','7-Nov-2014','F_3','Uncle','M_6','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('faizan',432423432,'M','4-July-2011','F_4','Aunt','M_5','G_7');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('iqrar',432748327,'M','9-Aug-2012','F_5','G.father','M_4','G_4');

INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('mujahid',432446777,'M','17-Oct-2007','F_2','G.mother','M_7','G_8');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('nida',1232132,'F','17-dec-2015','F_1','Uncle','M_8','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('haniya',432423432,'F','17-dec-2016','F_2','Aunt','M_7','G_5');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('fatima',4324234232,'F','17-dec-2011','F_1','Uncle','M_8','G_2');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('abeeha',3423423,'F','17-dec-2016','F_2','Aunt','M_7','G_6');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('abeera',342342,'F','7-Nov-2010','F_3','Uncle','M_6','G_1');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('rabbia',432423432,'F','4-July-2009','F_8','Aunt','M_2','G_7');

 INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('sehr',432748327,'F','9-Aug-2005','F_5','G.father','M_4','G_4');

INSERT INTO student(s_name,s_bayformno,s_gender,DOB,f_ID,relation,m_ID,g_ID)
values('raazia',432446777,'F','17-Oct-2007','F_5','G.mother','M_3','G_8');

commit;

insert into Registration(challanNumber,s_rollnumber,R_status) values ('1234','20S-1',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1235','20S-2',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1236','20S-3',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1237','20S-4',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1238','20S-5',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1239','20S-6',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1240','20S-7',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1241','20S-8',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1242','20S-9',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1243','20S-10',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1244','20S-11',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1245','20S-12',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1246','20S-13',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1247','20S-14',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1248','20S-15',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1249','20S-16',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1250','20S-17',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1251','20S-18',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1252','20S-19',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1253','20S-20',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1254','20S-21',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1255','20S-22',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1256','20S-23',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1257','20S-24',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1258','20S-25',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1259','20S-26',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1260','20S-27',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1261','20S-28',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1262','20S-29',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1263','20S-30',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1264','20S-31',0);
insert into Registration(challanNumber,s_rollnumber,R_status) values ('1265','20S-32',0);



commit;






select * from registration;
update registration set r_status = 1 where s_rollnumber = '20S-1';
select * from mother;
SELECT * FROM REGISTRATION_history;

update Registration set class_id = 102 where s_rollnumber = '20S-1' and class_id = 100;--it is the roll number that would be given in the form and the claass id is the previous class of the student and the class id 
--which we are setting is the new class id that would be given in the php and we would store them in variable here i could not ues variables so i have hard coded it
update Registration_history set SECTION_CHANGE = 'boht bura section tha' where s_rollnumber = '20S-1' and cl_id = 100;--this is the old section of the student
update Registration set class_id = 102 where s_rollnumber = '20S-2' and class_id = 100;
update Registration_history set SECTION_CHANGE = 'mera section meri mrzi' where s_rollnumber = '20S-2' and cl_id = 100;
update Registration set class_id = 301 where s_rollnumber = '20S-3' and class_id = 300;
update Registration_history set SECTION_CHANGE = 'mera section meri mrzi' where s_rollnumber = '20S-3' and cl_id = 300;
update Registration set class_id = 501 where s_rollnumber = '20S-15' and class_id = 500;
update Registration_history set SECTION_CHANGE = 'boht like ladke the' where s_rollnumber = '20S-15' and cl_id = 500;

update Registration set class_id = 201 where s_rollnumber = '20S-5' and class_id = 200;
update Registration_history set SECTION_CHANGE = 'teacher ache ni the' where s_rollnumber = '20S-5' and cl_id = 200;
update Registration set class_id = 402 where s_rollnumber = '20S-24' and class_id = 401;
update Registration_history set SECTION_CHANGE = 'mera section meri mrzi' where s_rollnumber = '20S-24' and cl_id = 401;
update Registration set class_id = 300 where s_rollnumber = '20S-11' and class_id = 301;
update Registration_history set SECTION_CHANGE = 'Mam marks hi ni deti' where s_rollnumber = '20S-11' and cl_id = 301;
update Registration set class_id = 502 where s_rollnumber = '20S-15' and class_id = 501;
update Registration_history set SECTION_CHANGE = 'aapke section mein hai kia' where s_rollnumber = '20S-15' and cl_id = 501;

--query 1 
select * from student;
--query 2
select distinct m.m_name wife_name,m.m_cnic wife_cnic,m.m_num wife_num,m.m_mail wife_mail,m.m_income wife_mail,m.m_isalive wife_isalive,m.m_emp_id wife_emp_id,f.f_name husband_name from student s,father f,mother m where s.f_id=f.f_id and s.m_id = m.m_id order by husband_name;
--query 3
select g.g_name,s_name,relation from student s, guardian g where s.g_id = g.g_id order by relation;
--query 4
select f.f_name,m.m_name,a.s_name from student a, father f, mother m where a.f_id = f.f_id and a.m_id = m.m_id;
--query 5
create view unique_parents as select distinct f_id,m_id from student;
drop view siblings;
create view siblings as select s.s_rollnumber,s.f_id,s.m_id from student s ,unique_parents u where u.f_id = s.f_id and u.m_id = s.m_id;
select * from siblings;
select r.class_id,s.s_rollnumber,std.s_name,f.f_name,m.m_name from registration r, siblings s,mother m, father f, student std where s.s_rollnumber = std.s_rollnumber and s.F_ID = f.f_id and s.M_ID = m.m_id and s.s_rollnumber = r.S_ROLLNUMBER order by r.class_id;

--query 9
select distinct f.f_name, m.m_name from father f, mother m , student s,registration r where f.f_id = s.f_id and m.m_id = s.m_id and s.s_rollnumber = r.S_ROLLNUMBER and ((r.r_date-s.dob)/365 >=2 and  (r.r_date-s.dob)/365 <=5) ;



create view male1 as select count('M') male,r.class_id from student s,registration r where s.s_rollnumber = r.s_rollnumber and s.s_gender = 'M' group by class_id;
create view female1 as select count('M') female,r.class_id from student s,registration r where s.s_rollnumber = r.s_rollnumber and s.s_gender = 'F' group by class_id;
create view boht as select m.male,f.female,m.class_id from male1 m,female1 f where m.class_id = f.class_id;
create view un_male as
select class_id from male1 
minus
select class_id from boht;

create view un_female as
select class_id from female1 
minus
select class_id from boht;

select b.class_id,male,female,male+female from boht b
union
select class_id,(select male from male1 m where un.class_id=m.class_id) ,NULL, (select male from male1 m where un.class_id=m.class_id) from un_male un
union 
select class_id,NULL,(select female from female1 m where un.class_id=m.class_id)  ,(select female from female1 m where un.class_id=m.class_id) from un_female un;


drop view Registration_Count;
--Selects Max SNO for each Student
create view Registration_Count as
select count(sno) Max_Sno, s_rollnumber from Registration_History group by s_rollnumber;

select * from Registration_count;

drop view Last_Class;
--select Last class_id for each student
create view Last_Class as
select cl_id, rh.s_rollnumber, Max_Sno
from Registration_History rh, Registration_Count rc
where Max_Sno = sno and rc.s_rollnumber = rh.s_rollnumber;

select * from Last_class;

drop view Registration_Gap_Months;
--Last Registration was 6 Months ago
create view Registration_Gap_Months as
select unique r.s_rollnumber, s.s_name, r.r_date, r.class_ID, sysdate s, (MONTHS_BETWEEN(sysdate,r.r_date)) Months_Gap
from student s, Registration r
where s.s_rollnumber = r.s_rollnumber and (MONTHS_BETWEEN(sysdate,r.r_date)) > 6; 

select * from Registration_Gap_Month;

drop view Registration_Gap_month;
--Just to check
create view Registration_Gap_Month as
select unique r.s_rollnumber, s.s_name, r.r_date, r.class_ID, sysdate s, (MONTHS_BETWEEN(sysdate,r.r_date)) Months_Gap
from student s, Registration r
where s.s_rollnumber = r.s_rollnumber and (MONTHS_BETWEEN(sysdate,r.r_date)) < 7; 

--selects all the students that changed their class ignoring New Admissions
select s.s_name, rgm.s_rollnumber, rgm.class_id, lc.cl_id, lc.s_rollnumber
from Registration_Gap_Months rgm, Last_Class lc, Student s
where (rgm.s_rollnumber = lc.s_rollnumber and rgm.class_id != lc.cl_id and s.S_ROLLNUMBER = lc.s_rollnumber);

drop view Class_change;
--selects students who changed their class
create view Class_Change as
select s.s_name, rgm.s_rollnumber, rgm.class_id, lc.cl_id
from Registration_Gap_Month rgm, Last_Class lc, Student s
where (rgm.s_rollnumber = lc.s_rollnumber and rgm.class_id != lc.cl_id and s.S_ROLLNUMBER = lc.s_rollnumber);

select * from class_change;

drop view New_Admissions;
--selects all the New Admissions
create View New_Admissions as
select s_rollnumber from Registration_Gap_Month
minus
select s_rollnumber from Class_Change;

--shows all new admissions + Class Changed
select s.s_name, s.s_rollnumber
from Student s ,New_Admissions na 
where s.s_rollnumber = na.s_rollnumber
union
select s_name, s_rollnumber
from Class_Change;


--Query 7
select na.s_rollnumber,s.s_name, r.class_id
from New_Admissions na, Registration r, student s
where na.s_rollnumber = r.s_rollnumber and na.s_rollnumber = s.s_rollnumber
order by r.class_id;

--Query 8
select na.s_rollnumber,s.s_name, f.f_name,m.m_name
from New_Admissions na, student s, father f, mother m
where  na.s_rollnumber = s.s_rollnumber and s.f_id = f.f_id and s.m_id = m.m_id;