-- 打开或建立数据库 .open Learn_05.db




-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    phone CHAR(16),
    class CHAR(8) DEFAULT 'ONE',
    PRIMARY KEY(id)
);






INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 2, 'Li Wu', '1993-08-08', '86-10-1238567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 4, 'Mi Si', '1992-01-08', '86-10-1232567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Yi Si', '1992-03-08', '86-10-1231567890', 'ONE');











-- 删除表的所有内容 -- DELETE FROM <表名>;
DELETE FROM
    StudentInf;











-- 删除表的特定内容
-- DELETE FROM StudentInf WHERE <条件>;







DELETE FROM
    StudentInf
WHERE
    id = 1;






DELETE FROM
    StudentInf
WHERE
    stu_name = 'Yi Si';