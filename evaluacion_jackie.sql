USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT title AS TituloPelicula
FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title AS TituloPelicula
FROM film
WHERE rating = 'PG-13';

-- 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title AS TituloPelicula, description AS Descripcion
FROM film
WHERE  description LIKE '%amazing%';

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title AS TituloPelicula
FROM film
WHERE length > 120;

-- 5. Recupera los nombres de todos los actores.

SELECT first_name
from actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name AS NombreActor, last_name AS ApellidoActor
FROM actor
WHERE last_name = 'GIBSON';

-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name AS NombreApellido
FROM actor 
WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title AS TituloPelicula
FROM film
WHERE rating NOT IN('R', 'PG-13');

/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con
el recuento.*/

SELECT rating AS Clasificacion, COUNT(film_id) AS TotalClasificacion
FROM film
GROUP BY (rating);

-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
-- apellido junto con la cantidad de películas alquiladas.PENDIENTE

SELECT C.customer_id AS IDCliente, CONCAT(C.first_name, ' ', C.last_name) AS NombreCliente, COUNT(R.rental_id) AS TotalPeliculasAlquiladas
FROM customer C -- Datos del cliente
INNER JOIN rental R -- Tengo los aquileres
ON C.customer_id = R.customer_id
GROUP BY C.customer_id;


/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
recuento de alquileres.*/

SELECT C.name AS NombreCategoria, COUNT(R.rental_id) AS TotalPeliculasAlquiladas
FROM rental R
INNER JOIN inventory I -- Unir rental con inventario para saber que copia de peli se alquilo
ON R.inventory_id = I.inventory_id
INNER JOIN film_category FY -- Unir inventario con categoria para saber que pelicula fue alquilada segun cat
ON  I.film_id = FY.film_id
INNER JOIN category C -- Unimos a categoria para saber el nombre de la categoria 
ON FY.category_id = C.category_id
GROUP BY C.name;

/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
clasificación junto con el promedio de duración.*/

SELECT rating AS Clasificacion, AVG(length) AS PromedioDuracion
FROM film
GROUP BY rating;

-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT CONCAT(A.first_name, " ", A.last_name) AS NombreActores
FROM actor A 
INNER JOIN film_actor FA
ON FA.actor_id = A.actor_id
INNER JOIN film F
ON F.film_id = FA.film_id
WHERE title = 'Indian Love';

-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT title AS TituloPelicula, description
FROM film
WHERE description LIKE '%dog%' OR '%cat%';

-- 15. Hay algún actor o actriz que no apareca en ninguna película en la tabla film_actor. Revisar

SELECT  A.actor_id AS IDActor, A.first_name AS NombreActor
FROM actor A 
LEFT JOIN film_actor FA -- Necesitamos traer todos los actores de la tabla actor incluso si no esta en la tabla film_actor
ON A.actor_id = FA.actor_id
WHERE FA.actor_id IS NOT NULL;

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title AS TituloPelicula, release_year
FROM film
WHERE release_year BETWEEN '2005' AND '2010';

-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".

SELECT F.title AS TituloPelicula, C.name
FROM film F 
INNER JOIN film_category FC
ON F.film_id = FC.film_id
INNER JOIN category C
ON C.category_id = FC.category_id
WHERE C.name = 'Family';

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.

SELECT CONCAT(A.first_name, " " , A.last_name) AS NombreActor
FROM actor A 
INNER JOIN film_actor FA
ON A.actor_id = FA.actor_id
GROUP BY A.first_name, A.last_name
HAVING COUNT(FA.actor_id) > 10; -- Cuenta los actores segun la pelicula

-- 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.

SELECT title AS TituloPelicula
FROM film
WHERE rating = 'R' AND length > 160;

/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
nombre de la categoría junto con el promedio de duración.*/

SELECT C.name, AVG(f.length) AS PromedioDuracion
FROM category C
INNER JOIN film_category FY
ON C.category_id = FY.category_id
INNER JOIN film F 
ON FY.film_id = F.film_id
GROUP BY C.name
HAVING PromedioDuracion > 120;

/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad
de películas en las que han actuado.*/

SELECT 

/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes.*/
/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
exclúyelos de la lista de actores.*/
/* BONUS
-- 24. BONUS: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
tabla film.*/
/* 25. BONUS: Encuentra todos los actores que han actuado juntos en al menos una película. La consulta debe mostrar el
nombre y apellido de los actores y el número de películas en las que han actuado juntos */