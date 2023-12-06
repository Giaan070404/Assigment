DROP DATABASE IF EXISTS Training;
CREATE DATABASE IF NOT EXISTS Training;
USE Training;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64)
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64)
);

DROP TABLE IF EXISTS Account;
CREATE TABLE Account(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_name NVARCHAR(64) NOT NULL UNIQUE,
	full_name NVARCHAR(64) NOT NULL,
	email VARCHAR(32) UNIQUE,
	gender ENUM('Male', 'Female', 'Unknown'),
    salary INT,
	department_id BIGINT NOT NULL,
	position_id BIGINT NOT NULL,
    group_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (department_id) REFERENCES Department(id),
	FOREIGN KEY (position_id) REFERENCES `Position`(id)
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64),
	creator_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (creator_id) REFERENCES Account(id)
);

DROP TABLE IF EXISTS GroupMember;
CREATE TABLE GroupMember(
	group_id BIGINT NOT NULL,
	account_id BIGINT,
	joined_date DATE,
	FOREIGN KEY (group_id) REFERENCES `Group`(id),
	FOREIGN KEY (account_id) REFERENCES Account(id)
);

DROP TABLE IF EXISTS QuestionType;
CREATE TABLE QuestionType(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	type varchar(32)
);

DROP TABLE IF EXISTS Category;
CREATE TABLE Category(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category varchar(32)
);

DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	content text,
	category_id BIGINT,
	type_id BIGINT NOT NULL,
	creator_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (category_id) REFERENCES Category(id),
	FOREIGN KEY (type_id) REFERENCES QuestionType(id),
	FOREIGN KEY (creator_id) REFERENCES Account(id)
);

DROP TABLE IF EXISTS Answser;
CREATE TABLE Answer(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	content text,
	question_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (question_id) REFERENCES Question(id)
);

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	code varchar(16),
	title NVARCHAR(64),
	duration INT,
	category_id BIGINT,
    creator nvarchar(100),
	creator_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (category_id) REFERENCES Category(id),
	FOREIGN KEY (creator_id) REFERENCES Account(id)
);

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	exam_id BIGINT,
	question_id BIGINT,
	FOREIGN KEY (exam_id) REFERENCES Exam(id),
	FOREIGN KEY (question_id) REFERENCES Question(id)
);

INSERT INTO Department(name) VALUES('Sale'), ('Marketing'), ('R&D'), ('Accounting'), ('Test'), ('Scrum Master'), ('PM');
SELECT * FROM Department;

INSERT INTO `Position`(name) VALUES('Staff'), ('Manager'), ('Developer'), ('Test'), ('Scrum Master'), ('PM');
SELECT * FROM `Position`;

INSERT INTO Account(user_name, full_name, email, gender, department_id, position_id, group_id, created_date, salary)
VALUES ('usr01', 'Nguyen Bxx Cxx', 'usr01@email.com', 'Male', 1, 1, 1, CURDATE(), 10000),
('usr02', 'Nguyen Bxx Cxx', 'usr02@yahoo.com', 'Male', 1, 1, 1, '2020-05-11', 15000),
('usr03', 'Tran Bxx Cxx', 'usr03@email.com', 'Female', 1, 1, 2, CURDATE(), 12000),
('usr04', 'Nguyen Bxx Cxx', 'usr04@yahoo.com', 'Female', 4, 3, 2, NULL, 14000),
('usr05', 'Tran Bxx Cxx', 'usr05@email.com', 'Male', 5, 4, 3, CURDATE(), 11000),
('usr06', 'Nguyen Bxx Cxx', 'usr06@yahoo.com', 'Male', 6, 5, 4, CURDATE(), 15500),
('usr07', 'Le Bxx Cxx', 'usr07@email.com', 'Male', 7, 6, 5, NULL, 12500);

