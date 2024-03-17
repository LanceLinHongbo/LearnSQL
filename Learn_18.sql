sqlite3

-- 打开或建立数据库
.open Learn_18.db









-- 创建表
CREATE TABLE StudentInf(
    id                  INTEGER,
    stu_name            VARCHAR(32)     NOT NULL,
    birthday            DATE            NOT NULL,
    class               CHAR(8)         DEFAULT 'ONE',
    PRIMARY KEY(id)
);


-- 创建表
CREATE TABLE StudentScore(
    id                  INTEGER,
    math_score          INTEGER         NOT NULL,
    english_score       INTEGER         NOT NULL,
    PRIMARY KEY(id)
);






-- 创建表
CREATE TABLE StudentSex(
    id                  INTEGER,
    sex                 CHAR(8)         DEFAULT 'M',
    PRIMARY KEY(id)
);











-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 1, 'Li Wu', '1993-08-08', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 2, 'Yi Si', '1992-03-08', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 3, 'Lin Jiu', '1992-03-03', NULL);
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 4, 'Ma Si', '1992-01-08', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 5, 'Li Si', '1992-08-08', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 6, 'Mi Si', '1992-01-08', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 7, 'Sun Yi', '1993-03-08', 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, class) VALUES ( 8, 'Liu Si', '1991-08-08', 'THREE');
COMMIT;






BEGIN TRANSACTION;
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 1, 90, 95);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 2, 85, 75);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 3, 88, 90);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 4, 75, 80);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 5, 80, 95);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 6, 99, 85);
INSERT INTO StudentScore (id, math_score, english_score) VALUES ( 7, 78, 88);
COMMIT;




BEGIN TRANSACTION;
INSERT INTO StudentSex (id, sex) VALUES ( 1, 'M');
INSERT INTO StudentSex (id, sex) VALUES ( 2, 'F');
INSERT INTO StudentSex (id, sex) VALUES ( 3, 'M');
INSERT INTO StudentSex (id, sex) VALUES ( 4, 'M');
INSERT INTO StudentSex (id, sex) VALUES ( 5, 'F');
INSERT INTO StudentSex (id, sex) VALUES ( 6, 'F');
INSERT INTO StudentSex (id, sex) VALUES ( 7, 'F');
INSERT INTO StudentSex (id, sex) VALUES ( 8, 'M');
COMMIT;


















-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;
SELECT * FROM StudentScore;
SELECT * FROM StudentSex;











-- 联结就是将其它表的列添加到目标表的运算.
-- 由于信息通常散在于多个表中, 所以需要联结获取期望的内容.
-- 内联结 INNER JOIN
-- 在 SELECT 中使用 <表别名>.<列名> 来指定列
SELECT
    SI.id,
    SI.stu_name,
    SI.birthday,
    SI.class,
    SS.math_score,
    SS.english_score
FROM
    -- 内联结使用 INNER JOIN 联结两个表
    -- 使用 ON 设定联结条件
    StudentInf AS SI
    INNER JOIN StudentScore AS SS ON SI.id = SS.id;











-- 可以将联结后的结果当成一个表, 可使用 WHERE, GROUP BY, HAVING, ORDER BY等.
SELECT
    SI.id,
    SI.stu_name,
    SI.birthday,
    SI.class,
    SS.math_score,
    SS.english_score
FROM
    StudentInf AS SI
    INNER JOIN StudentScore AS SS ON SI.id = SS.id
WHERE
    class = 'ONE';









-- 外联结 OUTER JOIN
SELECT
    SI.id,
    SI.stu_name,
    SI.birthday,
    SI.class,
    SS.math_score,
    SS.english_score
FROM
    -- 外联结使用 LEFT OUTER JOIN 或 RIGHT OUTER JOIN 联结两个表
    StudentInf AS SI
    RIGHT OUTER JOIN StudentScore AS SS ON SI.id = SS.id;











-- 外联结中使用 LEFT 或 RIGHT 指定主表
-- 外联结会选取主表的所有信息
SELECT
    SI.id,
    SI.stu_name,
    SI.birthday,
    SI.class,
    SS.math_score,
    SS.english_score
FROM
    StudentInf AS SI
    LEFT OUTER JOIN StudentScore AS SS ON SI.id = SS.id;












-- 多表联结
SELECT
    SI.id,
    SI.stu_name,
    SI.birthday,
    SI.class,
    SS.math_score,
    SS.english_score,
    SE.sex
FROM
    StudentInf AS SI
    -- 使用多个 INNER JOIN 将多个表联结
    INNER JOIN StudentScore AS SS ON SI.id = SS.id
    INNER JOIN StudentSex AS SE ON SI.id = SE.id;










-- 交叉联结 CROSS JOIN (笛卡尔积)
-- 在实际业务中基本不会使用
SELECT
    SI.id,
    SI.stu_name,
    SS.math_score,
    SS.english_score
FROM
    StudentInf AS SI
    -- 交叉联结不设条件, 每个表的每一行和其它表的所有行连接
    -- 其查询结果没有意义
    CROSS JOIN StudentScore AS SS;