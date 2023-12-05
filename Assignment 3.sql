DROP DATABASE IF EXISTS Training;               
CREATE DATABASE IF NOT EXISTS Training;         
USE Training;

DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64)
);
INSERT INTO Department(name) VALUES('Sale'), ('Marketing'), ('R&D'), ('Accounting');
select * from Department;

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64)
);
INSERT INTO `Position`(name) VALUES('Staff'), ('Manager'), ('PM');
select * from `Position`;

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
    group_id BIGINT,
	created_date DATE,
	FOREIGN KEY (department_id) REFERENCES Department(id),
	FOREIGN KEY (position_id) REFERENCES `Position`(id)
);
insert into Account (user_name, full_name, email, gender, salary, department_id, position_id, group_id, created_date)
values ('Uyenpham', 'Thu Uyên', 'uyen1@email.com', 'Female', 50000, 1, 1, 1, '2023-01-01'),
		('Anpham', 'Gia Ân', 'an2@email.com', 'Male', 60000, 2, 2, 2, CURDATE()),
		('Hieu03', 'Ngọc Hiếu', 'hieu3@email.com', 'Male', 55000, 1, 1, 1, '2023-01-03'),
		('Tu04', 'Minh Tú', 'tu4@yahoo.com', 'Male', 65000, 2, 2, 2, CURDATE()),
		('Huyen05', 'Nhật Huyền', 'huyen5@yahoo.com', 'Unknown', 70000, 3, 3, 3, '2023-01-05'),
		('Linh06', 'Khánh Linh', 'linh6@yahoo.com', 'Female', 60000, 1, 2, 3, CURDATE()),
		('Vu07', 'Bá Vũ', 'vu7@gmail.com', 'Male', 75000, 2, 3, 4, '2023-01-07'),
		('Nghiaaa', 'Quang Nghĩa', 'nghia8@gmail.com', 'Male', 80000, 3, 1, 2, NULL),
		('Ly09', 'Ái Ly', 'ly9@yahoo.com', 'Female', 70000, 1, 2, 3, '2023-01-09'),
		('Thiet10', 'Văn Thiết', 'thiet10@gmail.com', 'Unknown', 85000, 2, 3, 4, NULL);
select * from Account;

DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name NVARCHAR(64),
	creator_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (creator_id) REFERENCES Account(id)
);
insert into `Group` (name, creator_id, created_date)
values ('groupA', 1, CURDATE()),
		('groupB', 2, CURDATE()),
		('groupC', 3, CURDATE()),
		('groupD', 4, CURDATE()),
		('groupE', 5, CURDATE()),
		('groupF', 6, CURDATE()),
		('groupG', 7, CURDATE()),
		('groupH', 8, CURDATE()),
		('groupI', 9, CURDATE()),
		('groupK', 10, CURDATE());
select * from `Group`;

DROP TABLE IF EXISTS GroupMember;
CREATE TABLE GroupMember(
	group_id BIGINT NOT NULL,
	account_id BIGINT NOT NULL,
	joined_date DATE,
	FOREIGN KEY (group_id) REFERENCES `Group`(id),
	FOREIGN KEY (account_id) REFERENCES Account(id)
);
insert into  GroupMember (group_id, account_id, joined_date)
values (1, 1, '2019-12-10'), 
	  (2, 2, CURDATE()), 
	  (3, 3, '2019-09-10'), 
	  (4, 4, CURDATE()), 
	  (5, 5, CURDATE()),
      (6, 6, '2019-11-10'), 
	  (7, 7, CURDATE()), 
	  (8, 8, CURDATE()), 
	  (9, 9, '2019-02-10'),
      (10, 10, '2019-10-10');
select * from GroupMember;
select g.group_id, a.id, g.joined_date from GroupMember as g 
inner join Account as a on g.account_id = a.id;

DROP TABLE IF EXISTS QuestionType;
CREATE TABLE QuestionType(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	type varchar(32)
);
insert into QuestionType (type)
values ('Trắc nghiệm'),
		('Đúng/Sai'),
		('Trả lời'),
		('Tự luận'),
		('Kết hợp'),
		('Điền vào chỗ trống'),
		('Xếp hạng'),
		('Số học'),
		('Kéo và thả'),
		('Nối');
select * from QuestionType;

DROP TABLE IF EXISTS Category;
CREATE TABLE Category(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category varchar(32)
);
insert into Category (category) 
values ('CSDL'),
		('Toán'),
		('Php'),
		('Java'),
		('JS'),
		('CSDL'),
		('CSS'),
		('HTML'),
		('C++'),
		('Python');
select * from Category;

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
insert into Question (content, category_id, type_id, creator_id, created_date) 
values ('What', 1, 1, 1, NOW()), 
		('Câu hỏi', 2, 2, 2, NOW()),
		('Who', 3, 3, 3, NOW()),
		('How', 4, 4, 4, NOW()),
		('Do', 5, 5, 5, NOW()),
        ('Câu hỏi', 6, 6, 6, NOW()), 
		('Câu hỏi', 7, 7, 7, NOW()),
		('Ai', 8, 8, 8, NOW()),
		('Như thế nào', 9, 9, 9, NOW()),
		('Làm gì', 10, 10, 10, NOW());
