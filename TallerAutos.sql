-- Taller Consesionaria - Base de Datos I 2025-2
-- Studiante: Luis Esteban Villegas
-- GitHub https://github.com/LuisEstebanVillegas/sql
-- Versión corregida

create database TallerAutos
go
use TallerAutos
go

-- =====================================================
--  Paises - Departamentos - Ciudades
-- =====================================================

CREATE TABLE Pais (
    id_pais int primary key identity (1,1),
    nombre_pais VARCHAR(100) NOT NULL
);

CREATE TABLE Departamento (
    id_departamento int primary key identity (1,1),
    nombre_departamento VARCHAR(100) NOT NULL,
    id_pais INT,
    FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)
);

CREATE TABLE Ciudad (
    id_ciudad int primary key identity (1,1),
    nombre_ciudad VARCHAR(100) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

-- =====================================================
--  CLIENTES Y DOCUMENTOS
-- =====================================================

CREATE TABLE Tipo_Documento (
    id_tipo_documento int primary key identity (1,1),
    tipo_documento VARCHAR(10) NOT NULL
);

CREATE TABLE Direccion (
    id_direccion int primary key identity (1,1),
    direccion VARCHAR(255) NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

CREATE TABLE Cliente (
    id_cliente int primary key identity (1,1),
    nombre_cliente VARCHAR(100) NOT NULL,
    email_cliente VARCHAR(100),
    telefono_cliente VARCHAR(20),
    id_tipo_documento INT,
    num_documento VARCHAR(20),
    id_direccion INT,
    FOREIGN KEY (id_tipo_documento) REFERENCES Tipo_Documento(id_tipo_documento),
    FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion)
);

-- =====================================================
--  VEHÍCULOS Y ATRIBUTOS
-- =====================================================

CREATE TABLE Marca (
    id_marca int primary key identity (1,1),
    nombre_marca VARCHAR(100) NOT NULL
);

CREATE TABLE Modelo (
    id_modelo int primary key identity (1,1),
    nombre_modelo VARCHAR(100) NOT NULL,
    año int
);

CREATE TABLE Categoria_Carro (
    id_categoria int primary key identity (1,1),
    nombre_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE Tipo_Carroceria (
    id_tipo_carroceria int primary key identity (1,1),
    tipo_carroceria VARCHAR(50) NOT NULL
);

CREATE TABLE Transmision (
    id_transmision int primary key identity (1,1),
    tipo_transmision VARCHAR(50) NOT NULL
);

CREATE TABLE Combustible (
    id_combustible int primary key identity (1,1),
    tipo_combustible VARCHAR(50) NOT NULL
);

CREATE TABLE Carro (
    id_carro int primary key identity (1,1),
    id_marca INT,
    id_modelo INT,
    color VARCHAR(50),
    precio_base DECIMAL(15,2),
    descuento DECIMAL(15,2),
    precio_final DECIMAL(15,2),
    id_categoria INT,
    id_tipo_carroceria INT,
    motor VARCHAR(50),
    id_transmision INT,
    id_combustible INT,
    kilometraje INT,
    num_puertas INT,
    num_pasajeros INT,
    FOREIGN KEY (id_marca) REFERENCES Marca(id_marca),
    FOREIGN KEY (id_modelo) REFERENCES Modelo(id_modelo),
    FOREIGN KEY (id_categoria) REFERENCES Categoria_Carro(id_categoria),
    FOREIGN KEY (id_tipo_carroceria) REFERENCES Tipo_Carroceria(id_tipo_carroceria),
    FOREIGN KEY (id_transmision) REFERENCES Transmision(id_transmision),
    FOREIGN KEY (id_combustible) REFERENCES Combustible(id_combustible)
);

-- =====================================================
--  VENDEDOR Y SUCURSAL
-- =====================================================

CREATE TABLE Vendedor (
    id_vendedor int primary key identity (1,1),
    nombre_vendedor VARCHAR(100) NOT NULL,
    email_vendedor VARCHAR(100),
    telefono_vendedor VARCHAR(20),
    comision DECIMAL(5,2)
);

CREATE TABLE Sucursal (
    id_sucursal int primary key identity (1,1),
    nombre_sucursal VARCHAR(100) NOT NULL,
    id_ciudad INT,
    FOREIGN KEY (id_ciudad) REFERENCES Ciudad(id_ciudad)
);

-- =====================================================
--  PAGO Y FINANCIACIÓN
-- =====================================================

CREATE TABLE Pago (
    id_pago int primary key identity (1,1),
    metodo_pago VARCHAR(50),
    cuotas INT,
    entidad_financiera VARCHAR(100),
    tasa_interes DECIMAL(5,2)
);

-- =====================================================
--  ENTREGA, SEGURO, TEST DRIVE, TRANSPORTADORA
-- =====================================================

CREATE TABLE Entrega (
    id_entrega int primary key identity (1,1),
    forma_entrega VARCHAR(50),
    id_direccion INT,
    fecha_entrega DATE,
    garantia VARCHAR(50),
    meses_garantia INT,
    FOREIGN KEY (id_direccion) REFERENCES Direccion(id_direccion)
);

CREATE TABLE Seguro (
    id_seguro int primary key identity (1,1),
    seguro_incluido varchar(10),
    aseguradora VARCHAR(100),
    valor_seguro DECIMAL(15,2)
);

CREATE TABLE Test_Drive (
    id_test_drive int primary key identity (1,1),
    test_drive varchar(10),
    fecha_test DATE
);

CREATE TABLE Transportadora (
    id_transportadora int primary key identity (1,1),
    nombre_transportadora VARCHAR(100)
);

-- =====================================================
--  ACCESORIOS
-- =====================================================

CREATE TABLE Accesorios (
    id_accesorio int primary key identity (1,1),
    descripcion_accesorio VARCHAR(255)
);

-- =====================================================
--  PEDIDOS (Encabezado)
-- =====================================================

CREATE TABLE Pedido (
    id_pedido int primary key identity (1,1),
    num_pedido VARCHAR(20) UNIQUE,
    fecha_pedido DATE,
    id_cliente INT,
    id_vendedor INT,
    id_sucursal INT,
    id_pago INT,
    id_entrega INT,
    id_seguro INT,
    id_test_drive INT,
    id_transportadora INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor),
    FOREIGN KEY (id_sucursal) REFERENCES Sucursal(id_sucursal),
    FOREIGN KEY (id_pago) REFERENCES Pago(id_pago),
    FOREIGN KEY (id_entrega) REFERENCES Entrega(id_entrega),
    FOREIGN KEY (id_seguro) REFERENCES Seguro(id_seguro),
    FOREIGN KEY (id_test_drive) REFERENCES Test_Drive(id_test_drive),
    FOREIGN KEY (id_transportadora) REFERENCES Transportadora(id_transportadora)
);

-- =====================================================
--  DETALLE DEL PEDIDO (Carros por pedido)
-- =====================================================

CREATE TABLE Detalle_Pedido (
    id_detalle_pedido int primary key identity (1,1),
    id_pedido INT,
    id_carro INT,
    id_accesorio INT,
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_carro) REFERENCES Carro(id_carro),
    FOREIGN KEY (id_accesorio) REFERENCES Accesorios(id_accesorio)
);

