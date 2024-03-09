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
join comercial c on pedido.id_comercial
where c.id = 1;




-- 3. Consultas multitabla (Composición externa) --

SELECT * FROM cliente c
LEFT JOIN pedido ON c.id = pedido.id_cliente


SELECT * FROM comercial
left join pedido on comercial.id = pedido.id_comercial


SELECT * FROM cliente
LEFT join pedido on cliente.id = pedido.id_cliente
where pedido.id IS NULL;


SELECT * FROM comercial
left join pedido on comercial.id = pedido.id_comercial
where pedido.id IS NULL;


SELECT'Cliente' AS tipo, nombre, apellido1, apellido2 FROM cliente
LEFT JOIN pedido ON cliente.id = pedido.id_cliente
WHERE pedido.id IS NULL
UNION
SELECT 'Comercial' AS tipo, nombre, apellido1, apellido2
FROM comercial
LEFT JOIN pedido ON comercial.id = pedido.id_comercial
WHERE pedido.id IS NULL;


/* SEXTO PUNTO */
/* NO se puede realizar la consulta requerida con el tipo de datos que se tienen actualmente en las tablas, mas sin embargo si se cambia
  en las tablas el nombre de los id en la tabla cliente por id_cliente y en comercial en id_comercial la consulta se podria realizar."*/



-- 4. Consultas resumen --

SELECT SUM(total) AS total_pedidos
FROM pedido;


SELECT AVG(total) AS media_pedidos
FROM pedido;






-- 5. Con operadores básicos de comparación --

SELECT * FROM pedido 
WHERE id_cliente = (
    SELECT id 
    FROM cliente 
    WHERE nombre = 'Adela' AND apellido1 = 'Salas' AND apellido2 = 'Díaz'
);


SELECT COUNT(*) FROM pedido 
WHERE id_comercial = (
    SELECT id 
    FROM comercial 
    WHERE nombre = 'Daniel' AND apellido1 = 'Sáez' AND apellido2 = 'Vega'
);


SELECT * FROM cliente 
WHERE id = (
    SELECT id_cliente 
    FROM pedido 
    WHERE fecha BETWEEN '2019-01-01' AND '2019-12-31' 
    ORDER BY total DESC 
    LIMIT 1
);


SELECT p.fecha, p.total
FROM pedido p
WHERE id_cliente = (
    SELECT id 
    FROM cliente 
    WHERE nombre = 'Pepe' AND apellido1 = 'Ruiz' AND apellido2 = 'Santana'
)
ORDER BY p.total ASC
LIMIT 1;

