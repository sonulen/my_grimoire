---
title: "Шпаргалка MySql"
date: 2019-02-24 16:51:33
categories: [database]
tags: [mysql]
---

MySQL представляет систему управления реляционными базами данных (СУБД). На сегодняшний день это одна из самых популярных систем управления базами данных.

Изначальным разработчиком данной СУБД была шведская компания MySQL AB. В 1995 году она выпустила первый релиз MySQL. В 2008 году компания MySQL AB была куплена компание Sun Microsystems, а в 2010 году уже компания Oracle поглотила Sun и тем самым приобрела права на торговую марку MySQL. Поэтому MySQL на сеголняшней день развивается под эгодой Oracle.

MySQL обладает кроссплатформенностью, имеются дистрибутивы под самые различные ОС, в том числе наиболее популярные версии Linux, Windows, MacOS.

# Установка

# Пример

Для примера вы можете установить базу данных бла бла:

```bash
CREATE DATABASE university;
USE university;
SOURCE <path_of_DLL.sql_file>;
SOURCE <path_of_InsertStatements.sql_file>;
```

И залогинится
```bash
mysql -u username -p
```
# Основы


## Команды для работы с базами данных

* Просмотр доступных баз данных
```sql
SHOW DATABASES;
```
* Создание новой базы данных
```sql
CREATE DATABASE;
```
* Выбор базы данных для использования
```sql
USE <database_name>;
```
* Импорт SQL-команд из файла .sql
```sql
SOURCE <path_of_.sql_file>;
```
* Удаление базы данных
```sql
DROP DATABASE <database_name>;
```

## Работа с таблицами
* Просмотр таблиц, доступных в базе данных
```sql
SHOW TABLES;
```
* Создание новой таблицы
```sql
CREATE TABLE <table_name1> (
  <col_name1> <col_type1>,
  <col_name2> <col_type2>,
  <col_name3> <col_type3>
  PRIMARY KEY (<col_name1>),
  FOREIGN KEY (<col_name2>) REFERENCES <table_name2>(<col_name2>)
);
```
  Ограничения целостности при использовании CREATE TABLE
  Может понадобиться создать ограничения для определённых столбцов в таблице. При создании таблицы можно задать следующие ограничения:

  - ячейка таблицы не может иметь значение NULL;
  - первичный ключ — PRIMARY KEY (col_name1, col_name2, …); (уникальный)
  - внешний ключ — FOREIGN KEY (col_namex1, …, col_namexn) REFERENCES table_name(col_namex1, …, col_namexn).

  Можно задать больше одного первичного ключа. В этом случае получится составной первичный ключ.

  Пример:
```sql
  CREATE TABLE instructor (
    ID CHAR(5),
    name VARCHAR(20) NOT NULL,
    dept_name VARCHAR(20),
    salary NUMERIC(8,2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
  );
  ```
* Сведения о таблице  
Можно просмотреть различные сведения (тип значений, является ключом или нет) о столбцах таблицы следующей командой:
```sql
DESCRIBE <table_name>;
```
* Добавление данных в таблицу
```sql
INSERT INTO <table_name> (<col_name1>, <col_name2>, <col_name3>, …)
  VALUES (<value1>, <value2>, <value3>, …);
```
Пример:
```sql
INSERT INTO classroom
VALUES TolmachevAA 75 3
```
При добавлении данных в каждый столбец таблицы не требуется указывать названия столбцов.
```sql
INSERT INTO <table_name>
  VALUES (<value1>, <value2>, <value3>, …);
  ```
* Обновление данных таблицы
```sql
UPDATE <table_name>
  SET <col_name1> = <value1>, <col_name2> = <value2>, ...
  WHERE <condition>;
  ```
Пример:
```sql
UPDATE classroom
SET building='Tolmachev'
WHERE building='TolmachevAA'
```
* Удаление всех данных из таблицы
```sql
DELETE FROM <table_name>;
```
* Удаление таблицы
```sql
DROP TABLE <table_name>;
```

## Команды для создания запросов
* SELECT  
SELECT используется для получения данных из определённой таблицы:
```sql
SELECT <col_name1>, <col_name2>, …
  FROM <table_name>;
```
Следующей командой можно вывести все данные из таблицы:
```sql
SELECT * FROM <table_name>;
```
* SELECT DISTINCT  
В столбцах таблицы могут содержаться повторяющиеся данные. Используйте SELECT DISTINCT для получения только неповторяющихся данных.
```sql
SELECT DISTINCT <col_name1>, <col_name2>, …
  FROM <table_name>;
```
* WHERE  
Можно использовать ключевое слово WHERE в SELECT для указания условий в запросе:
```sql
SELECT <col_name1>, <col_name2>, …
  FROM <table_name>
  WHERE <condition>;
```
В запросе можно задавать следующие условия:

  - сравнение текста;
  - сравнение численных значений;
  - логические операции AND (и), OR (или) и NOT (отрицание).  

  Пример:
  ```sql
  SELECT * from classroom where capacity >= 30;
  SELECT * FROM course WHERE dept_name=’Comp. Sci.’;
  SELECT * FROM course WHERE credits>3;
  SELECT * FROM course WHERE dept_name='Comp. Sci.' AND credits>3;
  ```

