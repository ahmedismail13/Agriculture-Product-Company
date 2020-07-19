--Creation Section--
CREATE DATABASE Agricultural_Products_Company;
--Please create the tables then create the triggers--
CREATE TRIGGER ship_trig_upd 
ON shipment
FOR update
AS --(
declare @id  int ;
declare @method varchar(10) ;
declare @state varchar(10) ;
declare @fees int ;
declare @weigt int;
declare @delitime  varchar(10);
declare @delivdate date ;
declare @location varchar(10);
declare @cid int ;
declare @hmessage varchar(50);

select @id   = i.ship_id from inserted i;
select @method =i.ship_method from inserted i;
select @state =i.ship_state from inserted i ;
select @fees =i.ship_fees from inserted i;
select @weigt =i.ship_weigt from inserted i;
select @delitime=i.ship_delitime from inserted i;
select @delivdate=i.ship_delivdate from inserted i;
select @location =i.ship_location from inserted i;
select @cid =i.customer_id from inserted i ;
select @hmessage='update trigger done';
INSERT INTO history_of_shipment
VALUES (@id,@method,@state,@fees,@weigt,@delitime,@delivdate,@location,@cid,@hmessage,getdate());
PRINT 'Trigger successfully executed'

GO --)


CREATE TRIGGER ship_trig_delete 
ON shipment
FOR delete
AS --(
declare @id  int ;
declare @method varchar(10) ;
declare @state varchar(10) ;
declare @fees int ;
declare @weigt int;
declare @delitime  varchar(10);
declare @delivdate date ;
declare @location varchar(10);
declare @cid int ;
declare @hmessage varchar(50);

select @id   = d.ship_id from deleted d;
select @method =d.ship_method from deleted d;
select @state =d.ship_state from deleted d ;
select @fees =d.ship_fees from deleted d;
select @weigt =d.ship_weigt from deleted d;
select @delitime=d.ship_delitime from deleted d;
select @delivdate=d.ship_delivdate from deleted d;
select @location =d.ship_location from deleted d;
select @cid =d.customer_id from deleted d ;
select @hmessage='delete trigger done';
INSERT INTO history_of_shipment
VALUES (@id,@method,@state,@fees,@weigt,@delitime,@delivdate,@location,@cid,@hmessage,getdate());
PRINT 'Trigger successfully executed'

GO --)


CREATE TRIGGER ship_trig 
ON shipment
FOR INSERT
AS --(
declare @id  int ;
declare @method varchar(10) ;
declare @state varchar(10) ;
declare @fees int ;
declare @weigt int;
declare @delitime  varchar(10);
declare @delivdate date ;
declare @location varchar(10);
declare @cid int ;
declare @hmessage varchar(50);

select @id   = i.ship_id from inserted i;
select @method =i.ship_method from inserted i;
select @state =i.ship_state from inserted i ;
select @fees =i.ship_fees from inserted i;
select @weigt =i.ship_weigt from inserted i;
select @delitime=i.ship_delitime from inserted i;
select @delivdate=i.ship_delivdate from inserted i;
select @location =i.ship_location from inserted i;
select @cid =i.customer_id from inserted i ;
select @hmessage='insert trigger done';
INSERT INTO history_of_shipment
VALUES (@id,@method,@state,@fees,@weigt,@delitime,@delivdate,@location,@cid,@hmessage,getdate());
PRINT 'Trigger successfully executed'

GO --)

CREATE TABLE Department(
Dept_Pnumber varchar(16) NOT NULL,
Dept_id int NOT NULL,
Dept_location varchar(150) NOT NULL,
Dept_email varchar(25),
Dept_name varchar(16) NOT NULL,
Dept_mng_ssn int,

CONSTRAINT Dept_pk PRIMARY KEY (Dept_id),
CONSTRAINT Unique_name UNIQUE (Dept_name)
);

CREATE TABLE Employee(
Emp_ssn int NOT NULL,
Emp_birthday date,
Emp_gender char NOT NULL,
Emp_Fname varchar(16) NOT NULL,
Emp_Lname varchar(16) NOT NULL,
Emp_street varchar(20) NOT NULL,
Emp_zip_code varchar(5),
Emp_city varchar(16),
Emp_salary int NOT NULL,
Emp_super_ssn int ,
Emp_Dept_id int NOT NULL

CONSTRAINT Emp_pk PRIMARY KEY (Emp_ssn),
CONSTRAINT Emp_supervisor_fk FOREIGN KEY (Emp_super_ssn) REFERENCES Employee (Emp_ssn),
CONSTRAINT Emp_Dept FOREIGN KEY (Emp_Dept_id) REFERENCES Department(Dept_id),
);

