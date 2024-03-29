-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS cine_arte_atrezo;
DROP DATABASE cine_arte_atrezo;

-- Seleccionar la base de datos
USE cine_arte_atrezo;
-- Crear la base de datos

-- Crear usuarios
CREATE USER 'Peter'@'localhost' IDENTIFIED BY 'curso';
CREATE USER 'David'@'localhost' IDENTIFIED BY 'curso';
CREATE USER 'Jose'@'localhost' IDENTIFIED BY 'curso';
CREATE USER 'Álvaro'@'localhost' IDENTIFIED BY 'curso';
-- Eliminar usuarios
DROP USER 'Peter'@'localhost';
DROP USER 'David'@'localhost';
DROP USER 'Jose'@'localhost';
DROP USER 'Álvaro'@'localhost';


-- Otorgar permisos a los usuarios
GRANT PROCESS ON *.* TO 'Peter'@'localhost';
GRANT PROCESS ON *.* TO 'David'@'localhost';
GRANT PROCESS ON *.* TO 'Jose'@'localhost';
GRANT PROCESS ON *.* TO 'Álvaro'@'localhost';
GRANT ALL PRIVILEGES ON cine_arte_atrezo.Cliente TO 'Peter'@'localhost';
GRANT ALL PRIVILEGES ON cine_arte_atrezo.Producto TO 'David'@'localhost';
GRANT ALL PRIVILEGES ON cine_arte_atrezo.Pedido TO 'Jose'@'localhost';
GRANT ALL PRIVILEGES ON cine_arte_atrezo.Factura TO 'Álvaro'@'localhost';
REVOKE SELECT ON cine_arte_atrezo.Producto FROM 'David'@'localhost';
-- Crear tabla Rol
CREATE TABLE Rol (
    id_rol INT AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_rol),
    UNIQUE (nombre)
);

-- Insertar roles
INSERT INTO Rol (nombre) VALUES
('administrador'),
('empleado');

-- Crear tabla Usuario
CREATE TABLE Usuario (
    id_usuario INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL,
    clave VARCHAR(50) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    id_rol INT,
    PRIMARY KEY (id_usuario),
    UNIQUE (nombre_usuario),
    FOREIGN KEY (id_rol) REFERENCES Rol(id_rol)
);

-- Insertar datos de usuarios
INSERT INTO Usuario (nombre_usuario, clave, rol, id_rol) VALUES
('Peter', 'curso', 'administrador', 1),
('David', 'curso', 'empleado', 2),
('Jose', 'curso', 'empleado', 2),
('Álvaro', 'curso', 'empleado', 2);

-- Crear tabla InformacionUsuario
CREATE TABLE InformacionUsuario (
    id_usuario INT,
    nombre_completo VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    telefono VARCHAR(15),
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Insertar información de usuario
INSERT INTO InformacionUsuario (id_usuario, nombre_completo, email, telefono) VALUES
(1, 'Peter Admin', 'peter.admin@example.com', '+123456789'),
(2, 'David Empleado', 'david.employee@example.com', '+987654321'),
(3, 'Jose Empleado', 'jose.employee@example.com', '+555666777'),
(4, 'Álvaro Empleado', 'alvaro.employee@example.com', '+999888777');


-- Crear tabla Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    numero_cuenta VARCHAR(30) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    email VARCHAR(255),
    PRIMARY KEY (id_cliente),
    UNIQUE (numero_cuenta)
);

-- Crear tabla Producto
CREATE TABLE Producto (
    id_producto INT AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    disponible BOOLEAN NOT NULL,
    categoria VARCHAR(50),
    fecha_adquisicion DATE,
    PRIMARY KEY (id_producto)
);

-- Crear tabla Pedido
CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT,
    id_cliente INT,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion DATE NOT NULL,
    estado ENUM('pendiente', 'entregado', 'devuelto') NOT NULL DEFAULT 'pendiente',
    direccion_entrega VARCHAR(255),
    detalles_envio TEXT,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Crear tabla Producto_Pedido para la relación muchos a muchos
CREATE TABLE Producto_Pedido (
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

-- Crear tabla Factura
CREATE TABLE Factura (
    id_factura INT AUTO_INCREMENT,
    id_pedido INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha_emision TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    metodo_pago VARCHAR(50),
    detalles_facturacion TEXT,
    PRIMARY KEY (id_factura),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido)
);