* GROUP BY  
  Оператор GROUP BY часто используется с агрегатными функциями, такими как COUNT, MAX, MIN, SUM и AVG, для группировки выходных значений.
```sql
  SELECT <col_name1>, <col_name2>, …
    FROM <table_name>
    GROUP BY <col_namex>;
```
  Пример, выведем кол-во ремонтируемых комнат каждым работником:
```sql
select building,count(room_number) from classroom group by building;
```

  ```bash  
  +-------------+--------------------+
  | building    | count(room_number) |
  +-------------+--------------------+
  | Packard     |                  1 |
  | Painter     |                  1 |
  | Taylor      |                  1 |
  | TolmachevAA |                  1 |
  | Watson      |                  2 |
  +-------------+--------------------+
  5 rows in set (0.00 sec)
  ```

* HAVING  
Ключевое слово HAVING было добавлено в SQL потому, что WHERE не может быть использовано для работы с агрегатными функциями.
```sql
SELECT <col_name1>, <col_name2>, ...
  FROM <table_name>
  GROUP BY <column_namex>
  HAVING <condition>
  ```
Пример, выведем список факультетов, у которых более одного курса:
```sql
SELECT COUNT(course_id), dept_name
  FROM course
  GROUP BY dept_name
  HAVING COUNT(course_id)>1;
```

* ORDER BY  
ORDER BY используется для сортировки результатов запроса по убыванию или возрастанию. ORDER BY отсортирует по возрастанию, если не будет указан способ сортировки ASC или DESC.
```sql
SELECT <col_name1>, <col_name2>, …
  FROM <table_name>
  ORDER BY <col_name1>, <col_name2>, … ASC|DESC;
  ```
Пример, выведем список курсов по возрастанию и убыванию количества кредитов:
```sql
SELECT * FROM course ORDER BY credits;
SELECT * FROM course ORDER BY credits DESC;
```

* BETWEEN  
BETWEEN используется для выбора значений данных из определённого промежутка. Могут быть использованы числовые и текстовые значения, а также даты.
```sql
SELECT <col_name1>, <col_name2>, …
 FROM <table_name>
 WHERE <col_namex> BETWEEN <value1> AND <value2>;
```
Пример, выведем список инструкторов, чья зарплата больше 50 000, но меньше 100 000:
```sql
SELECT * FROM instructor
 WHERE salary BETWEEN 50000 AND 100000;
```

* LIKE  
Оператор LIKE используется в WHERE, чтобы задать шаблон поиска похожего значения.

  Есть два свободных оператора, которые используются в LIKE:

    - **%** - ни одного, один или несколько символов;
    - **_** - один символ.

  ```sql
  SELECT <col_name1>, <col_name2>, …
    FROM <table_name>
    WHERE <col_namex> LIKE <pattern>;
  ```
  Пример, выведем список курсов, в имени которых содержится «to», и список курсов, название которых начинается с «CS-»:
  ```sql
  SELECT * FROM course WHERE title LIKE ‘%to%’;
  SELECT * FROM course WHERE course_id LIKE 'CS-___';
  ```

* IN  
С помощью IN можно указать несколько значений для оператора WHERE:
```sql
SELECT <col_name1>, <col_name2>, …
  FROM <table_name>
  WHERE <col_namen> IN (<value1>, <value2>, …);
  ```
Пример, выведем список студентов с направлений Comp. Sci., Physics и Elec. Eng.:
```sql
SELECT * FROM student
  WHERE dept_name IN (‘Comp. Sci.’, ‘Physics’, ‘Elec. Eng.’);
```

* JOIN  
JOIN используется для связи двух или более таблиц с помощью общих атрибутов внутри них. На изображении ниже показаны различные способы объединения в SQL.

<div style="text-align:center"><img src ="../images/posts_includes/mysql/join.jpg" /> d</div>

Обратите внимание на разницу между левым внешним объединением и правым внешним объединением:

  ```sql
  SELECT <col_name1>, <col_name2>, …
    FROM <table_name1>
    JOIN <table_name2>
    ON <table_name1.col_namex> = <table2.col_namex>;
    ```