ALTER TABLE Department
ADD CONSTRAINT Dept_manager_ssn 
FOREIGN KEY (Dept_mng_ssn) REFERENCES Employee (Emp_ssn);
alter table employee 
alter column Emp_Dept_id int 

CREATE TABLE Emp_Pnumber
(
Emp_ssn int NOT NULL,
Emp_pnumber varchar(16) NOT NULL
CONSTRAINT Emp_Pnumber_pk PRIMARY KEY (Emp_ssn, Emp_pnumber),
CONSTRAINT Emp_Pnumber_fk FOREIGN KEY (Emp_ssn) REFERENCES Employee (Emp_ssn)
);


CREATE TABLE Emp_Mail
(
Emp_ssn int NOT NULL,
Emp_mail varchar(25) NOT NULL
CONSTRAINT Emp_Mail_pk PRIMARY KEY (Emp_ssn, Emp_mail),
CONSTRAINT Emp_Mail_fk FOREIGN KEY (Emp_ssn) REFERENCES Employee (Emp_ssn)
);

create table customer
(
cust_id   int   NOT NULL,
cust_location  varchar(20)  NOT NULL,
cust_amount_of_cons int,
CONSTRAINT cust_pk PRIMARY KEY (cust_id)
);

create table shipment(
ship_id  int not null,
ship_method varchar(10) not null,
ship_state varchar(10) ,
ship_fees int not null,
ship_weigt int,
ship_delitime  varchar(10),
ship_delivdate date not null,
ship_location varchar(10),
customer_id int not null,
constraint ship_PK primary key(ship_id),
constraint customer_fk	foreign key(customer_id) references customer (cust_id)
);

create table history_of_shipment(
ship_id  int ,
ship_method varchar(10) ,
ship_state varchar(10) ,
ship_fees int ,
ship_weigt int,
ship_delitime  varchar(10),
ship_delivdate date ,
ship_location varchar(10),
customer_id int ,
histo_message varchar(50),
histo_time date

);



CREATE TABLE Working_for
(
Essn int NOT NULL,
s_id int NOT NULL,
CONSTRAINT Working_for_pk PRIMARY KEY (Essn,s_id),
CONSTRAINT Emp_working_fk FOREIGN KEY (Essn) REFERENCES Employee (Emp_ssn),
CONSTRAINT Ship_working_fk1 FOREIGN KEY (s_id) REFERENCES shipment (ship_id)
);
alter table working_for
add distance int;


create table warehouse (
ware_id int not null,
ware_location varchar(10) not null,
ware_name varchar(20) ,
ware_capacity int,
constraint warehouse_PK primary key(ware_id)
);

create table cust_phone_number
(
cust_id int NOT NULL,
phone_num int NOT NULL,
CONSTRAINT phone_number_pk PRIMARY KEY (cust_id, phone_num),
CONSTRAINT phone_number_fk FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
);


create table cust_email
(
cust_id int NOT NULL,
email varchar(20) NOT NULL,
CONSTRAINT email_pk PRIMARY KEY (cust_id, email),
CONSTRAINT email_fk FOREIGN KEY (cust_id) REFERENCES customer (cust_id)
);

create table cust_address
(
cust_id int NOT NULL,
city varchar(20),
zip int,
street varchar(20)
CONSTRAINT addess_pk PRIMARY KEY (cust_id, city, zip, street),
CONSTRAINT address_fk FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
); 

create table cust_comapny
(
cust_id int NOT NULL,
delegate varchar(20),
cname varchar(50) NOT NULL,
CONSTRAINT cust_company_pk PRIMARY KEY(cust_id),
CONSTRAINT cust_company_fk FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);


create table cust_individual
(
cust_id int NOT NULL,
fname varchar(20) NOT NULL,
lname varchar(20) NOT NULL,
CONSTRAINT cust_individual_pk PRIMARY KEY (cust_id),
CONSTRAINT cust_individual_fk FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);




CREATE TABLE Provider
(
prov_id       INT NOT NULL,
prov_state    VARCHAR(10),
prov_location VARCHAR(50),
prov_address  VARCHAR(50),
prov_name     VARCHAR(50),

CONSTRAINT Provide_PK
PRIMARY KEY (prov_id) );
				
