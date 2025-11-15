CREATE DATABASE Clinica_IPS;
GO
USE Clinica_IPS;
GO

CREATE TABLE Rol (
    ID_Rol INT PRIMARY KEY,
    Nombre_Rol VARCHAR(50)
);

CREATE TABLE Empleado (
    ID_Empleado INT PRIMARY KEY,
    Nombre_Completo VARCHAR(50),
    Cedula VARCHAR(20),
    Correo_Electronico VARCHAR(50),
    Telefono VARCHAR(20),
    Fecha_Nacimiento DATE,
    Direccion VARCHAR(50),
    ID_Rol INT,
    FOREIGN KEY (ID_Rol) REFERENCES Rol(ID_Rol)
);

CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    ID_Empleado INT,
    Nombre_Usuario VARCHAR(20),
    Contraseña VARCHAR(50),
    Fecha_Creacion DATE,
    FOREIGN KEY (ID_Empleado) REFERENCES Empleado(ID_Empleado)
);

CREATE TABLE Sesion (
    ID_Sesion INT PRIMARY KEY,
    ID_Usuario INT,
    Fecha_Inicio DATE,
    Fecha_Cierre DATE,
    IP_Conexion VARCHAR(50),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario)
);


CREATE TABLE Paciente (
    ID_Paciente INT PRIMARY KEY,
    Cedula VARCHAR(20),
    Nombre_Completo VARCHAR(50),
    Fecha_Nacimiento DATE,
    Genero VARCHAR(20),
    Direccion VARCHAR(50),
    Telefono VARCHAR(20),
    Correo_Electronico VARCHAR(50)
);

CREATE TABLE Contacto_Emergencia (
    ID_Contacto INT PRIMARY KEY,
    ID_Paciente INT,
    Nombre_Contacto VARCHAR(50),
    Relacion VARCHAR(30),
    Telefono_Contacto VARCHAR(20),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente)
);

CREATE TABLE Compañia_Seguros (
    ID_Compañia INT PRIMARY KEY,
    Nombre_Compañia VARCHAR(50)
);

CREATE TABLE Seguro_Medico (
    ID_Seguro INT PRIMARY KEY,
    ID_Paciente INT,
    ID_Compania INT,
    Numero_Poliza VARCHAR(20),
    Estado_Poliza VARCHAR(10),
    Vigencia_Poliza VARCHAR(15),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (ID_Compania) REFERENCES Compañia_Seguros(ID_Compañia)
    );
    
    CREATE TABLE Factura (
    ID_Factura INT PRIMARY KEY,
    ID_Paciente INT,
    ID_Seguro INT,
    ID_Medico INT,
    Fecha_Factura VARCHAR(15),
    Copago DECIMAL(12,2),
    Total DECIMAL(12,2),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente),
    FOREIGN KEY (ID_Seguro) REFERENCES Seguro_Medico(ID_Seguro),
    FOREIGN KEY (ID_Medico) REFERENCES Empleado(ID_Empleado)
);

CREATE TABLE Detalle_Factura (
    ID_Detalle INT PRIMARY KEY,
    ID_Factura INT,
    Descripcion VARCHAR(100),
    Costo DECIMAL(12,2),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura)
);

CREATE TABLE Pago (
    ID_Pago INT PRIMARY KEY,
    ID_Factura INT,
    Fecha_Pago VARCHAR(15),
    Monto DECIMAL(12,2),
    Metodo_Pago VARCHAR(30),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura)
);

CREATE TABLE Orden (
    Numero_Orden INT PRIMARY KEY,
    Cedula_Paciente VARCHAR(15),
    Cedula_Medico VARCHAR(15),
    Fecha_Creacion VARCHAR(15)
);

CREATE TABLE Medicamento (
    ID_Medicamento INT PRIMARY KEY,
    Nombre_Medicamento VARCHAR(50),
    Costo DECIMAL(12,2)
);

CREATE TABLE Procedimiento (
    ID_Procedimiento INT PRIMARY KEY,
    Nombre_Procedimiento VARCHAR(50),
    Costo DECIMAL(12,2)
);


CREATE TABLE Especialidad (
    ID_Especialidad INT PRIMARY KEY,
    Nombre_Especialidad VARCHAR(50)
);

CREATE TABLE Ayuda_Diagnostica (
    ID_Ayuda INT PRIMARY KEY,
    Nombre_Ayuda VARCHAR(50),
    Costo DECIMAL(12,2)
);

CREATE TABLE Orden_Medicamento (
    ID_Orden_Medicamento INT PRIMARY KEY,
    Numero_Orden INT,
    Numero_Item INT,
    ID_Medicamento INT,
    Dosis VARCHAR(30),
    Duracion_Tratamiento VARCHAR(30),
    Costo DECIMAL(12,2),
    FOREIGN KEY (Numero_Orden) REFERENCES Orden(Numero_Orden),
    FOREIGN KEY (ID_Medicamento) REFERENCES Medicamento(ID_Medicamento)
);

CREATE TABLE Orden_Procedimiento (
    ID_Orden_Procedimiento INT PRIMARY KEY,
    Numero_Orden INT,
    Numero_Item INT,
    ID_Procedimiento INT,
    Repeticiones INT,
    Frecuencia VARCHAR(30),
    Costo DECIMAL(12,2),
    Requiere_Especialista VARCHAR(5),
    ID_Especialidad INT,
    FOREIGN KEY (Numero_Orden) REFERENCES Orden(Numero_Orden),
    FOREIGN KEY (ID_Procedimiento) REFERENCES Procedimiento(ID_Procedimiento),
    FOREIGN KEY (ID_Especialidad) REFERENCES Especialidad(ID_Especialidad)
);

CREATE TABLE Orden_Ayuda_Diagnostica (
    ID_Orden_Ayuda INT PRIMARY KEY,
    Numero_Orden INT,
    Numero_Item INT,
    ID_Ayuda INT,
    Cantidad INT,
    Costo DECIMAL(12,2),
    Requiere_Especialista VARCHAR(5),
    ID_Especialidad INT,
    FOREIGN KEY (Numero_Orden) REFERENCES Orden(Numero_Orden),
    FOREIGN KEY (ID_Ayuda) REFERENCES Ayuda_Diagnostica(ID_Ayuda),
    FOREIGN KEY (ID_Especialidad) REFERENCES Especialidad(ID_Especialidad)
);

CREATE TABLE Signos_Vitales (
    ID_Signo INT PRIMARY KEY,
    ID_Paciente INT,
    Presion_Arterial VARCHAR(15),
    Temperatura VARCHAR(10),
    Pulso VARCHAR(10),
    Nivel_Oxigeno VARCHAR(10),
    FOREIGN KEY (ID_Paciente) REFERENCES Paciente(ID_Paciente)
);

CREATE TABLE Historia_Clinica_NoSQL (
    Cedula_Paciente VARCHAR(15),
    Fecha_Atencion VARCHAR(15),
    Cedula_Medico VARCHAR(15),
    Motivo_Consulta VARCHAR(100),
    Sintomatologia VARCHAR(100),
    Diagnostico VARCHAR(100)
);



