USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados +++.

SELECT DISTINCT title AS TituloPelicula
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13 +++".

SELECT title AS TituloPelicula
FROM film
WHERE rating = 'PG-13';

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción +++.

SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE  description LIKE '%amazing%';

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos +++.

SELECT title AS TituloPelicula
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores.

SELECT first_name
from actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido +++.

SELECT first_name AS NombreActor, last_name AS ApellidoActor
FROM actor
WHERE last_name LIKE '%GIBSON%';

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20 +++.

SELECT first_name AS NombreActor
FROM actor 
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación +++.

SELECT title AS TituloPelicula
FROM film
WHERE rating NOT IN('R', 'PG-13');

/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
el recuento +++.*/

SELECT rating AS Clasificacion, COUNT(film_id) AS TotalClasificacion
FROM film
GROUP BY (rating);

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
-- apellido junto con la cantidad de películas alquiladas.PENDIENTE

SELECT C.customer_id AS IDCliente, CONCAT(C.first_name, ' ', C.last_name) AS NombreCliente, COUNT(R.rental_id) AS TotalPeliculasAlquiladas
FROM customer C -- Datos del cliente
INNER JOIN rental R -- Tengo los aquileres
ON C.customer_id = R.customer_id
GROUP BY C.customer_id, C.first_name, C.last_name;


/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
recuento de alquileres. +++*/

SELECT C.name AS NombreCategoria, COUNT(R.rental_id) AS TotalPeliculasAlquiladas
FROM rental R -- Nos indica que inventario fue alquilado
INNER JOIN inventory I -- Unir rental con inventario para saber que copia de peli y unida a rental sabemos que peli se alquilo
ON R.inventory_id = I.inventory_id
INNER JOIN film_category FY -- Unir inventario con categoria para saber que pelicula fue alquilada segun categoria
ON  I.film_id = FY.film_id
INNER JOIN category C -- Unimos a categoria para saber el nombre de la categoria 
ON FY.category_id = C.category_id
GROUP BY C.name;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración +++.*/

SELECT rating AS Clasificacion, AVG(length) AS PromedioDuracion
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love" +++.

SELECT CONCAT(A.first_name, " ", A.last_name) AS NombreActores
FROM actor A 
INNER JOIN film_actor FA
ON FA.actor_id = A.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id
WHERE title = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción +++.

SELECT title AS TituloPelicula, description
FROM film
WHERE description LIKE '%dog%' OR '%cat%';

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. Revisar

SELECT  A.actor_id AS IDActor, A.first_name AS NombreActor
FROM actor A 
LEFT JOIN film_actor FA -- Necesitamos traer todos los actores de la tabla actor incluso si no esta en la tabla film_actor
ON A.actor_id = FA.actor_id
WHERE FA.actor_id IS NULL;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010 +++.

SELECT title AS TituloPelicula
FROM film
WHERE release_year BETWEEN 2005 AND 2010;

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family" +++.

SELECT F.title AS TituloPelicula, C.name
FROM film F 
INNER JOIN film_category FC
ON F.film_id = FC.film_id
INNER JOIN category C
ON C.category_id = FC.category_id
WHERE C.name = 'Family';

-- Buscar el id de categoria Family y luego las peliculas que pertenezcan a esa categoria
SELECT F.title AS TituloPelicula, C.name
FROM film F
INNER JOIN film_category FC ON F.film_id = FC.film_id
INNER JOIN category C ON C.category_id = FC.category_id
WHERE C.category_id = (
    SELECT C2.category_id
    FROM category C2
    WHERE C2.name = 'Family'
);

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas +++.

SELECT CONCAT(A.first_name, " " , A.last_name) AS NombreActor
FROM actor A 
INNER JOIN film_actor FA
ON A.actor_id = FA.actor_id
GROUP BY A.first_name, A.last_name
HAVING COUNT(FA.film_id) > 10; -- Cuenta el numero de peliculas por actor

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film +++.

SELECT title AS TituloPelicula
FROM film
WHERE rating = 'R' AND length > 120;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
nombre de la categoría junto con el promedio de duración.+++*/

SELECT C.name, AVG(F.length) AS PromedioDuracion
FROM category C
INNER JOIN film_category FY
ON C.category_id = FY.category_id
INNER JOIN film F 
ON FY.film_id = F.film_id
GROUP BY C.name
HAVING PromedioDuracion > 120;

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad
de películas en las que han actuado--.+++*/

SELECT CONCAT(A.first_name, " " , A.last_name) AS NombreActor, COUNT(FA.film_id) AS TotalPeliculasActor
FROM actor A
INNER JOIN film_actor FA
ON A.actor_id = FA.actor_id
GROUP BY A.first_name, A.last_name
HAVING COUNT(FA.film_id) >= 5;


/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/

SELECT title AS TituloPelicula
FROM film
WHERE film_id IN(
SELECT I.film_id
FROM rental R
INNER JOIN inventory I
ON R.rental_id = I.inventory_id
WHERE DATEDIFF(R.return_date, R.rental_date) >5);


/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
exclúyelos de la lista de actores --.*/

SELECT CONCAT(A.first_name, " ", A.last_name) AS NombreActor
FROM actor A
WHERE actor_id NOT IN (SELECT FA.actor_id AS IDActor
FROM film_actor FA 
INNER JOIN film_category FY
ON FA.film_id = FY.film_id
INNER JOIN category C 
ON C.category_id = FY.category_id
WHERE C.name = 'Horror'); -- Subconsulta para que arroje los actores que han actuado en las peliculas de categoria Horror

/* BONUS
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
tabla film.*/

SELECT F.title AS TituloPelicula
FROM film F
INNER JOIN film_category FY
ON F.film_id = FY.film_id
INNER JOIN category C 
ON C.category_id = FY.category_id
WHERE C.name = 'comedy' and length > 180;

/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el
nombre y apellido de los actores y el número de películas en las que han actuado juntos. CHAT GPT */ 

WITH ParejasActores AS(
SELECT FA1.actor_id AS Actor1_ID, FA2.actor_id AS Actor2_ID, COUNT(FA1.film_id) AS TotalPeliculasJuntos
FROM film_actor FA1
INNER JOIN film_actor FA2
ON FA1.film_id = FA2.film_id
AND FA1.actor_id < FA2.actor_id 
GROUP BY FA1.actor_id, FA2.actor_id)

SELECT CONCAT(A1.first_name, " " , A1.last_name) AS NombreActor1,  CONCAT(A2.first_name, " " , A2.last_name) AS NombreActor2, AP.TotalPeliculasJuntos
FROM ParejasActores AP
INNER JOIN actor A1 ON AP.Actor1_ID = A1.actor_id
INNER JOIN actor A2 ON AP.Actor2_ID = A2.actor_id
ORDER BY AP.TotalPeliculasJuntos DESC;