-- Introducir datos de prueba
INSERT INTO Cliente (nombre, apellidos, numero_cuenta, direccion, telefono, email) VALUES
('John', 'Doe', 'ES12345678901234567890', 'Calle Principal 123', '+123456789', 'john.doe@example.com'),
('Alice', 'Johnson', 'ES98765432109876543210', 'Avenida Secundaria 456', '+987654321', 'alice.j@example.com'),
('Bob', 'Smith', 'ES11112222333344445555', 'Calle Lateral 789', '+112233445', 'bob.smith@example.com'),
('Eva', 'Brown', 'ES55556666777788889999', 'Avenida Central 101', '+555666777', 'eva.brown@example.com'),
('David', 'Miller', 'ES98765432101234567890', 'Calle de Arriba 567', '+999888777', 'david.m@example.com'),
('Sophie', 'Williams', 'ES11223344556677889900', 'Avenida de Abajo 234', '+123890567', 'sophie.w@example.com'),
('Michael', 'Johnson', 'ES11223344557788990011', 'Calle Izquierda 890', '+987654332', 'michael.j@example.com'),
('Emma', 'Clark', 'ES11223344558899001122', 'Avenida Derecha 765', '+112233441', 'emma.c@example.com'),
('Oliver', 'Lee', 'ES11223344559900112233', 'Calle Transversal 321', '+999888777', 'oliver.l@example.com'),
('Mia', 'Scott', 'ES11223344551001122334', 'Avenida Diagonal 876', '+112233445', 'mia.s@example.com'),
('Daniel', 'Davis', 'ES11223344551112233445', 'Calle Curva 543', '+555666777', 'daniel.d@example.com'),
('Ava', 'Taylor', 'ES11223344552223344556', 'Avenida Recta 109', '+123890567', 'ava.t@example.com'),
('Logan', 'Baker', 'ES11223344553334455667', 'Calle Serpentina 876', '+987654332', 'logan.b@example.com'),
('Isabella', 'Carter', 'ES11223344554445566778', 'Avenida Zigzag 234', '+112233441', 'isabella.c@example.com'),
('William', 'Adams', 'ES11223344555556677889', 'Calle Espiral 654', '+999888777', 'william.a@example.com');


INSERT INTO Producto (nombre, descripcion, precio, disponible, categoria, fecha_adquisicion) VALUES
('Micrófono de Escenario', 'Micrófono profesional para actuaciones en vivo.', 150.00, TRUE, 'Audio', '2023-01-15'),
('Silla de Época', 'Réplica de silla antigua para escenografía.', 120.00, TRUE, 'Mobiliario', '2023-02-20'),
('Luces LED para Escenario', 'Juego de luces LED programables.', 200.00, TRUE, 'Iluminación', '2023-03-10'),
('Traje de Época', 'Traje histórico para ambientar la escena.', 180.00, TRUE, 'Vestuario', '2023-04-05'),
('Cañón de Humo', 'Generador de humo para efectos especiales.', 250.00, FALSE, 'Efectos Especiales', '2023-05-12'),
('Instrumento Musical', 'Réplica de un instrumento antiguo para la orquesta.', 300.00, TRUE, 'Instrumentos', '2023-06-01'),
('Máquina de Burbujas', 'Generador de burbujas para escenas mágicas.', 80.00, TRUE, 'Efectos Especiales', '2023-07-15'),
('Decoración de Bosque', 'Set de árboles y plantas para escenografía.', 400.00, TRUE, 'Decorados', '2023-08-20'),
('Armadura Medieval', 'Réplica de una armadura para escenas históricas.', 350.00, FALSE, 'Vestuario', '2023-09-10'),
('Escenografía Urbana', 'Set de edificios y calles para ambientar la ciudad.', 600.00, TRUE, 'Decorados', '2023-10-25'),
('Efecto de Lluvia', 'Sistema de lluvia artificial para escenas dramáticas.', 180.00, TRUE, 'Efectos Especiales', '2023-11-30'),
('Ropa de Época', 'Vestimenta histórica para el elenco.', 280.00, TRUE, 'Vestuario', '2023-12-05'),
('Muebles de Escenario', 'Réplicas de muebles antiguos para la escenografía.', 200.00, TRUE, 'Mobiliario', '2024-01-20'),
('Máscaras Teatrales', 'Conjunto de máscaras para escenas de teatro.', 120.00, FALSE, 'Accesorios', '2024-02-15'),
('Herramientas de Carpintería', 'Set de herramientas para el taller de escenografía.', 350.00, TRUE, 'Accesorios', '2024-03-01');


