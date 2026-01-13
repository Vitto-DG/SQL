USE practica;

-- Creación de la tabla 'empleados'
CREATE TABLE empleados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    departamento VARCHAR(50) NOT NULL
);

-- Inserción de datos de ejemplo en la tabla 'empleados'
INSERT INTO empleados (nombre, salario, departamento) VALUES
('Ana', 3000.00, 'Ventas'),
('Luis', 3500.00, 'Ventas'),
('María', 4500.00, 'Marketing'),
('Carlos', 5000.00, 'Marketing'),
('Pedro', 2500.00, 'Soporte'),
('Elena', 6000.00, 'Soporte'),
('Laura', 4200.00, 'Ventas'),
('José', 3800.00, 'Marketing'),
('Lucía', 4100.00, 'Soporte'),
('Marta', 3200.00, 'Ventas'),
('Juan', 3300.00, 'Ventas'),
('Sofía', 4900.00, 'Marketing'),
('Miguel', 4600.00, 'Soporte'),
('Paula', 3700.00, 'Marketing'),
('Raúl', 5200.00, 'Soporte');

-- Notas para los ejercicios prácticos:
-- 1. Usa la tabla 'empleados' para practicar las subconsultas como en los ejemplos del video.
-- 2. Las consultas proporcionadas en el guion están diseñadas para ejecutarse directamente con esta tabla.
-- 3. Asegúrate de tener una base de datos MySQL configurada antes de ejecutar este script.