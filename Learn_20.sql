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


















SELECT * FROM StudentInf;








-- 计算班级的数学总成绩
SELECT class, sum(math_score) FROM StudentInf GROUP BY class;










-- 通过 ROLLUP 合计所有班级总成绩
-- 相当于 GROUP BY() UNION GROUP BY(class)
SELECT class, sum(math_score) FROM StudentInf GROUP BY ROLLUP (class);










-- 对多列进行合计
-- 相当于 GROUP BY() UNION GROUP BY(class) UNION GROUP BY(class, stu_name)
SELECT stu_name, class, sum(math_score)
FROM StudentInf
GROUP BY ROLLUP (class, stu_name)
ORDER BY class, stu_name;











-- 通过 CUBE 合计所有班级总成绩
-- 相当于 GROUP BY() UNION GROUP BY(class)
SELECT class, sum(math_score) FROM StudentInf GROUP BY CUBE (class);










-- 使用 CUBE 对多列进行合计
-- 相当于 GROUP BY() UNION GROUP BY(class) UNION GROUP BY(stu_name) UNION GROUP BY(class, stu_name)
-- 对所有可能的组合进行合计
SELECT stu_name, class, sum(math_score)
FROM StudentInf
GROUP BY CUBE (class, stu_name)
ORDER BY class, stu_name;










-- 使用 GROUPING 函数, 区别基表 NULL 与 合计产生的 NULL
SELECT stu_name, GROUPING(stu_name) as group_name, class, GROUPING(class) as group_class, SUM(math_score)
FROM StudentInf
GROUP BY CUBE (class, stu_name)
ORDER BY class, stu_name;










-- 使用 GROUPING SETS 进行合计
-- 相当于 GROUP BY(class) UNION GROUP BY(stu_name)
-- 对 GROUPING SETS 集合中的列进行合计
SELECT stu_name, GROUPING(stu_name) as group_name, class, GROUPING(class) as group_class, SUM(math_score)
FROM StudentInf
GROUP BY GROUPING SETS (class, stu_name)
ORDER BY class, stu_name;