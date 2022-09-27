use testingsystem;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
CREATE VIEW `danh_sach_nhan_vien` AS
    (select 
        FullName
    from
        department d
            join
        account a
    where
        d.DepartmentID = a.DepartmentID
            and d.DepartmentName = 'Sale');
-- Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
-- cách 1 cte
DROP VIEW IF EXISTS `the number of groups the employee joins`;
CREATE VIEW `the number of groups the employee joins` as (
WITH                                                   -- sử dụng lệnh with để tạo bảng tạm (chỉ sử dug đc trong câu lệnh đó)
		sl as 
(SELECT
    COUNT(GroupID) sl1
	FROM 
	testingsystem.groupaccount
	GROUP BY
		AccountID)
SELECT
		a.FullName,a.AccountID,COUNT(a.AccountID) sl2 
FROM 
			testingsystem.account a 
JOIN 
			testingsystem.groupaccount d
on
			a.AccountID = d.AccountID
GROUP BY
			d.AccountID
		HAVING 
			COUNT(a.AccountID) =(SELECT MAX(sl1) FROM sl));
-- cách 2theo subquery

SELECT 
    a.AccountID, a.FullName, a.Email, COUNT(a.AccountID) sl
FROM
    testingsystem.account a
        JOIN
    testingsystem.groupaccount d ON a.AccountID = d.AccountID
GROUP BY a.AccountID
HAVING COUNT(a.AccountID) = (SELECT 
        MAX(COUNT1)
    FROM
        (SELECT 
            COUNT(gr.AccountID) COUNT1
        FROM
            testingsystem.groupaccount gr
        GROUP BY gr.AccountID) as sl1);
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
-- được coi là quá dài) và xóa nó đi
DROP VIEW 	
					sl_conten_qua_lon ; -- xóa view nếu có
CREATE VIEW 
					sl_conten_qua_lon as -- tạo view
(SELECT 
					*
FROM
					testingsystem.question q
WHERE 
					length(Content) > 19); -- length() đếm độ dài 

SET FOREIGN_KEY_CHECKS=0;    -- xóa foreign key tạm thời
DELETE FROM sl_conten_qua_lon;
-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
-- cách 1 theo cte
DROP VIEW IF EXISTS 
`department has the most employees`;
CREATE VIEW 
`department has the most employees` as (
WITH
		`số_nhân_viên_trong_phòng_ban` as (
SELECT 
		ac.*,COUNT(ac.AccountID) 	sl	-- đếm số nnhân vviên 
FROM 
		testingsystem.`account` ac
GROUP BY
		ac.DepartmentID)		-- theo phòng ban
SELECT
		d.DepartmentName,COUNT(d.DepartmentID) sl_ac_trong_mỗi_gr
FROM 
		testingsystem.department d
JOIN 
		testingsystem.`account` a 
on
		d.DepartmentID=a.DepartmentID
 GROUP BY 
		a.DepartmentID
 HAVING 
		COUNT(d.DepartmentID) = (SELECT MAX(sl)FROM
		số_nhân_viên_trong_phòng_ban
 ));
 -- cách 2 theo subquery
 SELECT 
		d.DepartmentName,COUNT(d.DepartmentID) sl_ac_trong_mỗi_gr
FROM 
		testingsystem.department d
JOIN 
		testingsystem.`account` a 
on
		d.DepartmentID=a.DepartmentID
 GROUP BY 
		a.DepartmentID
 HAVING 
		COUNT(d.DepartmentID)=( 
SELECT
		MAX(sl)FROM 
(SELECT 
		COUNT(1) sl
FROM
		testingsystem.account ac
GROUP BY 
		ac. DepartmentID
 ) AS sl1);
 -- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
 -- b1 tìm những user naào họ nguyễn 
 DROP VIEW  IF EXISTS    `câu hỏi do user họ Nguyễn tạo`;
 CREATE VIEW `câu hỏi do user họ Nguyễn tạo` AS
 (
 SELECT   	
			a. Username   , q.Content
 FROM 
			testingsystem.account AS a 
	JOIN 
			testingsystem.question q on a.AccountID=q.CreatorID
 WHERE 		Username LIKE 'nguyễn%');
 -- sử dụng subquery
 SELECT * 
FROM 
			testingsystem.question q
WHERE
			CreatorID in (SELECT a.AccountID
FROM 
			testingsystem.account a 
WHERE
			a.Username LIKE 'nguyễn%' );
-- sử dụng cte
WITH `người_có _họ_nguyễn` as (
SELECT *
FROM 
			testingsystem.account
WHERE
			Username like 'nguyễn%' )
SELECT
			q.Content,q.QuestionID
FROM 
			testingsystem.question q
WHERE 
			CreatorID IN (SELECT AccountID FROM `người_có _họ_nguyễn` );

