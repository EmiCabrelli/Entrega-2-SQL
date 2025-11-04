/*
Procedimientos
*/

delimiter //
create procedure sp_crear_prestamo(
	in p_id_socio int,
    in p_fecha_prestamo date,
    in p_fecha_devolucion date,
    out p_new_prestamo int
)
begin
	insert into prestamo (id_socio, fecha_prestamo, fecha_devolucion)
    values (p_id_socio, p_fecha_prestamo, p_fecha_devolucion);
    set p_new_prestamo = last_insert_id();
end//
delimiter ;

delimiter //
create procedure sp_agregar_juego_a_prestamo(
	in p_id_prestamo int,
    in p_id_juego int,
    in p_cantidad int
)
begin
	declare stock_actual int;
    start transaction;
    
    select stock_disponible into stock_actual from juego where id_juego = p_id_juego for update;
    
    if stock_actual is null then
		signal sqlstate '45000' set message_text = 'El juego no existe';
	end if;
    
    if stock_actual < p_cantidad then
		rollback;
        signal sqlstate '45000' set message_text = 'No quedan copias de este juego';
	end if;
    
    insert into prestamo_juego (id_prestamo, id_juego, cantidad)
    values (p_id_prestamo, p_id_juego, p_cantidad)
    on duplicate key update cantidad = cantidad + values(cantidad);
    
    update juego set stock_disponibles = stock_disponible - p_cantidad where id_juego = p_id_juego;
    
    commit;
end//
delimiter ;

delimiter //
create procedure sp_register_devolucion(
	in p_id_prestamo int,
    in p_fecha_devolucion date
)
begin
	declare done int default 0;
    declare v_id_juego int;
    declare v_cantidad int;
    declare cur cursor for
		select id_juego, cantidad from prestamo_juego where id_prestamo = p_id_prestamo;
	declare continue handler for not found set done = 1;
    
    start transaction;
    
    update prestamo set fecha_devolucion = p_fecha_devolucion, estado='devuelto' where id_prestamo = p_id_prestamo;
    
    open cur;
    read_loop: loop
		fetch cur into v_id_juego, v_cantidad;
        if done = 1 then
			leave read_loop;
		end if;
		update juego set stock_disponible = stock_disponible + v_cantidad where id_juego = v_id_juego;
	end loop;
    close cur;
    
    commit;
end//
delimiter ;