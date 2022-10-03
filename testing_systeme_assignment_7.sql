-- Chú ý: Tạo 1 File SQL đặt tên là "Testing_System_Assignment_7"
-- Exercise 1: Tiếp tục với Database Testing Syste
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo
-- trước 1 năm trước
USE testingsystem;
DROP TRIGGER IF EXISTS can_not_login;
 DELIMITER $$
	CREATE TRIGGER can_not_login
	BEFORE INSERT on `group`
	FOR EACH ROW 
	BEGIN 
	IF new.CreateDate<year(now())-1
		then 
	SIGNAL SQLSTATE '12223'
	SET MESSAGE_TEXT= 'lỗi dữ liệu vào bảng ';
 END IF;
 end $$
  DELIMITER ;
 
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào
-- department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DROP TRIGGER IF EXISTS can_not_add_any_user;
 DELIMITER $$
 CREATE TRIGGER can_not_add_any_use
	before INSERT on `department`
		FOR EACH ROW 
		begin 
		if 
			new.departmentname ='sale'
		then 
		SIGNAL SQLSTATE '12223'
		SET 	
			MESSAGE_TEXT= 'Sale" cannot add more user';
		END IF;
 end $$
  DELIMITER ;
-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user
DROP TRIGGER IF EXISTS `can_not_add_user>5`;
 DELIMITER $$
 CREATE TRIGGER `can_not_add_user>5`
before INSERT on `groupaccount`
 FOR EACH ROW 
 begin 
		DECLARE var_groupid TINYINT ;
		SELECT 
			COUNT(1) INTO var_groupid
		FROM
			groupaccount gr
		WHERE
			gr.groupid = NEW.groupid;
		if (var_groupid >5)
		then 
		SIGNAL SQLSTATE '12223'
		SET MESSAGE_TEXT= 'Cant add more User to This Group';
 END IF;
 end $$
  DELIMITER ;
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS`can_not_add_Question>10`;
 DELIMITER $$
 CREATE TRIGGER `can_not_add_Question>10`
before INSERT on `examquestion`
 FOR EACH ROW 
 begin 
 DECLARE var_countex TINYINT ;
SELECT 
    COUNT(ex.examid)
INTO var_countex FROM
    examquestion ex
WHERE
    ex.examid = new.examid;
 if (var_countex >10)
 then 
 SIGNAL SQLSTATE '12223'
 SET MESSAGE_TEXT= 'Cant add question is limitted 10';
 END IF;
 end $$
  DELIMITER ;
-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là
-- admin@gmail.com (đây là tài khoản admin, không cho phép user xóa)-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông
-- tin liên quan tới user đó
DROP TRIGGER IF EXISTS not_delete_adm;
 delimiter $$
 CREATE TRIGGER not_delete_adm
 BEFORE DELETE on `account`
 FOR EACH ROW
 BEGIN
 DECLARE var_email VARCHAR (50);
 SET var_email = 'admin@gmail.com' ;
 if (old.email = var_email) then
 SIGNAL SQLSTATE '12345'
SET MESSAGE_TEXT = 'bạn không thể xóa account admin!!';

END IF;
END $$
DELIMITER ;

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waitinDepartment"

DROP TRIGGER IF EXISTS `def_waitingDepartment` ;
 DELIMITER $$
 CREATE TRIGGER def_waitingDepartment
 BEFORE INSERT on `account`
 FOR EACH ROW
 BEGIN
 DECLARE v_waitinDepartment VARCHAR(255);
SELECT 
		DepartmentID
into 
		v_waitinDepartment
 FROM
		testingsystem.department
WHERE
		DepartmentName = 'waitinDepartment';
 if (new.DepartmentID is null )
 then
 SET NEW.DepartmentID = v_waitinDepartment;
 END IF;
 END $$
 DELIMITER ;
 
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.
DROP TRIGGER IF EXISTS `4answers_and_2question_correct`;
DELIMITER $$
CREATE TRIGGER `4answers_and_2question_correct`
BEFORE INSERT on `answer`
FOR EACH ROW
BEGIN
 DECLARE V_countinquestion TINYINT;
 DECLARE V_countincorrect TINYINT ;