INSERT INTO Pedido (id_cliente, fecha_devolucion, estado, direccion_entrega, detalles_envio) VALUES
(1, '2024-01-23', 'pendiente', 'Dirección Cliente 1', 'Detalles de Envío 1'),
(2, '2024-02-15', 'entregado', 'Dirección Cliente 2', 'Detalles de Envío 2'),
(3, '2024-03-01', 'pendiente', 'Dirección Cliente 3', 'Detalles de Envío 3'),
(4, '2024-03-15', 'entregado', 'Dirección Cliente 4', 'Detalles de Envío 4'),
(5, '2024-04-01', 'pendiente', 'Dirección Cliente 5', 'Detalles de Envío 5'),
(6, '2024-04-15', 'entregado', 'Dirección Cliente 6', 'Detalles de Envío 6'),
(7, '2024-05-01', 'pendiente', 'Dirección Cliente 7', 'Detalles de Envío 7'),
(8, '2024-05-15', 'entregado', 'Dirección Cliente 8', 'Detalles de Envío 8'),
(9, '2024-06-01', 'pendiente', 'Dirección Cliente 9', 'Detalles de Envío 9'),
(10, '2024-06-15', 'entregado', 'Dirección Cliente 10', 'Detalles de Envío 10'),
(11, '2024-07-01', 'pendiente', 'Dirección Cliente 11', 'Detalles de Envío 11'),
(12, '2024-07-15', 'entregado', 'Dirección Cliente 12', 'Detalles de Envío 12'),
(13, '2024-08-01', 'pendiente', 'Dirección Cliente 13', 'Detalles de Envío 13'),
(14, '2024-08-15', 'entregado', 'Dirección Cliente 14', 'Detalles de Envío 14'),
(15, '2024-09-01', 'pendiente', 'Dirección Cliente 15', 'Detalles de Envío 15');


INSERT INTO Producto_Pedido (id_pedido, id_producto, cantidad) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 2),
(4, 5, 1),
(5, 6, 2),
(6, 7, 3),
(7, 8, 1),
(8, 9, 2),
(9, 10, 3),
(10, 11, 1),
(11, 12, 2),
(12, 13, 3),
(13, 14, 1),
(14, 15, 2);

INSERT INTO Factura (id_pedido, total, metodo_pago, detalles_facturacion) VALUES
(1, 300.00, 'Transferencia Bancaria', 'Detalles de Facturación 1'),
(2, 375.00, 'Tarjeta de Crédito', 'Detalles de Facturación 2'),
(3, 360.00, 'Transferencia Bancaria', 'Detalles de Facturación 3'),
(4, 480.00, 'Tarjeta de Crédito', 'Detalles de Facturación 4'),
(5, 250.00, 'Transferencia Bancaria', 'Detalles de Facturación 5'),
(6, 600.00, 'Tarjeta de Crédito', 'Detalles de Facturación 6'),
(7, 160.00, 'Transferencia Bancaria', 'Detalles de Facturación 7'),
(8, 800.00, 'Tarjeta de Crédito', 'Detalles de Facturación 8'),
(9, 700.00, 'Transferencia Bancaria', 'Detalles de Facturación 9'),
(10, 900.00, 'Tarjeta de Crédito', 'Detalles de Facturación 10'),
(11, 280.00, 'Transferencia Bancaria', 'Detalles de Facturación 11'),
(12, 420.00, 'Tarjeta de Crédito', 'Detalles de Facturación 12'),
(13, 560.00, 'Transferencia Bancaria', 'Detalles de Facturación 13');

-- 1. Listar todos los clientes
SELECT * FROM Cliente;

-- 2. Listar todos los productos
SELECT * FROM Producto;

-- 3. Listar todos los pedidos
SELECT * FROM Pedido;

-- 4. Listar todos los productos en un pedido específico (por ejemplo, Pedido ID 1)
SELECT * FROM Producto_Pedido WHERE id_pedido = 1;

-- 5. Listar todos los productos junto con su categoría
SELECT nombre, categoria FROM Producto;

-- 6. Listar todos los pedidos con sus clientes asociados
SELECT Pedido.*, Cliente.nombre AS nombre_cliente, Cliente.apellidos AS apellidos_cliente
FROM Pedido
JOIN Cliente ON Pedido.id_cliente = Cliente.id_cliente;

-- 7. Calcular el total gastado en cada pedido
SELECT id_pedido, SUM(total) AS total_gastado
FROM Factura
GROUP BY id_pedido;

-- 8. Encontrar los productos que están disponibles para su compra
SELECT * FROM Producto WHERE disponible = TRUE;

