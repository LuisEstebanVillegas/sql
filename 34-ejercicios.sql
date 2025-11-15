-- ====== Base de Datos TallerAutos ======
--1 Listar todos los clientes ordenados alfabéticamente
--2 Contar el total de carros en inventario
--3 Obtener el precio promedio de los carros
--4 Encontrar el carro más caro
--5 Encontrar el carro más barato
--6 Listar marcas ordenadas por año de fundación
--7 Contar cuántos clientes hay por tipo de documento
--8 Sumar el valor total de todos los pedidos -
--9 Obtener estadísticas básicas de precios
--10 Contar carros por estado
--11 Carros con información de su modelo
--12 Contar pedidos por cliente
--13 Carros por marca ordenados por precio
--14 Ventas totales por vendedor
--15 Ciudades con cantidad de clientes
--16 Precio promedio por marca
--17 Clientes con y sin pedidos
--18 Modelos con y sin ventas
--19 Carros disponibles por categoría
--20 Ventas mensuales de cada vendedor -
--21 Top 5 clientes por gasto
--22 Análisis de descuentos aplicados
--23 Carros por color y transmisión
--24 Ciudades con mayor volumen de ventas
--25 Marcas con precio promedio por categoría
--26 Análisis de entregas por transportadora
--27 Todos los colores aunque no tengan carros
--28 Análisis de financiamiento por banco
--29 Clientes por ciudad con análisis de compra
--30 Modelos más vendidos por categoría -
--31 Listar el inventario completo con todas las especificaciones técnicas y de origen.
--32 Rastrear el estado de cada entrega con información del cliente, ubicación destino y transportadora
--33 Identificar qué tipos de carros prefiere cada segmento de clientes según su ubicación.
--34 Analizar qué métodos de pago se usan más en cada sucursal y su impacto en ventas.


--====== Solución Ejercicios Consultas SQL =======

use TallerAutos
go

-- 1. Listar todos los clientes ordenados alfabéticamente
select nombre_cliente
from Cliente
order by nombre_cliente asc

-- 2. Contar el total de carros en inventario
select count(*) as Total_Carros
from Carro

-- 3. Obtener el precio promedio de los carros
select AVG(precio_final) as precio_promedio
from Carro

-- 4. Encontrar el carro más caro
select MAX(precio_final) as Carro_Costoso
from Carro

-- 5. Encontrar el carro más barato
select min(precio_final) as Carro_Barato
from Carro

-- 6. Listar marcas ordenadas por año de fundación ???
select nombre_modelo, año
from Modelo
order by año asc

-- 7. Contar cuántos clientes hay por tipo de documento
select count(num_documento) as clientes_por_tipo_de_documento
from Cliente

-- 8. Sumar el valor total de todos los pedidos
select 
	sum (precio_final) as Valor_Total
from Carro
inner join Detalle_Pedido on Detalle_Pedido.id_carro = Carro.id_carro;

-- 9. Obtener estadísticas básicas de precios
select 
	AVG(precio_base) as Promedio_Precio_base_Carros,
	AVG(precio_final) as Promedio_Precio_final_Carros,
	count(id_pedido) as Total_Pedidos
from Detalle_Pedido
JOIN Carro ON Detalle_Pedido.id_carro = Carro.id_carro;

-- 10. Contar carros por estado
SELECT 
    SUM(CASE WHEN kilometraje < 1 THEN 1 ELSE 0 END) AS Carros_Nuevos,
    SUM(CASE WHEN kilometraje >= 1 THEN 1 ELSE 0 END) AS Carros_Usados
FROM Carro;

-- 11. Carros con información de su modelo
select 
	nombre_marca,
	nombre_modelo,
	año
FROM Carro
INNER JOIN Marca on Marca.id_marca = Carro.id_marca
inner JOIN Modelo on Modelo.id_modelo = Carro.id_modelo

-- 12. Contar pedidos por cliente
SELECT
	COUNT(id_pedido)
from Pedido
GROUP BY id_cliente

--13 Carros por marca ordenados por precio
select 
	nombre_marca,
	precio_final
from Carro
inner join Marca on Marca.id_marca = Carro.id_marca
ORDER by precio_final asc 

--14 Ventas totales por vendedor
select 
	Vendedor.nombre_vendedor,
	COUNT(Pedido.id_vendedor) as Ventas_totales
from Pedido
join Vendedor on Pedido.id_vendedor = Vendedor.id_vendedor
GROUP by Vendedor.nombre_vendedor;

--15 Ciudades con cantidad de clientes
select 
	nombre_ciudad,
	COUNT(id_cliente) as clientes
from Direccion
JOIN Ciudad ON Ciudad.id_ciudad = Direccion.id_ciudad
join Cliente on Cliente.id_cliente = Direccion.id_ciudad
GROUP BY Ciudad.nombre_ciudad

--16 Precio promedio por marca
SELECT
	nombre_marca,
	AVG(precio_base) as Promedio_precio_marca
FROM Carro
join Marca on Marca.id_marca = Carro.id_marca
GROUP by nombre_marca

--17 Clientes con y sin pedidos
SELECT 
	nombre_cliente
from Pedido
join Cliente on Cliente.id_cliente = Pedido.id_cliente
GROUP BY nombre_cliente

--18 Modelos con y sin ventas ???????
SELECT 
    nombre_modelo,
    COUNT(id_pedido) AS total_ventas
FROM Carro 
join Modelo on Modelo.id_modelo = Carro.id_modelo
LEFT JOIN Detalle_Pedido ON Carro.id_carro = Detalle_Pedido.id_carro
GROUP BY Modelo.nombre_modelo;

--19 Carros disponibles por categoría
SELECT 
	id_carro,
	nombre_categoria
FROM Carro
left join Categoria_Carro on Categoria_Carro.id_categoria = Carro.id_categoria

--20 Ventas mensuales de cada vendedor
SELECT 
	Vendedor.id_vendedor,
	nombre_vendedor,
	COUNT(num_pedido) as pedidos_mensuales
FROM Pedido
LEFT join Vendedor on Vendedor.id_vendedor = Pedido.id_vendedor

SELECT *
from Pedido
