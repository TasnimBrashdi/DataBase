use ITI

--1
create view Vstu_Grade50
as 
select St_Fname+' '+St_Lname as full_name from Student
where St_Id in(select St_Id from Stud_Course where Grade>50)

select * from Vstu_Grade50
--2
create view vEncrypted 
as
select Ins_Name,(select Crs_Name from Course where Crs_Id in(select Crs_Id from Ins_Course  where Ins_Id = Instructor.Ins_Id))as  Crs_Name from Instructor
where ins_id in (select Dept_manager from Department where Dept_manager in (select Ins_Id from Ins_Course where Crs_Id in(select Crs_Id from Course )))
select * from vEncrypted 

--3



create view vSdJava 
as
select Ins_Name, 
       (select Dept_Name 
        from Department 
        where Dept_Id = Instructor.Dept_Id 
          AND (Dept_Name = 'Java' OR Dept_Name = 'SD')) as Dept_Name
from Instructor
where Dept_Id IN (
    select Dept_Id 
    from Department 
    where Dept_Name = 'Java' OR Dept_Name = 'SD'
)
select * from vSdJava
--4
create view v1
as
select * from Student
where St_Address in ('Alex', 'Cairo')
with check option 

select * from v1

--5

use Company_SD


create view Vproject 
as
select Pname, (select COUNT(*)
        from Employee 
        where Dno = Project.Dnum) as NumberOfEmployees
from Project 
where Dnum IN (select Dnum from Departments)
select* from Vproject


