



-- 有些数据库应用需要使用SQL语言建立数据库
CREATE DATABASE student.db;

-- sqlite的建立或打开数据库方式: .open student.db 注意这里没有 ';'





































-- 创建表
-- 注意, 数据库名, 表名, 列名, 可使用半角英文字母, 半角数字, 以及下划线 '_'
CREATE TABLE studentInf(
    id          INTEGER,                    -- INTEGER 是整型数据
    stu_name    VARCHAR(32)     NOT NULL,   -- VARCHAR 是可变长度字符串, NOT NULL 约束列不可以是空
    birthday    DATE            NOT NULL,   -- DATE 是日期
    phone       CHAR(16),                   -- CHAR 是定长字符串
    PRIMARY KEY(id)                         -- PRIMARY KEY(id) 是设置 id 为主键, 主键内容不可重复, 必须唯一
);





















-- 更改表
-- 增加列
ALTER TABLE studentInf ADD COLUMN class CHAR(8);






-- 删除列
ALTER TABLE studentInf DROP COLUMN class;















-- 删除表
DROP TABLE studentInf;