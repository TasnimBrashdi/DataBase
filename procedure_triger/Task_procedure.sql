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
alter table  Project add Budget int 
UPDATE Project
SET Budget = 1000



  create table Audit
  (
	ProjectNo  int,
	foreign key (ProjectNo) references Project(pnumber),
	UserName nvarchar(100) ,
	ModifiedDate date,
	Budget_Old int,
	Budget_New int
  )


  create trigger insertAudit
  on project
  after update
  as
  begin
  if update (Budget)
  begin
	insert into Audit(ProjectNo, UserName, ModifiedDate, Budget_Old, Budget_New)
	select i.Pnumber, SYSTEM_USER ,GETDATE(), d.Budget ,i.Budget
	from inserted i join deleted d on i.Pnumber = d.Pnumber
  end
  end

  update Project
  set Budget = 50000
  where Pnumber = 200


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


create table Audit
  (
	
     ServerUserName NVARCHAR(100),
    InsertDate DATETIME,
    Note NVARCHAR(255)
  )



create trigger add_Row  
on Student 
after insert
as
BEGIN
    DECLARE @currentUser nvarchar(128) = ORIGINAL_LOGIN() --ORIGINAL_LOGIN function retrieves the name of the user who initiated the transaction
    DECLARE @currentDate DATETIME = GETDATE()

  
    INSERT INTO Audit (ServerUserName, InsertDate, Note)
    select 
        @currentUser, 
        @currentDate,
       '[' + @currentUser + '] Insert New Row with Key=[' + CAST(i.St_Id AS NVARCHAR(10)) + '] in table [Student]'--cast convert id integer to char
    from 
        inserted i
END



--8
create trigger delete_Row  
on Student 
INSTEAD OF DELETE
as
BEGIN
 DECLARE @currentUser nvarchar(128) = ORIGINAL_LOGIN() 
 DECLARE @currentDate DATETIME = GETDATE()
  INSERT INTO Audit (ServerUserName, InsertDate, Note)
    select 
        @currentUser, 
        @currentDate,
		'Try to delete Row with Key=[' + CAST(i.St_Id AS NVARCHAR(10)) + ']'
		   FROM 
        deleted i
		DELETE FROM Student
    WHERE St_Id IN (SELECT St_Id FROM deleted)
	end 