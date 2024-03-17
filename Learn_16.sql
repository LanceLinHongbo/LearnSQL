sqlite3

-- 打开或建立数据库
.open Learn_16.db























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








-- CASE 表达式就是 SQL 语言中的条件分支



-- CASE 表达式语法: (搜索 CASE 表达式)

-- CASE WHEN <求值表达式> THEN <表达式>
--      WHEN <求值表达式> THEN <表达式>
--      WHEN <求值表达式> THEN <表达式>
--      ELSE <表达式>
-- END




SELECT
    *,
    CASE
        WHEN math_score >= 90 THEN '优'
        WHEN math_score < 90
        AND math_score >= 80 THEN '良'
        WHEN math_score < 80
        AND math_score >= 60 THEN '中'
        WHEN math_score < 60 THEN '差'
        ELSE NULL
    END AS LEVEL
FROM
    StudentInf;










-- 简单 CASE 表达式

-- CASE <表达式>
--      WHEN <表达式> THEN <表达式>
--      WHEN <表达式> THEN <表达式>
--      WHEN <表达式> THEN <表达式>
--      ELSE <表达式>
-- END

SELECT
    *,
    CASE class
        WHEN 'ONE' THEN '一班'
        WHEN 'TWO' THEN '二班'
        WHEN 'THREE' THEN '三班'
        ELSE NULL
    END AS cn_class
FROM
    StudentInf;










-- CASE 表达式辅助聚合结果行列转置
SELECT
    class,
    sum(math_score)
FROM
    StudentInf
GROUP BY
    class;











SELECT
    sum(
        CASE
            WHEN class = 'ONE' THEN math_score
            ELSE 0
        END
    ) AS ONE_math_sum,
    sum(
        CASE
            WHEN class = 'TWO' THEN math_score
            ELSE 0
        END
    ) AS TWO_math_sum,
    sum(
        CASE
            WHEN class = 'THREE' THEN math_score
            ELSE 0
        END
    ) AS THREE_math_sum
FROM
    StudentInf;