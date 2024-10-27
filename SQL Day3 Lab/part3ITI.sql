use ITI


--1

create view InsDepNames as
select 
    I.Ins_Name,
    D.Dept_Name
from 
    Instructor I
LEFT JOIN 
    Department D on I.Dept_Id = D.Dept_Id


select * from InsDepNames
--2


create view view_stud_course 
as
select s.St_Fname +' '+s.St_Lname as 'Full Name',c.Crs_Name
from Student s inner join  Stud_Course sc on s.St_Id=sc.St_Id and sc.Grade>0
inner join  Course c on c.Crs_Id=sc.Crs_Id 


select * from view_stud_course 

select *
from Stud_Course


--3


create view number_course 
as
select 

 
    t.Top_Name,
    COUNT(c.Crs_Id) as 'Number Of Courses'
from 
    Topic t
LEFT JOIN 
    Course c on t.Top_Id = c.Top_Id
GROUP BY 
    t.Top_Name

select *
from number_course

--4
create view min_max_salary 
as
select 
min(Salary)as minimum ,max(Salary) as maximum
from Instructor

select * from min_max_salary
--5
create view min_salary_dep 
as
select 

    D.Dept_Name
from 
    Instructor I
INNER JOIN 
    Department D ON I.Dept_Id = D.Dept_Id
where 
    I.Salary = (select MIN(Salary) from Instructor)

select * from min_salary_dep

--6

WITH RankedSalaries as (
    select 
        I.Ins_Name,
        I.Salary,
        I.Dept_Id,
        RANK() OVER (PARTITION BY I.Dept_Id ORDER BY I.Salary DESC) as SalaryRank
    from 
        Instructor I
    where 
        I.Salary IS NOT NULL
)
select 
    Ins_Name,
    Salary,
    Dept_Id
from 
    RankedSalaries
where 
    SalaryRank <= 2
ORDER BY 
    Dept_Id, SalaryRank
	

--7


WITH RandomStudents as (
    select 
        St_Id,
        St_Fname+' '+St_Lname as full_name,
        Dept_Id,
        ROW_NUMBER() OVER (PARTITION BY Dept_Id ORDER BY NEWID()) as RandomRank
    FROM 
        Student
)
select 
    St_Id,
    full_name,
    Dept_Id
from 
    RandomStudents
where 
    RandomRank = 1
