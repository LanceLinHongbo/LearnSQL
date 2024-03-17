sqlite3

-- 打开或建立数据库
.open Learn_11.db























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












-- 视图是能返回一张表的 SELECT 语句
-- CREATE VIEW 视图名 (<视图列名1>...) AS <SELECT语句>;
CREATE VIEW ClassSum (class, class_count) AS
SELECT
    class,
    COUNT(*)
FROM
    StudentInf
GROUP BY
    class;



















-- 使用视图就像使用一个表
SELECT * FROM ClassSum;


















-- 删除视图
DROP VIEW ClassSum;













-- 视图的限制, 定义时不能使用 ORDER BY
-- 但在某些数据库也可以执行
CREATE VIEW ClassSumTest (class, class_count) AS
SELECT
    class,
    COUNT(*)
FROM
    StudentInf
GROUP BY
    class
ORDER BY        -- 在sqlite中创建视图, 加入 ORDER BY 没有问题, 但仍不建议, 视图与表的用途一致, 对于查询, 提前排序没有意义.
    class;







SELECT * FROM ClassSumTest;











-- 视图的限制, 内容更新
-- 对视图进行更新要求十分严格,
-- SELECT 子句中不能有 DISTINCT,
-- FROM 子句中只能有一张表,
-- 不可使用 GROUP BY,
-- 不能使用 HAVING
-- 凡是含有非原始数据的视图, 都不可更新
CREATE VIEW ClassOne(id, stu_name, class) AS
SELECT
    *
FROM
    StudentInf
WHERE
    class = 'ONE';

--  即便满足以上要求, sqlite 也不允许进行视图更新, 其它数据库也许可以, 但没必要, 因为本质都是对基表进行更新.
INSERT INTO
    ClassOne(id, stu_name, class)
VALUES
    (7, 'Sun Ying', 'ONE');