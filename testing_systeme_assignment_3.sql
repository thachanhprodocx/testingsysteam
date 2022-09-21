-- はじめましょう
USE testingsystem;
-- câu 22 lấy ra các phonbgf ban

SELECT *
FROM department;

-- câu 3 lấy ra id của  các phòng ban sale
SELECT DepartmentID
FROM department
WHERE DepartmentName='Sale';


-- câu 4 lấy ra thông tin account có full name dài nhất
SELECT MAX(length(Fullname))
FROM `account`;
SELECT*
FROM `account`
WHERE length(Fullname)=15;

-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id-3
SELECT*
FROM `account`
WHERE DepartmentID=3 and (SELECT MAX(LENGTH(Fullname)) FROM `account`);

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/122019
SELECT *
FROM `group`
WHERE CreateDate<'2019/12/20';
-- Lấy ra ID của question có >= 4 câu trả lời

SELECT * FROM answer;

SELECT 
    QuestionID, COUNT(1) as `số lượng`
FROM
    answer
GROUP BY QuestionID
HAVING count(QuestionID) >= 4;

-- Question 8: Lấy ra các mã đề thi có thời gian thi Duration>= 60 phút và được tạo trước ngày20/12/2019
SELECT `code`
FROM exam
WHERE Duration >= 60 and CreateDate<'2019/12/20';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất
SELECT*
FROM `group`
ORDER BY CreateDate DESC
LIMIT 5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2
SELECT COUNT(1) as `số nhân viên`,DepartmentID
FROM `account`
WHERE DepartmentID = 2;

-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
SELECT *
FROM `Account`
WHERE FullName like ('A%i');

-- Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM testingsystem.exam
WHERE CreateDate<'2019/12/20';
-- Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" chưa lam đc

 DELETE FROM question
 WHERE Content LIKE  'Câu hỏi%' ;
 
-- Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" vàemail thành loc.nguyenba@vti.com.vn
UPDATE `Account`
SET FullName = 'Nguyễn Bá Lộc', Email= 'loc.nguyenba@vti.com.vn'
WHERE AccountID = 5;
SELECT * 
FROM `Account`;

-- Question 15: update account có id = 5 sẽ thuộc group có id bănngf 4
UPDATE groupaccount 
SET AccountID = 5
WHERE GroupID = 4;
SELECT *
FROM groupaccount;
-- đã hôàn thành hơi muộn 20-09 ちょっと下手けど　もっともっと頑張って下さい　俺がね