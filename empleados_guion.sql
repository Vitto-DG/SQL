SELECT * FROM practica.empleados;

SELECT nombre, salario
FROM empleados
WHERE a.salario > (SELECT MAX(salario)
					FROM empleados);
                    
SELECT a.nombre, a.salario
FROM empleados a
WHERE a.salario > (SELECT AVG(salario)
					FROM empleados b
                    WHERE b.departamento = a.departamento);