-------------------------------------------====================================================================
-- INSERTS ----------------------------------------------------------------------------------------------------
-------------------------------------------====================================================================


-- =====================================================
--  PAISES
-- =====================================================
INSERT INTO Pais (nombre_pais) VALUES ('Colombia');

-- =====================================================
--  DEPARTAMENTOS
-- =====================================================
INSERT INTO Departamento (nombre_departamento, id_pais) VALUES
('Antioquia', 1),
('Cundinamarca', 1),
('Valle del Cauca', 1),
('Atlántico', 1);

-- =====================================================
--  CIUDADES
-- =====================================================
INSERT INTO Ciudad (nombre_ciudad, id_departamento) VALUES
('Medellín', 1),
('Bogotá', 2),
('Cali', 3),
('Barranquilla', 4);

-- =====================================================
--  TIPOS DE DOCUMENTO
-- =====================================================
INSERT INTO Tipo_Documento (tipo_documento) VALUES
('CC'), ('CE');

-- =====================================================
--  DIRECCIONES
-- =====================================================
INSERT INTO Direccion (direccion, id_ciudad) VALUES
('Calle 45 #23-10', 1),
('Carrera 70 #80-15', 2),
('Avenida 6 #25-30', 3),
('Calle 100 #15-20', 2),
('Carrera 50 #45-30', 4);

-- =====================================================
--  CLIENTES
-- =====================================================
INSERT INTO Cliente (nombre_cliente, email_cliente, telefono_cliente, id_tipo_documento, num_documento, id_direccion) VALUES
('Juan Pérez', 'juan.perez@email.com', '3001234567', 1, '1234567890', 1),
('Ana García', 'ana.garcia@email.com', '3009876543', 1, '9876543210', 2),
('Carlos López', 'carlos.lopez@email.com', '3112345678', 2, '1122334455', 3),
('María Rodríguez', 'maria.rod@email.com', '3156789012', 1, '5544332211', 4),
('Pedro Sánchez', 'pedro.sanchez@email.com', '3201239876', 1, '6677889900', 5);

