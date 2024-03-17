sqlite3

-- 打开或建立数据库
.open Learn_12.db























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
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 7, 'Lin Jiu', '1992-03-03',NULL, 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 8, 'Ma Si', '1992-01-08', NULL, 'TWO');
COMMIT;










-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;














-- 子查询可简单理解为一次性的视图, 将构造 VIEW 的 SELECT 语句放到 FROM 关键字底下即可
SELECT
    class,
    class_count
FROM
(
        SELECT                          -- 直接书写视图的 SELECT 语句
            class,
            COUNT(*) AS class_count     -- 起一个别名, 方便在查询 SELECT 中使用
        FROM
            StudentInf
        GROUP BY
            class
    ) AS ClassSum;                      -- 也要为子查询命名

















-- 子查询可以被嵌套, 但是会影响可读性以及性能
SELECT
    class
FROM
(
        SELECT                                  -- 第一层嵌套
            class,
            class_count
        FROM
            (
                SELECT
                    class,
                    COUNT(*) AS class_count     -- 第二层嵌套
                FROM
                    StudentInf
                GROUP BY
                    class
            ) AS ClassSumA
    ) AS ClassSumB
WHERE
    class_count = 2;















-- 标量子查询就是只返回单一值的子查询
-- 因此, 可以广泛用于需要进行比较的运算中
-- 例如, 查询 id 大于平均 id 的学生信息, 标量子查询放在 WHERE 字句中
-- 因为在 WHERE 字句中, 不能直接使用聚合函数, HAVING 子句则作用不同
SELECT
    *
FROM
    StudentInf
WHERE
    id >(
        SELECT              -- 标量子查询, 只返回最大 id 值
            AVG(id)
        FROM
            StudentInf
    );










-- 标量子查询的注意事项是: 不要返回多个结果
SELECT
    *
FROM
    StudentInf
WHERE
    id >(
        SELECT              -- 返回多个结果, 最终导致结果无意义
            AVG(id)
        FROM
            StudentInf
        GROUP BY
            class
    );