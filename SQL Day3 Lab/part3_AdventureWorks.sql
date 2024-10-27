use AdventureWorks2012

--1
select Name 
from Production.Product where Name like 'b%'

--2
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select Description 
from Production.ProductDescription where Description LIKE '%[_]%'

--3

select SUM(TotalDue)
from Sales.SalesOrderHeader WHERE OrderDate between '7/1/2001'and '7/31/2014'

--4

select avg(distinct ListPrice)
from Production.Product 

--5
select FORMATMESSAGE('The %s is only! %s',Name,CONVERT(VARCHAR, ListPrice, 1)) as ProductInfo 
from  Production.Product where ListPrice between 100 and 120 ORDER BY ListPrice
--6

select CONVERT(VARCHAR(10), GETDATE(), 101) AS FormatDate  
UNION
select CONVERT(VARCHAR(10), GETDATE(), 103) AS FormatDate  
UNION
select CONVERT(VARCHAR(10), GETDATE(), 110) AS FormatDate  
UNION
select FORMAT(GETDATE(), 'dd MMMM yyyy') AS FormatDate     
UNION
select FORMAT(GETDATE(), 'yyyy-MM-dd') AS FormatDate         