INSERT INTO Account(user_name, full_name, email, gender, department_id, position_id, group_id, created_date, salary)
VALUES ('usr08', 'Axx Bxx Cxx', 'usr08@email.com', 'Male', 1, 1, 1, CURDATE(), 17000),
('usr09', 'Le Bxx Cxx', 'usr09@yahoo.com', 'Female', 3, 1, 1, '2021-06-19', 16500),
('usr10', 'Le Bxx Cxx', 'usr10@email.com', 'Female', 3, 1, 2, CURDATE(), 13000),
('usr11', 'Le Bxx Cxx', 'usr11@yahoo.com', 'Male', 3, 2, 2, NULL, 18500),
('usr12', 'Tran Bxx Cxx', 'usr12@yahoo.com', 'Female', 4, 1, 3, '2022-02-23', 14000),
('usr13', 'Le Bxx Cxx', 'usr13@email.com', 'Male', 4, 1, 4, NULL, 12000),
('usr14', 'Tran Bxx Cxx', 'usr14@email.com', 'Female', 4, 2, 5, CURDATE(), 15500);

INSERT INTO Account(user_name, full_name, email, gender, department_id, position_id, group_id, created_date, salary)
VALUES ('usr15', 'Axx Bxx Cxx', 'usr15@email.com', 'Male', 1, 1, 1, CURDATE(), 16000),
('usr16', 'Le Bxx Cxx', 'usr16@yahoo.com', 'Female', 3, 1, 2, CURDATE(), 19500),
('usr17', 'Le Bxx Cxx', 'usr17@email.com', 'Female', 3, 1, 1, NULL, 14000),
('usr18', 'Le Bxx Cxx', 'usr18@yahoo.com', 'Male', 3, 2, 2, '2022-07-09', 17000),
('usr19', 'Tran Bxx Cxx', 'usr19@email.com', 'Female', 4, 1, 3, CURDATE(), 18000),
('usr20', 'Le Bxx Cxx', 'usr20@yahoo.com', 'Male', 4, 1, 4, NULL, 15000),
('usr21', 'Tran Bxx Cxx', 'usr21@email.com', 'Female', 4, 2, 5, CURDATE(), 13000);

INSERT INTO Account(user_name, full_name, email, gender, department_id, position_id, group_id, created_date, salary)
VALUES ('usr22', 'Axx Bxx Cxx', 'usr22@gmail.com', 'Male', 1, 1, 2, CURDATE(), 12000),
('usr23', 'Le Bxx Cxx', 'usr23@yahoo.com', 'Female', 3, 1, 1, CURDATE(), 13000),
('usr24', 'Le Bxx Cxx', 'usr24@email.com', 'Female', 3, 1, 2, NULL, 14000),
('usr25', 'Le Bxx Cxx', 'usr25@gmail.com', 'Male', 3, 2, 1, '2022-07-09', 15000),
('usr26', 'Tran Bxx Cxx', 'usr26@email.com', 'Female', 4, 1, 3, CURDATE(), 16000),
('usr27', 'Le Bxx Cxx', 'usr27@gmail.com', 'Male', 4, 1, 4, NULL, 17000),
('usr28', 'Tran Bxx Cxx', 'usr28@email.com', 'Female', 4, 2, 5, CURDATE(), 18000);

INSERT INTO `Group`(name, creator_id, created_date) 
VALUES ('Lap Trinh', 2, CURDATE()), ('Choi Game', 3, CURDATE());

INSERT INTO GroupMember 
VALUES (1, 1, CURDATE()), (1, 2, CURDATE()),
(2, 1, CURDATE()), (2, 2, CURDATE()),
(2, 3, CURDATE()), (2, 4, CURDATE());

INSERT INTO `Group` (name, creator_id, created_date) 
VALUES('Rocket41', 1, '2020-05-19'), ('Rocket42', 2, '2020-05-20'),('Rocket43', 2, '2021-07-25'), 
('Rocket44', 3, '2022-07-14'), ('Rocket45', 1, '2020-09-11'), ('Rocket46', 1, '2022-08-27');

SELECT * FROM `Group`;

