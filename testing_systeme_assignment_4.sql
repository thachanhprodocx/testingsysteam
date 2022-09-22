-- 問題4はじめましょう
-- b1 xem thông tin accounnt có j

use testingsystem;
SELECT *
FROM `account`;
-- b2 xác định thứ muốn tìm 
-- b3 xác định kiểu join và viếT

SELECT a.Email,a.FullName,a.Username,a.CreateDate,d.DepartmentName
FROM `account` AS a
JOIN department d on a.DepartmentID=d.DepartmentID;

-- câu 2
SELECT*
FROM `account`
WHERE CreateDate>'2020-03-10';

-- câu 3 lấy ra các thoong tin có chứa dev

SELECT * 
FROM position;
SELECT a.Email,a.FullName,a.Username,a.CreateDate,p.PositionName
FROM `account` a
JOIN position as p on a.PositionID =p.PositionID
HAVING p.PositionName ='Dev';
-- câu 4 Viết lệnh để lấy ra danh sách các phòng ban có >2 nhân viên
-- cách viết thông thường có quá nhiều bước  
SELECT * 
FROM `account`
GROUP BY DepartmentID
HAVING COUNT(departmentID)>2;
SELECT*
FROM department
WHERE DepartmentID =2;
-- khi  ta sử dụng câu lệnh join câu lệnh sẽ được rút ngắn như sau
SELECT d.departmentname,COUNT(a.departmentID) `tổng số nhân viên`
FROM `account` AS a
JOIN department as d on a.departmentID=d.departmentID
GROUP BY a.departmentID
HAVING  COUNT(a.departmentID)>2;

-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT ExamID, COUNT(1) `ls câu hỏi`
FROM examquestion
GROUP BY QuestionID
ORDER BY `ls câu hỏi` DESC
LIMIT 1;
-- 
SELECT Content,eq.ExamID,COUNT(1) sl
FROM question q
JOIN examquestion eq on q.QuestionID=eq.QuestionID
GROUP BY q.QuestionID
ORDER BY sl DESC
LIMIT 1
;


-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu question
SELECt cn.CategoryName,COUNT(q.CategoryID)
FROM question q
left JOIN categoryquestion cn on q.CategoryID =cn.CategoryID
GROUP BY q.CategoryID;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
SELECT q.QuestionID, COUNT(1) sl 
FROM Examquestion e
JOIN Question q on q.QuestionID= e.QuestionID
GROUP BY e.QuestionID;





-- Question 8: Lấy ra Question có nhiều câu trả lời nhấT
 SELECT QuestionID,COUNT(1) sl
FROM answer
GROUP BY QuestionID
ORDER BY sl DESC
LIMIT 1;
SELECT Content
FROM question
WHERE QuestionID =1;
-- hoặc giải theo join thì
SELECT q.Content,COUNT(1) sl
FROM question q
JOIN answer a on a.QuestionID =q.QuestionID
GROUP BY a.QuestionID
ORDER BY sl DESC
LIMIT 1;

-- Question 9: Thống kê số lượng account trong mỗi group
SELECT COUNT(1) `sô lượng `,g.GroupID
FROM `group` g
JOIN groupaccount ga ON g.GroupID = ga.GroupID
GROUP BY ga.GroupID;

-- Question 10: Tìm chức vụ có ít người nhất
SELECT p.PositionName,COUNT(1) `số lượng`
FROM `account` a
LEFT JOIN position p  on p.PositionID=a.PositionID
GROUP BY a.PositionID
ORDER BY `số lượng`
LIMIT 2;



-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
SELECT *
FROM `account`;
SELECT d.DepartmentName, p.PositionName,COUNT(d.DepartmentID) `số lượng`
FROM department d
LEFT JOIN
 `account` a on a.DepartmentID = d.DepartmentID
 JOIN position p on p.PositionID = a.PositionID
 GROUP BY d.DepartmentID;
  


-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
SELECT Q.QuestionID, Q.Content, A.FullName, T.TypeName, AN.Content FROM question Q 
JOIN categoryquestion CQ ON Q.CategoryID = CQ.CategoryID
JOIN typequestion T ON Q.TypeID = T.TypeID
JOIN account A ON A.AccountID = Q.CreatorID
JOIN Answer AS AN ON Q.QuestionID = AN.QuestionID;




-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
SELECT COUNT(1) `số lương`,TypeID
FROM question 
GROUP BY TypeID;
SELECT t.TypeName,t.TypeID,COUNT(t.TypeID) `số lượng`
FROM question q
JOIN typequestion t on t.TypeID=q.TypeID
GROUP BY q.TypeID;


-- Question 14:Lấy ra group không có account nào
SELECT GroupName
FROM `group`AS gr
LEFT JOIN `account` ac
on ac.accountID=CreatorID 
WHERE ac.accountID IS NULL;



-- Question 16: Lấy ra question không có answer nào
-- LẤY RA câu hỏi không có câu trả lời nào
SELECT qt.QuestionID `mã câu hỏi`,qt.Content
FROM question qt
LEFT JOIN answer an on qt.QuestionID = an.QuestionID
WHERE an.QuestionID is NULL;


-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
-- b) Lấy các account thuộc nhóm thứ 2
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.`AccountID`,a.Email,a.Username,a.FullName,a.CreateDate,g.GroupID
FROM `account` a
JOIN groupaccount g on a.AccountID =g.AccountID
WHERE g.GroupID=1;
-- b) Lấy các account thuộc nhóm thứ 2
SELECT a.`AccountID`,a.Email,a.Username,a.FullName,a.CreateDate,g.GroupID
FROM `account` a
JOIN groupaccount g on a.AccountID =g.AccountID
WHERE g.GroupID=2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
SELECT a.`AccountID`,a.Email,a.Username,a.FullName,a.CreateDate,g.GroupID
FROM `account` a
JOIN groupaccount g on a.AccountID =g.AccountID
WHERE g.GroupID=1
UNION
SELECT a.`AccountID`,a.Email,a.Username,a.FullName,a.CreateDate,g.GroupID
FROM `account` a
JOIN groupaccount g on a.AccountID =g.AccountID
WHERE g.GroupID=2;



-- Question 18:
-- a) Lấy các group có lớn hơn 2 thành viên
SELECT g.GroupName,a.FullName,COUNT(1) sl
FROM `group` g
JOIN `account` a on a.AccountID=g.CreatorID
GROUP BY a.AccountID
HAVING sl >2;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT g.GroupName,a.FullName,COUNT(1) sl
FROM `group` g
JOIN `account` a on a.AccountID=g.CreatorID
GROUP BY a.AccountID
HAVING sl <7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT g.GroupName,a.FullName,COUNT(1) sl
FROM `group` g
JOIN `account` a on a.AccountID=g.CreatorID
GROUP BY a.AccountID
HAVING sl >2 
UNION all
SELECT g.GroupName,a.FullName,COUNT(1) sl
FROM `group` g
JOIN `account` a on a.AccountID=g.CreatorID
GROUP BY a.AccountID
HAVING sl <7;









