sqlite3

-- 打开或建立数据库
.open Learn_14.db























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













-- 加减乘除
SELECT 5 + 3 AS addnum;











-- 在查询中使用算数函数
SELECT
    *,
    math_score + english_score AS sum_score
FROM
    StudentInf;









-- ABS() 绝对值函数
SELECT
    *,
    ABS(math_score - english_score) AS abs_score
FROM
    StudentInf;








-- MOD(被除数, 除数) 求余函数
SELECT MOD(5, 3);

SELECT 5 % 3;

SELECT 5 / 3;





-- ROUND(数值, 保留小数) 四舍五入函数
SELECT ROUND(11.123456, 4);












-- 字符串函数
-- || 拼接, 与 NULL 拼接还是 NULL
SELECT stu_name || '_' || class FROM StudentInf;









-- LENGTH(字符串) 求字符串长度函数, NULL 的长度是空
SELECT stu_name, LENGTH(stu_name) as name_length, class, LENGTH(class) FROM StudentInf;









-- UPPER(字符串)大写转换, LOWER(字符串)小写转换
SELECT UPPER(stu_name), LOWER(stu_name) FROM StudentInf;









-- REPLACE(对象字符串, 替换前的字符串, 替换后的字符串) 字符串替换函数
SELECT stu_name, class, REPLACE(class, 'ONE', '一班') AS change_class FROM StudentInf;








-- SUBSTRING(对象字符串 FROM 截取起始位置 FOR 截取的字符数) 字符串截取函数
-- SUBSTRING(对象字符串, 截取起始位置, 截取的字符数) sqlite用法
SELECT stu_name, class, SUBSTRING(class, 1, 1) AS sub_class FROM StudentInf;








-- 日期函数
-- CURRENT_DATE 获取当前日期
SELECT CURRENT_DATE;



















-- CURRENT_TIME 获取当前时间
SELECT CURRENT_TIME;













-- CURRENT_TIMESTAMP 获取当前日期和时间
SELECT CURRENT_TIMESTAMP;












-- EXTRACT(日期元素 FROM 日期) 截取日期元素函数
SELECT
    CURRENT_TIMESTAMP,
    EXTRACT( YEAR FROM CURRENT_TIMESTAMP) AS year,
    EXTRACT( MONTH FROM CURRENT_TIMESTAMP) AS MONTH,
    EXTRACT( DAY FROM CURRENT_TIMESTAMP) AS DAY;

-- STRFTIME('%d %m %Y', 日期) sqlite 截取日期元素函数
SELECT STRFTIME('%d %m %Y', CURRENT_DATE);

SELECT
    CURRENT_DATE,
    STRFTIME('%d', CURRENT_DATE) AS day,
    STRFTIME('%m', CURRENT_DATE) AS month,
    STRFTIME('%Y', CURRENT_DATE) AS year;









-- 转换函数
-- CAST(转换前的值 AS 想要转换的类型) 类型转换函数
SELECT CAST('001' AS INTEGER);












-- COALESCE(数据1, 数据2, 数据3...) 返回第一个非空值, 一般用于将NULL转换为其它值
SELECT stu_name, class, COALESCE(class, 'ONE') FROM StudentInf;