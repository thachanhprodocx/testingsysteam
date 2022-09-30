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

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
SELECT *
FROM testingsystem.typequestion ty
JOIN testingsystem.question q
on ty.TypeID=q.TypeID
WHERE ty.TypeID 

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
DROP PROCEDURE IF EXISTS cau_11;
DELIMITER $$
CREATE PROCEDURE cau_11 (in iin_DepartmentName VARCHAR(255)UNICODE)
BEGIN 
SELECT *
FROM 
--  Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay 2
-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")
-- 1. Nhập vào DepartmentID sau đó sử dụng function để in ra DepartmentName