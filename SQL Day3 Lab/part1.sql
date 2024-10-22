use Company_SD

--1
select Sex,Dependent_name
from Dependent where sex='F'
 union all
 select Sex,Fname
from Employee where sex='F'

select Sex,Dependent_name
from Dependent where sex='M'
 union all
 select Sex,Fname
from Employee where sex='M'

--2

SELECT Pname, Pnumber 
FROM Project 
WHERE Pnumber IN (SELECT pno FROM Works_for GROUP BY pno)
GROUP BY Pname, Pnumber;


--3
SELECT *
FROM Departments
WHERE Dnum in (SELECT  Dno from Employee where SSN in (select min(ssn)from Employee))

--4 


Select Max(salary) as Max_val,Min(salary) as Min_Val,AVG(Salary)as Ave_Val
from Employee where Dno in (select Dnum from Departments )group by Dno
--5

select Fname+' '+Lname as full_name
from Employee where SSN  not in (select ESSN from Dependent)


--6
SELECT Dnum, 
       Dname, 
       (SELECT COUNT(*) from Employee WHERE Dno = D.Dnum) as Employee_Count
from Departments D
WHERE Dnum IN (
    SELECT Dno
    from Employee 
    GROUP BY Dno 
    having AVG(salary) < (SELECT AVG(salary) from Employee)
)

--7
select Fname+' '+Lname as Full_name, (select p.Pname from Project p where p.Pnumber = w.Pno) as projects_names
from Employee e, Works_for w where e.SSN = w.ESSN order by e.Dno, e.Lname, e.Fname


 --8
 select TOP 2 Fname + ' ' + Lname as full_name, 
       Salary
from Employee
order by Salary DESC
--9
 select Fname + ' ' + Lname as full_name
from Employee where EXISTS (select 1
from Dependent where Dependent_name like '%'+Fname+'%'or Dependent_name like '%'+Lname+'%')



select * from Employee
select * from Departments

--10
select SSN as employee_number, 
Fname + ' ' + Lname as full_name
from Employee 
where EXISTS (select 1
from Dependent where ESSN = SSN)

--11
insert into Departments values('DEPT IT',100,112233,'1-11-2006')
--12

update Departments set MGRSSN =968574 where Dnum=100

update Departments set MGRSSN =102672 where Dnum=20
update Employee set Superssn =102672 where SSN=102660
--13
begin try

	begin transaction
	delete from Employee where SSN=223344
	commit

end try

begin catch
	ROLLBACK
	select ERROR_LINE() ,ERROR_MESSAGE(), ERROR_NUMBER()
end catch
--14
update Employee set Salary=Salary*1.30 where SSN in(select ESSN FROM Works_for WHERE
    Pno = (
        SELECT Pnumber
        FROM Project 
        WHERE Pname = 'Al Rabwah'
     ))
