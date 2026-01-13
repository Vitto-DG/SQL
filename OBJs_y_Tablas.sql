-- Normalizacion de datos en los registros de una bbdd --

-- Tenemos una tabla llamada 'Clientes' con telefonos y emails repetidos entre clientes --

-- 1 _ Se crea una nueva tabla para separar la informacion --

CREATE TABLE Contactos (
id_contacto INT AUTO_INCREMENT PRIMARY KEY,
telefono VARCHAR(20),
email VARCHAR(100));

-- 2 _ Insertamos los datos correspondientes, tomandolos desde la tabla en conflicto --
 
INSERT INTO Contactos (telefono, email)
SELECT DISTINCT telefono, email -- DISTINCT para traer datos sin duplicaciones --
FROM Clientes;

/* 3 _ Creamos el campo "id_contacto" en la tabla Clientes
 y actualizamos en la tabla Clientes por telefono y email. 
 Antes, relacionamos ambas tablas referenciando a la tabla contactos con la FK */

ALTER TABLE Clientes
ADD COLUMN id_contacto INT;

-- Creamos la FK --

ALTER TABLE Clientes
ADD FOREIGN KEY (id_contacto) REFERENCES Contactos(Id_Contacto);

-- Realizamos "populacion" del campo "Id_contacto", tomando de la tabla Contactos --

UPDATE Clientes cl
SET cl.Id_Contacto = (SELECT co.Id_Contacto
						FROM Contactos co
						WHERE co.email = cl.email
                        AND co.telefono = cl.telefono);
/* 
*Esta tabla fue completada haciendo un DISTINCT,
 no habra repetidos y siempre tendremos un registro.
  Esta consulta se esta generando sin ningun tipo de Indice,
  por lo que se espera que tarde bastante (67segs)
 */ 
	
-- Creamos un indice sobre la tabla Contactos en el campo email --
CREATE INDEX idx_email on Contactos (email);


-- Anula lo uqe ya hizo en el Update, volviendo a nulo esos registros --
UPDATE Clientes
SET ID_contacto = null;

/* Vuelve a ejecutar la consulta de la populacion 
pero esta vez con un indice para acortar el tiempo de consulta */

-- Una vez obtenido un resultado optimizado ejecutado esto, no haria falta conservar los campos telefono y email

ALTER TABLE Clientes
DROP COLUMN telefono;

ALTER TABLE Clientes
DROP COLUMN email;
