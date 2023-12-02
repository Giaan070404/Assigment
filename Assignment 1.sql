create database Testing_System_Assigment_1;
use Testing_System_Assigment_1;

-- Table 1: Department
create table Department(
	DepartmentID bigint PRIMARY KEY,
    DepartmentName nvarchar(50) not null
);
-- Table 2: Position
create table Position (
	PositionID bigint primary key,
    PositionName nvarchar(50) not null
);
-- Table 3: Account
create table Account (
	AccountID bigint primary key,
    Email nvarchar(50) not null,
    Username nvarchar(50) not null,
    Fullname nvarchar(50) not null,
    DepartmentID bigint ,
    PositionID bigint,
    CreateDate date,
    foreign key (DepartmentID) references Department(DepartmentID),
    foreign key  (PositionID) references Position (PositionID)
);
-- Table 4: Group
create table Groupp (
	GroupID bigint primary key,
    GroupName nvarchar(50) not null,
    CreatorID bigint,
    CreateDate Date
);
-- Table 5: GroupAccont
create table GroupAccount (
	GroupID bigint,
    AccountID bigint,
    JoinDate date,
    primary key (GroupID, AccountID),
    foreign key (GroupID) references Groupp(GroupID),
    foreign key (AccountID) references Account(AccountID)
);
-- Table 6: TypeQuestion
create table TypeQuestion(
	TypeID bigint primary key,
    TypeName nvarchar(50) not null
);
-- table 7:CategoryQuestion
create table CategoryQuestion(
	CategoryID bigint primary key,
    CategoryName nvarchar(50) not null
);
-- table 8: Question
create table Question (
    QuestionID bigint PRIMARY KEY,
    Content nvarchar(50) NOT NULL,
    CategoryID bigint,
    TypeID bigint,
    CreatorID bigint,
    CreateDate DATE,
    foreign key (CreatorID) references Account(AccountID),
    foreign key (TypeID) references TypeQuestion(TypeID),
    foreign key (CategoryID) references CategoryQuestion(CategoryID)
);
-- table 9: Answer
create table Answer (
    AnswerID bigint primary key,
    Content nvarchar(50) not null,
    QuestionID bigint,
    isCorrect boolean,
    foreign key (QuestionID) references Question(QuestionID)
);
-- table 10: Exam
create table Exam(
	ExamID bigint primary key,
    code nvarchar(50) not null,
    Title nvarchar(50) not null,
    CategoryID bigint,
    Duration time,
    CreatorID bigint,
    CreateDate date,
    foreign key (CategoryID) references CategoryQuestion(CategoryID),
    foreign key (CreatorID) references Account(AccountID)
);
-- table 11: ExamQuestion
create table ExamQuestion(
	ExamID bigint,
    QuestionID bigint,
    primary key (ExamID, QuestionID),
    foreign key (ExamID) references Exam(ExamID),
    foreign key (QuestionID) references Question(QuestionID)
);
