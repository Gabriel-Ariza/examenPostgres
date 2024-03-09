-- Active: 1709946878197@@127.0.0.1@5432@hola@public


-- 1. Consultas sobre una tabla --

Select * from pedido ORDER BY fecha asc;

 id |  total  |   fecha    | id_cliente | id_comercial
----+---------+------------+------------+--------------
 10 |  250.45 | 2015-06-27 |          8 |            2
  7 |    5760 | 2015-09-10 |          2 |            1
  6 |  2400.6 | 2016-07-27 |          7 |            1
 11 |   75.29 | 2016-08-17 |          3 |            7
  4 |   110.5 | 2016-08-17 |          8 |            3
  2 |  270.65 | 2016-09-10 |          1 |            5
  9 |  2480.4 | 2016-10-10 |          8 |            3
 14 |  145.82 | 2017-02-02 |          6 |            1
 12 |  3045.6 | 2017-04-25 |          2 |            1
  5 |   948.5 | 2017-09-10 |          5 |            2
  1 |   150.5 | 2017-10-05 |          5 |            2
  3 |   65.26 | 2017-10-05 |          2 |            1
  8 | 1983.43 | 2017-10-10 |          4 |            6
 13 |  545.75 | 2019-01-25 |          6 |            1
 15 |  370.85 | 2019-03-11 |          1 |            5
 16 | 2389.23 | 2019-03-11 |          1 |            5
(16 filas)


Select * from pedido
order by total  desc LIMIT 2;

 id | total  |   fecha    | id_cliente | id_comercial
----+--------+------------+------------+--------------
  7 |   5760 | 2015-09-10 |          2 |            1
 12 | 3045.6 | 2017-04-25 |          2 |            1


SELECT DISTINCT c.id, c.nombre, c.apellido1 from cliente c
join pedido p on c.id = p.id_cliente;

 id | nombre | apellido1
----+--------+-----------
  2 | Adela  | Salas
  3 | Adolfo | Rubio
  7 | Pilar  | Ruiz
  8 | Pepe   | Ruiz
  1 | Aar≤n  | Rivero
  6 | Marφa  | Santana
  4 | Adrißn | Sußrez
  5 | Marcos | Loyola


SELECT * FROM pedido
WHERE EXTRACT(YEAR FROM fecha) = 2017
AND total > 500;

 id |  total  |   fecha    | id_cliente | id_comercial
----+---------+------------+------------+--------------
  5 |   948.5 | 2017-09-10 |          5 |            2
  8 | 1983.43 | 2017-10-10 |          4 |            6
 12 |  3045.6 | 2017-04-25 |          2 |            1


SELECT nombre,apellido1,apellido2 FROM comercial
where comisión > 0.05
and comisión < 0.11;

  +---------+-----------+-----------+
  | nombre  | apellido1 | apellido2 |
  +---------+-----------+-----------+
  | Diego   | Flores    | Salas     |
  | Antonio | Vega      | Hernández |
  | Alfredo | Ruiz      | Flores    |
  +---------+-----------+-----------+


SELECT comisión FROM comercial
ORDER BY comisión DESC LIMIT 1

  +----------+
  | comisión |
  +----------+
  |     0.15 |
  +----------+


SELECT id,nombre,apellido1 from cliente
where apellido2 is null
ORDER BY apellido1, nombre ASC;

 id | nombre | apellido1
----+--------+-----------
  7 | Pilar  | Ruiz
  4 | Adrißn | Sußrez


SELECT nombre from cliente where nombre LIKE 'A%N'
ORDER BY nombre ASC;

  +--------+
  | nombre |
  +--------+
  | Aarón  |
  | Adrián |
  +--------+


SELECT nombre from cliente where nombre not LIKE 'A%'
ORDER BY nombre ASC;

  +-----------+
  | nombre    |
  +-----------+
  | Daniel    |
  | Guillermo |
  | Marcos    |
  | María     |
  | Pepe      |
  | Pilar     |
  +-----------+


SELECT DISTINCT nombre from comercial where nombre LIKE '%EL'
OR nombre LIKE '%o' ORDER BY nombre ASC;

  +---------+
  | nombre  |
  +---------+
  | Alfredo |
  | Antonio |
  | Daniel  |
  | Diego   |
  | Manuel  |
  +---------+





-- 2. Composicion multitabla 

