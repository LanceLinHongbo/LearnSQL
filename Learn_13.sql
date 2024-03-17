sqlite3

-- 打开或建立数据库
.open Learn_13.db























-- 创建表
CREATE TABLE StudentInf(
    id                  INTEGER,
    stu_name            VARCHAR(32)     NOT NULL,
    birthday            DATE            NOT NULL,
    phone               CHAR(16),
    class               CHAR(8)         DEFAULT 'ONE',
    PRIMARY KEY(id)
);



















-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Wu', '1993-08-08', '86-10-1238567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 2, 'Yi Si', '1992-03-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Lin Jiu', '1992-03-03',NULL, 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 4, 'Ma Si', '1992-01-08', NULL, 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 6, 'Mi Si', '1992-01-08', '86-10-1232567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 7, 'Sun Yi', '1993-03-08', NULL, 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 8, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
COMMIT;










-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;














-- 关联子查询, 可简单理解为将一个集合按照某些元素切分, 对切分后的表进行比较的查询
-- 关联子查询通过关联条件将表进行切分, 逐一对切分后的内容进行比较
SELECT
    *
FROM
    StudentInf AS StudentInfA
WHERE
    id >(
        SELECT                                      -- 关联子查询
            AVG(id)
        FROM
            StudentInf AS StudentInfB
        WHERE
            StudentInfA.class = StudentInfB.class   -- 关联条件
        GROUP BY
            class
    );










-- 关联子查询的关联条件, 要放在子查询中
SELECT
    *
FROM
    StudentInf AS StudentInfA
WHERE
    StudentInfA.class = StudentInfB.class -- 关联条件位置错误, 没有放在子查询中
    AND id >(
        SELECT
            -- 关联子查询
            AVG(id)
        FROM
            StudentInf AS StudentInfB
        GROUP BY
            class
    );