use Company_SD


select D.Dname,D.Dnum,E.Fname as 'Manger',E.SSN
from Departments D inner join  Employee E on E.SSN=D.MGRSSN

select d.Dname,p.Pname
from Departments d inner join Project p on
d.Dnum=p.Dnum

Select *
from Dependent d inner join Employee e
on d.ESSN=e.SSN

select Pnumber,Pname,Plocation
from Project where City='Cairo ' or City= 'Alex'

select * from Project where Pname like 'a%'

select *
from Employee where Dno=30 and Salary between 1000 and 2000

select distinct e.Fname+' '+e.Lname as Name
from Employee e inner join Project p on e.Dno=10 and p.Pname='AL Rabwah'
inner join Works_for w on w.Hours>=10

 
 select ee.Fname+' '+ee.Lname as Name,ee.Superssn
from Employee e join Employee ee on e.SSN=ee.Superssn
where e.Fname='Kamel' and e.Lname='Mohamed' and e.SSN=ee.Superssn


 select e.Fname+' '+e.Lname as Name,p.Pname
 from Employee e inner join Project p on e.Dno=p.Dnum order by p.Pname


select  p.Pnumber,d.Dname ,e.Lname as 'Last Name',e.Address,e.Bdate
from Project p inner join Departments d on p.City='Cairo'
inner join Employee e on d.MGRSSN=e.SSN

 select  e.*
 from Employee e inner join Departments d on e.SSN=d.MGRSSN

 select  *
 from Employee e inner join Dependent d on e.SSN=d.ESSN