select * from Question;
select q.content, ca.id, t.id, a.id, g.created_date from Question as q
inner join Category as ca on q.category_id = ca.id
inner join QuestionType as t on q.type_id = t.id
inner join Account as a on q.creator_id = a.id
inner join `Group` as g on q.created_date = g.created_date;

DROP TABLE IF EXISTS Anwser;
CREATE TABLE Anwser(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	content text,
	question_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (question_id) REFERENCES Question(id)
);
insert into Anwser (content, question_id, created_date) 
values ('Học', 1, NOW()), 
		('Ở trường', 1, NOW()),
		('Tôi', 1, NOW()),
		('Thảo luận', 1, NOW()),
		('Thảo luận trong phòng', 2, NOW()),
        ('Đi làm', 1, NOW()), 
		('In school', 2, NOW()),
		('Bạn bè', 2, NOW()),
		('Help', 2, NOW()),
		('Đi chơi', 2, NOW());
select * from Anwser;
-- select a.content, q.id, g.created_date from Anwser as a 
-- inner join Question as q on a.question_id = q.id
-- inner join `Group` as g on a.created_date = g.created_date;

DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	code varchar(16),
	title NVARCHAR(64),
	duration INT,
	category_id BIGINT,
	creator_id BIGINT NOT NULL,
	created_date DATE,
	FOREIGN KEY (category_id) REFERENCES Category(id),
	FOREIGN KEY (creator_id) REFERENCES Account(id)
);
insert into Exam (code, title, duration, category_id, creator_id, created_date)
values ('A1', 'Programming', '00:50:00', 1, 1, CURDATE()),
		('A2', 'Marketing', '03:00:00', 2, 2, '2019-12-10'),
		('A3', 'Finance', '04:00:00', 3, 3, CURDATE()),
		('A4', 'HR', '00:40:00', 4, 4, CURDATE()),
		('A5', 'Design Web', '14:00:00', 5, 5, '2019-10-10'),
		('A6', 'Programming', '19:00:00', 6, 6, CURDATE()),
		('A7', 'Marketing', '00:03:00', 7, 7, CURDATE()),
		('A8', 'Finance', '06:00:00', 8, 8, '2019-2-5'),
		('A9', 'HR', '02:00:00', 9, 9, CURDATE()),
		('A10', 'Design Web', '03:00:00', 10, 10, CURDATE());
select * from Exam;
select e.code, e.title, e.duration, ca.id, a.id, g.created_date from Exam as e 
inner join Category as ca on e.category_id = ca.id
inner join Account as a on e.creator_id = a.id
inner join `Group` as g on e.created_date = g.created_date;

DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
	exam_id BIGINT,
	question_id BIGINT,
	FOREIGN KEY (exam_id) REFERENCES Exam(id),
	FOREIGN KEY (question_id) REFERENCES Question(id)
);
insert into ExamQuestion (exam_id, question_id) 
values (1, 1),
		(2, 2),
		(3, 3),
		(4, 4),
		(5, 5),
		(6, 6),
		(7, 7),
		(8, 8),
		(9, 9),
		(10, 10);
select * from ExamQuestion;
select e.id, q.id from ExamQuestion as eq 
inner join Exam as e on eq.exam_id = e.id
inner join Question as q on eq.question_id = q.id;


-- Lấy ra id phòng ban Sale 
SELECT id FROM Department WHERE name = 'Sale';
-- lấy ra thông tin account có full name dài nhất
select * from Account
order by length(full_name) desc
limit 1;
-- Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3
select * from Account
where department_id = 3 
order by length(full_name) desc;
-- Lấy ra tên group đã tham gia trước ngày 20/12/2019
select g.name from `Group` g
join GroupMember gm on g.id = gm.group_id
where gm.joined_date < '2019-12-20';
-- Lấy ra ID của question có >= 4 câu trả lời
select q.id, count(a.id) as so_cau_tra_loi from Question as q
left join Anwser as a on q.id = a.question_id
group by q.id having so_cau_tra_loi >= 4;
-- Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019
select code from Exam
where duration >= '01:00:00' and created_date < '2019-12-20';
-- Lấy ra 5 group được tạo gần đây nhất
select g.name from `Group` g
join GroupMember gm on g.id = gm.group_id
where datediff(gm.joined_date, '2023/4/12') < 0;
-- Đếm số nhân viên thuộc department có id = 2
select count(*) from Account
where department_id = 2; 
-- Lấy ra nhân viên có tên bắt đầu bằng chữ "H" và kết thúc bằng chữ "a"
select * from Account 
where user_name like 'H%' or user_name like '%a'; 
-- Xóa tất cả các exam được tạo trước ngày 20/12/2019
-- e đang bị lỗi ở đây nhỉ
delete from Exam                                                                  
where created_date < '2019-12-20';    
-- Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
delete from Question
where content = 'Câu hỏi';                 
-- Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
update Account 
set full_name = 'Nguyễn Bá Lộc', email = 'loc.nguyenba@vti.com.vn'
where id = 5;
-- update account có id = 5 sẽ thuộc group có id = 4
update Account 
set group_id = 4
where id = 5; 