INSERT INTO GroupMember (group_id, account_id, joined_date)
VALUES (1, 1, '2020-05-20'), (1, 2, '2020-05-21'), (1, 3, '2020-05-22'),
(2, 1, '2020-05-20'), (2, 2, '2020-05-20'), (2, 4, '2020-05-23'), (2, 5, '2020-05-24'),
(3, 2, '2021-07-29'), (3, 7, '2020-08-01'), (3, 5, '2021-09-20'),
(4, NULL, NULL), (5, NULL, NULL), (6, NULL, NULL);

SELECT * FROM GroupMember;

DROP TABLE IF EXISTS Staff;
CREATE TABLE Staff(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	staff_code NVARCHAR(64) NOT NULL UNIQUE,
	staff_name NVARCHAR(64) NOT NULL,
	email VARCHAR(32) UNIQUE,
	gender ENUM('Male', 'Female', 'Unknown'),
    salary INT,
	department_id BIGINT NOT NULL,
	position_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (department_id) REFERENCES Department(id),
	FOREIGN KEY (position_id) REFERENCES `Position`(id)
);

INSERT INTO Staff(staff_code, staff_name, email, gender, department_id, position_id, created_date, salary)
SELECT user_name, full_name, email, gender, department_id, position_id, created_date, salary
FROM Account WHERE id >= 20;

INSERT INTO Staff(staff_code, staff_name, email, gender, department_id, position_id, created_date, salary)
VALUES ('staff01', 'Axx Bxx Cxx', 'staff01@gmail.com', 'Male', 1, 1, CURDATE(), 12000),
('staff02', 'Le Bxx Cxx', 'staff02@yahoo.com', 'Female', 3, 1, CURDATE(), 13000),
('staff03', 'Le Bxx Cxx', 'staff03@email.com', 'Female', 3, 1, NULL, 14000),
('staff04', 'Le Bxx Cxx', 'staff04@gmail.com', 'Male', 3, 2, '2022-07-09', 15000);

INSERT INTO QuestionType(type) VALUES ('Multiple Choice'), ('True/False'), ('Short Answer');

INSERT INTO Category(category) VALUES ('Programming'), ('Marketing'), ('Finance'), ('HR'), ('Design Web');

INSERT INTO Question(content, category_id, type_id, creator_id, created_date)
VALUES
('What is a variable?', 1, 1, 1, CURDATE()),
('What is the role of a marketing manager?', 2, 2, 2, '2020-12-10'),
('Explain the concept of ROI in finance.', 3, 1, 3, CURDATE()),
('What is the purpose of HR policies?', 4, 2, 4, CURDATE()),
('How to optimize website performance?', 5, 1, 5, '2019-10-10'),
('What is a loop in programming?', 1, 1, 6, CURDATE()),
('How to create an effective marketing plan?', 2, 2, 7, CURDATE()),
('What is financial forecasting?', 3, 1, 8, '2019-02-05'),
('Discuss the importance of HR training programs.', 4, 2, 9, CURDATE()),
('What are the key principles of web design?', 5, 1, 10, CURDATE());

INSERT INTO Answer(content, question_id, created_date)
VALUES
('A variable is a container for storing data.', 1, CURDATE()),
('True', 2, '2020-12-11'),
('False', 2, '2020-12-11'),
('ROI stands', 3, CURDATE()),
('HR policies', 4, CURDATE()),
('Optimizing website ', 5, '2019-10-11'),
('', 6, CURDATE()),
('Creating', 7, CURDATE()),
('Financial', 8, '2019-02-06'),
('HR training', 9, CURDATE()),
('', 10, CURDATE());

INSERT INTO Exam(code, title, duration, category_id, creator, creator_id, created_date)
VALUES
('A11', 'Programming Basics', 60, 1,'justin' ,1, CURDATE()),
('A12', 'Marketing Strategies', 120, 2,'Donal', 2, '2019-12-12'),
('A13', 'Finance Fundamentals', 180, 3,'Charli', 3, CURDATE()),
('A14', 'HR Management', 40, 4,'MTP', 4, CURDATE()),
('A15', 'Web Design Principles', 240, 5,'Taylor', 5, '2019-10-12');