SELECT DISTINCT cliente.id, nombre, apellido1, apellido2 from cliente 
join pedido on cliente.id = pedido.id_cliente
ORDER BY cliente.nombre ASC;

  +----+--------+-----------+-----------+
  | id | nombre | apellido1 | apellido2 |
  +----+--------+-----------+-----------+
  |  1 | Aarón  | Rivero    | Gómez     |
  |  2 | Adela  | Salas     | Díaz      |
  |  3 | Adolfo | Rubio     | Flores    |
  |  4 | Adrián | Suárez    | NULL      |
  |  5 | Marcos | Loyola    | Méndez    |
  |  6 | María  | Santana   | Moreno    |
  |  8 | Pepe   | Ruiz      | Santana   |
  |  7 | Pilar  | Ruiz      | NULL      |
  +----+--------+-----------+-----------+


SELECT DISTINCT * from pedido
join cliente on pedido.id_cliente = cliente.id
ORDER BY cliente.nombre ASC;

  +----+---------+------------+------------+--------------+----+--------+-----------+-----------+---------+-----------+
  | id | total   | fecha      | id_cliente | id_comercial | id | nombre | apellido1 | apellido2 | ciudad  | categoría |
  +----+---------+------------+------------+--------------+----+--------+-----------+-----------+---------+-----------+
  |  2 |  270.65 | 2016-09-10 |          1 |            5 |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 |
  | 15 |  370.85 | 2019-03-11 |          1 |            5 |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 |
  | 16 | 2389.23 | 2019-03-11 |          1 |            5 |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 |
  |  3 |   65.26 | 2017-10-05 |          2 |            1 |  2 | Adela  | Salas     | Díaz      | Granada |       200 |
  |  7 |    5760 | 2015-09-10 |          2 |            1 |  2 | Adela  | Salas     | Díaz      | Granada |       200 |
  | 12 |  3045.6 | 2017-04-25 |          2 |            1 |  2 | Adela  | Salas     | Díaz      | Granada |       200 |
  | 11 |   75.29 | 2016-08-17 |          3 |            7 |  3 | Adolfo | Rubio     | Flores    | Sevilla |      NULL |
  |  8 | 1983.43 | 2017-10-10 |          4 |            6 |  4 | Adrián | Suárez    | NULL      | Jaén    |       300 |
  |  1 |   150.5 | 2017-10-05 |          5 |            2 |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |
  |  5 |   948.5 | 2017-09-10 |          5 |            2 |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |
  | 13 |  545.75 | 2019-01-25 |          6 |            1 |  6 | María  | Santana   | Moreno    | Cádiz   |       100 |
  | 14 |  145.82 | 2017-02-02 |          6 |            1 |  6 | María  | Santana   | Moreno    | Cádiz   |       100 |
  |  4 |   110.5 | 2016-08-17 |          8 |            3 |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 |
  |  9 |  2480.4 | 2016-10-10 |          8 |            3 |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 |
  | 10 |  250.45 | 2015-06-27 |          8 |            2 |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 |
  |  6 |  2400.6 | 2016-07-27 |          7 |            1 |  7 | Pilar  | Ruiz      | NULL      | Sevilla |       300 |
  +----+---------+------------+------------+--------------+----+--------+-----------+-----------+---------+-----------+


SELECT DISTINCT * from pedido
join comercial on pedido.id_comercial = comercial.id
ORDER BY comercial.nombre ASC;

  +----+---------+------------+------------+--------------+----+---------+-----------+-----------+----------+
  |  2 |  270.65 | 2016-09-10 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  | 11 |   75.29 | 2016-08-17 |          3 |            7 |  7 | Antonio | Vega      | Hernández |     0.11 |
  | 15 |  370.85 | 2019-03-11 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  | 16 | 2389.23 | 2019-03-11 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  |  3 |   65.26 | 2017-10-05 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  6 |  2400.6 | 2016-07-27 |          7 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  7 |    5760 | 2015-09-10 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  | 12 |  3045.6 | 2017-04-25 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  | 13 |  545.75 | 2019-01-25 |          6 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  | 14 |  145.82 | 2017-02-02 |          6 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  4 |   110.5 | 2016-08-17 |          8 |            3 |  3 | Diego   | Flores    | Salas     |     0.11 |
  |  9 |  2480.4 | 2016-10-10 |          8 |            3 |  3 | Diego   | Flores    | Salas     |     0.11 |
  |  1 |   150.5 | 2017-10-05 |          5 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  |  5 |   948.5 | 2017-09-10 |          5 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  | 10 |  250.45 | 2015-06-27 |          8 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  |  8 | 1983.43 | 2017-10-10 |          4 |            6 |  6 | Manuel  | Domínguez | Hernández |     0.13 |
  +----+---------+------------+------------+--------------+----+---------+-----------+-----------+----------+


