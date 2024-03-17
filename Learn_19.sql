-- 打开或建立数据库
sqlite3
.open Learn_19.db










-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    math_score INTEGER NOT NULL,
    english_score INTEGER NOT NULL,
    class CHAR(8) DEFAULT 'ONE',
    PRIMARY KEY(id)
);











-- 使用事务可以一次性增删改多条数据, DML语句即数据操纵语言, 也就是增删改查
-- BEGIN TRANSACTION; DML语句1; DML语句2; DML语句3; ... COMMIT;
BEGIN TRANSACTION;
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (1, 'Li Wu', '1993-08-08', 90, 95, 'ONE');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (2, 'Yi Si', '1992-03-08', 85, 75, 'ONE');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (3, 'Lin Jiu', '1992-03-03', 88, 90, NULL);
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (4, 'Ma Si', '1992-01-08', 75, 80, 'TWO');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (5, 'Li Si', '1992-08-08', 80, 95, 'TWO');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (6, 'Mi Si', '1992-01-08', 99, 85, 'TWO');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (7, 'Sun Yi', '1993-03-08', 78, 88, 'THREE');
INSERT INTO StudentInf ( id, stu_name, birthday, math_score, english_score, class) VALUES (8, 'Liu Si', '1991-08-08', 87, 90, 'THREE');
COMMIT;











-- 创建表
CREATE TABLE StockPrice(
    id INTEGER,
    stock_date DATE NOT NULL,
    price REAL NOT NULL,
    PRIMARY KEY(id)
);











BEGIN TRANSACTION;
INSERT INTO StockPrice (id, stock_date, price) VALUES (1, '2000-06-30', 13.510);
INSERT INTO StockPrice (id, stock_date, price) VALUES (2, '2000-07-07', 13.020);
INSERT INTO StockPrice (id, stock_date, price) VALUES (3, '2000-07-14', 13.950);
INSERT INTO StockPrice (id, stock_date, price) VALUES (4, '2000-07-21', 14.260);
INSERT INTO StockPrice (id, stock_date, price) VALUES (5, '2000-07-28', 14.100);
INSERT INTO StockPrice (id, stock_date, price) VALUES (6, '2000-08-04', 13.850);
INSERT INTO StockPrice (id, stock_date, price) VALUES (7, '2000-08-11', 14.350);
INSERT INTO StockPrice (id, stock_date, price) VALUES (8, '2000-08-18', 14.190);
INSERT INTO StockPrice (id, stock_date, price) VALUES (9, '2000-08-25', 13.720);
COMMIT;












-- 启用表头
.header on

-- 启用列模式
.mode column










SELECT * FROM StudentInf;
SELECT * FROM StockPrice;











-- 窗口函数可以进行分组排序, 生成序列号, 计算前若干名, 累计, 计算移动平均等高级操作
-- 窗口函数语法 <窗口函数> OVER (PARTITION BY <列清单> ORDER BY <排序列清单>)
-- RANK函数, 分组排序
SELECT
    id, stu_name, class, math_score,
    RANK() OVER(PARTITION BY class ORDER BY math_score) AS stu_rank
FROM
    StudentInf;










-- ROW_NUMBER函数, 生成序列号
-- 省略 PARTITION BY
SELECT
    stu_name, class, math_score,
    ROW_NUMBER() OVER(ORDER BY class, stu_name) AS stu_id
FROM
    StudentInf;







-- RANK函数, 计算前若干名
SELECT
    *
FROM
    (SELECT
            id, stu_name, class, math_score,
            RANK() OVER(PARTITION BY class ORDER BY math_score) AS stu_rank
     FROM
            StudentInf
    )
WHERE
    stu_rank < 3;







-- 专用窗口函数 RANK, DENSE_RANK, ROW_NUMBER
-- 专用窗口函数的使用区别: 在如果存在相同记录, 则排序结果不同
-- RANK的排序逻辑是如存在3个相同记录则排序为: 1, 1, 1, 4
SELECT
    class,
    RANK() OVER (ORDER BY class)
FROM
    StudentInf;






-- DENSE_RANK的排序逻辑是: 1, 1, 1, 2
SELECT
    class,
    DENSE_RANK() OVER (ORDER BY class)
FROM
    StudentInf;






-- ROW_NUMBER的排序逻辑是: 1, 2, 3, 4
SELECT
    class,
    ROW_NUMBER() OVER (ORDER BY class)
FROM
    StudentInf;










-- 使用聚合函数作为窗口函数
-- SUM()累计
SELECT
    id, stu_name, class, math_score,
    SUM(math_score) OVER(PARTITION BY class ORDER BY id) AS sum_math_score
FROM
    StudentInf;










-- AVG()移动平均
-- AVG() OVER (ORDER BY <排序列> ROWS <行数> PRECEDING)
-- PRECEDING 代表截至到之前几行
SELECT
    id, stock_date, price,
    AVG(price) OVER (ORDER BY id ROWS 2 PRECEDING) AS moving_avg_price
FROM
    StockPrice;








-- 设置移动平均范围, FOLLOWING 代表截止到之后几行
SELECT
    id, stock_date, price,
    AVG(price) OVER (ORDER BY id ROWS BETWEEN 0 PRECEDING AND 2 FOLLOWING) AS moving_avg_price
FROM
    StockPrice;








-- 窗口函数中的 ORDER BY 和普通的 ORDER BY
-- 窗口函数中的 ORDER BY 是用来决定按照什么顺序进行计算, 不一定保证结果显示顺序
-- 以下查询结果按照 ranking 排序只是在 sqlite 数据库, 其它数据库不一定
SELECT
    id, stu_name,
    rank() OVER(ORDER BY stu_name) AS ranking
FROM
    StudentInf;





-- 普通的 ORDER BY 决定最终结果的排序
SELECT
    id, stu_name,
    rank() OVER(ORDER BY stu_name) AS ranking
FROM
    StudentInf
ORDER BY
    id;