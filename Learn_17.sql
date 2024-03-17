sqlite3

-- 打开或建立数据库
.open Learn_17.db























-- 创建表
CREATE TABLE StudentInfA(
    id                  INTEGER,
    stu_name            VARCHAR(32)     NOT NULL,
    birthday            DATE            NOT NULL,
    math_score          INTEGER         NOT NULL,
    english_score       INTEGER         NOT NULL,
    class               CHAR(8)         DEFAULT 'ONE',
    PRIMARY KEY(id)
);


-- 创建表
CREATE TABLE StudentInfB(
    id                  INTEGER,
    stu_name            VARCHAR(32)     NOT NULL,
    birthday            DATE            NOT NULL,
    math_score          INTEGER         NOT NULL,
    english_score       INTEGER         NOT NULL,
    class               CHAR(8)         DEFAULT 'ONE',
    PRIMARY KEY(id)
);




































-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInfA (id, stu_name, birthday, math_score, english_score, class) VALUES ( 1, 'Li Wu', '1993-08-08', 90, 95, 'ONE');
INSERT INTO StudentInfA (id, stu_name, birthday, math_score, english_score, class) VALUES ( 2, 'Yi Si', '1992-03-08', 85, 75, 'ONE');
INSERT INTO StudentInfA (id, stu_name, birthday, math_score, english_score, class) VALUES ( 3, 'Lin Jiu', '1992-03-03', 88, 90, NULL);
INSERT INTO StudentInfA (id, stu_name, birthday, math_score, english_score, class) VALUES ( 4, 'Ma Si', '1992-01-08', 75, 80, 'TWO');
INSERT INTO StudentInfA (id, stu_name, birthday, math_score, english_score, class) VALUES ( 5, 'Li Si', '1992-08-08', 80, 95, 'TWO');
COMMIT;



-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInfB (id, stu_name, birthday, math_score, english_score, class) VALUES ( 4, 'Ma Si', '1992-01-08', 75, 80, 'TWO');
INSERT INTO StudentInfB (id, stu_name, birthday, math_score, english_score, class) VALUES ( 5, 'Li Si', '1992-08-08', 80, 95, 'TWO');
INSERT INTO StudentInfB (id, stu_name, birthday, math_score, english_score, class) VALUES ( 6, 'Mi Si', '1992-01-08', 99, 85, 'TWO');
INSERT INTO StudentInfB (id, stu_name, birthday, math_score, english_score, class) VALUES ( 7, 'Sun Yi', '1993-03-08', 78, 88, 'THREE');
INSERT INTO StudentInfB (id, stu_name, birthday, math_score, english_score, class) VALUES ( 8, 'Liu Si', '1991-08-08', 87, 90, 'THREE');
COMMIT;

















-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInfA;
SELECT * FROM StudentInfB;










-- 集合运算就是对满足某种规则的记录进行: 并集(UNION), 交集(INTERSECT), 差集(EXCEPT)等操作的运算
-- 表的加法: 并集运算
SELECT * FROM StudentInfA
UNION
SELECT * FROM StudentInfB;









-- 集合运算的注意事项
-- 作为运算对象的记录, 其列数必须相同
-- 列的类型必须一致
-- 可以使用任何 SELECT 语句, ORDER BY 子句只能在最后使用一次









-- 包含重复行的 ALL 关键字
SELECT * FROM StudentInfA
UNION ALL
SELECT * FROM StudentInfB;










-- 交集运算
SELECT * FROM StudentInfA
INTERSECT
SELECT * FROM StudentInfB;










-- 表的减法: 差集运算
SELECT * FROM StudentInfA
EXCEPT
SELECT * FROM StudentInfB;











-- 差集运算中顺序不可颠倒
SELECT * FROM StudentInfB
EXCEPT
SELECT * FROM StudentInfA;