SELECT DISTINCT * from cliente
join pedido on cliente.id = pedido.id_cliente
join comercial on pedido.id_comercial = comercial.id;

  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+----+---------+-----------+-----------+----------+
  | id | nombre | apellido1 | apellido2 | ciudad  | categoría | id | total   | fecha      | id_cliente | id_comercial | id | nombre  | apellido1 | apellido2 | comisión |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+----+---------+-----------+-----------+----------+
  |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |  1 |   150.5 | 2017-10-05 |          5 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 |  2 |  270.65 | 2016-09-10 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 |  3 |   65.26 | 2017-10-05 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 |  4 |   110.5 | 2016-08-17 |          8 |            3 |  3 | Diego   | Flores    | Salas     |     0.11 |
  |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |  5 |   948.5 | 2017-09-10 |          5 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  |  7 | Pilar  | Ruiz      | NULL      | Sevilla |       300 |  6 |  2400.6 | 2016-07-27 |          7 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 |  7 |    5760 | 2015-09-10 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  4 | Adrián | Suárez    | NULL      | Jaén    |       300 |  8 | 1983.43 | 2017-10-10 |          4 |            6 |  6 | Manuel  | Domínguez | Hernández |     0.13 |
  |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 |  9 |  2480.4 | 2016-10-10 |          8 |            3 |  3 | Diego   | Flores    | Salas     |     0.11 |
  |  8 | Pepe   | Ruiz      | Santana   | Huelva  |       200 | 10 |  250.45 | 2015-06-27 |          8 |            2 |  2 | Juan    | Gómez     | López     |     0.13 |
  |  3 | Adolfo | Rubio     | Flores    | Sevilla |      NULL | 11 |   75.29 | 2016-08-17 |          3 |            7 |  7 | Antonio | Vega      | Hernández |     0.11 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 | 12 |  3045.6 | 2017-04-25 |          2 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  6 | María  | Santana   | Moreno    | Cádiz   |       100 | 13 |  545.75 | 2019-01-25 |          6 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  6 | María  | Santana   | Moreno    | Cádiz   |       100 | 14 |  145.82 | 2017-02-02 |          6 |            1 |  1 | Daniel  | Sáez      | Vega      |     0.15 |
  |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 | 15 |  370.85 | 2019-03-11 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 | 16 | 2389.23 | 2019-03-11 |          1 |            5 |  5 | Antonio | Carretero | Ortega    |     0.12 |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+----+---------+-----------+-----------+----------+


SELECT DISTINCT * from cliente
join pedido on cliente.id = pedido.id_cliente
where YEAR(fecha) = 2017;

  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+
  | id | nombre | apellido1 | apellido2 | ciudad  | categoría | id | total   | fecha      | id_cliente | id_comercial |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+
  |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |  1 |   150.5 | 2017-10-05 |          5 |            2 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 |  3 |   65.26 | 2017-10-05 |          2 |            1 |
  |  5 | Marcos | Loyola    | Méndez    | Almería |       200 |  5 |   948.5 | 2017-09-10 |          5 |            2 |
  |  4 | Adrián | Suárez    | NULL      | Jaén    |       300 |  8 | 1983.43 | 2017-10-10 |          4 |            6 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 | 12 |  3045.6 | 2017-04-25 |          2 |            1 |
  |  6 | María  | Santana   | Moreno    | Cádiz   |       100 | 14 |  145.82 | 2017-02-02 |          6 |            1 |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+


SELECT DISTINCT c.nombre, c.apellido1, c.apellido2 from comercial c
join pedido on c.id = pedido.id_comercial
join cliente on pedido.id_cliente = cliente.id
where cliente.id = '6';

  +--------+-----------+-----------+
  | nombre | apellido1 | apellido2 |
  +--------+-----------+-----------+
  | Daniel | Sáez      | Vega      |
  +--------+-----------+-----------+


SELECT DISTINCT cliente.nombre from cliente
join pedido on cliente.id = pedido.id_cliente
join comercial c on pedido.id_comercial where c.id = 1;

  +--------+
  | nombre |
  +--------+
  | Marcos |
  | Aarón  |
  | Adela  |
  | Pepe   |
  | Pilar  |
  | Adrián |
  | Adolfo |
  | María  |
  +--------+





-- 3. Consultas multitabla (Composición externa) --

SELECT * FROM cliente c
LEFT JOIN pedido ON c.id = pedido.id_cliente

 id |  nombre   | apellido1 | apellido2 | ciudad  | categorφa | id |  total  |   fecha    | id_cliente | id_comercial
