create table table_1 (user_id INT, name VARCHAR(50),age INT, salary INT, PRIMARY KEY (user_id));
insert into table_1 values (1, 'John', 23, 400);
insert into table_1 values (2, 'Mary', 20,450);
insert into table_1 values (3, 'Max', 29,1200);
insert into table_1 values (4, 'Felix', 218,350);
insert into table_1 values (5, 'Groover', 22,570);
insert into table_1 values (6, 'Ben', 19,620);
select name from table_1 where user_id = 6;
select name from table_1 where salary>=500;
insert into table_1 values (7,'Denis',23,600);
delete from table_1 where user_id=7;
select nsme from table_1 where salary>=500 and salary<=1000
