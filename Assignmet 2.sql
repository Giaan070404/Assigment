create database Testing_System_Assigment_1;
use Testing_System_Assigment_1;
-- Table 1: Department
create table Department(
	id bigint auto_increment primary key,
    department_name nvarchar(50) not null
);
-- Add data department 
insert into Department (department_name) 
values 	('Information technology'),
		('Marketing'),
		('Finance'),
		('Human resources'),
        ('Ship');
select * from Department;
-- ---------------------------------------------------------------------------------------- 
-- Table 2: Position
create table Position (
	id bigint auto_increment primary key,
    position_name nvarchar(50) not null
);
-- Add data Position
insert into Position (position_name)
values 	('Developer'),
		('Designer'),
		('Marketing Manager'),
		('HR Director'),
		('Shipper');
select * from Position;
-- ---------------------------------------------------------------------------------------- 

-- Table 3: Account
create table Account (
	id bigint auto_increment primary key,
    email nvarchar(50) not null,
    user_name nvarchar(50) not null,
    full_name nvarchar(50) not null,
    department_id bigint ,
    position_id bigint,
    create_date date,
    foreign key (department_id) references Department(id),
    foreign key (position_id) references Position (id)
);

-- add data account
insert into Account (email, user_name, full_name, department_id, position_id, create_date ) 
values  ('giaan@gmail', 'an2505', 'Phạm Gia Ân', 1, 1, NOW()),
		('ngochieu@gmail', 'hieu0304', 'Nguyễn Ngọc Hiếu', 2, 2, NOW()),
		('nhathuyen@gmail', 'huyen0204', 'Vi Nhật Huyền', 4, 3, NOW()),
		('daotu@gmail', 'tu1109', 'Đào Minh Tú', 3, 4, NOW()),
		('khanhlinh@gmail', 'linh0907', 'Trần Khánh Linh', 5, 5, NOW());
select * from Account;
select a.id, a.email, a.user_name, a.full_name, d.department_name, p.position_name from `Account` as a
join department as d on a.department_id = d.id
join position as p on a.position_id = p.id;

-- ---------------------------------------------------------------------------------------- 
-- Table 4: Group
create table Groupp (
	id bigint auto_increment primary key,
    group_name nvarchar(50) not null,
    creator_id bigint,
    create_date date
);
-- add data group
insert into Groupp (group_name, creator_id, create_date ) 
values  ('An_Dev', '1', NOW()),
		('hieu_Des', '2',NOW()),
		('huyen_CA', '3', NOW()),
		('tu_Mar', '4', NOW()),
		('linh_EL', '5', NOW());
select * from Groupp;
-- ---------------------------------------------------------------------------------------- 
-- Table 5: GroupAccount
create table Group_account (
    group_id bigint,
    account_id bigint,
    join_date date,
    primary key (group_id, account_id),
    foreign key (group_id) references Groupp(id),
    foreign key (account_id) references Account(id)
);
select id as group_id from Groupp;
select id as account_id from Account;
-- add data group_account
insert into Group_account (group_id, account_id, join_date) 
values  (1, 1, NOW()),
		(2, 2, NOW()),
		(3, 3, NOW()),
		(4, 4, NOW()),
		(5, 5, NOW());
select g.id, a.id, ga.join_date from `Group_account` as ga
join `Account` as a  on ga.account_id = a.id
join `Groupp` as g on ga.account_id = g.id;
select * from Group_account;
-- ---------------------------------------------------------------------------------------- 
-- Table 6: TypeQuestion
create table Type_question(
	id bigint auto_increment primary key,
    type_name nvarchar(50) not null
);
insert into Type_question(type_name)
values ('Trắc nghiệm nhiều lựa chọn'),
		('Đúng/Sai'),
		('Trả lời ngắn'),
		('Luận văn'),
		('Nối đôi');
select * from Type_question;

-- ---------------------------------------------------------------------------------------- 
-- table 7:CategoryQuestion
create table category_question(
	id bigint auto_increment primary key,
    category_name nvarchar(50) not null
);
insert into category_question(category_name)
values ('Công nghệ thông tin'),
		('Marketing'),
		('Tài chính'),
		('Nhân sự'),
		('Vận chuyển');
select * from category_question;
-- ---------------------------------------------------------------------------------------- 
-- table 8: Question
create table Question (
    id bigint auto_increment PRIMARY KEY,
    content nvarchar(50) NOT NULL,
    category_id bigint,
    type_id bigint,
    creator_id bigint,
    create_date DATE,
    foreign key (creator_id) references Account(id),
    foreign key (type_id) references Type_question(id),
    foreign key (creator_id) references Category_question(id)
);
select id as type_id from Type_question;
SELECT id AS category_id FROM Category_question;
SELECT id AS creator_id FROM Account;
-- add data question
insert into Question(content, category_id, type_id, creator_id, create_date)
values ('What', 1, 1, 1, NOW()), 
		('Where', 2, 2, 2, NOW()),
		('Who', 3, 3, 3, NOW()),
		('How', 4, 4, 4, NOW()),
		('Do', 5, 5, 5, NOW());
select * from Question;
select q.content, c.category_name, t.type_name, q.creator_id, q.create_date from `Question` as q
join Category_question as c on q.category_id = c.id
join Type_question as t on q.type_id = t.id
join Account as a on q.creator_id = a.id;
-- ---------------------------------------------------------------------------------------- 
-- table 9: Answer
create table Answer (
    id bigint auto_increment primary key,
    content nvarchar(50) not null,
    question_id bigint,
    is_correct bit,
    foreign key (question_id) references Question(id)
);
insert into Answer (content, question_id, is_correct)
values ('A', 1, true),   
		('Option D', 2, false),
		('Yes', 3, true),          
		('By plane', 4, false),       
		('No', 5, false);
select * from Answer;
select q.id, q.content, a.is_correct from `Answer` as a
join Question as q on a.id = q.id;
-- ---------------------------------------------------------------------------------------- 
-- table 10: Exam
create table Exam(
	id bigint auto_increment primary key,
    code nvarchar(50) not null,
    title nvarchar(50) not null,
    category_id bigint,
    duration time,
    creator_id bigint,
    create_date date,
    foreign key (category_id) references Category_question(id),
    foreign key (creator_id) references Account(id)
);
insert into Exam (code, title, category_id, duration, creator_id, create_date)
values 
    ('C1', 'Programming ', 1, '02:00:00', 1, NOW()),  
    ('C2', 'Marketing ', 2, '01:30:00', 2, NOW()),        
    ('C3', 'Finance', 3, '01:45:00', 3, NOW()),            
    ('C4', 'HR', 4, '01:30:00', 4, NOW()),            
    ('C5', 'Ship ', 5, '02:15:00', 5, NOW());  
select * from Exam;
select e.code, e.title, q.category_id, e.duration, q.creator_id, q.create_date from `exam` as e
join Question as q on e.category_id = q.category_id and e.creator_id = q.creator_id;
-- ---------------------------------------------------------------------------------------- 
-- table 11: ExamQuestion
create table Exam_question(
    id bigint,
    question_id bigint,
    primary key (id, question_id),
    foreign key (question_id) references Question(id)
);
insert into Exam_question (id, question_id)
values 
    (1, 1),  
    (2, 2),  
    (3, 3),  
    (4, 4),  
    (5, 5);
select * from Exam_question;
select e.id, q.id from `Exam_question` as eq 
join Exam as e on eq.id = e.id
join Question as q on eq.question_id = q.id;