----+-----------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------
  5 | Marcos    | Loyola    | MΘndez    | Almerφa |       200 |  1 |   150.5 | 2017-10-05 |          5 |            2
  1 | Aar≤n     | Rivero    | G≤mez     | Almerφa |       100 |  2 |  270.65 | 2016-09-10 |          1 |            5
  2 | Adela     | Salas     | Dφaz      | Granada |       200 |  3 |   65.26 | 2017-10-05 |          2 |            1
  8 | Pepe      | Ruiz      | Santana   | Huelva  |       200 |  4 |   110.5 | 2016-08-17 |          8 |            3
  5 | Marcos    | Loyola    | MΘndez    | Almerφa |       200 |  5 |   948.5 | 2017-09-10 |          5 |            2
  7 | Pilar     | Ruiz      |           | Sevilla |       300 |  6 |  2400.6 | 2016-07-27 |          7 |            1
  2 | Adela     | Salas     | Dφaz      | Granada |       200 |  7 |    5760 | 2015-09-10 |          2 |            1
  4 | Adrißn    | Sußrez    |           | JaΘn    |       300 |  8 | 1983.43 | 2017-10-10 |          4 |            6
  8 | Pepe      | Ruiz      | Santana   | Huelva  |       200 |  9 |  2480.4 | 2016-10-10 |          8 |            3
  8 | Pepe      | Ruiz      | Santana   | Huelva  |       200 | 10 |  250.45 | 2015-06-27 |          8 |            2
  3 | Adolfo    | Rubio     | Flores    | Sevilla |           | 11 |   75.29 | 2016-08-17 |          3 |            7
  2 | Adela     | Salas     | Dφaz      | Granada |       200 | 12 |  3045.6 | 2017-04-25 |          2 |            1
  6 | Marφa     | Santana   | Moreno    | Cßdiz   |       100 | 13 |  545.75 | 2019-01-25 |          6 |            1
  6 | Marφa     | Santana   | Moreno    | Cßdiz   |       100 | 14 |  145.82 | 2017-02-02 |          6 |            1
  1 | Aar≤n     | Rivero    | G≤mez     | Almerφa |       100 | 15 |  370.85 | 2019-03-11 |          1 |            5
  1 | Aar≤n     | Rivero    | G≤mez     | Almerφa |       100 | 16 | 2389.23 | 2019-03-11 |          1 |            5
 10 | Daniel    | Santana   | Loyola    | Sevilla |       125 |    |         |            |            |
  9 | Guillermo | L≤pez     | G≤mez     | Granada |       225 |    |         |            |            |


SELECT * FROM comercial
left join pedido on comercial.id = pedido.id_comercial

  +----+---------+-----------+-----------+----------+------+---------+------------+------------+--------------+
  | id | nombre  | apellido1 | apellido2 | comisión | id   | total   | fecha      | id_cliente | id_comercial |
  +----+---------+-----------+-----------+----------+------+---------+------------+------------+--------------+
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |    3 |   65.26 | 2017-10-05 |          2 |            1 |
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |    6 |  2400.6 | 2016-07-27 |          7 |            1 |
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |    7 |    5760 | 2015-09-10 |          2 |            1 |
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |   12 |  3045.6 | 2017-04-25 |          2 |            1 |
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |   13 |  545.75 | 2019-01-25 |          6 |            1 |
  |  1 | Daniel  | Sáez      | Vega      |     0.15 |   14 |  145.82 | 2017-02-02 |          6 |            1 |
  |  2 | Juan    | Gómez     | López     |     0.13 |    1 |   150.5 | 2017-10-05 |          5 |            2 |
  |  2 | Juan    | Gómez     | López     |     0.13 |    5 |   948.5 | 2017-09-10 |          5 |            2 |
  |  2 | Juan    | Gómez     | López     |     0.13 |   10 |  250.45 | 2015-06-27 |          8 |            2 |
  |  3 | Diego   | Flores    | Salas     |     0.11 |    4 |   110.5 | 2016-08-17 |          8 |            3 |
  |  3 | Diego   | Flores    | Salas     |     0.11 |    9 |  2480.4 | 2016-10-10 |          8 |            3 |
  |  4 | Marta   | Herrera   | Gil       |     0.14 | NULL |    NULL | NULL       |       NULL |         NULL |
  |  5 | Antonio | Carretero | Ortega    |     0.12 |    2 |  270.65 | 2016-09-10 |          1 |            5 |
  |  5 | Antonio | Carretero | Ortega    |     0.12 |   15 |  370.85 | 2019-03-11 |          1 |            5 |
  |  5 | Antonio | Carretero | Ortega    |     0.12 |   16 | 2389.23 | 2019-03-11 |          1 |            5 |
  |  6 | Manuel  | Domínguez | Hernández |     0.13 |    8 | 1983.43 | 2017-10-10 |          4 |            6 |
  |  7 | Antonio | Vega      | Hernández |     0.11 |   11 |   75.29 | 2016-08-17 |          3 |            7 |
  |  8 | Alfredo | Ruiz      | Flores    |     0.05 | NULL |    NULL | NULL       |       NULL |         NULL |
  +----+---------+-----------+-----------+----------+------+---------+------------+------------+--------------+


