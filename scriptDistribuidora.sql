DROP DATABASE distribuidora;
CREATE DATABASE distribuidora;

\c distribuidora


-- Creación de la tabla Estante
CREATE TABLE Estante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255)
);

-- Creación de la tabla Categoria
CREATE TABLE Categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) ,
    descripcion VARCHAR(255)
);

-- Creación de la tabla Producto
CREATE TABLE Producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    cantidad INTEGER,
    precio DECIMAL(10, 2),
    descripcion VARCHAR(255),
    id_estante SERIAL NOT NULL,
    id_categoria SERIAL NO,
    CONSTRAINT fk_id_estante FOREIGN KEY (id_estante) REFERENCES Estante(id),
    CONSTRAINT fk_id_categoria FOREIGN KEY (id_estante) REFERENCES Producto(id)
);

-- Creacion de la tabla tipo de movimiento

CREATE TABLE TipoDeMovimiento (
    id SERIAL PRIMARY KEY,
    descripcion VARCHAR(255)
)
;

-- Creacion de la tabla movimiento stock

CREATE TABLE MovimientoStock (
    id SERIAL PRIMARY KEY,
    fecha DATE,
    hora TIME,
    descripcion VARCHAR(255),
    id_tipo_de_movimiento SERIAL NOT NULL,
    CONSTRAINT fk_id_tipo_de_movimiento FOREIGN KEY (id_tipo_de_movimiento) REFERENCES TipoDeMovimiento(id)
);

CREATE TABLE DetalleMovimiento (
    id SERIAL PRIMARY KEY,
    cantidad INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    id_producto SERIAL,
    id_movimiento SERIAL,
    CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id),
    CONSTRAINT fk_id_movimiento FOREIGN KEY (id_movimiento) REFERENCES MovimientoStock(id)
);

--- INSERTS Y CONSULTAS

--- Cargas de datos de tablas fijos

INSERT INTO Categoria (nombre, descripcion)
VALUES ('Limpieza', 'Todos productos de limpieza'),
('Perfumeria', 'Todos productos de perfumeria'),
('Automotor', 'Todos productos de automotor')
;

INSERT INTO Estante (nombre)
VALUES ('Estante 1'),
('Estante 2'),
('Estante 3'),
('Estante 4')
;

INSERT into TipoDeMovimiento(descripcion)
VALUES ('COMPRA'),
('VENTA')
;

-- Carga de produtos al azar

INSERT INTO producto (nombre, cantidad, precio, descripcion, id_categoria, id_estante)
VALUES ('Lavandina 1 Litro', 30, 200, 'Lavandina MOBY', 1, 1),
('Lavandina 2 Litros', 20, 350, 'Lavandina MOBY', 1, 1),
('Lavandina 3 Litros', 100, 500, 'Lavandina MOBY', 1, 1),
('Perfume 1', 30, 200, 'Perfume', 2, 2),
('Perfume 2', 10, 100, 'Perfume', 2, 2),
('Perfume 3', 10, 200, 'Perfume', 2, 2)
;


SELECT * FROM Producto;
SELECT * FROM estante;
SELECT * FROM Categoria;
-- SELECT 
-- *
-- FROM Producto
-- INNER JOIN Estante on producto.id_estante_producto = estante.id_estante
-- WHERE id_estante_producto = 1
-- ;

-- SELECT 
-- *
-- FROM Producto
-- INNER JOIN Estante on producto.id_estante_producto = estante.id_estante
-- WHERE id_estante_producto = 2
-- ;

-- SELECT * FROM producto
-- WHERE id_producto = 7;

-- UPDATE Producto
-- SET cantidad = 2000
-- WHERE id = 7;

-- SELECT * FROM producto
-- WHERE id_producto = 7;

-- UPDATE Producto
-- SET precio = 33
-- WHERE id = 7;

-- SELECT * FROM producto
-- WHERE id_producto = 7;



-- INSERT into MovimientoStock(cantidad_movimiento, descripcion_movimiento, id_producto_movimiento, id_tipo_de_movimiento_movimiento, fecha_movimiento, hora_movimiento)
-- VALUES(10,'COMPRA A X', 1, 1, CURRENT_DATE, CURRENT_TIME),
-- (34,'COMPRA A X', 2, 1, CURRENT_DATE, CURRENT_TIME),
-- (1220,'COMPRA A X', 3, 1, CURRENT_DATE, CURRENT_TIME),
-- (100,'COMPRA A X', 2, 1, CURRENT_DATE, CURRENT_TIME)
-- ;

-- SELECT * FROM MovimientoStock;

-- SELECT 
-- p.nombre_producto as "Producto",
-- m.fecha_movimiento as "Fecha",
-- m.hora_movimiento as "Hora",
-- tm.descripcion_tipo_de_movimiento as "Tipo de movimiento",
-- m.cantidad_movimiento as "Cantidad de Producto"
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento_movimiento = tm.id_tipo_de_movimiento
-- INNER JOIN producto p on m.id_producto_movimiento = p.id_producto
-- ;

-- INSERT into MovimientoStock(cantidad_movimiento, descripcion_movimiento, id_producto_movimiento, id_tipo_de_movimiento_movimiento, fecha_movimiento, hora_movimiento)
-- VALUES(1232,'VENTA A X', 1, 2, CURRENT_DATE, CURRENT_TIME),
-- (32,'VENTA A X', 2, 2, CURRENT_DATE, CURRENT_TIME),
-- (20,'COMPRA A X', 3, 1, CURRENT_DATE, CURRENT_TIME),
-- (1,'VENTA A X', 2, 2, CURRENT_DATE, CURRENT_TIME)
-- ;

