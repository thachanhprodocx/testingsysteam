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
-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DELIMITER $$
create procedure thong_ke_question_duoc_tao_gan()
		begin
			SELECT 
				tq.*, COUNT(q.TypeID) as sl_question
			FROM
				typequestion tq
					LEFT JOIN
				question q ON tq.TypeID = q.TypeID
			WHERE
				YEAR(q.CreateDate) = YEAR(NOW())
					AND MONTH(q.createDate) = MONTH(NOW())
			GROUP BY tq.typeId;  
		end$$
DELIMITER ;
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất

DELIMITER $$

CREATE PROCEDURE ty_questionid ()
BEGIN
WITH ls_kieu_cau_hoi as (
SELECT COUNT(1) sl
FROM testingsystem.question
GROUP BY question.TypeID )
SELECT ty.TypeID,COUNT(q.TypeID) sl1
FROM testingsystem.typequestion ty JOIN testingsystem.question q on q.TypeID =ty.TypeID
GROUP BY q.TypeID 
HAVING  COUNT(q.TypeID)= (SELECT MAX(sl)FROM ls_kieu_cau_hoi);
  End$$
DELIMITER ;
Call ty_questionid();
-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DELIMITER $$
CREATE PROCEDURE ty_questionname ()
BEGIN
WITH ls_kieu_cau_hoi as (
SELECT COUNT(1) sl
FROM testingsystem.question
GROUP BY question.TypeID )
SELECT ty.TypeName,COUNT(q.TypeID) sl1
FROM testingsystem.typequestion ty JOIN testingsystem.question q on q.TypeID =ty.TypeID
GROUP BY q.TypeID 
HAVING  COUNT(q.TypeID)= (SELECT MAX(sl)FROM ls_kieu_cau_hoi);
  End$$
DELIMITER ;
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào

DELIMITER $$
create procedure thong_tin_acc_use(
	in in_sequence varchar(255))
		begin
			select a.username as result from account a where a.username like CONCAT('%', in_sequence, '%')
			union
			select g.groupName as result from `group` g where g.GroupName like CONCAT('%', in_sequence, '%');
		end $$
DELIMITER ;
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DROP PROCEDURE IF EXISTS thong_tin_ket_qua;
DELIMITER $$
CREATE PROCEDURE thong_tin_ket_qua(IN IN_FullName varchar(255) ,in in_email varchar (50))
BEGIN
 DECLARE v_Username VARCHAR(50) DEFAULT SUBSTRING_INDEX(var_Email, '@', 1);
DECLARE v_DepartmentID TINYINT UNSIGNED DEFAULT 11;
DECLARE v_PositionID TINYINT UNSIGNED DEFAULT 1;
INSERT INTO `account` (`Email`, `Username`, `FullName`,
`DepartmentID`, `PositionID`, `CreateDate`)
VALUES (var_Email, v_Username, var_Fullname,
v_DepartmentID, v_PositionID, v_CreateDate);
END $$
DELIMITER;


-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất


-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DROP PROCEDURE IF EXISTS xoa_ex;
DELIMITER $$
CREATE PROCEDURE xoa_ex (IN in_ExamID TINYINT UNSIGNED)
BEGIN
DELETE FROM examquestion WHERE ExamID = in_ExamID;
DELETE FROM Exam WHERE ExamID = in_ExamID;
END$$
DELIMITER ;
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ đưoc chuyển về phòng ban default là phòng ban chờ việc
DROP PROCEDURE IF EXISTS SP_DelDepFromName;
DELIMITER $$
CREATE PROCEDURE SP_DelDepFromName(IN var_DepartmentName VARCHAR(255))
BEGIN
DECLARE v_DepartmentID VARCHAR(255) ;
SELECT D1.DepartmentID INTO v_DepartmentID FROM department D1 WHERE D1.DepartmentName
= var_DepartmentName;
UPDATE `account` A SET A.DepartmentID = '11' WHERE A.DepartmentID = v_DepartmentID;
DELETE FROM department d WHERE d.DepartmentName = var_DepartmentName;
END$$
DELIMITER ;

--  Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay  
DROP PROCEDURE IF EXISTS `how many questions are created per month this year`;
DELIMITER $$
CREATE PROCEDURE `how many questions are created per month this year`()
BEGIN
WITH CTE_12Months AS (
SELECT 1 AS MONTH
UNION SELECT 2 AS MONTH
UNION SELECT 3 AS MONTH
UNION SELECT 4 AS MONTH
UNION SELECT 5 AS MONTH
UNION SELECT 6 AS MONTH
UNION SELECT 7 AS MONTH
UNION SELECT 8 AS MONTH
UNION SELECT 9 AS MONTH
UNION SELECT 10 AS MONTH
UNION SELECT 11 AS MONTH
UNION SELECT 12 AS MONTH
)
SELECT 
    M.MONTH, count(month(Q.CreateDate)) AS SL
FROM
    CTE_12Months M
        LEFT JOIN
    (SELECT 
        *
    FROM
        question Q1
    WHERE
        year(Q1.CreateDate) = year(now())) Q ON M.MONTH = month(Q.CreateDate)
GROUP BY M.MONTH;
END$$
DELIMITER ;
Call sp_CountQuesInMonth();

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
DROP PROCEDURE IF EXISTS sp_CountQuesBefore6Month;
DELIMITER $$
CREATE PROCEDURE sp_CountQuesBefore6Month()
BEGIN
WITH CTE_Talbe_6MonthBefore AS (

SELECT MONTH(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS MONTH,

YEAR(DATE_SUB(NOW(), INTERVAL 5 MONTH)) AS `YEAR`

UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS MONTH,

YEAR(DATE_SUB(NOW(), INTERVAL 4 MONTH)) AS `YEAR`

UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS MONTH,

YEAR(DATE_SUB(NOW(), INTERVAL 3 MONTH)) AS `YEAR`

UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS MONTH,

YEAR(DATE_SUB(NOW(), INTERVAL 2 MONTH)) AS `YEAR`
UNION
SELECT MONTH(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS MONTH,

YEAR(DATE_SUB(NOW(), INTERVAL 1 MONTH)) AS `YEAR`

UNION
SELECT MONTH(NOW()) AS MONTH, YEAR(NOW()) AS `YEAR`

)

SELECT M.MONTH,M.YEAR, CASE

WHEN COUNT(QuestionID) = 0 THEN 'không có câu hỏi nào trong

tháng'
ELSE COUNT(QuestionID)
END AS SL
FROM CTE_Talbe_6MonthBefore M
LEFT JOIN (SELECT * FROM question where CreateDate >= DATE_SUB(NOW(),

INTERVAL 6 MONTH) AND CreateDate <= now()) AS Sub_Question ON M.MONTH =
MONTH(CreateDate)

GROUP BY M.MONTH
ORDER BY M.MONTH ASC;

END$$
DELIMITER ;
-- Run:
CALL sp_CountQuesBefore6Month;
- 1. Nhập vào DepartmentID sau đó sử dụng function để in ra DepartmentName