SELECT * FROM cliente
LEFT join pedido on cliente.id = pedido.id_cliente
where pedido.id IS NULL;

  +----+-----------+-----------+-----------+---------+-----------+------+-------+-------+------------+--------------+
  | id | nombre    | apellido1 | apellido2 | ciudad  | categoría | id   | total | fecha | id_cliente | id_comercial |
  +----+-----------+-----------+-----------+---------+-----------+------+-------+-------+------------+--------------+
  |  9 | Guillermo | López     | Gómez     | Granada |       225 | NULL |  NULL | NULL  |       NULL |         NULL |
  | 10 | Daniel    | Santana   | Loyola    | Sevilla |       125 | NULL |  NULL | NULL  |       NULL |         NULL |
  +----+-----------+-----------+-----------+---------+-----------+------+-------+-------+------------+--------------+


SELECT * FROM comercial
left join pedido on comercial.id = pedido.id_comercial
where pedido.id IS NULL;

  +----+---------+-----------+-----------+----------+------+-------+-------+------------+--------------+
  | id | nombre  | apellido1 | apellido2 | comisión | id   | total | fecha | id_cliente | id_comercial |
  +----+---------+-----------+-----------+----------+------+-------+-------+------------+--------------+
  |  4 | Marta   | Herrera   | Gil       |     0.14 | NULL |  NULL | NULL  |       NULL |         NULL |
  |  8 | Alfredo | Ruiz      | Flores    |     0.05 | NULL |  NULL | NULL  |       NULL |         NULL |
  +----+---------+-----------+-----------+----------+------+-------+-------+------------+--------------+


SELECT'Cliente' AS tipo, nombre, apellido1, apellido2 FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
WHERE pedido.id IS NULL
UNION
SELECT 'Comercial' AS tipo, nombre, apellido1, apellido2
FROM comercial
LEFT JOIN pedido ON comercial.id = pedido.id_comercial
WHERE pedido.id IS NULL;

  +-----------+-----------+-----------+-----------+
  | tipo      | nombre    | apellido1 | apellido2 |
  +-----------+-----------+-----------+-----------+
  | Cliente   | Guillermo | López     | Gómez     |
  | Cliente   | Daniel    | Santana   | Loyola    |
  | Comercial | Marta     | Herrera   | Gil       |
  | Comercial | Alfredo   | Ruiz      | Flores    |
  +-----------+-----------+-----------+-----------+


-- SEXTA CONSULTA: no se puede realizar debido a que no coinciden los nombres
-- de las columnas en ambas tablas. Se debería cambiar el nombre de la columna





-- 4. Consultas resumen --

SELECT SUM(total) AS total_pedidos
FROM pedido;

  +--------------------+
  | total_pedidos      |
  +--------------------+
  | 20992.829999999998 |
  +--------------------+


SELECT AVG(total) AS media_pedidos
FROM pedido;

  +--------------------+
  | media_pedidos      |
  +--------------------+
  | 1312.0518749999999 |
  +--------------------+


SELECT DISTINCT COUNT(comercial.id) as total from comercial
join pedido on comercial.id = pedido.id_comercial;

  +-------+
  | total |
  +-------+
  |    16 |
  +-------+


SELECT DISTINCT COUNT(cliente.id) as total from cliente;

  +-------+
  | total |
  +-------+
  |    10 |
  +-------+


SELECT * from pedido
order by total DESC LIMIT 1;

  +----+-------+------------+------------+--------------+
  | id | total | fecha      | id_cliente | id_comercial |
  +----+-------+------------+------------+--------------+
  |  7 |  5760 | 2015-09-10 |          2 |            1 |
  +----+-------+------------+------------+--------------+


SELECT * from pedido
order by total ASC LIMIT 1;

  +----+-------+------------+------------+--------------+
  | id | total | fecha      | id_cliente | id_comercial |
  +----+-------+------------+------------+--------------+
  |  3 | 65.26 | 2017-10-05 |          2 |            1 |
  +----+-------+------------+------------+--------------+


SELECT * FROM cliente
order by categoría DESC LIMIT 1;

  +----+--------+-----------+-----------+--------+-----------+
  | id | nombre | apellido1 | apellido2 | ciudad | categoría |
  +----+--------+-----------+-----------+--------+-----------+
  |  4 | Adrián | Suárez    | NULL      | Jaén   |       300 |
  +----+--------+-----------+-----------+--------+-----------+


SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2, p.fecha,
  MAX(p.total) AS maxvalorpedido