CREATE TABLE Provider_Mail
(
prov_id INT  NOT NULL,
pMail   VARCHAR (50),

CONSTRAINT Provider_Mail_PK
PRIMARY KEY (prov_id,pMail)
);

CREATE TABLE Provider_Number
(
prov_id   INT NOT NULL ,
pNumber   INT,

CONSTRAINT Provider_Number_PK
PRIMARY KEY (prov_id , pNumber)
);

alter table provider
alter column prov_state varchar(50);

CREATE TABLE Product
(
prod_id      INT  NOT NULL ,
prod_import  CHAR,
prod_name    VARCHAR(50),
prod_weight  VARCHAR (10),
prod_section VARCHAR(20),
prod_tax     INT ,
prod_state   VARCHAR(10),
prod_price   INT ,
ware_id      INT NOT NULL,
prod_prov_id  INT,

CONSTRAINT Product_PK
PRIMARY KEY (prod_id),

CONSTRAINT PRODUCT_WAREHOUSE_FK
FOREIGN KEY(ware_id) REFERENCES warehouse(ware_id),

CONSTRAINT PRODUCT_PROVIDER_FK
FOREIGN KEY(prod_prov_id) REFERENCES Provider (prov_id)

);


CREATE TABLE Prod_Ship
(
pID   INT,
sh_ID INT,

CONSTRAINT Prod_Ship_PK
PRIMARY KEY (pID , sh_ID),

CONSTRAINT Prod_Ship_FK
FOREIGN KEY ( pID ) REFERENCES Product (prod_id),
 
CONSTRAINT Prod_Ship_FK1
FOREIGN KEY ( sh_ID) REFERENCES shipment(ship_id)
);
alter table prod_ship
add  quantity int;


CREATE TABLE Machines
(
prod_id  INT NOT  NULL ,
model    VARCHAR (20)

CONSTRAINT Machines_PK
PRIMARY KEY (prod_id),

CONSTRAINT Machines_FK
FOREIGN KEY (prod_id) REFERENCES Product ( prod_id)
);

CREATE TABLE Seeds
(
prod_id     INT NOT NULL ,
expire_date date

CONSTRAINT Seed_PK
PRIMARY KEY (prod_id),

CONSTRAINT Seed_FK
FOREIGN KEY (prod_id) REFERENCES Product( prod_id)
);


CREATE TABLE Agriculture_instruments
(
prod_id         INT NOT NULL,
kind_of_martial VARCHAR(20),

CONSTRAINT Agriculture_instruments_PK
PRIMARY KEY (prod_id),

CONSTRAINT Agriculture_instruments_FK
FOREIGN KEY ( prod_id ) REFERENCES Product ( prod_id)
);



CREATE TABLE Agriculture_insecticides
(
prod_id     INT NOT NULL ,
expire_date DATE

CONSTRAINT Agriculture_insecticides_PK
PRIMARY KEY ( prod_id),

CONSTRAINT Agriculture_insecticides_FK
FOREIGN KEY ( prod_id) REFERENCES Product( prod_id)
);

--Insertion section--

insert into Department (Dept_Pnumber,Dept_id,Dept_location,Dept_email,Dept_name)
values('111-222','101','H101','HR@AGCOMP.com','HR');

insert into Department (Dept_Pnumber,Dept_id,Dept_location,Dept_email,Dept_name) 
values('222-333','102','H102','PR@AGCOMP.com','PR');

insert into Department (Dept_Pnumber,Dept_id,Dept_location,Dept_email,Dept_name) 
values('555-333','103','G103','finance@AGCOMP.com','Finance');

insert into Department (Dept_Pnumber,Dept_id,Dept_location,Dept_email,Dept_name) 
values('444-223','104','G104','sales@AGCOMP.com','Sales');

insert into Department (Dept_Pnumber,Dept_id,Dept_location,Dept_email,Dept_name) 
values('111-333','105','k105','distributers@AGCOMP.com','Distributers');



insert into Employee(Emp_ssn,Emp_birthday,Emp_gender,Emp_Fname,Emp_Lname,Emp_street,Emp_zip_code,Emp_city,Emp_salary)
values(88,'7/7/1996','f','amal','donqol','bilno','112','masr',1260);

insert into Employee(Emp_ssn,Emp_birthday,Emp_gender,Emp_Fname,
Emp_Lname,Emp_street,Emp_zip_code,Emp_city,Emp_salary)
values(29,'8/3/1983','M','saad','samir','9th','185','new cairo',3250);