SELECT 
    COUNT(q.questionid)
INTO V_countinquestion FROM
    testingsystem.answer q
WHERE
    q.QuestionID = new.QuestionID;
SELECT 
    COUNT(*)
INTO V_countincorrect FROM
    testingsystem.answer q
WHERE
    q.QuestionID = new.QuestionID
        and q.isCorrect = new.isCorrect;
 if (  V_countinquestion>4 )or( V_countincorrect>2
 ) THEN
 SIGNAL SQLSTATE '45000'
 SET MESSAGE_TEXT = 'không thể thêm dữ liệu bị lỗi';
 END IF;
 END $$
 DELIMITER ;
 
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database
DROP TRIGGER IF EXISTS gender_correction;
DELIMITER $$
CREATE TRIGGER gender_correction 
BEFORE INSERT  on `account`
FOR EACH ROW
BEGIN
if new.Gender = 'Nam'THEN
SET new.Gender ='M';
ELSEIF  new.Gender = 'Nữ'THEN
SET new.Gender ='F';
ELSEIF  new.Gender = 'Chưa xác định 'THEN
SET new.Gender ='U';
END IF;
END $$
DELIMITER ;
 
-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày
DROP TRIGGER IF EXISTS deletl_new_exam_created_2_days;
DELIMITER $$
CREATE TRIGGER deletl_new_exam_created_2_days
BEFORE DELETE on exam
		FOR EACH ROW
        BEGIN
        DECLARE V_dell_CreateDate DATE;
				set V_dell_CreateDate= DATE_SUB(NOW(),INTERVAL 2 DAY);
                IF (OLD.CreateDate>V_dell_CreateDate) THEN
                SIGNAL SQLSTATE '12222'
                SET MESSAGE_TEXT = 'KHÔNG THỂ XÓA BÀI THI QUÁ HẠN ';
                END IF;
                END $$
                DELIMITER ;
                
-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào
DROP TRIGGER IF EXISTS deletl_question_not_in_exam;
DELIMITER $$
CREATE TRIGGER delete_question_not_in_exam
BEFORE DELETE on question
		FOR EACH ROW
        BEGIN
        DECLARE V_countquestionid TINYINT;
        set V_countquestionid=-1;
        SELECT COUNT(*) INTO V_countquestionid FROM testingsystem.examquestion q
        WHERE q.QuestionID = OLD.QuestionID;
        IF (V_countquestionid<>-1) THEN
        SIGNAL SQLSTATE '11112'
        SET MESSAGE_TEXT ='KHÔNG THỂ XÓA FILE NÀY';
        END IF;
        END $$
        DELIMITER ;
-- Question 12: Lấy ra thông tin exam trong đó:
-- duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"
SELECT *, CASE
	WHEN duration <= 30 THEN 'Short time'
    WHEN duration <= 60 THEN 'Medium time'
    ELSE 'Long time'
    END as duration
    FROM Exam ;
-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:2
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT 
    GA.GroupID,
    COUNT(GA.GroupID),
    CASE
        WHEN COUNT(GA.GroupID) <= 5 THEN 'few'
        WHEN COUNT(GA.GroupID) <= 20 THEN 'normal'
        ELSE 'higher'
    END AS the_number_user_amount
FROM
    groupaccount GA
GROUP BY GA.GroupID;


-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"
SELECT 
    D.DepartmentName,
    CASE
        WHEN COUNT(A.DepartmentID) = 0 THEN 'Không có User'
        ELSE COUNT(A.DepartmentID)
    END AS SL
FROM
    department D
        LEFT JOIN
    account A ON D.DepartmentID = A.DepartmentID
GROUP BY d.DepartmentID