-- =====================================================
--  MARCAS
-- =====================================================
INSERT INTO Marca (nombre_marca) VALUES
('Toyota'),
('Honda'),
('Mazda'),
('Chevrolet'),
('Nissan');

-- =====================================================
--  MODELOS
-- =====================================================
INSERT INTO Modelo (nombre_modelo, año) VALUES
('Corolla', 2024),
('Civic', 2024),
('3', 2023),
('Spark', 2023),
('Sentra', 2024);

-- =====================================================
--  CATEGORÍA CARRO
-- =====================================================
INSERT INTO Categoria_Carro (nombre_categoria) VALUES
('Sedán'),
('Hatchback');

-- =====================================================
--  TIPO CARROCERÍA
-- =====================================================
INSERT INTO Tipo_Carroceria (tipo_carroceria) VALUES
('Sedán'),
('Hatchback');

-- =====================================================
--  TRANSMISION
-- =====================================================
INSERT INTO Transmision (tipo_transmision) VALUES
('Automática'),
('Manual'),
('CVT');

-- =====================================================
--  COMBUSTIBLE
-- =====================================================
INSERT INTO Combustible (tipo_combustible) VALUES
('Gasolina');

-- =====================================================
--  CARROS
-- =====================================================
INSERT INTO Carro (id_marca, id_modelo, color, precio_base, descuento, precio_final, id_categoria, id_tipo_carroceria, motor, id_transmision, id_combustible, kilometraje, num_puertas, num_pasajeros) VALUES
(1, 1, 'Blanco', 85000000, 18000000, 162000000, 1, 1, '1.8L', 1, 1, 0, 4, 5),
(2, 2, 'Negro', 95000000, 18000000, 162000000, 1, 1, '2.0L', 2, 1, 0, 4, 5),
(3, 3, 'Rojo', 90000000, 0, 90000000, 1, 1, '2.5L', 1, 1, 5000, 4, 5),
(4, 4, 'Azul', 45000000, 4500000, 40500000, 2, 2, '1.4L', 2, 1, 0, 5, 5),
(5, 5, 'Plata', 88000000, 0, 88000000, 1, 1, '1.8L', 3, 1, 0, 4, 5);

-- =====================================================
--  VENDEDORES
-- =====================================================
INSERT INTO Vendedor (nombre_vendedor, email_vendedor, telefono_vendedor, comision) VALUES
('María López', 'maria.lopez@carros.com', '3107654321', 5),
('Carlos Ruiz', 'carlos.ruiz@carros.com', '3156789012', 5),
('Laura Martínez', 'laura.martinez@carros.com', '3201234567', 5);

-- =====================================================
--  SUCURSALES
-- =====================================================
INSERT INTO Sucursal (nombre_sucursal, id_ciudad) VALUES
('Medellín Centro', 1),
('Bogotá Norte', 2),
('Cali Sur', 3);

-- =====================================================
--  MÉTODOS DE PAGO
-- =====================================================
INSERT INTO Pago (metodo_pago, cuotas, entidad_financiera, tasa_interes) VALUES
('Efectivo', 0, NULL, NULL),
('Tarjeta de Crédito', 0, NULL, NULL),
('Financiación', 36, 'Bancolombia', 11),
('Cheque', 0, NULL, NULL),
('Financiación', 48, 'Davivienda', 12);

-- =====================================================
--  ENTREGAS
-- =====================================================
INSERT INTO Entrega (forma_entrega, id_direccion, fecha_entrega, garantia, meses_garantia) VALUES
('Domicilio', 1, '2025-01-20', 'Incluida', 12),
('Domicilio', 2, '2025-01-21', 'Incluida', 12),
('Domicilio', 3, '2025-01-22', 'Incluida', 12),
('Domicilio', 4, '2025-01-23', 'Incluida', 12),
('Domicilio', 5, '2025-01-24', 'Incluida', 12),
('Domicilio', 1, '2025-01-25', 'Incluida', 12),
('Domicilio', 2, '2025-01-26', 'Incluida', 12),
('Domicilio', 3, '2025-01-27', 'Incluida', 12),
('Domicilio', 4, '2025-01-28', 'Incluida', 12),
('Domicilio', 5, '2025-01-29', 'Incluida', 12);

-- =====================================================
-- 🔹 SEGUROS
-- =====================================================
INSERT INTO Seguro (seguro_incluido, aseguradora, valor_seguro) VALUES
('Si', 'Seguros Bolivar', 2500000),
('No', NULL, 0),
('Si', 'Seguros Bolivar', 2500000),
('No', NULL, 0),
('Si', 'Seguros Bolivar', 2500000),
('No', NULL, 0),
('Si', 'Seguros Bolivar', 2500000),
('No', NULL, 0),
('Si', 'Seguros Bolivar', 2500000),
('No', NULL, 0);

