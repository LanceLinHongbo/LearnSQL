-- 打开或建立数据库
.open Learn_09.db
























-- 创建表
CREATE TABLE StudentInf(
    id INTEGER,
    stu_name VARCHAR(32) NOT NULL,
    birthday DATE NOT NULL,
    phone CHAR(16),
    class CHAR(8) DEFAULT 'ONE',
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
COMMIT;











-- 启用表头
.header on

-- 启用列模式
.mode column

















SELECT * FROM StudentInf;

















-- 使用事务, 一次性更改多条数据内容
BEGIN TRANSACTION;
UPDATE StudentInf SET phone = '86-10-1234567891' WHERE id = 1;
UPDATE StudentInf SET phone = '86-10-1234567892' WHERE id = 2;
UPDATE StudentInf SET phone = '86-10-1234567893' WHERE id = 3;
UPDATE StudentInf SET phone = '86-10-1234567894' WHERE id = 4;
UPDATE StudentInf SET phone = '86-10-1234567895' WHERE id = 5;
UPDATE StudentInf SET phone = '86-10-1234567896' WHERE id = 6;
COMMIT;





















-- 使用事务, 一次性删除多条数据
BEGIN TRANSACTION;
DELETE FROM StudentInf WHERE id = 1;
DELETE FROM StudentInf WHERE id = 3;
DELETE FROM StudentInf WHERE id = 5;
COMMIT;





















-- ROLLBACK 取消处理, 放弃更改
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Yi Si', '1992-03-08', '86-10-1231567890', 'ONE');
ROLLBACK;






























-- 事务的性质ACID
-- 原子性(Atomicity), 要改全改, 要不改就全不改, 没有某些改了某些没改的情况
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 1, 'Li Si', '1992-08-08', '86-10-1234567890', 'TWO');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 3, 'Liu Si', '1991-08-08', '86-10-1234561890', 'THREE');
COMMIT;
























-- 事务的性质ACID
-- 一致性(Consistency), 事务处理必须满足列的约束, 比如 NOT NULL, 主键约束等.
BEGIN TRANSACTION;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 5, 'Qian Si', '1991-08-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 7, 'Yi Si', NULL, '86-10-1231567890', 'ONE');
COMMIT;

























-- 事务的性质ACID
-- 隔离性(Isolation), 事务之间是不能相互干扰的,
-- 在没有提交之前, 就算一个事务插入或更改某个数据, 另一个事务也不知道, 这个在并发的时候很重要
BEGIN;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 8, 'Sun Jiu' , '1991-08-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 9, 'Gao Liu', '1991-08-08', '86-10-1231567890', 'ONE');
COMMIT;

-- 如果两个事务同时进行, 在上述事务未提交前, 此事务无法知道有 id = 8 或 9 的信息, 也就无法执行删除.
BEGIN TRANSACTION;
DELETE FROM StudentInf WHERE id = 8;
DELETE FROM StudentInf WHERE id = 9;
COMMIT;












































-- 事务的性质ACID
-- 持久性(Durability)
-- 在事务结束(提交或回滚)之后, 该时间点的数据状态会被保存, 比如通过执行日志, 当发生故障, 可通过执行日志恢复到故障发生前的状态.
BEGIN;
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 8, 'Sun Jiu' , '1991-08-08', '86-10-1231567890', 'ONE');
INSERT INTO StudentInf (id, stu_name, birthday, phone, class) VALUES ( 9, 'Gao Liu', '1991-08-08', '86-10-1231567890', 'ONE');
COMMIT;
