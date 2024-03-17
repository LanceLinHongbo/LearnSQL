sqlite3

-- 打开或建立数据库
.open Learn_15.db























-- 创建表
CREATE TABLE StudentInf(
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
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 1, 'Li Wu', '1993-08-08', 90, 95, 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 2, 'Yi Si', '1992-03-08', 85, 75, 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 3, 'Lin Jiu', '1992-03-03', 88, 90, NULL);
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 4, 'Ma Si', '1992-01-08', 75, 80, 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 5, 'Li Si', '1992-08-08', 80, 95, 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 6, 'Mi Si', '1992-01-08', 99, 85, 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 7, 'Sun Yi', '1993-03-08', 78, 88, 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, math_score, english_score, class) VALUES ( 8, 'Liu Si', '1991-08-08', 87, 90, 'THREE');
COMMIT;










-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;









-- 谓词是返回值为TRUE, FALSE, UNKNOWN这类值的函数
-- LIKE 用于字符串查询
SELECT * FROM StudentInf WHERE class LIKE 'ONE';










-- LIKE 前方一致性, 查询有相同起始部分的字符串
-- 比如在 'abc', 'acd', 'cde' 中查询第一个字母为'a'的字符串
-- 可用 LIKE 'a%'
SELECT * FROM StudentInf WHERE class LIKE 'T%';









-- LIKE 后方一致性, 查询有相同结尾的字符串
-- 比如在 'abc', 'acd', 'cde' 中查询最后一个字母为'e'的字符串
-- 可用 LIKE '%e'
SELECT * FROM StudentInf WHERE class LIKE '%E';












-- LIKE 中间一致性, 查询含有要查询字符串的字符串
-- 比如在 'abc', 'cad', 'cda' 中查询含有字母'a'的字符串
-- 可用 LIKE '%a%'
SELECT * FROM StudentInf WHERE class LIKE '%R%';










-- BETWEEN 范围查询, 如查询10到100之间的值, 可用 BETWEEN 10 AND 100
SELECT * FROM StudentInf WHERE math_score BETWEEN 80 AND 90;










-- IS NULL, IS NOT NULL 查询值为 NULL 或不为 NULL 的记录
SELECT * FROM StudentInf WHERE class IS NOT NULL;









-- IN 查询值在某集合的记录
-- 例如, 查询值在集合 (10, 20, 30) 中出现过的记录 IN (10, 20, 30)
-- 或查询值在集合 (10, 20, 30) 中没有出现过的记录 NOT IN (10, 20, 30)
SELECT * FROM StudentInf WHERE math_score IN (80, 85, 90);










-- 使用子查询作为 IN 的参数
SELECT
    *
FROM
    StudentInf
WHERE
    math_score IN (
        SELECT
            math_score
        FROM
            StudentInf
        WHERE
            math_score > 80
    );










-- EXISTS 判断是否存在满足某种条件的记录
-- EXISTS 通常要接关联子查询
SELECT
    *
FROM
    StudentInf AS S1
WHERE
    EXISTS (
        SELECT
            AVG(math_score) AS avg_math_score
        FROM
            StudentInf AS S2
        WHERE
            S1.class = S2.class
        GROUP BY
            class
        HAVING
            avg_math_score > 83
    );