insert into Employee (Emp_ssn,Emp_birthday,Emp_gender,Emp_Fname,Emp_Lname
,Emp_street,Emp_zip_code,Emp_city,Emp_salary,Emp_Dept_id)
values(147,'6/3/1994','F','Nada','Gamal','inter-cont','0123','new cairo',2200,'105');


insert into Employee (Emp_ssn,Emp_birthday,Emp_gender,Emp_Fname,Emp_Lname,Emp_street,Emp_zip_code,Emp_city,Emp_salary,Emp_Dept_id)
values (1,'1/1/1990','M','mohamed','hegazy','menio','123','obour',20000,'101');

insert into Employee (Emp_ssn,Emp_birthday,Emp_gender,Emp_Fname,Emp_Lname,Emp_street,Emp_zip_code,Emp_city,Emp_salary,Emp_Dept_id)
values (10,'1/7/1973','M','asharf','mansour','henrdy','410','qahira',20000,'102');

insert into Employee
values(2,'3/7/1980','F','fadwa','akram','helioples','201','masr-elgdeda',5500,1,'101');
update Employee
set Emp_Dept_id ='102'
where emp_ssn=2;

insert into Employee
values(3,'1/9/1980','m','ahmed','mahomud','nozha','201','nozha-gdeda',5500,1,'101');
update Employee
set Emp_Dept_id='103'
where Emp_ssn=3;

insert into Employee
values(4,'1/5/1991','F','samar','mohamed','beinsaf','112','tagmou3-5ames',3200,10,'102');

insert into Employee
values(5,'3/4/1980','F','saly','saaed','helioples','201','masr-elgdeda',2800,10,'102');
update Employee
set Emp_Dept_id='104'
where Emp_ssn=5;
insert into Employee
values(6,'5/4/1989','F','meran','ahmed','ashraf-wahby','189','madinat-nasr',15000,10,'104');
update Employee
set Emp_Dept_id='105'
where Emp_ssn=6;

insert into Employee
values(7,'4/4/1980','F','leila','el-kharbotly','3rd st','452','madinaty',2800,6,'103');

insert into Employee
values(8,'3/8/1980','M','kareem','desoki','6th st','500','rehab',3500,1,'104');

insert into Employee
values(9,'3/3/1980','M','mohannad','saaed','bahy','201','alex',1200,6,'105');
insert into Employee
values(15,'3/3/1980','M','asharf','el-komy','sherok','3301','cairo',1500,6,'105');
insert into Employee
values(11,'3/3/1980','M','ahmed','ismael','fysal','2201','haram',2500,6,'105');
insert into Employee
values(12,'3/3/1980','M','mohamad','el-sayed','zagazig','2021','shrkia',2200,6,'105');


update Department 
set Dept_mng_ssn='1'
where Dept_id='101';

update Department
set Dept_mng_ssn ='2'
where Dept_id=102;

update  Department
set Dept_mng_ssn ='6'
where Dept_id=105;

update  Department
set Dept_mng_ssn ='5'
where Dept_id=104;

update  Department
set Dept_mng_ssn ='3'
where Dept_id=103;


insert into Provider
values ('1','local','Alexandria-Egypt','stanly st','Ahmed el-saadany');

insert into Provider
values ('2','local','Sharkia-Egypt','newzone st','mohamed asharf');

insert into Provider
values (3,'international','madrid-spain','melano st','loca modric');

insert into Provider
values (4,'international','rome-italy','livera st','james bond');

insert into Provider
values (5,'local','6th oct -Egypt','juhaina st','mahmoud mekkawy');

insert into Provider
values (6,'international','california-US','bread st','john santy');


insert into warehouse 
values('888','BADR','Centeral','5000');

insert into warehouse 
values('880','October','Sub1','2000');

insert into warehouse 
values('885','belbes','sub2','2500');

insert into warehouse 
values('111','rawwash','Centeral2','10000');

insert into warehouse 
values('112','bola2','sub-sub','1000');



insert into Provider_Number
values(1,888-555-444);

insert into Provider_Number
values(2,888-555-001);

insert into Provider_Number
values(3,888-444-444);

insert into Provider_Number
values(4,555-555-444);

insert into Provider_Number
values(5,444-555-444);

insert into Provider_Number
values(6,888-555-555);


insert into Product 
values(120,'y','Olive-seed','0.01 mg','seeds',15,'Effective',20,888,5);

insert into Product 
values(125,'y','apple-seed','0.12 mg','seeds',15,'Effective',20,885,1);

