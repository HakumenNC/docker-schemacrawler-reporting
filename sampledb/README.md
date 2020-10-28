# Sample database

[![docker](https://github.com/HakumenNC/logo-gallery/raw/main/img/docker/docker.png)](https://www.docker.com "Docker")
[![dockercompose](https://github.com/HakumenNC/logo-gallery/raw/main/img/docker-compose/docker-compose.png)](https://docs.docker.com/compose "Docker compose")
[![postgresql](https://github.com/HakumenNC/logo-gallery/raw/main/img/database/postgresql/postgresql.png)](https://www.postgresql.org/ "Postgresql")

## :speech_balloon: Description

No database on hand? It's ok, just create it one!

## :books: Prerequisites

See the main `README.md`

## :rocket: How to use

### Database

The SQL scripts come from [sqltutorial.org](https://www.sqltutorial.org/sql-sample-database/).

* Create and launch the database, we using [Postgres](https://hub.docker.com/_/postgres) docker image.

```sh
docker-compose -f postgres.yml up -d
```

* Check connection 

```sh
docker run --name postgres-psql -it --rm --network host postgres psql -h localhost -p 5432 -U user
```

```sh
$ docker run --name postgres-psql -it --rm --network host postgres psql -h localhost -p 5432 -U user -d db
Password for user user: 
psql (13.0 (Debian 13.0-1.pgdg100+1))
Type "help" for help.

db=#
```

```sh
SELECT * FROM employees LIMIT 5;
```

```sh
db=# SELECT * FROM employees LIMIT 5;
 employee_id | first_name | last_name |              email               | phone_number | hire_date  | job_id |  salary  | manager_id | department_id 
-------------+------------+-----------+----------------------------------+--------------+------------+--------+----------+------------+---------------
         100 | Steven     | King      | steven.king@sqltutorial.org      | 515.123.4567 | 1987-06-17 |      4 | 24000.00 |            |             9
         101 | Neena      | Kochhar   | neena.kochhar@sqltutorial.org    | 515.123.4568 | 1989-09-21 |      5 | 17000.00 |        100 |             9
         102 | Lex        | De Haan   | lex.de haan@sqltutorial.org      | 515.123.4569 | 1993-01-13 |      5 | 17000.00 |        100 |             9
         103 | Alexander  | Hunold    | alexander.hunold@sqltutorial.org | 590.423.4567 | 1990-01-03 |      9 |  9000.00 |        102 |             6
         104 | Bruce      | Ernst     | bruce.ernst@sqltutorial.org      | 590.423.4568 | 1991-05-21 |      9 |  6000.00 |        103 |             6
(5 rows)

db=#
```

Easy, don't you?

### GDRP informations

*Coming soon...* :wink: