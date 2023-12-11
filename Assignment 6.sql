use Training;
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó
DELIMITER $$
create procedure GetAccount(IN dept_name VARCHAR(255))
begin
    select a.id, a.full_name, d.name
    from Account a
    join Department d ON a.department_id = d.id
    where d.name = dept_name;
end $$
DELIMITER ;
call GetAccount('Sale');
    
-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DELIMITER $$
create procedure soLuongAccocunt (in account_id varchar(255))
begin 
	select group_id, COUNT(*) as soLuongAccount
	from Account
	group by group_id;
end $$
DELIMITER ;
call soLuongAccocunt('group_id');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại
DELIMITER $$
create procedure TypeQuestion(in question varchar(255))
begin
    declare thangHienTai int;
    declare namHienTai int;
    set thangHienTai = month(CURRENT_DATE());
    set namHienTai = year(CURRENT_DATE());
    create temporary table if not exists ThongKeCauHoi (
        Type varchar(255),
        SoLuong int
    );
    insert into ThongKeCauHoi (Type, SoLuong)
    select Type, COUNT(*) AS SoLuong
    from Question
    where month(NgayTao) = thangHienTai and year(NgayTao) = namHienTai
    and Type = question
    group by Type;
    select * from ThongKeCauHoi;
end $$
DELIMITER ;
call TypeQuestion();

-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DELIMITER $$
CREATE PROCEDURE get_type_name(IN question_id VARCHAR(255))
BEGIN
    DECLARE type_id_result VARCHAR(255);
    SELECT type_id INTO type_id_result FROM questions WHERE id = question_id;
    SELECT type_name
    FROM question_type
    WHERE type_id = type_id_result;
END $$
DELIMITER ;


-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
DELIMITER $$
create procedure Get_type_name(in question_id varchar(255))
begin
    declare type_id_result varchar(255);
    select type_id into type_id_result from questions where id = question_id;
    select type_name
    from question_type
    where type_id = type_id_result;
end $$
DELIMITER ;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào


-- --------------------------------------------------------------------------------------------------------------

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công
DELIMITER $$
create procedure CreateUserStore(
    in p_fullName varchar(255),
    in p_email varchar(255)
)
begin
    declare v_username varchar(255);
    declare v_positionID int default 1;
    declare v_departmentID int default 0; 
    set v_username = SUBSTRING_INDEX(p_email, '@', 1);
    insert into users (full_name, email, user_name, position_id, department_id)
    values (p_full_name, p_email, v_user_name, v_position_id, v_department_id);
    select 'User created successfully' AS result;
end $$
DELIMITER ;

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DELIMITER $$
create procedure UserEssay(
	in p_essay Text,
    in p_Multiple_Choice text
)
begin 
	select * from questions
	where question_type = 'essay'
    and question_type = 'multiple-choice'
	order by LENGTH(content) desc
	limit 1;
end $$
DELIMITER ;    

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
DELIMITER $$
create procedure dropExam (in id int)
begin 
	delete from Exam where title = id;
	select 'thành công.' as Message;
end$$
DELIMITER ; 
CALL dropExam(1);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DELIMITER $$
create procedure searchExam ()
begin 
	declare threeYearsAgo DateTime;
    set threeYearsAgo = DATE_SUB(CURDATE(), INTERVAL 3 YEAR);
	select * from Exam
    where created_date <= threeYearsAgo;
    delete from Exam
	where created_date <= threeYearsAgo;
    select CONCAT('Thành công. Đã xóa ', row_count(), ' bản ghi.') as Message;
end$$
DELIMITER ;
call searchExam();

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc

 -- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")









