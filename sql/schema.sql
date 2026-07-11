-- Script de creación de base de datos: Proyecto Ferretería
-- Autor: Hugo Insaurralde

CREATE DATABASE IF NOT EXISTS ferreteria;
USE ferreteria;

-- Tabla: categoria
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL
);

-- Tabla: proveedor
CREATE TABLE proveedor (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    razon_social VARCHAR(45) NOT NULL,
    cuit VARCHAR(45) NOT NULL UNIQUE,
    condicion_pago VARCHAR(45) NOT NULL,
    email_contacto VARCHAR(100) NOT NULL UNIQUE,
    telefono VARCHAR(45) NOT NULL
);

-- Tabla: producto
CREATE TABLE producto (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    descripcion VARCHAR(255),
    codigo VARCHAR(45) NOT NULL UNIQUE,
    precio DECIMAL(10,2) NOT NULL,
    stock_actual INT NOT NULL DEFAULT 0,
    categoria_id INT NOT NULL,
    proveedor_principal_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categoria(id_categoria),
    FOREIGN KEY (proveedor_principal_id) REFERENCES proveedor(id_proveedor)
);

-- Tabla: producto_proveedor (relación N:M)
CREATE TABLE producto_proveedor (
    producto_id INT,
    proveedor_id INT,
    precio_compra DECIMAL(10,2) NOT NULL,
    descuento_proveedor DECIMAL(5,2),
    PRIMARY KEY (producto_id, proveedor_id),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto),
    FOREIGN KEY (proveedor_id) REFERENCES proveedor(id_proveedor)
);

-- Tabla: stock (historial de movimientos)
CREATE TABLE stock (
    id_stock INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_movimiento ENUM('entrada','salida') NOT NULL,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    producto_id INT NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);

-- Tabla: venta
CREATE TABLE venta (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    metodo_pago VARCHAR(45) NOT NULL,
    total_venta DECIMAL(10,2) NOT NULL DEFAULT 0
);

-- Tabla: detalle_venta
CREATE TABLE detalle_venta (
    id_detalle_venta INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    venta_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (venta_id) REFERENCES venta(id_venta),
    FOREIGN KEY (producto_id) REFERENCES producto(id_producto)
);