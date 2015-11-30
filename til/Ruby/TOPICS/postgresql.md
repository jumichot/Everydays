/* Video from Tutsplus postgresql essentials training */

Install Postgresql with homebrew :
```
  brew install postgresql
```

The installation will create a PostgreSQL database cluster needed to run pg
with this command :

```
initdb /usr/local/var/postgres/ -E utf8
```

If you look in this folder you can see a bunch of important configuration files 
like :
- postgresql.conf
- PG_VERSION

When you lunch the 'postgres' command you can pass the -D option to specify
which folder you want to use as cluster configuration

You can create your own cluster with initdb, and then use postgres command to
specify this folder
```
initdb /your/custom/folder/ -E utf8
```

2 ways to run the server :
```
postgres -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log
```
or via the pg control command
```
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

You can create a db with createdb command:
```
createdb mydbname
```

Enter into psql, by default the dbname will be your username
```
psql
```
If you want to see all available database use:
```
psql -l
```

Then you can select which database you want to login with:
```
psql -d dbname
```

To exit
```
\q
```

Now you want type command, you can get help for that with:
```
\h sql command
```
Create a table (named relation in pg) :
```
create table authors (name varchar(100));
```

Display list of tables :
```
\d
```

Detail view of table (see the type of each fields)
```
\d authors
```

Edit the command in your editor (need EDITOR variable in your bash)
```
\e
```

Add a primary key using a serial type.
Serial type: notational convenience for creating unique
identifier columns (similar to the AUTO_INCREMENT in mysql)"

Nice things : it creates the ids for the existing entries
```
 alter table authors
 add column author_id serial primary key;
 ```

 Create table with references to another with foreign key constraint
 and multiple fields;
 ```
create table tutorials (
  tutorial_id serial primary key,
  title text,
  author_id, integer references authors(author_id)
);
```

Make you first join:
```
select tutorials.title, authors.name from tutorials join authors on tutorials.author_id = authors.author_id;
```

Drop multiple table:
```
drop table authors, tutorials;
```

Insert multiple row at the same time:
```
insert into authors(name) values ('hector'), ('jeannot'), ('toto');
```

You can alter a table to add constraint on a column.
```
ju=# alter table authors add column email varchar(100) not null;
ERROR:  column "email" contains null values
```
But if you add constraint like not nul you should add a default value
```
alter table authors add column email varchar(100) not null default 'invalid@email.com;
```

Update rows on a condition with:
```
update authors set email='hector@contact.com' where name ='hector';
```

Delete rows on a condition with :
```
delete from authors where name='toto';
```

Add empty table then edit it 
```
create table tutorials();

\e

alter table tutorials
add column tutorial_id serial primary key,
add column title text,
add column author_id integer,
add constraint unique_title unique(title),
add foreign key(author_id) references authors(author_id);
```
You can check the constraint
```
Check uniqueness
ju=# insert into tutorials(title, author_id) values ('lol mon gros', 1);
ERROR:  duplicate key value violates unique constraint "unique_title"
DETAIL:  Key (title)=(lol mon gros) already exists.

Check type
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', 1df);
ERROR:  syntax error at or near "df"
LINE 1: ...o tutorials(title, author_id) values ('lol mon gros2', 1df);

Check references constraint
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', 23);
ERROR:  insert or update on table "tutorials" violates foreign key constraint "tutorials_author_id_fkey"
DETAIL:  Key (author_id)=(23) is not present in table "authors".
```

You can put null on author_id to let's change it :
```
ju=# insert into tutorials(title, author_id) values ('lol mon gros2', null);
INSERT 0 1
```
TODO : constraint on foreign key, validate presence

Update a field
```
update tutorials set author_id=3 where tutorial_id=1
```
A schema : group of table. Organizing principle for table.
View schema
```
\dS
```
View schema  lookup
```
show search_path;
```
#SCHEMA

Create a schema
```
create schema temp;
```
Create table in this schema
```
create table temp.test();
```

Modify search path
```
set search_path=public,temp;
```
Logs :
You can see after the operation you can see the table
```
ju=# create schema temp;
CREATE SCHEMA
ju=# create table temp.test(toto varchar(100));
CREATE TABLE
ju=# \d
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | authors                   | table    | ju
 public | authors_author_id_seq     | sequence | ju
 public | tutorials                 | table    | ju
 public | tutorials_tutorial_id_seq | sequence | ju
(4 rows)

ju=# set search_path=public,temp
ju-# ;
SET
ju=# show search_path
ju-# ;
 search_path
--------------
 public, temp
(1 row)

