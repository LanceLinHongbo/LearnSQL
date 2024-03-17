-- 打开或建立数据库
.open Learn_08.db
























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
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 6, 'Sun Yi', '1993-03-08', NULL, 'THREE');










-- 启用表头
.header on

-- 启用列模式
.mode column




















-- 聚合函数
-- COUNT        计算表中聚合结果的行数
-- SUM          计算聚合数据的合计值
-- AVG          计算聚合数据的平均值
-- MAX          计算聚合数据的最大值
-- MIN          计算聚合数据的最小值






-- 计算表中所有数据的行数, 包括NULL
SELECT COUNT(*) FROM StudentInf;
























-- 也可以计算某一列的行数, 值为NULL的不被计算
SELECT COUNT(class) FROM StudentInf;




























-- 也可以计算某一列的行数, 值为NULL的不被计算
SELECT COUNT(phone) FROM StudentInf;






























-- 其它聚合函数
SELECT SUM(id), AVG(id), MAX(id), MIN(id) FROM StudentInf;





























-- 删除重复值
SELECT COUNT(DISTINCT class) FROM StudentInf;






























-- 对表进行分组 SELECT <列名>... FROM <表名> GROUP BY <列名>...;
SELECT class FROM StudentInf GROUP BY class;

























SELECT class, COUNT(class) FROM StudentInf GROUP BY class;




















-- 含有NULL的分组
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 7, 'Shi San', '1993-03-08', NULL, NULL);










-- 对于 NULL 给与分组但不统计数量
SELECT class, COUNT(class) FROM StudentInf GROUP BY class;

















-- 使用 COUNT(*) 统计 NULL 数量
SELECT class, COUNT(*) FROM StudentInf GROUP BY class;



















-- 在分组的基础上再加 WHERE 条件
SELECT class, COUNT(*) FROM StudentInf WHERE class IS NOT NULL GROUP BY class;


















-- 常见 GROUP BY 使用错误
-- 除了在 GROUP BY 中使用到的列, 以及聚合函数, 和常数, 不应该在 SELECT 语句中使用其它列, 因为结果无意义
SELECT id, class, COUNT(*) FROM StudentInf WHERE class IS NOT NULL GROUP BY class;








-- 不要在 GROUP BY 中使用别名, 虽然在 sqlite 中是正常的, 但这不是标准 SQL, 其它数据库可能会产生错误.
SELECT class AS "班级", COUNT(*) FROM StudentInf GROUP BY "班级";





-- 不能在 WHERE 中使用聚合函数
SELECT class, COUNT(*) FROM StudentInf WHERE COUNT(*) = 2 GROUP BY class;





















-- 使用汇总操作时, 可以在 HAVING 中使用聚合函数
-- SELECT <列名>... FROM <表名> GROUP BY <列名>... HAVING <分组结果筛选条件>;
SELECT class, COUNT(*) FROM StudentInf GROUP BY class HAVING COUNT(*) = 2;



















-- WHERE 关键字是作为行内的限制条件, HAVING 关键字是作为分组结果的条件
SELECT class, COUNT(*) FROM StudentInf WHERE class <> 'ONE' GROUP BY class HAVING COUNT(*) = 2;





















-- 虽然有时候能混用, 但是为了别人更容易看懂, 以及性能, 还是不要混用
-- 以下示例可用, 但是概念混淆, 性能低下
SELECT class, COUNT(*) FROM StudentInf GROUP BY class HAVING COUNT(*) = 2 AND class <> 'ONE';




















-- 用 ORDER BY 对查询结果排序
-- SELECT <列名>... FROM <表名> ORDER BY <列名>...;
SELECT stu_name, class FROM StudentInf ORDER BY class;





















-- 使用多个排序列
SELECT class, stu_name, phone FROM StudentInf ORDER BY class, stu_name;


















-- 倒排
SELECT class, stu_name, phone FROM StudentInf ORDER BY class DESC;


















-- 在 ORDER BY 中使用 SELECT 未出现的列
SELECT stu_name, phone FROM StudentInf ORDER BY class DESC;







































-- 使用我们所学的的所有查询知识进行查询, 请记住关键字的组合位置
-- 巧记: 四幅我国海鸥, SELECT ... FROM ... WHERE ... GROUP BY ... HAVING ... ORDER BY;
SELECT class, COUNT(*) FROM StudentInf WHERE class <> 'ONE' GROUP BY class HAVING COUNT(*) = 2 ORDER BY class;
