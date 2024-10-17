create database company
use company
create table employee(
ssn int primary key,
Fname nvarchar(10) not null,
Minit nvarchar(10) not null,
Lname nvarchar(10) not null,
Bdate date,
Address nvarchar(50),
Sex bit,
salary  DECIMAL(10, 2) CHECK (Salary > 0),

)

create table Department(

Dnumber int primary key,
Dname nvarchar(10) not null,
Mgr_start_date date,
Mgr_ssn int,
FOREIGN KEY (Mgr_ssn) REFERENCES employee (ssn),


)
create table Project(

pnumber int primary key,
pname nvarchar(10) not null,
Plocation nvarchar(50),
Dnum int,
FOREIGN KEY (Dnum) REFERENCES Department (Dnumber),


)

create table DEPT_LOCATION(
Dnumber int,
Dlocation nvarchar(50) primary key,
FOREIGN KEY (Dnumber) REFERENCES Department (Dnumber),

)

create table Works_no(
Essn int,
Pno int,
hours char(10) ,
FOREIGN KEY (Essn) REFERENCES employee (SSN),
FOREIGN KEY (Pno) REFERENCES Project (pnumber),
PRIMARY KEY (Essn,Pno)
)
create table Dependents(
dependent_name nvarchar(20),
Essn int,
Sex bit,
Bdate date ,
relationship nvarchar(50),
FOREIGN KEY (Essn) REFERENCES employee (ssn),
PRIMARY KEY (Essn,dependent_name)
)