-- 9. Encontrar los productos que no están disponibles para su compra
SELECT * FROM Producto WHERE disponible = FALSE;

-- 10. Listar todos los pedidos pendientes de entrega
SELECT * FROM Pedido WHERE estado = 'pendiente';

-- 11. Listar todos los pedidos entregados
SELECT * FROM Pedido WHERE estado = 'entregado';

-- 12. Listar todos los pedidos devueltos
SELECT * FROM Pedido WHERE estado = 'devuelto';

-- 13. Contar la cantidad total de productos vendidos en todos los pedidos
SELECT SUM(cantidad) AS total_productos_vendidos FROM Producto_Pedido;

-- 14. Calcular el total de ingresos generados por todas las facturas
SELECT SUM(total) AS total_ingresos FROM Factura;

-- 15. Encontrar el cliente con más pedidos
SELECT id_cliente, COUNT(id_pedido) AS total_pedidos
FROM Pedido
GROUP BY id_cliente
ORDER BY total_pedidos DESC
LIMIT 1;

-- 16. Listar todos los productos adquiridos en un rango de fechas (por ejemplo, entre '2023-01-01' y '2023-02-01')
SELECT * FROM Producto WHERE fecha_adquisicion BETWEEN '2023-01-01' AND '2023-02-01';

-- 17. Calcular el promedio de precios de todos los productos
SELECT AVG(precio) AS precio_promedio FROM Producto;

-- 18. Listar todos los productos en orden descendente de precio
SELECT * FROM Producto ORDER BY precio DESC;

-- 19. Encontrar el cliente que ha gastado más dinero en total
SELECT Cliente.id_cliente, Cliente.nombre, Cliente.apellidos, SUM(Factura.total) AS total_gastado
FROM Cliente
JOIN Pedido ON Cliente.id_cliente = Pedido.id_cliente
JOIN Factura ON Pedido.id_pedido = Factura.id_pedido
GROUP BY Cliente.id_cliente
ORDER BY total_gastado DESC
LIMIT 1;

-- 20. Listar todos los clientes que han realizado pedidos pendientes
SELECT DISTINCT Cliente.*
FROM Cliente
JOIN Pedido ON Cliente.id_cliente = Pedido.id_cliente
WHERE Pedido.estado = 'pendiente';

-- 21. Listar todos los productos que son efectos especiales
SELECT * FROM Producto WHERE categoria = 'Efectos Especiales';

-- 22. Listar todos los productos que no tienen una fecha de adquisición definida
SELECT * FROM Producto WHERE fecha_adquisicion IS NULL;

-- 23. Listar todos los productos junto con la cantidad en stock (considerando pedidos entregados)
SELECT Producto.*, IFNULL(SUM(Producto_Pedido.cantidad), 0) AS cantidad_en_stock
FROM Producto
LEFT JOIN Producto_Pedido ON Producto.id_producto = Producto_Pedido.id_producto
LEFT JOIN Pedido ON Producto_Pedido.id_pedido = Pedido.id_pedido AND Pedido.estado = 'entregado'
GROUP BY Producto.id_producto;

-- 24. Listar todos los productos que han sido pedidos al menos una vez
SELECT DISTINCT Producto.*
FROM Producto
JOIN Producto_Pedido ON Producto.id_producto = Producto_Pedido.id_producto;

-- 25. Listar todos los productos que no han sido pedidos nunca
SELECT Producto.*
FROM Producto
LEFT JOIN Producto_Pedido ON Producto.id_producto = Producto_Pedido.id_producto
WHERE Producto_Pedido.id_producto IS NULL;







SELECT Pedido.*, Cliente.nombre AS nombre_cliente, Cliente.apellidos AS apellidos_cliente
FROM Pedido
JOIN Cliente ON Pedido.id_cliente = Cliente.id_cliente;

SELECT SUM(total) AS total_ingresos FROM Factura;

INSERT INTO Cliente (nombre, apellidos, numero_cuenta, direccion, telefono, email) VALUES
('Test', 'Duplicate', 'ES12345678901234567890', 'Calle de Prueba 123', '+111222333', 'test.duplicate@example.com');


SELECT * FROM cine_arte_atrezo.Producto;


SELECT * FROM Producto WHERE disponible = TRUE;

SELECT DISTINCT Cliente.*
FROM Cliente
JOIN Pedido ON Cliente.id_cliente = Pedido.id_cliente
WHERE Pedido.estado = 'pendiente';

SHOW ERRORS;
