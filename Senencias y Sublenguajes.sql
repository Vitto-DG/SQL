
-- Indentacion sugerida como buena practica --
SELECT name, age
FROM users
WHERE age > 30
ORDER BY name;


-- Seleccion de campos necesarios y no de todos --
SELECT title, price
FROM products;


-- Creacion de indices --
CREATE INDEX idx_email 
	ON users(email);


CREATE INDEX idx_customer_id
	ON orders (customer_id);

				-- Tambien poderia haber casos de indices compuestos --
CREATE INDEX idx_customer_id_date
	ON orders (customer_id, order_date);

-- Consultas Anidadas innecesarias --
	-- Ej --
	
SELECT name
FROM customers
WHERE id
IN (SELECT customer
	FROM orders);

	-- Solucion con JOIN --
SELECT customers.name
FROM customers
INNER JOIN orders
ON customers.id = orders.customer.id;

-- Turn this: --
SELECT name
FROM students
WHERE id
IN (SELECT student_id
	FROM enrollments
    WHERE course_id = 1);

-- into This --
SELECT students.name
FROM students
INNER JOIN enrollments
ON students.id = enrollments.student_id
WHERE enrollments.course_id = 1;

-- INNER JOIN: Solo devuelve filas que coinciden en ambas tablas --
SELECT orders.id, customers.name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.id;

-- LEFT JOIN: Incluye todas las filas de la tabla izquierda, incluso si no hay coincidencias. --
SELECT orders.id, customers.name
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.id;

-- Ejercicio: Escribe una consulta que devuelva todos los productos y, si están asociados, también sus categorías. --
SELECT 
	products.name AS product_name,
    categories.name AS categorry_name
FROM products
LEFT JOIN categories
ON products.category_id = categories.id;

-- Operadores Eficientes EXISTS o  > < --

-- Mal --
SELECT *
FROM orders
WHERE customer_id
IN 
	(SELECT id
    FROM customers);
    
-- Bien --
SELECT *
FROM orders
WHERE EXISTS
	(SELECT 1
    FROM customers
    WHERE customers.id = orders.customer_id);
    
-- Reformular --
SELECT *
FROM products
WHERE id
IN 
	(SELECT product_id 		-- traer el id de productos --
    FROM inventory 			-- de la tabla inventory --
    WHERE quantity > 0);	-- si es que hay en stock --
    
-- Fixed --
SELECT *
FROM products p
WHERE EXISTS
	(SELECT 1
    FROM inventory i
    WHERE i.product_id = p.id
		AND i.quantity > 0);

-- EXISTS no compara valores como IN, verifica si la subconsulta devuelve al menos una fila --

-- LIMIT o TOP, Limitar los resultados de la consulta --
SELECT *
FROM sales
ORDER BY sale_date
DESC LIMIT 10;

-- Evitar funciones en WHERE --
-- Mal --
SELECT *
FROM orders
WHERE YEAR(order_date) = 2023;

-- Bien -- 
SELECT *
FROM orders
WHERE order_date
BETWEEN '2023-01-01' 
	AND '2023-12-31';

-- Ejercicio --
SELECT *
FROM employees
WHERE name = 'John'
	OR name = 'JOHN'
    OR name = 'john';
    
-- GROUP BY (agrupar) o HAVING (filtrado final) --
-- ejemplo --
SELECT department, 
	COUNT(*) AS total_employees
FROM employees
WHERE hire_date >= '2020-01-01'
GROUP BY department
HAVING COUNT(*) > 10;

-- Ejercicio --
SELECT 
	product_id, 
	COUNT(*) AS ventas_grandes
FROM ventas
GROUP BY product_id
HAVING COUNT(*) > 100;

-- Pruebas y Ajustes -- 
-- Ejemplo --
EXPLAIN 
	SELECT *
    FROM orders 
    WHERE customer_id = 123;
    
-- Ejercicio --
EXPLAIN
	SELECT *
    FROM products
    WHERE price > 100;
