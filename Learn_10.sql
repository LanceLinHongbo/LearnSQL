-- 打开或建立数据库
.open Learn_10.db























-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    phone CHAR(16),
    class CHAR(8) DEFAULT 'ONE',
    PRIMARY KEY(id)
);



















-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 2, 'Li Wu', '1993-08-08', '86-10-1238567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 4, 'Mi Si', '1992-01-08', '86-10-1232567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Yi Si', '1992-03-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 6, 'Sun Yi', '1993-03-08', NULL, 'THREE');
COMMIT;










-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;


DELETE FROM StudentInf WHERE id > 6;