ju=# \d
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | authors                   | table    | ju
 public | authors_author_id_seq     | sequence | ju
 public | tutorials                 | table    | ju
 public | tutorials_tutorial_id_seq | sequence | ju
 temp   | test                      | table    | ju
(5 rows)
```

No nesting of schema.

Drop schema
```
drop schema temp cascade;
```

#TYPES

##NUMERIC
Create new table with some types. You can see we use the last created type publish_state, and some sexy types like
array of varchar, numeric(4,2) so values can go to 99,99.
```
create table books(
  book_id serial primary key,
  price_usd numeric(4,2),
  isbn varchar(20),
  title text,

  author_id integer references authors(author_id),
  tags varchar(30)[],

  publish_date date,
  last_updated timestamp,

  published boolean,
  state publish_state
);
```
You can't go above the limite of precision for numeric type
```
insert into books(price_usd) values(123.99);
ERROR:  numeric field overflow
DETAIL:  A field with precision 4, scale 2 must round to an absolute value less than 10^2.
```
##TAGS
Insert tags, collection of varchars
```
insert into books(title, tags) values
('Postgres Essentials', '{"sql", "video", "tuts", "database", "postgres"}');

ju=# select title, tags from books;
        title        |                tags
---------------------+------------------------------------
                     |
 Postgres Essentials | {sql,video,tuts,database,postgres}
```
You can retrieve index by slicing, 1 indexed not 0
```
ju=# select tags[1:3] from books
ju-# ;
       tags
------------------

 {sql,video,tuts}

(3 rows)
```
You can update a specific index :
```
ju=# select * from books;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date | last_updated | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+--------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    |              |              |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              |              |           |
       3 |     23.99 |      |                     |           | {a,b,c}                            |              |              |           |

ju=# update books set tags[2]='z' where book_id=3;
UPDATE 1
ju=# select * from books;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date | last_updated | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+--------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    |              |              |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              |              |           |
       3 |     23.99 |      |                     |           | {a,z,c}
```

##Date
You can pass a date in diffrent format :
2015-03-05
2015-Jan-01
03-24-2014
03/24/2013

There is a validation on the date.
You can modify the configuration for datestyle, to change the date convention
PG have built in validation for dates
```
ju=# update books set publish_date='2015-03-46' where book_id=1
;
ERROR:  date/time field value out of range: "2015-03-46"
LINE 1: update books set publish_date='2015-03-46' where book_id=1
                                      ^
HINT:  Perhaps you need a different "datestyle" setting.
```
##TIMESTAMP
You can specify an hour with pm and am
```
ju=# update books set last_updated='Apr 20 2015 03:20pm';
UPDATE 3
ju=# select * from books order by book_id;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date |    last_updated     | published | state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+---------------------+-----------+-------
       1 |     23.99 |      |                     |           |                                    | 2015-03-06   | 2015-04-20 15:20:00 |           |
       2 |           |      | Postgres Essentials |           | {sql,video,tuts,database,postgres} |              | 2015-04-20 15:20:00 |           |
       3 |     23.99 |      |                     |           | {a,z,c}                            |              | 2015-04-20 15:20:00 |           |
(3 rows)
```
PG have built in keyword for special moment like 'today', 'yesterday', 'tomorrow' or 'now'

##ENUM
Create a type, example with enum
```
create type publish_state as enum ('initial', 'approved', 'authored', 'edited','reviewd','scheduled','published');
```

You can see the datatype you created 
```
\dT+
```

```
ju=# \dT+
                                     List of data types
 Schema |     Name      | Internal name | Size | Elements  | Access privileges | Description
--------+---------------+---------------+------+-----------+-------------------+-------------
 public | publish_state | publish_state | 4    | initial  +|                   |
        |               |               |      | approved +|                   |
        |               |               |      | authored +|                   |
        |               |               |      | edited   +|                   |
        |               |               |      | reviewd  +|                   |
        |               |               |      | scheduled+|                   |
        |               |               |      | published |                   |
(1 row)

ju=# update books set state='initial';
UPDATE 3
```
PG validate you pass a value in enum
```
ju=# update books set state='initialsadf';
ERROR:  invalid input value for enum publish_state: "initialsadf"
LINE 1: update books set state='initialsadf';
```

##JSON
You can have column as json
PG validate it's a valide json format
```
ju=# insert into temp(col_json) values ('{"name":"julien", "surname": "juju"}');
```
### JSON FUNCTIONS

doc: http://www.postgresql.org/docs/9.3/static/functions-json.html

you can output results in a json way with row_to_josn
```
ju=# select row_to_json(row(title,tags)) from books;
                                  row_to_json
