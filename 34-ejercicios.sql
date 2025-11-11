-- Base de Datos TallerAutos -
--Listar todos los clientes ordenados alfabéticamente
-- Contar el total de carros en inventario
-- Obtener el precio promedio de los carros
-- Encontrar el carro más caro
-- Encontrar el carro más barato
-- Listar marcas ordenadas por año de fundación
-- Contar cuántos clientes hay por tipo de documento
-- Sumar el valor total de todos los pedidos
-- Obtener estadísticas básicas de precios
-- Contar carros por estado
-- Carros con información de su modelo
-- Contar pedidos por cliente
-- Carros por marca ordenados por precio
-- Ventas totales por vendedor
-- Ciudades con cantidad de clientes
-- Precio promedio por marca
-- Clientes con y sin pedidos
-- Modelos con y sin ventas
-- Carros disponibles por categoría
-- Ventas mensuales de cada vendedor
-- Top 5 clientes por gasto
-- Análisis de descuentos aplicados
-- Carros por color y transmisión
-- Ciudades con mayor volumen de ventas
-- Marcas con precio promedio por categoría
-- Análisis de entregas por transportadora
-- Todos los colores aunque no tengan carros
-- Análisis de financiamiento por banco
-- Clientes por ciudad con análisis de compra
-- Modelos más vendidos por categoría
-- Listar el inventario completo con todas las especificaciones técnicas y de origen.
-- Rastrear el estado de cada entrega con información del cliente, ubicación destino y transportadora
-- Identificar qué tipos de carros prefiere cada segmento de clientes según su ubicación.
-- Analizar qué métodos de pago se usan más en cada sucursal y su impacto en ventas.

-- Ejercicios Consultas SQL 
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
