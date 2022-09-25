DROP DATABASE  IF EXISTS fresher;
CREATE DATABASE fresher;
USE fresher;
DROP TABLE IF EXISTS Trainee;
CREATE TABLE Trainee (
    TraineeID MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    Full_name VARCHAR(50) NOT NULL,
    Birth_Date DATE,
    Gender ENUM('male', 'female', 'unknown'),
    ET_IQ TINYINT UNSIGNED CHECK (ET_IQ >= 0 and ET_IQ <= 20),
    ET_Gmath TINYINT UNSIGNED CHECK (ET_Gmath >= 0 and ET_Gmath <= 20),
    ET_English TINYINT UNSIGNED CHECK (ET_English >= 0 and ET_English <= 50),
    Training_Class VARCHAR(50)UNICODE,
    Evaluation_Notes TEXT(520));
DROP TABLE IF EXISTS VTI_Account;
CREATE TABLE VTI_Account (
    VTI_AccountID MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    VTI_Account VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (VTI_AccountID) REFERENCES Trainee (TraineeID)
    );
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
	ID MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(255) NOT NULL,
    `Code` CHAR(20),
    ModifiedDate DATETIME,
    FOREIGN KEY (ID) REFERENCES VTI_Account (VTI_AccountID)
  
);
DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer (
    CustomerID MEDIUMINT AUTO_INCREMENT PRIMARY KEY,
    `Name` VARCHAR(255) NOT NULL,
    Birth_Date DATE,
    Gender TINYINT,
    IsDeletedFlag TINYINT(1)NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES`Account`(ID)
);
INSERT INTO Trainee (Full_name,Birth_Date,Gender,ET_IQ,ET_Gmath,ET_English,Training_Class,Evaluation_Notes)
VALUES				 ('ngo thach anh','1995-02-01','male','20','11','40','Training_Class 1',NULL),
					('nguyen ngoc son','1995-03-01','male','11','12','30','Training_Class 2',NULL ),
                     ('nguyen thi thuy','1995-04-01', 'female','10','13','20','Training_Class 3',NULL),
					('hoang thi nga','1995-05-01','female','11','11','45','Training_Class 4',NULL ),
                    ('vu khac tiep','1995-06-01', 'male','10','1','31','Training_Class 5',NULL),
					('nguyen hoang anh','1995-07-01','male','11','10','30','Training_Class 6',NULL ),
                     ('vu kim linh','1995-08-01', 'female','10','9','20','Training_Class 7',NULL),
					('vu hoang lien','1995-09-01','male','11','4','15','Training_Class 8',NULL ), 
                    ('phan kim lien','1995-11-01', 'unknown','10','6','20','Training_Class 9',NULL),
					('hoang thi kieu trang','1995-02-01','male','11','1','15','Training_Class 10',NULL );
INSERT INTO VTI_Account (VTI_Account) 
VALUES				('ngo thach anh'),
					('nguyen ngoc son' ),
                     ('nguyen thi thuy'),
					('hoang thi nga' ),
                    ('vu khac tiep'),
					('nguyen hoang anh' ),
                     ('vu kim linh'),
					('vu hoang lien' ), 
                    ('phan kim lien'),
					('hoang thi kieu trang' );
INSERT INTO `Account` (`Name`,`code`,ModifiedDate)
VALUES 				('ngo thach anh','sbd001','1995-02-01'),
					('nguyen ngoc son','sbd002' ,'1995-03-01'),
					('nguyen thi thuy','sbd03','1995-04-01' ),
					('hoang thi nga','sbd004' ,'1995-05-01'),
					('vu khac tiep','sbd005','1995-06-01' ),
					('nguyen hoang anh','sbd006' ,'1995-07-01'),
					('vu kim linh','sbd007','1995-08-01' ),
					('vu hoang lien','sbd008' ,'1995-09-01'),
                    ('phan kim lien','sbd009','1995-11-01' ),
				  ('hoang thi kieu trang','sbd0010' ,'1995-02-01');
INSERT  INTO Customer(`Name`,Birth_Date,Gender,IsDeletedFlag)
VALUES 				('ngo thach anh','1995-02-01',' 0','0'),
					('nguyen ngoc son','1995-03-01','0','0' ),
                     ('nguyen thi thuy','1995-04-01','1','0'),
					('hoang thi nga', '1995-05-01','1','1'),
                    ('vu khac tiep','1995-06-01','0','1'),
					('nguyen hoang anh', '1995-07-01','0','0'),
                     ('vu kim linh','1995-08-01','1','0'),
					('vu hoang lien', '1995-09-01','0','0'),
                    ('phan kim lien','1995-11-01' ,null,'0'),
                    ('hoang thi kieu trang','1995-02-01','1','0');
