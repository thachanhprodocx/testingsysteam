DROP DATABASE IF EXISTS TestingSystem;
CREATE DATABASE TestingSystem;
USE TestingSystem;
DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
    DepartmentID 					TINYINT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName 					VARCHAR(255) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
    PositionID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    PositionName 					ENUM('Dev', 'Test', 'Scrum Master', 'PM') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
    AccountID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    Email 							VARCHAR(50) NOT NULL UNIQUE KEY,
    Username 						VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName 						VARCHAR(255) NOT NULL,
    DepartmentID 					TINYINT NOT NULL,
    PositionID 						TINYINT NOT NULL,
    CreateDate 						DATE,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department (DepartmentID),
    FOREIGN KEY (PositionID)
        REFERENCES `Position` (PositionID)
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
    GroupID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    GroupName 						VARCHAR(255) NOT NULL UNIQUE KEY,
    CreatorID 						TINYINT,
    CreateDate 						DATE,
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount (
    GroupID 						TINYINT NOT NULL,
    AccountID 						TINYINT NOT NULL,
    JoinDate 						DATE,
    PRIMARY KEY (GroupID , AccountID),
    FOREIGN KEY (GroupID)
        REFERENCES `Group` (GroupID),
    FOREIGN KEY (AccountID)
        REFERENCES `Account` (AccountID)
);
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 							TINYINT AUTO_INCREMENT PRIMARY KEY,
    TypeName 						ENUM('Essay', 'Multiple-Choice') NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion (
    CategoryID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    CategoryName 					VARCHAR(255) NOT NULL UNIQUE KEY
);
DROP TABLE IF EXISTS Question;
CREATE TABLE Question (
    QuestionID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    Content 						VARCHAR(120) NOT NULL,
    CategoryID 						TINYINT NOT NULL,
    TypeID 							TINYINT NOT NULL,
    CreatorID 						TINYINT NOT NULL,
    CreateDate DATE,
    FOREIGN KEY (CategoryID)
       REFERENCES  CategoryQuestion (CategoryID),
    FOREIGN KEY (TypeID)
        REFERENCES TypeQuestion (TypeID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer (
    AnswerID 						TINYINT AUTO_INCREMENT PRIMARY KEY,
    Content 						VARCHAR(100) NOT NULL,
    QuestionID 						TINYINT NOT NULL,
    isCorrect 						VARCHAR(255),
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID)
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam (
    ExamID 							TINYINT AUTO_INCREMENT PRIMARY KEY,
    `Code` 							VARCHAR(10) NOT NULL,
    Title 							VARCHAR(50) NOT NULL,
    CategoryID 						TINYINT NOT NULL,
    Duration 						TINYINT NOT NULL,
    CreatorID 						TINYINT NOT NULL,
    CreateDate 						DATE,
    FOREIGN KEY (CategoryID)
        REFERENCES CategoryQuestion (CategoryID),
    FOREIGN KEY (CreatorID)
        REFERENCES `Account` (AccountId)
);
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion (
    ExamID 							TINYINT NOT NULL,
    QuestionID 						TINYINT NOT NULL,
    FOREIGN KEY (QuestionID)
        REFERENCES Question (QuestionID),
    FOREIGN KEY (ExamID)
        REFERENCES Exam (ExamID),
    PRIMARY KEY (ExamID , QuestionID)
);
INSERT INTO Department(DepartmentName)
VALUES

								('Marketing' ),
								('Sale' ),
								('Nhân sự' ),
								('Kỹ thuật' ),
								('Phó giám đốc'),
								('Giám đốc' ),
								('Bán hàng' );

INSERT INTO Position (PositionName )
VALUES 							('Dev' ),
								('Test' ),
								('Scrum Master'),
								('PM' );

INSERT INTO `Account`(Email ,		 Username,			 FullName ,				 DepartmentID , PositionID,			CreateDate)
VALUES (	'Email1@gmail.com' ,'mariaozawa' ,'			mariaozawa' , 				'5' ,			 '1',			'2020-03-05'),

			('Email2@gmail.com' ,'Username2' ,			'Seiko Matsuda' ,			 '1' , 			'2',		'2020-03-05'),

			('ngoanh3@gmail.com' , 'Username3' ,		'Akina Nakamori', 			'2' , 			'2' ,		'2020-03-07'),

			('ngoanh4@gmail.com' , 'Username4' ,		'Momoe Yamaguchi', 			'3' ,			 '4' ,		'2020-03-08'),

			('ngoanh5@gmail.com' , 'Username5' ,		'Kenji Sawada',				 '4' , 			'4' ,		'2020-03-10'),

			('ngoanh6@gmail.com' , 'Username6' ,		'Shizuka Kudo', 			'6' , 			'3' ,		'2020-04-05'),

			('ngoanh7@gmail.com' , 'Username7' ,		'Hideki Saijo',				 '2' , 			'2' ,		'2020-12-3' );
INSERT INTO `Group` ( GroupName , 	CreatorID , CreateDate)
VALUES 				('Testing System' , 5,	'	2019-03-05'),

					('Development' , 	1,		'2020-03-07'),
					('Sale 01' , 		2 ,		'2020-03-09'),
					('Sale 02' , 		3 ,		'2020-03-10'),
					('Sale 03' , 		4 ,		'2020-03-28'),
					('Creator' , 		6 ,		'2020-04-06'),
					('Marketing 01' , 	7 ,		'2020-04-07');
INSERT INTO `GroupAccount` ( GroupID , AccountID , 		JoinDate )
VALUES						 ( 1 , 			1,			'2019-03-05'),

							( 1 , 			2,			'2020-03-07'),

							( 3 , 			3,			'2020-03-09'),

							( 3 ,			 4,			'2020-03-10'),

                            ( 5 ,			 5,			'2020-03-28'),

							( 1 , 			3,			'2020-04-06'),

							( 1 , 			7,			'2020-04-07');

INSERT INTO TypeQuestion 					(TypeName )
VALUES 								('Essay' ),('Multiple-Choice' );

INSERT INTO CategoryQuestion (CategoryName )
VALUES						 ('Java' ),
							('SQL' ),
						('Postman' ),
					('Ruby' ),
				('Python' ),
			('C++' ),
		('PHP' );

INSERT INTO Question (Content,		CategoryID,			TypeID 				,CreatorID			,CreateDate )
VALUES 				('Câu hỏi về Java' , 1 ,			'1' , 					'1' ,			'2020-04-05'),

					('Câu Hỏi về PHP' ,	 2 ,			'2' , 					'2' ,			'2020-04-05'),

					('Hỏi về Ruby' , 	3 ,'			1' , 					'3' ,			'2020-04-06'),

					('Hỏi về Postman' , 5 ,				'1' , 					'4',			 '2020-04-06'),

					('Hỏi về C++' , 7 ,					'1' , 					'5' ,			'2020-01-07'),

					('Hỏi về SQL' , 4 ,					'2' , 					'6' ,			'2020-02-07'),

					('Hỏi về Python' , 6 ,				'1' , 					'7' ,			'2020-03-07');
INSERT INTO Answer ( Content , 		QuestionID , isCorrect )
VALUES 				('Trả lời 01' ,		 1 ,			 0),
					('Trả lời 02' , 	1 ,				 1),
					('Trả lời 03',	 	1 , 			0 ),
					('Trả lời 04',	 	1 ,				 1 ),
					('Trả lời 05',	 	2 , 			1 ),
					('Trả lời 06', 		3 ,				 1 ),
					('Trả lời 07', 		4 , 			0 );

INSERT INTO Exam (`Code` ,				Title , 		CategoryID, 		Duration , 		CreatorID , 		CreateDate )
VALUES			 ('VTIQ001' , 			'Đề thi C#' 		,1 , 				60 ,			 '5' ,			'2019-04-05'),
				('VTIQ002' , 			'Đề thi PHP' ,		2 ,					 60 , 			'2' ,			'2019-04-05'),
				('VTIQ003' , 			'Đề thi C++' , 		3 ,					120 , 			'2' ,			'2019-04-07'),
				('VTIQ004' , 			'Đề thi Java' , 	4 , 				60, 			'3' ,			'2020-04-08'),
				('VTIQ005' , 			'Đề thi Ruby' , 	5 , 				120, 			'4' ,			'2020-04-10'),
				('VTIQ006' ,			'Đề thi Postman' ,	 6 	,				60 , 			'6' ,			'2020-04-05'),
				('VTIQ007' , 			'Đề thi SQL' , 		2 ,					60 , 			'7' ,			'2020-04-05');

INSERT INTO ExamQuestion(ExamID , QuestionID )
VALUES 						( 1 ,	 5 ),
							( 2 ,	 3 ),
							( 3 ,	 4 ),
							( 4 ,	 1 ),
							( 5 ,	 7 ),
							( 7 ,	 6 ),
							( 6 ,	 2 );