--------------------------------------------------------------------------------
 {"f1":"Postgres Essentials","f2":["sql","video","tuts","database","postgres"]}
 {"f1":null,"f2":["a","z","c"]}
 {"f1":null,"f2":null}
```

You can output arrays to json too:
```
ju=# select array_to_json(tags) from books;
                array_to_json
----------------------------------------------
 ["sql","video","tuts","database","postgres"]
 ["a","z","c"]
```

##XML
```
ju=# alter table temp add column col_xml xml;
```

Engine validation as expected
```
LINE 1: insert into temp(col_xml) values('<hello>world')
                                         ^
DETAIL:  line 1: Premature end of data in tag hello line 1
<hello>world
            ^
```

Xpath fonctions
```
ju=# select xpath('//world/text()', col_xml) from temp;
  xpath
----------
 {coucou}
 {coucou}
 {coucou}
 {coucou}
```

create xml element from a request
```
ju=# select xmlelement(name "Book", xmlattributes(authors.name as "Atuhor"))
from books join authors
on books.author_id = authors.author_id;
       xmlelement
-------------------------
 <Book Atuhor="hector"/>
 <Book Atuhor="hector"/>
 <Book Atuhor="hector"/>
```

You can create nested xml element
```
ju=# \e
                         xmlelement
------------------------------------------------------------
 <Book><Author>hector</Author><State>initial</State></Book>
 <Book><Author>hector</Author><State>initial</State></Book>
 <Book><Author>hector</Author><State>initial</State></Book>
```
##RANGE
Create a range, you can see by default its [) lower range is inclusive
and the upper is exclusive
```
ju=# select numrange(1,20) ;
 numrange
----------
 [1,20)
```

Check intersection
```
ju=# select numrange('[1,20]') && numrange(20,30);
 ?column?
----------
 t

ju=# select numrange('[1,20)') && numrange(20,30);
 ?column?
----------
 f
```

To see the intersection use * operator
```
ju=# select numrange('[1,20)') * numrange(10,30);
----------
 [10,20)
```
To see the union use * operator
```
ju=# select numrange('[1,20)') + numrange(10,30);
----------
 [10,20)
```

idem with -
```
ju=# select numrange('[1,20)') - numrange(10,30);
 ?column?
----------
 [1,10)
```

You can cast a string to a range with:
```
ju=# select '[3,]'::numrange;
 numrange
----------
 [3,)
```

You can make nice selection with ranges :
```
ju=# select * from books;
 book_id | price_usd | isbn |        title        | author_id |                tags                | publish_date |        last_updated        | published |  state
---------+-----------+------+---------------------+-----------+------------------------------------+--------------+----------------------------+-----------+---------
       2 |     75.21 |      | Postgres Essentials |         1 | {sql,video,tuts,database,postgres} |              | 2015-04-20 15:20:00        |           | initial
       3 |     44.82 |      |                     |         1 | {a,z,c}                            |              | 2015-04-20 15:20:00        |           | initial
       1 |     43.35 |      |                     |         1 |                                    | 2015-03-06   | 2015-03-06 10:24:39.118288 |           | initial
(3 rows)

ju=# select title, price_usd from books where '[1,50]'::numrange @> price_usd;
 title | price_usd
-------+-----------
       |     44.82
       |     43.35
(2 rows)
```
#TYPE CREATION
You can create special types
```
ju=# create type  address as (
  street text,
  state char(2),
  country varchar(50),
  postal_code varchar(10)
);
```
To insert it don't use this notation :
```
ju=# insert into temp(address) values('("some street","NY","USA","10022")');
```
But this one, you can add some spaces for readability
```
ju=# insert into temp(address) values(row('some street', 'ny', 'usa', '10022'));
```

To update some specific field in a custom type:
```
ju=# update temp set address.country='FR';
```

You can have some ambiguity address is the name of the type
and the name of the column
```
ju=# select address.country from temp;
ERROR:  missing FROM-clause entry for table "address"
LINE 1: select address.country from temp;
               ^
```

You must qualified the table name:
```
ju=# select (temp.address).country from temp;
```

You can drop types with
```
drop type address cascade
```



#OTHER
Know the max connection value :
```
select name, setting from pg_settings where name = 'max_connections';
```

reset sequence of ids for primary key for example:
```
ju=# alter sequence authors_author_id_seq restart with 1;
```
The sequence is visible here :
```
ju=# \d
                   List of relations
 Schema |           Name            |   Type   | Owner
--------+---------------------------+----------+-------
 public | authors                   | table    | ju
 public | authors_author_id_seq     | sequence | ju
 public | books                     | table    | ju
 public | books_book_id_seq         | sequence | ju
 public | temp                      | table    | ju
 public | tutorials                 | table    | ju
 public | tutorials_tutorial_id_seq | sequence | ju