FROM cliente c
  JOIN pedido p ON c.id = p.id_cliente 
  GROUP BY c.id, c.nombre, c.apellido1, c.apellido2, p.fecha
  ORDER BY fecha ASC;

  +----+--------+-----------+-----------+------------+----------------+
  | id | nombre | apellido1 | apellido2 | fecha      | maxvalorpedido |
  +----+--------+-----------+-----------+------------+----------------+
  |  8 | Pepe   | Ruiz      | Santana   | 2015-06-27 |         250.45 |
  |  2 | Adela  | Salas     | Díaz      | 2015-09-10 |           5760 |
  |  7 | Pilar  | Ruiz      | NULL      | 2016-07-27 |         2400.6 |
  |  8 | Pepe   | Ruiz      | Santana   | 2016-08-17 |          110.5 |
  |  3 | Adolfo | Rubio     | Flores    | 2016-08-17 |          75.29 |
  |  1 | Aarón  | Rivero    | Gómez     | 2016-09-10 |         270.65 |
  |  8 | Pepe   | Ruiz      | Santana   | 2016-10-10 |         2480.4 |
  |  6 | María  | Santana   | Moreno    | 2017-02-02 |         145.82 |
  |  2 | Adela  | Salas     | Díaz      | 2017-04-25 |         3045.6 |
  |  5 | Marcos | Loyola    | Méndez    | 2017-09-10 |          948.5 |
  |  5 | Marcos | Loyola    | Méndez    | 2017-10-05 |          150.5 |
  |  2 | Adela  | Salas     | Díaz      | 2017-10-05 |          65.26 |
  |  4 | Adrián | Suárez    | NULL      | 2017-10-10 |        1983.43 |
  |  6 | María  | Santana   | Moreno    | 2019-01-25 |         545.75 |
  |  1 | Aarón  | Rivero    | Gómez     | 2019-03-11 |        2389.23 |
  +----+--------+-----------+-----------+------------+----------------+


SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2, p.fecha,
  MAX(p.total) AS maxvalorpedido
FROM cliente c
  JOIN pedido p ON c.id = p.id_cliente 
  WHERE total > '2000'
  GROUP BY c.id, c.nombre, c.apellido1, c.apellido2, p.fecha
  ORDER BY fecha ASC ;

  +----+--------+-----------+-----------+------------+----------------+
  | id | nombre | apellido1 | apellido2 | fecha      | maxvalorpedido |
  +----+--------+-----------+-----------+------------+----------------+
  |  2 | Adela  | Salas     | Díaz      | 2015-09-10 |           5760 |
  |  7 | Pilar  | Ruiz      | NULL      | 2016-07-27 |         2400.6 |
  |  8 | Pepe   | Ruiz      | Santana   | 2016-10-10 |         2480.4 |
  |  2 | Adela  | Salas     | Díaz      | 2017-04-25 |         3045.6 |
  |  1 | Aarón  | Rivero    | Gómez     | 2019-03-11 |        2389.23 |
  +----+--------+-----------+-----------+------------+----------------+


SELECT DISTINCT c.id, c.nombre, c.apellido1, c.apellido2, p.fecha,
  MAX(p.total) AS maxvalorpedido
FROM cliente c
  JOIN pedido p ON c.id = p.id_cliente 
  WHERE fecha = '2016-08-17'
  GROUP BY c.id, c.nombre, c.apellido1, c.apellido2, fecha;

  +----+--------+-----------+-----------+------------+----------------+
  | id | nombre | apellido1 | apellido2 | fecha      | maxvalorpedido |
  +----+--------+-----------+-----------+------------+----------------+
  |  8 | Pepe   | Ruiz      | Santana   | 2016-08-17 |          110.5 |
  |  3 | Adolfo | Rubio     | Flores    | 2016-08-17 |          75.29 |
  +----+--------+-----------+-----------+------------+----------------+


SELECT c.id, c.nombre, c.apellido1, c.apellido2, COUNT(p.id) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id, nombre;

  +----+-----------+-----------+-----------+---------------+
  | id | nombre    | apellido1 | apellido2 | total_pedidos |
  +----+-----------+-----------+-----------+---------------+
  |  1 | Aarón     | Rivero    | Gómez     |             3 |
  |  2 | Adela     | Salas     | Díaz      |             3 |
  |  3 | Adolfo    | Rubio     | Flores    |             1 |
  |  4 | Adrián    | Suárez    | NULL      |             1 |
  |  5 | Marcos    | Loyola    | Méndez    |             2 |
  |  6 | María     | Santana   | Moreno    |             2 |
  |  7 | Pilar     | Ruiz      | NULL      |             1 |
  |  8 | Pepe      | Ruiz      | Santana   |             3 |
  |  9 | Guillermo | López     | Gómez     |             0 |
  | 10 | Daniel    | Santana   | Loyola    |             0 |
  +----+-----------+-----------+-----------+---------------+


