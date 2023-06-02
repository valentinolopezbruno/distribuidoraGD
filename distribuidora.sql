DROP DATABASE distribuidora;
CREATE DATABASE distribuidora;

\c distribuidora


-- Creación de la tabla Estante
CREATE TABLE Estante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

-- Creación de la tabla Categoria
CREATE TABLE Categoria (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255)
);

-- Creación de la tabla Producto
CREATE TABLE Producto (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255),
    cantidad INTEGER,
    precio DECIMAL(10, 2),
    descripcion VARCHAR(255),
    id_estante INTEGER REFERENCES Estante(id) ON DELETE CASCADE,
    id_categoria INTEGER REFERENCES Categoria(id) ON DELETE CASCADE
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
    id_tipo_de_movimiento SERIAL,
    CONSTRAINT fk_id_tipo_de_movimiento FOREIGN KEY (id_tipo_de_movimiento) REFERENCES TipoDeMovimiento(id)
);

CREATE TABLE DetalleMovimiento (
    id SERIAL PRIMARY KEY,
    cantidad INT,
    precio DECIMAL(10,2),
    id_producto SERIAL,
    id_movimiento SERIAL,
    CONSTRAINT fk_id_producto FOREIGN KEY (id_producto) REFERENCES Producto(id) ,
    CONSTRAINT fk_id_movimiento FOREIGN KEY (id_movimiento) REFERENCES MovimientoStock(id) 
);