--use EmployeeDemo;
--create table Employee(EmployeeId int Identity(1,1) primary key,EmployeeName varchar(30),EmployeeAge int ,
--EmployeeSalary int ,EmployeeAddress varchar(50));

--create Proc spInsertEmployeeDetails
--@name varchar(30),@age int,@salary int,@address varchar(50)
--As
--Begin
--Insert into Employee(EmployeeName,EmployeeAge,EmployeeSalary,EmployeeAddress) values (@name,@age,@salary,@address)
--End

--create Proc spUpdateEmployeeDetailsById
--@id int,@name varchar(30),@age int,@salary int,@address varchar(50)
--As
--Begin
--update Employee set EmployeeName= @name,EmployeeAge=@age,EmployeeSalary=@salary,EmployeeAddress=@address where EmployeeId=@id
--End

--create Proc spGetEmployeeDetails
--As
--Begin
--select * from Employee
--End

sp_helptext spDeleteEmployeeDetailsById

--====================================================
select * from Employee order by EmployeeSalary;
select e.EmployeeSalary from employee e where (select count(distinct e1.EmployeeSalary)from employee e1
where e.EmployeeSalary<=e1.EmployeeSalary)in(2,4)
union all
select e.EmployeeSalary from employee e where (select count(distinct e1.EmployeeSalary)from employee e1
where e.EmployeeSalary>=e1.EmployeeSalary)in(5,1);
select * from Employee order by EmployeeSalary desc;

select * from employee;
select * from employee 
order by EmployeeId
offset 1 rows
fetch first 1 rows only;
--alter table employee Rename column EmployeeSal to EmployeeSalary;
exec sp_rename 'Employee.EmployeeSalary','EmployeeSal','column';


--=========================================================================
create database FourthReview;
use FourthReview;
create table Employee(EmployeeId int Identity(1,1) primary key,EmployeeName varchar(30),EmployeeAge int ,
EmployeeDept varchar(50));
insert into Employee values('Prabhu',27,'Testing',45000);

--alter table Employee Add EmployeeSalary int;
--select * from Employee;
--exec sp_rename 'Employee.EmployeeDept','EmployeeDpt','COLUMN';
--insert into Employee values('Raghu',29,'Developer',45000);
--update Employee set EmployeeSalary=55000 where EmployeeId=1;
--Delete table EMployee where EMployeeAge<25;
-------------------------------------------
select EmployeeName from Employee order by EmployeeName;
select top 5 EmployeeName,EmployeeSalary from Employee order by EmployeeSalary desc;
select EmployeeName from EMployee where EmployeeName like 'a%';
select * from EMployee order by EmployeeId offset 2 rows;

create table Department(DepartmentId int Identity(1,1) primary key,DepartmentName varchar(30));
insert into Department values('Developer');

--select * from EMployee e Inner Join Department d on e.EmployeeDpt = d.DepartmentName;

create Proc spGetEmployeeDetailsByName
@name varchar(1)
As
Begin
select * from Employee where EmployeeName like @name+'%'
End

create Proc spGetEmployeeDetailsById
@id int
As
Begin	
select * from Employee where EmployeeId=@id
End

select e.EmployeeSal from employee e where (select count(distinct e1.EmployeeSal)from employee e1 where e.EmployeeSal<=e1.EmployeeSal)=2;
-------------------------------------------------------------------------------------
select * from employee;
create table Product(
product_Id int identity(1,1) primary key,
product_Name varchar(30),
brand_Id int,
product_Price dec(10,2));
select * from product;

CREATE TABLE product_audits(
    change_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    product_name VARCHAR(30),
    brand_id INT ,
    product_Price DEC(10,2),
    updated_at DATETIME NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
);
select * from product_audits;
-----------------------------------------------------
create Trigger trg_Product_audits
on Product
After insert,delete
as
begin
insert into product_audits(product_Id,product_Name,brand_Id,product_Price,updated_at,operation)
    SELECT i.product_Id,product_Name,brand_Id,i.product_Price,GETDATE(),'INS'
    FROM inserted i
    UNION ALL
    SELECT d.product_Id,product_Name,brand_Id,d.product_Price,GETDATE(),'DEL'
    FROM deleted d;
END
--====================================================
insert into product values('Vivo',1001,34333.99);
delete from product where product_Id=2;