INSERT INTO ExamQuestion(exam_id, question_id)
VALUES
(1, 1),
(1, 6),
(2, 2),
(2, 7),
(3, 3),
(3, 8),
(4, 4),
(5, 5),
(5, 10);

select * from `Group`;
select * from GroupMember;
select * from Account;
select * from QuestionType;
select * from Question; 
select * from Category;
select * from Answer;
select * from Exam;
select * from ExamQuestion;

-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select A.id as account_id, A.user_name, A.full_name, A.email, A.gender, A.salary,
		D.name as department_name
from Account A
join Department D ON A.department_id = D.id;
-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
select * from Account 
where created_date > '20/12/2010';
-- Question 3: Viết lệnh để lấy ra tất cả các developer
select p.name as position_name
from Position p
where p.name = 'Developer';
-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên
select d.id as department_id, d.name as department_name,
	count(a.id) as employee_count 
from department d
join Account a on d.id = a.department_id
group by d.id, d.name
having count(a.id) > 3;
-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
select q.id as question_id, q.content, 
		count(eq.exam_id) as used_in_exam
from Question q
join ExamQuestion eq on q.id = eq.exam_id
group by q.id, q.content
order by used_in_exam desc;
-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question
select C.category as category_name,
    count(Q.id) as question_count
from Category C
left join Question Q on C.id = Q.category_id
group by C.category;
-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam
select q.content as question_name,
	count(e.id) as exam_count
from Question q
left join Exam e on q.id = e.id
group by q.content;
-- Question 8: Lấy ra Question có nhiều câu trả lời nhất
select q.id as question_id, q.content as question_content, count(a.id) as answer_count
from Question q
left join Answer a on q.id = a.question_id
group by q.id, q.content
order by answer_count desc
limit 1;
-- Question 9: Thống kê số lượng account trong mỗi group
select a.user_name, count(g.creator_id) as creator_count
from Account a
left join `Group` g on a.id = g.creator_id
group by a.user_name;
-- Question 10: Tìm chức vụ (p) có ít người nhất (s)
select p.id as id, p.name as name, 
		count(s.position_id) as position_id
from Position p 
left join Staff s on p.id = s.position_id
group by p.id, p.name
order by  position_id asc                -- asc sắp xếp theo số lượng ít nhất
limit 1;
-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM
select d.name as department_name,
		p.name as position_name,
		count(s.id) as employee_count
from Department d
join Account s on d.id = s.department_id
join Position p on s.position_id = p.id
group by d.id, p.id
order by d.id, p.id;
-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select q.id, q.content as content,
		qt.type as type,
        e.creator as creator,
        a.content as content
from Question q
join QuestionType qt on q.id = qt.id
join Exam e on q.id = e.id
join Answer a on q.id = a.id;
-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
select QuestionType.type as QuestionType, count(Question.id) as NumberOfQuestions
from Question
join QuestionType on Question.type_id = QuestionType.id
group by QuestionType.type;
-- Question 14:Lấy ra group không có account nào
select `Group`.id as GroupID, `Group`.name as GroupName
from `Group`
left join GroupMember on `Group`.id = GroupMember.group_id
where GroupMember.account_id is null;
-- Question 16: Lấy ra question không có answer nào
select Question.id as questionID, Question.content 
from Question
left join Answer as a on Question.id = a.question_id
where a.id is null;

-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
select id, group_id
from Account
where group_id = 1
union
select id, name
from `Group`
where id = 1;
-- b) Lấy các account thuộc nhóm thứ 2
select id, group_id
from Account
where group_id = 2
union
select id, name
from `Group`
where id = 2;
-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
select id, group_id from Account
union
select id, name from `Group`;
-- Question 18:
-- a) Lấy các group có lớn hơn 5 thành viên
-- Câu truy vấn lấy các dòng từ bảng employees với phòng ban lớn hơn 2
SELECT * FROM `Group` WHERE creator_id > 2;
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT * FROM `Group` WHERE creator_id < 7;
-- c) Ghép 2 kết quả từ câu a) và câu b)
select creator_id from `Group`
union
select creator_id from `Group`;