(7 rows)
```

You can see a sequence :
```
ju=# \d books_book_id_seq
      Sequence "public.books_book_id_seq"
    Column     |  Type   |        Value
---------------+---------+---------------------
 sequence_name | name    | books_book_id_seq
 last_value    | bigint  | 3
 start_value   | bigint  | 1
 increment_by  | bigint  | 1
 max_value     | bigint  | 9223372036854775807
 min_value     | bigint  | 1
 cache_value   | bigint  | 1
 log_cnt       | bigint  | 30
 is_cycled     | boolean | f
 is_called     | boolean | t
Owned by: public.books.book_id
```

Import a csv file
```
ju=# copy authors(name,email) from '/Users/ju/Inbox/authors.csv' delimiter '|' csv header;
```


#SELECT COMMAND
```
select authors.name as "auteur", books.title as "titre du livre"  
from authors join books on authors.author_id = books.author_id order by authors.name;

select a.name,count(t.tutorial_id) as count
from authors a join tutorials t
on a.author_id = t.author_id
group by a.name
order by count
limit 3;

select * from (values (1,3,3),(2,3,44)) as numbers(a,b,c);

select 5/2.0;
```

#SUBQUERY
(missing last command)
```
-- books authors
select a.author_id, a.name
from authors a join books b on a.author_id = b.author_id;

-- tutorials authors
select distinct a.author_id, a.name
from authors a join tutorials t on a.author_id = t.author_id
order by a.author_id;
```

#TEMPORARY TABLE
Have lifetime of a session
```
-- select authors who have tutorials and books via temporary table
create	temporary table tutorials_authors as
select distinct a.author_id, a.name as author_name
from authors a join tutorials  t on a.author_id=t.author_id;

select t.author_id, t.author_name from tutorials_authors t
join books on books.author_id=t.author_id
```
if you launch the last query again it will fail saying
table already exist.

#CTE (COMMON TABLE EXPRESSION)
Last for the duration of the query

```
with tutorial_authors as (
select distinct a.author_id, a.name as author_name
from authors a join tutorials t on a.author_id=t.author_id
)

select t.author_id, t.author_name from tutorial_authors t
join books on books.author_id=t.author_id;
```
If you try to select something the cte it will print an error

#TABLE FUNCTION
```
-- function signature
-- you can pass parameter
-- usefull to build complex queries
CREATE or replace function tutorial_authors(INT) returns table(author_id INT, author_name TEXT)
as $$
select distinct a.author_id, a.name from authors a join tutorials t on a.author_id=t.author_id
limit $1
$$ language sql;

select * from tutorial_authors(5);

drop function tutorial_authors(INT);
```

#VIEWS
```
create or replace view tutorial_authors(author_id, author_name)
as
select distinct a.author_id, a.name from authors a join tutorials t on
a.author_id=t.author_id;

select * from tutorial_authors;
drop view tutorial_authors;
```

#HSTORE
Install hstore
```
create extension hstore;
```

Add column to a table
```
alter table books
add column sales hstore;
```

```
update books set sales='total_sales=> 12343, peak_sales=>4344, peak_sale_date=>"12/23/2013"' where book_id=13;

ju=# select sales from books where book_id=13;
 
                                    sales
------------------------------------------------------------------------------
 "peak_sales"=>"4344", "total_sales"=>"12343", "peak_sale_date"=>"12/23/2013"

```

Access specific value
```
select sales->'peak_sales' from books where book_id=13; 
```
You can cast specific fields, here in a date
```
select DATE(sales->'peak_sale_date') from books where book_id=13; 
```
concatenate htore
```
select 'a=> 12, b=>13'::hstore || 'c=>14'::hstore
```
get keys
```
select akeys('a=> 12, b=>13'::hstore || 'c=>14'::hstore)
```
get values
```
select avals('a=> 12, b=>13'::hstore || 'c=>14'::hstore)
```

- operator
```
select 'a=> 12, b=>13'::hstore - 'c=>14'
select 'a=> 12, b=>13'::hstore - 'c=>14'::text
select 'a=> 12, b=>13'::hstore - 'c=>14'::hstore
```

add random value for a key
```
update books set sales=sales || hstore('total_sales', round((random() * 100000))::TEXT);
select sales from books;
```
Run some stats for keys
```
update books set sales=sales || hstore('peak_sales', round((random() * 100000))::TEXT);
select sum((sales->'peak_sales')::INT) from books;
```

#TROUBLESHOUTING

If error with psql (psql: FATAL:  database "user" does not exist), it's you don't
have any db yet, create one with :
```
createdb
```
