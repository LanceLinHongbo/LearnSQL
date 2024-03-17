-- 打开或建立数据库 .open Learn_01.db

-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    phone CHAR(16),
    class CHAR(8) DEFAULT 'ONE',
    PRIMARY KEY(id)
);











-- INSERT INTO <表名> (列...) VALUES (值...);






-- 列的顺序和值的顺序必须一一对应, 主键不可重复, 不可为空
INSERT INTO
    StudentInf (id, stu_name, birthday, phone, class)
VALUES
    ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');












-- 对于空值, 要写 NULL
INSERT INTO
    StudentInf (id, stu_name, birthday, phone, class)
VALUES
    (2, 'Zhang San', '1992-07-07', NULL, 'ONE');












-- 一般对于默认值要写 DEFAULT, 但sqlite不支持这种用法
INSERT INTO
    StudentInf (id, stu_name, birthday, phone, class)
VALUES
    (3, 'Wang Wu', '1992-09-09', NULL, DEFAULT);




-- 一般对于默认值要写 DEFAULT, 但sqlite不支持这种用法
INSERT INTO
    StudentInf (id, stu_name, birthday, phone)
VALUES
    (3, 'Wang Wu', '1992-09-09', NULL);


















-- 省略列清单, 对于向所有列插入时, 可省略列清单
INSERT INTO
    StudentInf
VALUES
    (4, 'Zhao Liu', '1992-05-09', NULL, 'TWO');












-- 省略 phone 列, 其内容自动填充 NULL
INSERT INTO
    StudentInf (id, stu_name, birthday, class)
VALUES
    (5, 'Zhao Qi', '1992-05-09', 'THREE');













-- 省略默认列, 列清单省略设置过 DEFAULT 的列时, 这些列将自动填充为 DEFAULT
-- 省略 class 列, 其内容自动填充 'ONE'
INSERT INTO
    StudentInf (id, stu_name, birthday)
VALUES
    (6, 'Zhao Ba', '1992-05-09');






SELECT * FROM StudentInf;