SELECT c.id, c.nombre, c.apellido1, c.apellido2, p.fecha, COUNT(p.id) AS total_pedidos
from cliente c
join pedido p on c.id = p.id_cliente
WHERE YEAR(p.fecha) = '2017'
GROUP BY c.id, nombre, p.fecha;

  +----+--------+-----------+-----------+------------+---------------+
  | id | nombre | apellido1 | apellido2 | fecha      | total_pedidos |
  +----+--------+-----------+-----------+------------+---------------+
  |  5 | Marcos | Loyola    | Méndez    | 2017-10-05 |             1 |
  |  2 | Adela  | Salas     | Díaz      | 2017-10-05 |             1 |
  |  5 | Marcos | Loyola    | Méndez    | 2017-09-10 |             1 |
  |  4 | Adrián | Suárez    | NULL      | 2017-10-10 |             1 |
  |  2 | Adela  | Salas     | Díaz      | 2017-04-25 |             1 |
  |  6 | María  | Santana   | Moreno    | 2017-02-02 |             1 |
  +----+--------+-----------+-----------+------------+---------------+


SELECT c.id, c.nombre, c.apellido1, COUNT(p.id) AS total_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id = p.id_cliente
GROUP BY c.id, nombre;

  +----+-----------+-----------+---------------+
  | id | nombre    | apellido1 | total_pedidos |
  +----+-----------+-----------+---------------+
  |  1 | Aarón     | Rivero    |             3 |
  |  2 | Adela     | Salas     |             3 |
  |  3 | Adolfo    | Rubio     |             1 |
  |  4 | Adrián    | Suárez    |             1 |
  |  5 | Marcos    | Loyola    |             2 |
  |  6 | María     | Santana   |             2 |
  |  7 | Pilar     | Ruiz      |             1 |
  |  8 | Pepe      | Ruiz      |             3 |
  |  9 | Guillermo | López     |             0 |
  | 10 | Daniel    | Santana   |             0 |
  +----+-----------+-----------+---------------+


SELECT YEAR(fecha) AS anio, max(total) AS total_pedidos
FROM pedido GROUP BY YEAR(fecha);

  +------+---------------+
  | anio | total_pedidos |
  +------+---------------+
  | 2017 |        3045.6 |
  | 2016 |        2480.4 |
  | 2015 |          5760 |
  | 2019 |       2389.23 |
  +------+---------------+


SELECT YEAR(fecha) AS anio, COUNT(*) AS total_pedidos
FROM pedido GROUP BY YEAR(fecha);

  +------+---------------+
  | anio | total_pedidos |
  +------+---------------+
  | 2017 |             6 |
  | 2016 |             5 |
  | 2015 |             2 |
  | 2019 |             3 |
  +------+---------------+





-- 5. Con operadores básicos de comparación --

SELECT * FROM pedido 
WHERE id_cliente = (
    SELECT id FROM cliente 
    WHERE nombre = 'Adela' AND apellido1 = 'Salas' AND apellido2 = 'Díaz'
);

  +----+--------+------------+------------+--------------+
  | id | total  | fecha      | id_cliente | id_comercial |
  +----+--------+------------+------------+--------------+
  |  3 |  65.26 | 2017-10-05 |          2 |            1 |
  |  7 |   5760 | 2015-09-10 |          2 |            1 |
  | 12 | 3045.6 | 2017-04-25 |          2 |            1 |
  +----+--------+------------+------------+--------------+


SELECT COUNT(*) FROM pedido 
WHERE id_comercial = (
    SELECT id FROM comercial 
    WHERE nombre = 'Daniel' AND apellido1 = 'Sáez' AND apellido2 = 'Vega'
);

  +----------+
  | COUNT(*) |
  +----------+
  |        6 |
  +----------+


SELECT * FROM cliente 
WHERE id = (
    SELECT id_cliente FROM pedido 
    WHERE fecha BETWEEN '2019-01-01' AND '2019-12-31' 
    ORDER BY total DESC 
    LIMIT 1
);

  +----+--------+-----------+-----------+---------+-----------+
  | id | nombre | apellido1 | apellido2 | ciudad  | categoría |
  +----+--------+-----------+-----------+---------+-----------+
  |  1 | Aarón  | Rivero    | Gómez     | Almería |       100 |
  +----+--------+-----------+-----------+---------+-----------+


SELECT p.fecha, p.total
FROM pedido p
WHERE id_cliente = (
    SELECT id FROM cliente 
    WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana'
)
ORDER BY p.total ASC
LIMIT 1;

  +------------+-------+
  | fecha      | total |
  +------------+-------+
  | 2016-08-17 | 110.5 |
  +------------+-------+


