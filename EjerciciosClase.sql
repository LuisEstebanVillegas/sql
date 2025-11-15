GO
USE TallerAutos
GO
-- 8. Sumar el valor total de todos los pedidos
select 
	sum (precio_final) as Valor_Total
from Carro
inner join Detalle_Pedido on Detalle_Pedido.id_carro = Carro.id_carro

--20 Ventas mensuales de cada vendedor -
SELECT 
    Vendedor.nombre_vendedor,
    MONTH(Pedido.fecha_pedido) AS mes,
    COUNT(Pedido.id_pedido) AS ventas_realizadas
FROM Pedido
JOIN Vendedor ON Pedido.id_vendedor = Vendedor.id_vendedor
GROUP BY Vendedor.nombre_vendedor, MONTH(Pedido.fecha_pedido)
ORDER BY Vendedor.nombre_vendedor, mes

--30 Modelos más vendidos por categoría -
SELECT 
    Categoria_Carro.nombre_categoria,
    Modelo.nombre_modelo,
    SUM(Carro.id_categoria) AS total_vendido
FROM Categoria_Carro
JOIN Carro ON Categoria_Carro.id_categoria = Carro.id_categoria
JOIN Detalle_Pedido ON Detalle_Pedido.id_carro = Carro.id_carro
JOIN Modelo ON Modelo.id_modelo = Carro.id_modelo

GROUP BY Categoria_Carro.nombre_categoria, nombre_modelo
ORDER BY total_vendido DESC;

-- EJERCICIOS CLINICA

go 
use Clinica_IPS
go

-- Especialidad con mas consultas 

SELECT 
	Nombre_Especialidad, 
	COUNT(Numero_Orden) AS Cantidad_Consultas
FROM Especialidad
INNER JOIN Orden_Procedimiento ON Especialidad.ID_Especialidad = Orden_Procedimiento.ID_Especialidad
GROUP BY Nombre_Especialidad
ORDER BY COUNT(Numero_Orden) DESC

-- y el medico con mas pacientes
SELECT 
	Nombre_Completo, 
	COUNT(ID_Paciente) AS Numero_pacientes
FROM Empleado
INNER JOIN Factura ON Empleado.ID_Empleado = Factura.ID_Medico
GROUP BY Nombre_Completo
ORDER BY COUNT(ID_Paciente) DESC