-- =====================================================
-- 🔹 TEST DRIVES
-- =====================================================
INSERT INTO Test_Drive (test_drive, fecha_test) VALUES
('Si', '2025-01-25'),
('No', NULL),
('No', NULL),
('Si', '2025-01-28'),
('No', NULL),
('No', NULL),
('Si', '2025-01-31'),
('No', NULL),
('Si', '2025-02-02'),
('No', NULL);

-- =====================================================
-- 🔹 TRANSPORTADORAS
-- =====================================================
INSERT INTO Transportadora (nombre_transportadora) VALUES
('Servientrega'),
('Coordinadora'),
('TCC'),
('Deprisa');

-- =====================================================
-- 🔹 ACCESORIOS
-- =====================================================
INSERT INTO Accesorios (descripcion_accesorio) VALUES
('Alarma'),
('Vidrios Polarizados'),
('Ninguno');

-- =====================================================
-- 🔹 PEDIDOS
-- =====================================================
INSERT INTO Pedido (num_pedido, fecha_pedido, id_cliente, id_vendedor, id_sucursal, id_pago, id_entrega, id_seguro, id_test_drive, id_transportadora) VALUES
('PED0001', '2025-01-15', 1, 1, 1, 1, 1, 1, 1, 1),
('PED0002', '2025-01-16', 2, 2, 2, 2, 2, 2, 2, 2),
('PED0003', '2025-01-17', 3, 3, 3, 3, 3, 3, 3, 3),
('PED0004', '2025-01-18', 4, 1, 1, 4, 4, 4, 4, 4),
('PED0005', '2025-01-19', 5, 2, 2, 1, 5, 5, 5, 1),
('PED0006', '2025-01-20', 1, 3, 3, 2, 6, 6, 6, 2),
('PED0007', '2025-01-21', 2, 1, 1, 5, 7, 7, 7, 3),
('PED0008', '2025-01-22', 3, 2, 2, 4, 8, 8, 8, 4),
('PED0009', '2025-01-23', 4, 3, 3, 1, 9, 9, 9, 1),
('PED0010', '2025-01-24', 5, 1, 1, 2, 10, 10, 10, 2);

-- =====================================================
-- 🔹 DETALLE DE PEDIDOS
-- =====================================================
INSERT INTO Detalle_Pedido (id_pedido, id_carro, id_accesorio) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 3),
(3, 4, 1),
(4, 5, 3),
(5, 1, 3),
(6, 2, 1),
(7, 3, 3),
(8, 4, 3),
(8, 5, 3),
(9, 1, 1),
(10, 2, 3);


--========================================================================================================
-- Consulta de verificación ------------------------------------------------------------------------------
-- Vista general --
/*
SELECT 
    p.num_pedido,
    c.nombre_cliente,
    v.nombre_vendedor,
    s.nombre_sucursal,
    pa.metodo_pago,
    e.forma_entrega,
    se.seguro_incluido,
    t.test_drive,
    tr.nombre_transportadora
FROM Pedido p
INNER JOIN Cliente c ON p.id_cliente = c.id_cliente
INNER JOIN Vendedor v ON p.id_vendedor = v.id_vendedor
INNER JOIN Sucursal s ON p.id_sucursal = s.id_sucursal
INNER JOIN Pago pa ON p.id_pago = pa.id_pago
INNER JOIN Entrega e ON p.id_entrega = e.id_entrega
INNER JOIN Seguro se ON p.id_seguro = se.id_seguro
INNER JOIN Test_Drive t ON p.id_test_drive = t.id_test_drive
INNER JOIN Transportadora tr ON p.id_transportadora = tr.id_transportadora
ORDER BY p.num_pedido;
*/

-- JOINS -----------------

select 
    nombre_marca,nombre_modelo
from Modelo
inner join Marca on Modelo.id_modelo = Marca.id_marca

--- Con alias ---------------
select 
    mode.nombre_modelo,
    mar.nombre_marca
from Modelo
inner join Marca on Modelo.id_modelo = Marca.id_marca



-- Nomnbre del vendedor que ha realizado pedidos con un descuento del 10%

select precio_base
from Carro
where sum(precio_base * 0.1) = descuento;
select 
    *

from Vendedor
inner join Carro on Vendedor.id_vendedor = Carro.id_carro

SELECT 
nombre_vendedor
FROM Vendedor, Carro
INNER JOIN Pedido ON Vendedor.id_vendedor = Pedido.id_vendedor
inner join  on Pedido.num_pedido = Carro.id_carro
WHERE Carro.descuento = 0.10;



-- Obtener los email de los clientes que adquirieron Toyota
