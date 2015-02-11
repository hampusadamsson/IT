/*PART 2 - 2.2*/
Select Count(*)
FROM Employee E, Department D
Where E.Department = D.Number AND D.Name = 'IT';

/*PART 2 - 2.3*/
SELECT D.Number, D.Name, avg(Salary)
From Department D, Employee E
where D.Number = E.Department
GROUP by D.Number, D.Name;

/*PART 2 - 2.4*/
Select D.Name, avg(salary)
FROM Employee E, Department D
Where E.Department = D.Number
GROUP by D.Number
HAVING count(EmpID)>= 4 AND 
avg(salary)>45000;


/*PART 2 - 2.5*/
Select Employee.Department,Max(salary)
From Employee join Project on 
Employee.Department = Project.Department
GROUP by Employee.Department
HAVING count(DISTINCT EmpID)>= 5 and count(distinct Number) >=2;

/*PART 2 - 3.2*/
select Name, Surname
From Employee E
Where Supervisor In (Select EmpID;

/*PART 2 - 3.3*/
Select E.Name, E.Surname
From Employee E, Works_on W, Project P left outer join Location L on P.Number = L.Project
Where E.EmpID = W.Employee and
W.Project = P.number and Location is null;

/*PART 2 - 3.4*/
Select Name, Surname
From Employee E join Works_on W on 
E.EmpID=W.Employee
Where Project in
	(SELECT Number
	From Project Where Department in
		(Select D.Number 
									)			)