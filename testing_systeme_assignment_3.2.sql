USE fresher;
-- Question 2: Viết lệnh để lấy ra tất cả các thực tập sinh đã vượt qua bài test đầu vào nhóm chúng thành các tháng sinh khác nhau
SELECT *
FROM Trainee
GROUP BY Birth_Date;
-- Question 3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT *,MAX(length(Full_name)) as ls
FROM Trainee
GROUP BY TraineeID
ORDER BY ls DESC
LIMIT 1;
-- Question 4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là
-- những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau: 
-- ET_IQ + ET_Gmath>=20
SELECT full_name,ET_IQ,ET_Gmath
FROM Trainee
WHERE ET_IQ + ET_Gmath >=20;
--  ET_IQ>=8
SELECT full_name,ET_IQ
FROM Trainee
WHERE ET_IQ>=8;
--  ET_Gmath>=8
SELECT full_name,ET_Gmath
FROM Trainee 
WHERE ET_Gmath>=8;
--  ET_English>=18
SELECT full_name,ET_English
FROM Trainee 
WHERE ET_English>=18;
-- Question 5: xóa thực tập sinh có TraineeID = 3
SET FOREIGN_KEY_CHECKS=0; -- xóa tạm thời 
DELETE FROM Trainee WHERE TraineeID = 3;

-- Question 6: Thực tập sinh có TraineeID = 5 được chuyển sang lớp "2". Hãy cập nhật
-- thông tin vào database
SET FOREIGN_KEY_CHECKS=0;
UPDATE Trainee 
SET Training_Class = 'Training_Class 2'
WHERE TraineeID = 5;