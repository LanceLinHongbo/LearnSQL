# sqlite的建立数据库方式: .open Learn_01.db 注意这里没有 ';'
;

# 有些数据库应用需要使用SQL语言建立数据库
CREATE DATABASE Learn_01.db;

# 创建表, 只有一列, 列名为 id, 设置为主键
CREATE TABLE test(id integer, PRIMARY KEY(id));