use Company_SD
select * from employee 
select * from Departments
select * from Project 

select Fname,Lname,salary,Dnum
from Departments,employee

SELECT pname,plocation,Dnum
FROM Project

select Fname + ' '+ Lname as [full name],(salary*10/100)AS [ANNUAL COMM]
from employee

SELECT SSN,Fname + ' '+ Lname as [full name]
from employee
where Salary>1000

SELECT SSN,Fname + ' '+ Lname as [full name]
from employee
where Salary>10000

SELECT Fname + ' '+ Lname as [full name],Salary
from employee
where Sex='F'

SELECT Dname,Dname
from Departments
where MGRSSN=968574


SELECT Pname,Pnumber
from Project
where Dnum=10

insert into employee (Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn,Dno)
values('Tasnim','brashdi',102672,'8-24-1999','Muscat','F',3000,112233,30)
insert into employee (Fname,Lname,SSN,Bdate,Address,Sex,Salary,Superssn,Dno)
values('Zahir','brashdi',102660,'8-24-1975','Muscat','M',3000,112233,30)

update employee
set Salary+=20/100
where ssn=102672