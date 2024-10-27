use ITI


--1
Create Function dbo.GetName (@InputDate DATE)
Returns varchar(20)
AS
Begin
    Return DATENAME(MONTH, @InputDate)
END

SELECT dbo.GetName('2024-10-23') AS MonthName


--2

create function dbo.GetValues ( @X INT,@Y INT )
returns @ValuesTable table (value int)
as
Begin
     declare @z int = @X
       while @z< @Y
          Begin
           insert into @ValuesTable (value ) values (@z)
             set @z = @z +1
         END
            return
END

select * from dbo.GetValues(11, 16)


--3

create function dbo.GetStudInfo(@StudNo INT)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        s.St_Fname + ' ' + s.St_Lname AS FullName,
        d.Dept_Name
    FROM 
        Student s
    JOIN 
        Department d ON s.Dept_Id = d.Dept_Id
    WHERE 
        s.St_Id = @StudNo
)
select * from dbo.GetStudInfo(4)

select * from Student
--4

Create Function dbo.GetNameNull(@id int) 
Returns varchar(200) 
Begin
   declare @masg nvarchar(200)
   declare @FName nvarchar (20) , @LName nvarchar (20)
   select @FName = St_Fname , @LName = St_Lname from Student where St_Id = @id
     if @FName is null and @Lname is null
       set @masg ='First name & last name are null'
    else if @FName is null
       set @masg ='first name is null'
    else if @LName is null
       set @masg ='last name is null'
    else
       set @masg ='First name & last name are not null'
   return @masg
end

select dbo.GetNameNull(1)

--5


Create Function dbo.GetNameManage(@id INT)
returns table
as
return
(
    select
        d.dept_name,
        i.ins_name as managername,
        d.manager_hiredate as hiredate
    from
        department d
    inner join
        instructor i on d.dept_manager = i.ins_id
    where
        d.dept_manager = @ID
)

select * from GetNameManage(1)

--6

 

 Create Function dbo.GetNamestud(@name nvarchar(50)) 
Returns @names table (Names nvarchar(50))
as
Begin
if @name ='first name'
insert into @names (Names) select isnull(St_Fname,'is null') from student
else if @name='last name'
insert into @names(Names) select isnull(St_Lname,'is null') from Student 
else if @name='full name'insert into @names (Names) select isnull(concat(st_fname, ' ', st_lname), 'full name null') 
from student
return 
end

select * from GetNamestud('full name')

--7
 use Company_SD
 declare c1 cursor
 for select SSN,Salary from Employee
for read only
declare @ID int,@Salary int
open c1
fetch next from c1 into @ID,@Salary
while @@FETCH_STATUS=0
begin
	if @Salary >= 3000
        select @ID as SSN, @Salary * 1.1 as Salary;
    else
        select @ID as SSN, @Salary * 1.2 as Salary;

    fetch next from c1 into @ID, @Salary;
end
close C1
Deallocate C1

--8 Display Department name with its manager name using cursor.  
 use Company_SD
 declare c2 cursor
 for select d.Dname,e.Fname from Departments d inner join   Employee e on d.MGRSSN=e.SSN
for read only
 open c2
 declare @dept_name nvarchar(20)
 declare @manageName nvarchar(20)
 fetch next from c2 into @dept_name,@manageName
 while @@FETCH_STATUS=0
begin

select @dept_name as 'Department name',@manageName as 'Manager name'
 fetch next from c2 into @dept_name,@manageName
 end
 close C2
Deallocate C2






--9 Try to display all instructor names in one cell separated by comma

use ITI

 SELECT STRING_AGG(Ins_Name, ', ') AS 'instructors Names'
FROM instructor
