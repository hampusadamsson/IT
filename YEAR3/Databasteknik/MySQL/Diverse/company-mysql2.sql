CREATE DATABASE Company;

USE Company;

CREATE TABLE Department (
Number int PRIMARY KEY,
Name varchar(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Project (
Number int PRIMARY KEY,
Name varchar(100) NOT NULL,
Department int
references Department(Number) on update cascade
) ENGINE=InnoDB;


CREATE TABLE Location (
Location varchar(100) PRIMARY KEY,
Department int
references Department(Number) on update cascade,
Project int
references Project(Number) on update cascade
) ENGINE=InnoDB;

CREATE TABLE Employee (
EmpID int PRIMARY KEY,
SSN char(10) UNIQUE,
Name varchar(100) NOT NULL,
Surname varchar(100) NOT NULL,
Salary int,
Department int
references Department(Number) on delete set null on update cascade,
Supervisor int
references Employee(EmpID) on delete set null on update cascade,
CHECK (supervisor<>EmpID),
CHECK (salary <= 100000)
) ENGINE=InnoDB;

CREATE TABLE Manager (
EmpID int
references Employee(EmpID) on delete set null on update cascade,
Department int
references Department(Number) on delete set null on update cascade,
StartDate date,
primary key (EmpID,Department)
) ENGINE=InnoDB;

CREATE TABLE Works_on (
Employee int
references Employee(EmpID) on update cascade,
Project int
references Project(Number) on update cascade,
StartDate date,
Weeks int,
Hours_per_week float,
PRIMARY KEY(Employee, Project)
) ENGINE=InnoDB;

INSERT INTO Department VALUES (1,'IT');
INSERT INTO Department VALUES (2,'Medicine');
INSERT INTO Department VALUES (3,'Law');
INSERT INTO Department VALUES (4,'History');

INSERT INTO Project VALUES (1,'NG-smartphone',1);
INSERT INTO Project VALUES (2,'CommuniKat',1);
INSERT INTO Project VALUES (3,'SmartPower',1);
INSERT INTO Project VALUES (4,'SelfAdapt',1);
INSERT INTO Project VALUES (5,'Cardio',2);
INSERT INTO Project VALUES (6,'Cardio2',2);
INSERT INTO Project VALUES (7,'King genealogy',4);

INSERT INTO Location VALUES ('R132',1,1);
INSERT INTO Location VALUES ('R124',1,1);
INSERT INTO Location VALUES ('R125',1,1);
INSERT INTO Location VALUES ('R232',1,2);
INSERT INTO Location VALUES ('R233',1,3);
INSERT INTO Location VALUES ('R234',1,4);
INSERT INTO Location VALUES ('AB1',2,5);
INSERT INTO Location VALUES ('AB2',2,6);
INSERT INTO Location VALUES ('AB3',3,null);
INSERT INTO Location VALUES ('Aula',null,null);
INSERT INTO Location VALUES ('AulaBis',null,null);

-- supervisors
INSERT INTO Employee VALUES (1,'6808029376','John','McEnroe',53000,1,null);
INSERT INTO Employee VALUES (2,'6803080476','Roger','Federer',59000,2,null);
INSERT INTO Employee VALUES (3,'6805191585','Pete','Sampras',55000,3,null);
INSERT INTO Employee VALUES (4,'6804068855','Rafael','Nadal',55000,4,null);
-- other employees
INSERT INTO Employee VALUES (5,null,'Rafael','Codardus',43000,1,1);
INSERT INTO Employee VALUES (6,'6803036078','Obama','Virilus',34000,1,1);
INSERT INTO Employee VALUES (7,'7808178347','Karl','Gloriosus',43500,1,1);
INSERT INTO Employee VALUES (8,'6809099948','Carl','Macho',33000,1,1);
INSERT INTO Employee VALUES (9,'7802136064','Moni','Merd',31000,2,2);
INSERT INTO Employee VALUES (10,'6804228795','Dave','Nerd',45500,2,9);
INSERT INTO Employee VALUES (11,'7803139814','David','Carrol',49500,2,9);
INSERT INTO Employee VALUES (12,'6806150479','Carl','Farter',47000,2,9);
INSERT INTO Employee VALUES (13,'8808267475','Linda','Cocco',44500,3,null);
INSERT INTO Employee VALUES (14,'6804182372','Maria','Milusson',48000,3,null);
INSERT INTO Employee VALUES (15,'8803134478','Monk','Forksen',38500,3,3);
INSERT INTO Employee VALUES (16,'8807167470','Peter','Mustacchi',41000,3,null);
INSERT INTO Employee VALUES (17,'6808289577','Pete','Carrol',48000,4,4);
INSERT INTO Employee VALUES (18,'8803194475','Marina','Golpe',58000,4,4);
INSERT INTO Employee VALUES (19,'4803165434','John','Golpe',49500,4,4);
INSERT INTO Employee VALUES (20,'5806236475','Alvaro','Codardus',42000,4,4);

INSERT INTO Manager VALUES(1,1,'2013-07-27');
INSERT INTO Manager VALUES(12,2,'2013-05-14');
INSERT INTO Manager VALUES(3,3,'2013-02-18');
INSERT INTO Manager VALUES(4,4,'2012-12-16');

INSERT INTO Works_on VALUES(1,1,'2012-04-07',12,37);
INSERT INTO Works_on VALUES(1,2,'2012-08-07',12,37);
INSERT INTO Works_on VALUES(1,3,'2012-08-27',12,37);
INSERT INTO Works_on VALUES(1,4,'2013-07-07',8,37);
INSERT INTO Works_on VALUES(3,4,'2013-07-07',16,37);
INSERT INTO Works_on VALUES(4,4,'2012-07-07',16,37);
INSERT INTO Works_on VALUES(5,1,'2012-04-07',12,37);
INSERT INTO Works_on VALUES(6,1,'2012-04-07',10,37);
INSERT INTO Works_on VALUES(7,2,'2012-08-07',10,37);
INSERT INTO Works_on VALUES(7,3,'2012-08-27',8,37);
INSERT INTO Works_on VALUES(8,4,'2013-09-07',2,37);
INSERT INTO Works_on VALUES(13,1,'2012-04-07',8,37);
INSERT INTO Works_on VALUES(14,2,'2012-08-07',10,37);
INSERT INTO Works_on VALUES(15,3,'2012-08-27',12,37);
INSERT INTO Works_on VALUES(16,4,'2013-09-07',2,37);
INSERT INTO Works_on VALUES(9,5,'2013-04-21',4,37);
INSERT INTO Works_on VALUES(10,5,'2013-04-21',4,37);
INSERT INTO Works_on VALUES(11,5,'2013-04-21',4,37);
INSERT INTO Works_on VALUES(12,5,'2013-04-21',4,37);
INSERT INTO Works_on VALUES(9,6,'2012-07-31',5,37);
INSERT INTO Works_on VALUES(10,6,'2012-07-31',4,37);
INSERT INTO Works_on VALUES(11,6,'2012-07-31',4,37);
INSERT INTO Works_on VALUES(12,6,'2012-07-31',16,37);
INSERT INTO Works_on VALUES(20,7,'2013-01-26',4,37);