# Порядок действий

1. sudo yum install postgresql-server
2. sudo postgresql-setup initdb
3. sudo systemctl enable postgresql
4. sudo systemctl start postgresql
5. sudo passwd postgres
6. su - postgres
7. psql
8. create user db0 with password '132435';
9. create database db0;
10. grant all privileges on database db0 to db0;

    Выхожу: \q

11. ps aux | grep postgres | grep -- -D (узнаем где лежат конфиги)
12. nano /var/lib/pgsql/data/postgresql.conf

    там ищу через ctrl + w текст **listen** и меняю на:

```bash
  listen_addresses = '*'
```

13. nano /var/lib/pgsql/pg_hba.conf и там:

```bash
  # IPv4 local connections:
  host all all 127.0.0.1/32 md5
  # IPv6 local connections:
  host all all ::1/128 md5
```

14. echo localhost:*:db0:db0:132435 >> .pgpass

15. chmod 0600 .pgpass

16. Захожу в рута. Перезапускаю: service postgresql restart

17. psql -h localhost db0 db0

18. Создаю таблицы:

```sql
  db0=> CREATE TABLE table0
  db0-> ( id INTEGER primary key,
  db0(> entity varchar(256));
  NOTICE:  CREATE TABLE / PRIMARY KEY will create implicit index "table0_pkey" for table "table0"
  CREATE TABLE
  db0=> CREATE TABLE table1
  db0-> ( id INTEGER primary key,
  db0(> entity_id int references table0 (id), property varchar(256));
  NOTICE:  CREATE TABLE / PRIMARY KEY will create implicit index "table1_pkey" for table "table1"
  CREATE TABLE
```
19. Заполняю таблицы
```sql
  db0=> insert into table0
  values (1234, 'Formosa tea');
  INSERT 0 1
  db0=> insert into table0
  values (2345, 'White tea');
  INSERT 0 1
  db0=> insert into table1
  values (1, 2345, 'Shou mei');
  INSERT 0 1
  db0=> insert into table1
  values (2, 2345, 'Bai mudan');
  INSERT 0 1
  db0=> insert into table1
  values (3, 1234, 'Dongding');
  INSERT 0 1
  db0=> insert into table1
  values (4, 1234, 'Alishan Gaaba');
  INSERT 0 1
```
20. Выхожу с бд: ```\q```

21. Выхожу с рута: ```exit```

22. От своего юзера выполняю:
```bash
  psql -h localhost -U db0 -d db0 -c 'select table0.entity as e,
  table1.property as p from table0 join table1 on table0.id =
  table1.entity_id;' >> ~/postgres_task_result
```
23. И вот что в файле:
```bash
  [user19@s-19 ~]$ cat postgres_task_result
        e       |     p
  --------------+---------------
  Formosa tea   | Alishan Gaaba
  Formosa tea   | Dongding
  White tea     | Bai mudan
  White tea     | Shou mei
  (4 rows)
```
