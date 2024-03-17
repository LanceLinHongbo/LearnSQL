-- 打开或建立数据库 .open Learn_07.db














-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    phone CHAR(16),
    class CHAR(8) DEFAULT 'ONE',
    PRIMARY KEY(id)
);















INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 2, 'Li Wu', '1993-08-08', '86-10-1238567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 4, 'Mi Si', '1992-01-08', '86-10-1232567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Yi Si', '1992-03-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 6, 'Sun Yi', '1993-03-08', NULL, NULL);
















-- 启用表头     .header on
-- 启用列模式   .mode column














-- 查询表中所有信息 SELECT * FROM <表名>;
SELECT * FROM StudentInf;















-- 查询表中某些列 SELECT <列名>, ... FROM <表名>;
SELECT id, stu_name FROM StudentInf;














-- 为列设定别名 SELECT <列名> AS <别名> FROM <表名>;
-- 别名可以用中文, 但需用 "" 双引号括起来
SELECT id  AS "学号", stu_name AS "姓名" FROM StudentInf;














-- 结果去重 DISTINCT 关键字
SELECT class FROM StudentInf;

SELECT DISTINCT class FROM StudentInf;




















-- 查询特定记录 SELECT <列名>... FROM <表名> WHERE <条件>;
SELECT id, stu_name FROM StudentInf WHERE class = 'ONE';




















-- 算数运算符 + - * /
SELECT id * 2 AS id_x_2 FROM StudentInf;











-- 所有包含 NULL 的计算, 结果都是 NULL
5 + NULL
5 - NULL
5 * NULL
5 / NULL




















-- 比较运算符
=       -- 相等
<>      -- 不等
>=      -- 大于等于
<=      -- 小于等于
>       -- 大于
<       -- 小于

SELECT * FROM StudentInf WHERE id <> 1;






-- 比较字符串时要小心
SELECT * FROM StudentInf WHERE class > 'THREE';











-- 当你不了解你究竟在做什么时候, 不要使用字符比较
SELECT * FROM StudentInf WHERE class > 'T';











-- 不可以对 NULL 做比较运算


SELECT * FROM StudentInf WHERE class = NULL;


SELECT * FROM StudentInf WHERE class IS NULL;


SELECT * FROM StudentInf WHERE class IS NOT NULL;




















-- 逻辑运算符 NOT AND OR

-- NOT     不是
SELECT * FROM StudentInf WHERE NOT id = 1;






-- AND     且
SELECT * FROM StudentInf WHERE  id > 1 AND id < 5;







-- OR      或
SELECT * FROM StudentInf WHERE  id < 3 OR id > 5;



















-- 含有 NULL 的逻辑运算

-- AND
-- 条件1       条件2       结果
-- 真          真          真
-- 假          假          假
-- 真          假          假
-- 真          不确定      不确定
-- 假          不确定      假


SELECT * FROM StudentInf WHERE  id > 3 AND class <> 'ONE';






-- OR
-- 条件1       条件2       结果
-- 真          真          真
-- 假          假          假
-- 真          假          真
-- 真          不确定      真
-- 假          不确定      不确定


SELECT * FROM StudentInf WHERE  id > 3 OR class <> 'ONE';