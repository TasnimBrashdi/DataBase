use Company_SD

--For each project, list the project name and the total hours per week (for all employees) spent on that project.


select p.Pname,sum(w.Hours) as Total_hours
from Project p inner join Works_for w on p.Pnumber=w.Pno
group by p.Pname


--For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
Select Max(salary) as Max_val,Min(salary) as Min_Val,AVG(Salary)as Ave_Val
from Departments d inner join Employee e on
d.Dnum=e.Dno
group by d.Dnum

