drop database if exists Testingsystem;
CREATE DATABASE Testingsystem;
USE Testingsystem;
CREATE TABLE `Department` (
    DepartmentID 		INT,
    DepartmentName 		VARCHAR(50),
    PRIMARY KEY (DepartmentID)
);
CREATE TABLE `Position` (
    PositionID 			INT,
    PositionName 		VARCHAR(50)
);
CREATE TABLE `Account`(
    AccountID 			INT,
    Email 				VARCHAR(50),
    Username 			VARCHAR(50),
    FullName 			VARCHAR(50),
    DepartmentID 		INT,
    PositionID 			INT,
    CreateDate 			DATE
);
CREATE TABLE 			`Group`(
    gropid INT AUTO_INCREMENT,
    GroupNamer 			VARCHAR(50),
    creatorid 			INT,
    CreateDate 			DATE
);
CREATE TABLE `GroupAccount` (
    groupid 			INT,
    accountid 			INT,
    joindate 			DATE
);
CREATE TABLE `typequestion` (
    typeid 				INT,
    typename 			VARCHAR(50)
);
CREATE TABLE `CategoryQuestion` (
    CategoryID 			INT,
    CategoryName 		VARCHAR(50)
);
CREATE TABLE `question` (
    questionid 			INT,
    content 			VARCHAR(50),
    categoryid 			INT,
    typeid 				INT,
    creatorid 			INT,
    createdate 			DATE
);
CREATE TABLE `answer` (
    answerid 			INT,
    content 			VARCHAR(50),
    questionid 			INT,
    iscorrect 			VARCHAR(10)
);
CREATE TABLE `exam` (
    examid 				INT,
    `code` 				VARCHAR(50),
    Title 				VARCHAR(50),
    CategoryID 			INT,
    Duration 			VARCHAR(50),
    CreatorID 			INT,
    CreateDate 			DATE
);
CREATE TABLE `ExamQuestion` (
    ExamID 				INT,
    QuestionID 			INT
);


