Use Training;
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale
create view sale_tbl as 
	select user_name, full_name, email, d.id, d.name from Account a inner join Department d on a.department_id = d.id 
    where d.name = 'Sale';
select * from sale_tbl;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
create view account_inf as 
	select a.user_name, a.full_name, a.email, count(g.creator_id) as creator_count
    from Account a
    left join `Group` g on a.id = g.creator_id
    group by a.user_name
limit 3;
 
-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
create view long_content as 
	select q.id as question_id,
    q.content as question_content
    from question q
    where length(q.content) > 300;
-- Xóa các câu hỏi có nội dung quá dài từ bảng Question
delete from Question
where id in (select question_id from long_content);

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
create view room as 
	select d.id as department_id, d.name as department_name,
    count(a.id) as Account
    from Department d
    join Account a on d.id = a.department_id
    group by d.id, d.name
    order by Account desc
limit 1;

-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo
create view creator as
	select q.id, q.content, q.creator_id from Question q
    inner join Account a on q.creator_id = a.id
	where a.full_name like '%Nguyen%';
    

