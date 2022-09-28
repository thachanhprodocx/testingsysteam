USE testingsystem;
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DELIMITER $$
CREATE PROCEDURE department_of_ac (IN in_departmentName VARCHAR(50))
BEGIN
SELECT d.DepartmentName
FROM testingsystem.account a
JOIN testingsystem.department d on a.DepartmentID =d.DepartmentID
WHERE d.DepartmentName=in_departmentName;
END$$
DELIMITER ;

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
-- tìm số lượng acc trong mỗi gr
DELIMITER $$
CREATE PROCEDURE ac_in_gr (IN in_accountid INT)
BEGIN
SELECT gr.*,COUNT(gr.AccountID) sl
FROM testingsystem.account a JOIN
testingsystem.groupaccount gr on a.AccountID=gr.AccountID
GROUP BY gr.GroupID
HAVING  gr.GroupID = in_accountid ;
END$$
DELIMITER ;
-- caua 3