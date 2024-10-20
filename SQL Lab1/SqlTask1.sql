create database University 

use University
create table Instractor 
(

	ID int primary key identity(1,1 ),
	Fname nvarchar(20) not null,
	Lname nvarchar(20) not null,
	BD date,
	Hiredate date default getdate(),
	Instractor_Address  NVARCHAR(5) CHECK (Instractor_Address IN ('cairo', 'alex')),
	OverTime int CONSTRAINT UQ_OverTime UNIQUE,
	Salary int CONSTRAINT CK_Salary check(Salary between 1000 and 5000) default 3000,
	age as (DateDiff(year,BD,GetDate())),
	Netsalary as (Salary+OverTime),

)
create table course 
(

	CID int primary key identity(1,1 ),
	Cname nvarchar(20) not null,
	Duration int CONSTRAINT UQ_Duration UNIQUE ,

)
create table Lab 
(

	LID int primary key identity(1,1 ),
    locationLab nvarchar(100), 
	Capacity int check(Capacity<20) CONSTRAINT UQ_Capacity UNIQUE,
	C_ID int,
    foreign key (C_ID) references course(CID)

)
create table IteachC 
(

	I_ID int,
	CourseID int,
	foreign key (CourseID) references course(CID),
    foreign key (I_ID) references Instractor(ID),
	primary key (I_ID, CourseID)
	
)
insert into Instractor(Fname,Lname,BD,Instractor_Address,OverTime)
values('Tanim','Brashdi','8-24-1999','alex',20)

insert into Instractor(Fname,Lname,BD,Instractor_Address,OverTime)
values('Ali','Hamad','8-2-1989','alex',10)
select * from Instractor

insert into course(Cname,Duration)
values('Math',90)

insert into course(Cname,Duration)
values('Database',100)
select * from course

insert into Lab(locationLab,Capacity,C_ID)
values('room 1 bulding A',19,1)
insert into Lab(locationLab,Capacity,C_ID)
values('room 2 bulding B',10,2)

select * from Lab