insert into Product 
values(11,'n','strapping-machine','1500 kg','machines',45,'Effective',19000,880,6);

insert into Product 
values(10,'y','tree-scissors','0.5 kg','instruments',35,'Effective',257.5,111,6)

insert into Product 
values(78,'y','tractor','5 tons','machines',140,'Effective',48580,112,3);

insert into Product 
values(147,'y','malathyon','400 mg','insectisides',38,'Effective',55,880,4);

insert into Product 
values(111,'n','Olive-seed','0.01 mg','seeds',15,'Effective',20,888,5);




insert into customer
values(155,'Egypt',1200)

insert into customer
values(255,'china',50000)

insert into customer
values(455,'Egypt',1200)

insert into customer
values(555,'US',152000)

insert into customer
values(541,'Egypt',1200)


insert into customer
values(1488,'china',500000)


insert into customer
values(2488,'china',150000)

update customer
set cust_amount_of_cons =cust_amount_of_cons+48580
where cust_id='155'

insert into cust_phone_number
values(155,0100023565)

insert into cust_phone_number
values (155 , 0120235560)

insert into cust_phone_number
values (155 , 0110001019)

insert into cust_phone_number
values(541,012014522)

insert into cust_phone_number
values(541,0122254109)

insert into cust_phone_number
values(541,01112223556)

insert into cust_phone_number
values(555,0111183215)

insert into cust_phone_number
values(555,012564789)

insert into cust_phone_number
values(455,01005454152)


insert into cust_email
values (155, 'hegazy123@gmail.com')

insert into cust_email
values (155 , 'Muhammed123@gmail')

insert into cust_email
values (155,'Muhammed123@hotmail')

insert into cust_email
values (455, 'ferial_m@hotmail.com')

insert into cust_email
values (455, 'ferial_m@gmail.com')

insert into cust_email
values (555,'john@gmail.com')

insert into cust_email
values (1488,'jenko@mail.jenk')

insert into cust_email
values (2488,'barukhan@mail')

insert into cust_email
values (2488,'barukhan_B@gmail.com')

insert into cust_email
values (255,'@dahlia.jenk')

insert into cust_email
values (255,'Dee@dahlia.jenk')



insert into cust_individual 
values(155,'mohamed','hegazy')

insert into cust_individual 
values(455,'ferial','mohamed')

insert into cust_individual 
values(541,'mohamed','ashraf')

insert into cust_individual 
values(555,'john','cenii')

insert into cust_comapny 
values(1488,'helkat12','genko');

insert into cust_comapny 
values(2488,'dahlia','barikuan');

insert into shipment
values (101,'CAR','NDeliverd',26,0.5,'2.30','03/12/2016','masr',455);
insert into shipment
values(111,'Car','Ndeliverd',11,1.6,'13.10','9/12/2016','alex',1488)

insert into shipment
values (102,'ship','Deliverd',330,0.5,'13.30','03/12/2016','alex',541);


insert into shipment
values (103,'DHL','NDeliverd',450,1.5,'2.30','03/12/2016','CHINA',1488);

insert into shipment
values (104,'plane','Deliverd',5000,3.5,'00.30','03/11/2016','CHINA',2488);

insert into shipment
values (105,'plane','Deliverd',1254,0.2,'2.30','1/10/2016','CHINA',255);

insert into shipment
values (106,'DHL','NDeliverd',550,1.0,'23.00','2/12/2016','US',555);

insert into shipment

values(108,'truck','Ndeliver',2800,5000,'00.00','9/12/2016','new cairo',155)


update shipment
set ship_state='Deliverd'
where ship_id=106;


insert into Prod_Ship
values(120,105,3);

insert into Prod_Ship
values(147,106,2)

insert into Prod_Ship
 values(111,101,3)

insert into Prod_Ship
values( 10,103,3);

update Prod_Ship 
set quantity =1
where pID=147;

update Prod_Ship 
set quantity =2
where pID=120;

insert into Seeds
values(111,'3/7/2017')


insert into Seeds
values(120,'1/1/2017')

insert into Agriculture_insecticides
values(147,'1/1/2018')

insert into Agriculture_instruments
values(10,'copper')

insert into Machines
values(78,'huyndai 2015')

insert into Working_for
values(9,104,15);

insert into Working_for
values(6,101,22)

insert into Working_for
values(15,103,3300)

insert into Working_for
values(12,104,1752.5)

insert into Working_for
values(12,106,2563)