SELECT cliente.*, pedido.* 
FROM cliente, pedido 
WHERE cliente.id = pedido.id_cliente 
AND pedido.fecha BETWEEN '2017-01-01' AND '2017-12-31' 
AND pedido.total >= (
    SELECT AVG(total) FROM pedido 
    WHERE fecha BETWEEN '2017-01-01' AND '2017-12-31'
);

  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+
  | id | nombre | apellido1 | apellido2 | ciudad  | categoría | id | total   | fecha      | id_cliente | id_comercial |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+
  |  4 | Adrián | Suárez    | NULL      | Jaén    |       300 |  8 | 1983.43 | 2017-10-10 |          4 |            6 |
  |  2 | Adela  | Salas     | Díaz      | Granada |       200 | 12 |  3045.6 | 2017-04-25 |          2 |            1 |
  +----+--------+-----------+-----------+---------+-----------+----+---------+------------+------------+--------------+





-- 6. Subconsultas con ANY y AND --

SELECT * FROM pedido p1 
WHERE NOT EXISTS (
    SELECT * FROM pedido p2 
    WHERE p2.total > p1.total
);

  +----+-------+------------+------------+--------------+
  | id | total | fecha      | id_cliente | id_comercial |
  +----+-------+------------+------------+--------------+
  |  7 |  5760 | 2015-09-10 |          2 |            1 |
  +----+-------+------------+------------+--------------+


SELECT * FROM cliente 
WHERE id NOT IN (
    SELECT id_cliente FROM pedido
);

  +----+-----------+-----------+-----------+---------+-----------+
  | id | nombre    | apellido1 | apellido2 | ciudad  | categoría |
  +----+-----------+-----------+-----------+---------+-----------+
  |  9 | Guillermo | López     | Gómez     | Granada |       225 |
  | 10 | Daniel    | Santana   | Loyola    | Sevilla |       125 |
  +----+-----------+-----------+-----------+---------+-----------+


SELECT * FROM comercial 
WHERE id NOT IN (
    SELECT id_comercial FROM pedido
);

  +----+---------+-----------+-----------+----------+
  | id | nombre  | apellido1 | apellido2 | comisión |
  +----+---------+-----------+-----------+----------+
  |  4 | Marta   | Herrera   | Gil       |     0.14 |
  |  8 | Alfredo | Ruiz      | Flores    |     0.05 |
  +----+---------+-----------+-----------+----------+


SELECT * FROM cliente 
WHERE id NOT IN (
    SELECT id_cliente FROM pedido
);

  +----+-----------+-----------+-----------+---------+-----------+
  | id | nombre    | apellido1 | apellido2 | ciudad  | categoría |
  +----+-----------+-----------+-----------+---------+-----------+
  |  9 | Guillermo | López     | Gómez     | Granada |       225 |
  | 10 | Daniel    | Santana   | Loyola    | Sevilla |       125 |
  +----+-----------+-----------+-----------+---------+-----------+


SELECT * FROM comercial 
WHERE id NOT IN (
    SELECT id_comercial FROM pedido
);

  +----+---------+-----------+-----------+----------+
  | id | nombre  | apellido1 | apellido2 | comisión |
  +----+---------+-----------+-----------+----------+
  |  4 | Marta   | Herrera   | Gil       |     0.14 |
  |  8 | Alfredo | Ruiz      | Flores    |     0.05 |
  +----+---------+-----------+-----------+----------+




-- 7. Subconsulta con EXIST y NOT EXISTS

SELECT * FROM cliente c
WHERE NOT EXISTS (
    SELECT * FROM pedido p
    WHERE p.id_cliente = c.id
);

  +----+-----------+-----------+-----------+---------+-----------+
  | id | nombre    | apellido1 | apellido2 | ciudad  | categoría |
  +----+-----------+-----------+-----------+---------+-----------+
  |  9 | Guillermo | López     | Gómez     | Granada |       225 |
  | 10 | Daniel    | Santana   | Loyola    | Sevilla |       125 |
  +----+-----------+-----------+-----------+---------+-----------+


SELECT * FROM comercial c
WHERE NOT EXISTS (
    SELECT * FROM pedido p
    WHERE p.id_comercial = c.id
);

  +----+---------+-----------+-----------+----------+
  | id | nombre  | apellido1 | apellido2 | comisión |
  +----+---------+-----------+-----------+----------+
  |  4 | Marta   | Herrera   | Gil       |     0.14 |
  |  8 | Alfredo | Ruiz      | Flores    |     0.05 |
  +----+---------+-----------+-----------+----------+