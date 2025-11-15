-- Luis Esteban Villegas

CREATE DATABASE ClinicaIPS;
go
USE ClinicaIPS;
go

-- Tabla de Usuarios (Empleados)
CREATE TABLE Usuario (
    cedula VARCHAR(10) PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(30) NOT NULL,
    rol VARCHAR(50) NOT NULL,
    nombre_usuario VARCHAR(15) UNIQUE NOT NULL,
    contrasena VARCHAR(100) NOT NULL
);

-- Tabla de Pacientes
CREATE TABLE Paciente (
    cedula VARCHAR(10) PRIMARY KEY,
    nombre_completo VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    correo_electronico VARCHAR(100)
);

-- Tabla de Contacto de Emergencia
CREATE TABLE ContactoEmergencia (
    id_contacto INT PRIMARY KEY AUTO_INCREMENT,
    cedula_paciente VARCHAR(10) NOT NULL,
    nombre_contacto VARCHAR(100) NOT NULL,
    relacion VARCHAR(50) NOT NULL,
    telefono_emergencia VARCHAR(10) NOT NULL,
    FOREIGN KEY (cedula_paciente) REFERENCES Paciente(cedula)
);

-- Tabla de Seguro Médico
CREATE TABLE SeguroMedico (
    id_seguro INT PRIMARY KEY AUTO_INCREMENT,
    cedula_paciente VARCHAR(10) NOT NULL,
    nombre_compania VARCHAR(100) NOT NULL,
    numero_poliza VARCHAR(50) NOT NULL,
    estado_poliza BOOLEAN NOT NULL,
    vigencia_poliza DATE NOT NULL,
    FOREIGN KEY (cedula_paciente) REFERENCES Paciente(cedula)
);

-- Tabla de Inventario de Medicamentos
CREATE TABLE InventarioMedicamento (
    id_medicamento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_medicamento VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    costo DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- Tabla de Inventario de Procedimientos
CREATE TABLE InventarioProcedimiento (
    id_procedimiento INT PRIMARY KEY AUTO_INCREMENT,
    nombre_procedimiento VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    costo DECIMAL(10, 2) NOT NULL
);

-- Tabla de Inventario de Ayudas Diagnósticas
CREATE TABLE InventarioAyudaDiagnostica (
    id_ayuda INT PRIMARY KEY AUTO_INCREMENT,
    nombre_ayuda VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    costo DECIMAL(10, 2) NOT NULL
);

-- Tabla de Especialidades
CREATE TABLE Especialidad (
    id_especialidad INT PRIMARY KEY AUTO_INCREMENT,
    nombre_especialidad VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200)
);

-- Tabla de Ordenes
CREATE TABLE Orden (
    numero_orden INT PRIMARY KEY,
    cedula_paciente VARCHAR(10) NOT NULL,
    cedula_medico VARCHAR(10) NOT NULL,
    fecha_creacion DATE NOT NULL,
    FOREIGN KEY (cedula_paciente) REFERENCES Paciente(cedula),
    FOREIGN KEY (cedula_medico) REFERENCES Usuario(cedula)
);

-- Tabla de Orden Medicamento
CREATE TABLE OrdenMedicamento (
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    nombre_medicamento VARCHAR(100) NOT NULL,
    dosis VARCHAR(50) NOT NULL,
    duracion_tratamiento VARCHAR(50) NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (numero_orden, numero_item),
    FOREIGN KEY (numero_orden) REFERENCES Orden(numero_orden)
);

-- Tabla de Orden Procedimiento
CREATE TABLE OrdenProcedimiento (
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    nombre_procedimiento VARCHAR(100) NOT NULL,
    numero_veces INT NOT NULL,
    frecuencia VARCHAR(50) NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    requiere_especialista BOOLEAN NOT NULL,
    id_especialidad INT,
    PRIMARY KEY (numero_orden, numero_item),
    FOREIGN KEY (numero_orden) REFERENCES Orden(numero_orden),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
);

-- Tabla de Orden Ayuda Diagnóstica
CREATE TABLE OrdenAyudaDiagnostica (
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    nombre_ayuda VARCHAR(100) NOT NULL,
    cantidad INT NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    requiere_especialista BOOLEAN NOT NULL,
    id_especialidad INT,
    PRIMARY KEY (numero_orden, numero_item),
    FOREIGN KEY (numero_orden) REFERENCES Orden(numero_orden),
    FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad)
);

-- Tabla de Signos Vitales (Registro de Enfermería)
CREATE TABLE SignosVitales (
    id_registro INT PRIMARY KEY AUTO_INCREMENT,
    cedula_paciente VARCHAR(10) NOT NULL,
    cedula_enfermera VARCHAR(10) NOT NULL,
    fecha_registro DATETIME NOT NULL,
    presion_arterial VARCHAR(20),
    temperatura DECIMAL(4, 1),
    pulso INT,
    nivel_oxigeno DECIMAL(4, 1),
    observaciones TEXT,
    FOREIGN KEY (cedula_paciente) REFERENCES Paciente(cedula),
    FOREIGN KEY (cedula_enfermera) REFERENCES Usuario(cedula)
);

-- Tabla de Aplicación de Medicamentos (Enfermería)
CREATE TABLE AplicacionMedicamento (
    id_aplicacion INT PRIMARY KEY AUTO_INCREMENT,
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    cedula_enfermera VARCHAR(10) NOT NULL,
    fecha_aplicacion DATETIME NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (numero_orden, numero_item) REFERENCES OrdenMedicamento(numero_orden, numero_item),
    FOREIGN KEY (cedula_enfermera) REFERENCES Usuario(cedula)
);

-- Tabla de Realización de Procedimientos (Enfermería)
CREATE TABLE RealizacionProcedimiento (
    id_realizacion INT PRIMARY KEY AUTO_INCREMENT,
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    cedula_enfermera VARCHAR(10) NOT NULL,
    fecha_realizacion DATETIME NOT NULL,
    observaciones TEXT,
    FOREIGN KEY (numero_orden, numero_item) REFERENCES OrdenProcedimiento(numero_orden, numero_item),
    FOREIGN KEY (cedula_enfermera) REFERENCES Usuario(cedula)
);

-- Tabla de Facturación
CREATE TABLE Factura (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    cedula_paciente VARCHAR(10) NOT NULL,
    cedula_medico VARCHAR(10) NOT NULL,
    fecha_factura DATE NOT NULL,
    copago DECIMAL(10, 2) NOT NULL,
    total_servicios DECIMAL(10, 2) NOT NULL,
    total_aseguradora DECIMAL(10, 2) NOT NULL,
    total_paciente DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (cedula_paciente) REFERENCES Paciente(cedula),
    FOREIGN KEY (cedula_medico) REFERENCES Usuario(cedula)
);

-- Tabla de Detalle de Factura
CREATE TABLE DetalleFactura (
    id_detalle INT PRIMARY KEY AUTO_INCREMENT,
    id_factura INT NOT NULL,
    numero_orden INT NOT NULL,
    numero_item INT NOT NULL,
    tipo_servicio VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NOT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_factura) REFERENCES Factura(id_factura),
    FOREIGN KEY (numero_orden) REFERENCES Orden(numero_orden)
);