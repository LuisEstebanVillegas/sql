-- Ejercicios en clase 8/11/25

-- Mostrar tipo de Trasmision, kilometraje y el precio base 

select
	nombre_marca,
	nombre_modelo,
	tipo_transmision,
	tipo_combustible
from Combustible, Transmision, Carro
inner join Marca on Carro.id_marca = Marca.id_marca
inner join Modelo on Modelo.id_modelo = Carro.id_modelo

-- Compras del cliente con el detallle de la entrega
-- order por fecha de entrega
select 
	fecha_entrega, 
	nombre_cliente,	
	num_pedido,
	fecha_pedido,
	forma_entrega
from Cliente
inner join Pedido on Cliente.id_cliente = Pedido.id_cliente
inner join Entrega on Pedido.id_entrega = Entrega.id_entrega
order by Entrega.fecha_entrega

-- Calcular el total de ventas, cantidad de pedidos y comisiones ganadas por 
-- cada vendedor en su sucursal