-- SELECT 
-- p.nombre_producto as "Producto",
-- m.fecha_movimiento as "Fecha",
-- m.hora_movimiento as "Hora",
-- tm.descripcion_tipo_de_movimiento as "Tipo de movimiento",
-- m.cantidad_movimiento as "Cantidad de Producto"
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento_movimiento = tm.id_tipo_de_movimiento
-- INNER JOIN producto p on m.id_producto_movimiento = p.id_producto
-- ;

-- SELECT 
-- p.nombre_producto as "Producto",
-- m.fecha_movimiento as "Fecha",
-- m.hora_movimiento as "Hora",
-- tm.descripcion_tipo_de_movimiento as "Tipo de movimiento",
-- m.cantidad_movimiento as "Cantidad de Producto"
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento_movimiento = tm.id_tipo_de_movimiento
-- INNER JOIN producto p on m.id_producto_movimiento = p.id_producto
-- WHERE tm.id_tipo_de_movimiento = 1
-- ;

-- SELECT 
-- p.nombre_producto as "Producto",
-- m.fecha_movimiento as "Fecha",
-- m.hora_movimiento as "Hora",
-- tm.descripcion_tipo_de_movimiento as "Tipo de movimiento",
-- m.cantidad_movimiento as "Cantidad de Producto"
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento_movimiento = tm.id_tipo_de_movimiento
-- INNER JOIN producto p on m.id_producto_movimiento = p.id_producto
-- WHERE tm.id_tipo_de_movimiento = 2
-- ;


--------------------------------------------------
-- Moviento y update de cantidad COMPRA
--------------------------------------------------

--- COMPRA

INSERT into MovimientoStock(id_tipo_de_movimiento, descripcion, fecha, hora)
VALUES
(1,'COMPRA A X', CURRENT_DATE, CURRENT_TIME)
;

INSERT into DetalleMovimiento(id_producto, id_movimiento, cantidad, precio)
VALUES (1,1,20,15)
;

INSERT into DetalleMovimiento(id_producto, id_movimiento, cantidad, precio)
VALUES (2,1,20,25)
;

--- UPDATE DE PRODUCTOS

UPDATE producto
SET cantidad = cantidad + 20
WHERE id = 1
;

UPDATE producto
SET cantidad = cantidad + 20
WHERE id = 2
;

SELECT * from MovimientoStock;

-- SELECT
-- p.nombre,
-- dm.precio,
-- dm.cantidad,
-- m.fecha,
-- m.hora,
-- m.id
-- FROM DetalleMovimiento dm
-- INNER JOIN MovimientoStock m on dm.id_movimiento = m.id
-- INNER JOIN Producto p on dm.id_producto = p.id
-- ;

SELECT
p.nombre as "Nombre Producto",
dm.precio as "Precio",
dm.cantidad as "Cantidad",
m.id as "Id Movimiento"
FROM DetalleMovimiento dm
INNER JOIN MovimientoStock m on dm.id_movimiento = m.id
INNER JOIN Producto p on dm.id_producto = p.id
;
--------------------------------------------------
-- Moviento y update de cantidad VENTA
--------------------------------------------------


--- RESVISAR

INSERT into MovimientoStock(id_tipo_de_movimiento, descripcion,  fecha, hora)
VALUES
(2,'VENTA A X',CURRENT_DATE, CURRENT_TIME)
;

INSERT into DetalleMovimiento(id_producto, id_movimiento, cantidad, precio)
VALUES (4,2,3,25)
;


INSERT into DetalleMovimiento(id_producto, id_movimiento, cantidad, precio)
VALUES (2,2,2,25)
;


INSERT into DetalleMovimiento(id_producto, id_movimiento, cantidad, precio)
VALUES (3,2,1,25)
;

UPDATE producto
SET cantidad = cantidad - 3
WHERE id = 4
;

UPDATE producto
SET cantidad = cantidad - 2
WHERE id = 2
;

UPDATE producto
SET cantidad = cantidad - 1
WHERE id = 3
;

SELECT
p.nombre,
dm.precio,
dm.cantidad,
m.fecha,
m.hora,
m.id
FROM DetalleMovimiento dm
INNER JOIN MovimientoStock m on dm.id_movimiento = m.id
INNER JOIN Producto p on dm.id_producto = p.id
;



--------------------------------------------------
-- Consulta de cantidad de productos vendidas
--------------------------------------------------

-- REVISAR

-- SELECT 
-- p.nombre as "Producto",
-- m.fecha as "Fecha",
-- m.hora as "Hora",
-- tm.descripcion as "Tipo de movimiento",
-- m.cantidad as "Cantidad de Producto"
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento = tm.id
-- INNER JOIN producto p on m.id_producto = p.id
-- WHERE tm.id = 2
-- ;

--------------------------------------------------
-- Consutla de cantidad vendida de productos con precio
--------------------------------------------------

-- REVISAR

-- SELECT 
-- p.nombre as "Producto",
-- m.fecha as "Fecha",
-- m.hora as "Hora",
-- tm.descripcion as "Tipo de movimiento",
-- m.cantidad as "Cantidad de Producto",
-- p.precio as "Precio Unitario",
-- p.precio * m.cantidad  as "Precio Total" 
-- FROM MovimientoStock m
-- INNER JOIN TipoDeMovimiento tm on m.id_tipo_de_movimiento = tm.id
-- INNER JOIN producto p on m.id_producto = p.id
-- WHERE tm.id = 2
-- ;