insert into Working_for
values(9,111,13)

insert into Working_for
values(147,108,1)

--Queries section--

create view warehouse_items
as 
select count(prod_id) as '#of items',w.ware_id,w.ware_name,w.ware_location
from warehouse w,Product p
where w.ware_id=p.ware_id
group by w.ware_id,w.ware_name,w.ware_location

select*
from warehouse_items

create  view supervisors
AS 
select dept_id,Dept_name,emp_fname ,emp_ssn
from Employee,Department
where  emp_ssn=Dept_mng_ssn
group by Dept_id,Dept_name,Emp_Fname,emp_ssn

select * 
from supervisors


create view staff
as
select count(*)as '# no of employees',sum(emp_salary) as 'total salary',Dept_id,Dept_name
from Employee,Department
where Emp_Dept_id=Dept_id
group by Dept_id,Dept_name

-- the two queries are the same--
--1--
--Retriving the number of employees in each department and the total salary of each department--
select s.Dept_id,s.Dept_name,[total salary],[# no of employees],s.Emp_Fname as'manager name'
from supervisors s,staff f
where s.Dept_name=f.Dept_name

select count(*) As '# of employees',
sum(Emp_salary)as 'total salaries per month',d.dept_name,d.dept_id,d.Dept_mng_ssn
from Department d,Employee e
where e.Emp_Dept_id=Dept_id
group by d.Dept_name,d.Dept_id,Dept_mng_ssn

--2--
--Retriving the Fnames of the department managers and their ssn--
Select Dept_mng_ssn,Dept_id,Emp_Fname
from Department,Employee
where Dept_mng_ssn=Emp_ssn

--3--
--Retriving the shipment information, product information servred to which customer and the total price needed--
select p.prod_id,s.ship_fees,p.prod_name,
p.prod_price,ps.quantity,p.prod_tax,s.ship_method,s.ship_state,s.ship_delivdate,
c.cust_id,c.cust_location,ps.sh_ID,
((p.prod_price+(p.prod_price*(p.prod_tax*0.01)))*ps.quantity +s.ship_fees ) AS 'total price'
from Prod_Ship ps ,Product p,customer c,shipment s
where ps.pID=p.prod_id
and ps.sh_ID=ship_id
and s.customer_id=c.cust_id

--4--
--Retrive whether the product is imported or not and displaying thr providers information--
select prod_import,prod_id,prod_name,prov_id,prov_name,prov_state
from Product,Provider
where prod_prov_id=prov_id

--5--
--Display the producted stored in which warehouse--
select t.prod_id,prod_import,prod_name,w.ware_id,ware_capacity,ware_location
from product t,warehouse w
where t.ware_id=w.ware_id 

--6--
--Retriving the ssn and name of the employee working in which shipment and deliverying which product--
select emp_ssn, Emp_Fname+' '+ Emp_lname as 'full name',
ship_delivdate,ship_id,ship_fees,quantity,prod_id,prod_name,prod_prov_id,ware_id
from Employee,shipment,Working_for w,Prod_Ship,Product
where emp_ssn=w.Essn
and ship_id=w.s_id
and Pid=prod_id
and ship_id=sh_ID

--7--
--Retriving the information of all employess whose salary is greater than the employees working in department 105--
SELECT emp_Fname+' ' + emp_Lname as 'full name',Emp_Dept_id,Emp_salary,Dept_name
FROM Employee,Department
WHERE Emp_Dept_id=Dept_id
and emp_Salary > ALL (SELECT emp_Salary
FROM Employee
WHERE Emp_Dept_id = '105');

--8--
--Retrive the name of company customers and their data--
select distinct c.cust_id,c.cust_amount_of_cons,cp.cname,cp.delegate
from customer c,cust_comapny cp
where c.cust_id=cp.cust_id
and cust_amount_of_cons >=ALL(
select cust_amount_of_cons
from customer )

--9--
--Retrieve the quantity of products in each shipment--
SELECT sh_id,quantity
FROM Prod_Ship LEFT OUTER JOIN Product
ON Prod_Ship.pID= prod_id;

--10--
--Display the fname and lname and department id of each employee--
SELECT Emp_Fname, Emp_Lname, Emp_Dept_id
FROM Department RIGHT OUTER JOIN Employee
ON Dept_id= Emp_Dept_id;

--11--
--Display the ssn, department id and employee name and the manager name
select a.emp_ssn,a.Emp_Dept_id,a.Emp_Fname +' '+a.Emp_Lname as
'Employee name' ,b.Emp_Fname+' '+b.Emp_Lname as 'manager name' 
from Employee a join Employee b
on a.Emp_super_ssn=b.Emp_ssn

--12--
--The distributer working in which shipment, serving which product, stored in which warehouse--
select Emp_Fname+' '+Emp_Lname as 'distributor name',
sh_ID,prod_id,prod_name,ware_name,ware_location
from Employee,working_for,Prod_Ship,Product p,warehouse w
where Emp_ssn=Essn
and s_id=sh_ID
and pID=prod_id
and p.ware_id=w.ware_id

--13--
--Display the oldest employee--
select Emp_Fname,Emp_Lname,Emp_birthday,Emp_salary
from Employee
where Emp_birthday <=all
(select emp_birthday from Employee )

--14--
--Displaying the supervisors and the number of employees supervised by each of them--
SELECT s.Emp_ssn, s.Emp_Fname+' '+ s.Emp_Lname AS 'Full Name', COUNT(e.Emp_ssn) AS 'Number of Employees supervised'
FROM Employee e, Employee s
WHERE e.Emp_super_ssn = s.Emp_ssn
GROUP BY s.Emp_ssn, s.Emp_Fname, s.Emp_Lname

--15--
--Displaying the managers of each department--
SELECT Emp_Fname+ ' '+Emp_Lname AS 'Manager Name', Dept_name, Emp_salary
FROM Department, Employee
WHERE Dept_mng_ssn = Emp_ssn

--16--
--Displaying the information of the customer and the number of orders he ordered--
SELECT distinct c.*,COUNT(ship_id) AS 'Number of orders', ci.fname + ' ' + ci.lname AS 'Indivicual Name'
FROM customer c, shipment s, cust_individual ci
WHERE c.cust_id = ci.cust_id
and c.cust_id=s.customer_id
GROUP BY c.cust_id,c.cust_amount_of_cons,c.cust_location, ci.fname, ci.lname

SELECT distinct c.*,COUNT(ship_id) AS 'Number of orders', cc.cname
FROM customer c, shipment s, cust_comapny cc
WHERE c.cust_id = cc.cust_id
and c.cust_id=s.customer_id
GROUP BY c.cust_id,c.cust_amount_of_cons,c.cust_location, cc.cname


--17--
--Displaying the products stored in each warehouse--
SELECT p.prod_id, w.ware_id, p.prod_name, p.prod_weight, w.ware_name, w.ware_location
FROM warehouse w, Product p
where w.ware_id = p.ware_id
ORDER BY w.ware_id DESC


--18--
--Retrive the total sales of each employee working in shipping--
SELECT Essn, SUM((prod_price + (prod_price* (prod_tax*0.01)))*quantity) AS 'Total Sales'
FROM Working_for, Prod_Ship, Product
WHERE pID = prod_id
GROUP BY Essn


--19--
--Retriving the types of products in each warehouse--
SELECT warehouse.ware_id, prod_id, prod_name
FROM warehouse JOIN Product
ON warehouse.ware_id=Product.ware_id
ORDER BY warehouse.ware_id ASC


--20--
--Retriving the greatest salary in each department--
SELECT Dept_id, Dept_name, MAX(Emp_salary) AS 'Greatest salary'
FROM Employee JOIN Department
ON Dept_id = Emp_Dept_id
GROUP BY Dept_id, Dept_name

--21--
--Displayes female employees information and working in department no. 105--
SELECT Emp_ssn, Dept_id, Dept_name, Emp_Fname + ' ' + Emp_Lname AS 'Emp name', Emp_salary, Emp_birthday, Emp_gender
FROM Employee, Department
WHERE Emp_Dept_id = Dept_id
AND Emp_gender IN (SELECT Emp_gender
					FROM Employee
					WHERE Emp_gender ='F'
					AND Dept_id = '105')

--22--
--retrieve the product name whose shipment fees are between 500 and 3000, along with shipment method and the location it is shipped to.
select distinct p.prod_name, s.ship_fees, s.ship_method, s.ship_location
from Product p, shipment s, Prod_Ship ps
where p.prod_id=ps.pID and s.ship_fees between '500' and '3000'
group by p.prod_name,s.ship_fees, s.ship_method, s.ship_location
order by s.ship_fees

--23--
--retrieved the employee first name and their salary in addition to their salary after a 20% raise.
select e.Emp_Fname+' '+ e.Emp_Lname AS 'employee fullname',e.Emp_salary AS 'original salary', 
e.Emp_salary+e.Emp_salary*0.2 AS 'Salary after raise'
from Employee e
order by e.Emp_Fname DESC

--24--
--retrieve the number of employee working in cairo
select count(e.Emp_ssn), e.Emp_city
from Employee e
where e.Emp_city='cairo'
group by e.Emp_city

--25--
--retrieve the department location that starts with G1
select d.Dept_name AS 'Department name', d.Dept_location AS 'Location', d.Dept_Pnumber
from Department d
where d.Dept_location LIKE 'G1%'
order by d.Dept_Pnumber

--26--
--retrieve the employees name working in each specific department
select d.Dept_name, d.Dept_id, e.Emp_Fname+' '+ e.Emp_Lname AS 'Employee name', e.Emp_ssn
from Department d join Employee e
on d.Dept_id=e.Emp_Dept_id
order by e.Emp_Fname

--27--
--retrieve the department name which doesnt include any employee names
select e.Emp_Fname+ ' '+e.Emp_Lname AS 'Full name', d.Dept_name
from  Department d left outer join Employee e
on d.Dept_id=e.Emp_ssn

--28--
--retrieve the imported products
select p.prod_name AS 'prodect name', p.prod_import
from Product p 
where p.prod_import='y'
order by p.prod_id

--29--
--retrieve the delivery time of a shipment to the US
select s.ship_delitime AS 'US delivery date'
from shipment s
where exists (select *
                    from customer c
					where c.cust_location='US' );

--30--
--retrieve employees and their managers
select e.Emp_Fname+' '+e.Emp_Lname AS ' employee name', d.Emp_Fname AS 'Manager name'
from Employee e left outer join Employee d
on e.Emp_super_ssn=d.Emp_ssn

--31--
--Displayes the employee and the department he is working in and the product in the shipment he is working on--
--and the name of provider who provided this product and this product stored in which warehouse--
select Emp_Fname+' '+ Emp_Lname as 'full name',Dept_name,prod_name,prov_name,ware_name,ware_location
from Employee,Department,Working_for,Prod_Ship,Product p,warehouse w,Provider
where Emp_Dept_id=Dept_id
and Emp_ssn=Essn
and s_id=sh_ID
and pID=prod_id
and w.ware_id=p.ware_id
and p.prod_prov_id=prov_id

--32--
-- Retrieve Fname and Lname of the Manager of the HR dep. and his salary--

SELECT Emp_Fname+Emp_Lname AS 'Manager name' , Emp_salary,Dept_name
FROM Employee, Department
WHERE Dept_name = 'HR'
AND Dept_mng_ssn=Emp_ssn;

--33--
-- Retrieve manager's name and number of emp they manage--
SELECT b.Emp_ssn, b.Emp_Fname+' '+ b.Emp_Lname AS 'Manager Name', COUNT(e.Emp_ssn) AS 'Number of Managed emp'
FROM Employee e, Employee b
WHERE e.Emp_super_ssn = b.Emp_ssn
GROUP BY b.Emp_ssn, b.Emp_Fname, b.Emp_Lname ; 

--34--
-- Retrieve the min salary in each dept and incrase it by 20 % --
SELECT Dept_id, Dept_name, MIN(Emp_salary)*0.2 AS 'Raised salary' 
FROM Employee JOIN Department
ON Dept_id = Emp_Dept_id 
GROUP BY Dept_id, Dept_name;


--35--
--Retrieve  the name of the machine and its data -- 
SELECT DISTINCT p.prod_id , p.Prod_name , p.Prod_weight , b.Model
FROM Product p , Machines b
WHERE p.prod_id=b.prod_id
AND prod_weight >= ALL(SELECT prod_weight
                        FROM Product);
--36--
--Retrive each warehouse and its capacity -- 
SELECT DISTINCT ware_id , ware_capacity
FROM warehouse ;

--37--
-- Retrieve number of products by each provider --
SELECT COUNT(prod_id) AS 'Number of Products' , Prov_name
FROM Product JOIN Provider
ON prov_id=prod_prov_id
GROUP BY prov_name;

--38--
--Retrieve the name of individual customers and their data -- 
select distinct a.cust_id,a.cust_amount_of_cons,b.Fname+' '+b.lname AS 'Customer name'
from customer a,cust_individual b
where a.cust_id=b.cust_id
and cust_amount_of_cons <=ALL(
select cust_amount_of_cons
from customer );


