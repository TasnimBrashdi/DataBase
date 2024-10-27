use ITI

--1
create Proc GetstByDepm 
as
   select COUNT(s.St_Id)as number_of_student,d.Dept_Name
   from Student s inner join department d
     on s.Dept_Id=d.Dept_Id
	 Group by d.Dept_Name
	 
GetstByDepm

--2
use Company_SD

create Proc GetNumOfEmp @p int
as
declare @num int

 select  @num= COUNT(ESSn) 
   from Works_for where Pno=@p
   if @num>=3
   select 'The number of employees in the project p1 is 3 or more'
   else
   select 'The following employees work for the project p1', Fname+' '+Lname as FullName from Employee where Dno in(select Dnum from Departments )
 


   GetNumOfEmp 100
--3
create Proc oldemp  @oldEmp int,@NewEmp int, @project int
as
BEGIN
 if EXISTS (select 1 from Works_for where ESSn = @NewEmp AND Pno = @project)
    BEGIN
        select 'Error: New employee already in project.'
        RETURN
    END
update Works_for set ESSn = @NewEmp where ESSn=@oldEmp and Pno=@project
END

EXEC oldemp 112233, 223344, 100


--4







--5
use ITI
create trigger prevent_Department 
on Department 
after insert
as
BEGIN
	select 'You can’t insert a new record in that table'
 ROLLBACK TRANSACTION
 end

 --6
 use Company_SD

create trigger PreventEmployeeInMarch
on Employee
after insert
as
BEGIN
    DECLARE @currentDate DATETIME = GETDATE()

    IF MONTH(@currentDate) = 3
    BEGIN
       select 'Error: Insertion into the Employee table is not allowed in March.'
        ROLLBACK TRANSACTION
    end
end

--7
use ITI
create trigger add_Row  
on Student 
after insert
as
BEGIN
    DECLARE @currentUser nvarchar(128) = ORIGINAL_LOGIN() --ORIGINAL_LOGIN function retrieves the name of the user who initiated the transaction
    DECLARE @currentDate DATETIME = GETDATE()

  
    INSERT INTO StudentAudit (ServerUserName, InsertDate, Note)
    select 
        @currentUser, 
        @currentDate,
        'User ' + @currentUser + ' Inserted New Row with Key=' + CAST(St_Id as nvarchar(10)) + ' in table [Student]' --cast convert id integer to char
    from 
        inserted
END





--8
create trigger delete_Row  
on Student 
after insert
as
BEGIN
