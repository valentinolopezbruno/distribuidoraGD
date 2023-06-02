--- Cargas de datos de tablas fijos

INSERT INTO Categoria (nombre, descripcion)
VALUES 
('Limpieza', 'Todos productos de limpieza'),
('Perfumeria', 'Todos productos de perfumeria'),
('Automotor', 'Todos productos de automotor')
;

INSERT INTO Estante (nombre)
VALUES 
('Estante 1'),
('Estante 2'),
('Estante 3'),
('Estante 4')
;

INSERT into TipoDeMovimiento(descripcion)
VALUES 
('COMPRA'),
('VENTA')
;

-- Carga de produtos al azar

INSERT INTO producto (nombre, cantidad, precio, descripcion, id_categoria, id_estante)
VALUES 
('Lavandina 1 Litro', 30, 200, 'Lavandina MOBY', 1, 1),
('Perfume 1', 10, 100, 'Perfume', 2, 2)
;