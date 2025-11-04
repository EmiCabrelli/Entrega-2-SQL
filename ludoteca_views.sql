/*
Vistas
*/
create or replace view vista_juegos_disponibles as
select j.id_juego, j.titulo, c.nombre as categoria, j.stock_disponible, j.edad_minima
from juego j
left join categoria c on j.id_categoria = c.id_categoria
where j.stock_disponible > 0;

create or replace view vista_prestamos_activos as
select p.id_prestamo, s.id_socio, s.nombre, s.apellido,
	p.fecha_prestamo, p.fecha_devolucion
from prestamo p
join socio s on p.id_socio = s.id_socio
where p.fecha_devolucion is null;

 
 create or replace view vista_prestamos_atrasados as
 select p.id_prestamo, p.id_socio, s.nombre, s.apellido,
	p.fecha_prestamo, p.fecha_devolucion,
    datediff(curdate(), p.fecha_devolucion) as dias_retraso
from prestamo p 
join socio s on p.id_socio = s.id_socio
where p.fecha_devolucion is not null
    and p.fecha_devolucion < curdate();

create or replace view vista_top_juegos as
select j.id_juego, j.titulo, sum(pj.cantidad) as total_prestado
from prestamo_juego pj
join juego j on pj.id_juego = j.id_juego
group by j.id_juego, j.titulo
order by total_prestado desc;