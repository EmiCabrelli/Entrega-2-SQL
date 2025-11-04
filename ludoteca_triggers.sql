/*
Triggers
*/

delimiter //
create trigger trg_before_insert_prestamo_juego
before insert on prestamo_juego
for each row
begin
	declare stock_actual int;
    select stock_disponible into stock_actual from juego where id_juego = new.id_juego for update;
    if stock_actual is null then
		signal sqlstate '45000' set message_text = 'Juego no encontrado';
	end if;
    if stock_actual < new.cantidad then
		signal sqlstate '45000' set message_text = 'No hay mas stock';
	end if;
    
    update juego set stock_disponible = stock_disponible - new.cantidad where id_juego = new.id_juego;
end//
delimiter ;

delimiter //
create trigger trg_before_delete_prestamo_juego
before delete on prestamo_juego
for each row
begin
	update juego set stock_disponible = stock_disponible + old.cantidad where id_juego = old.id_juego;
end //
delimiter ;

delimiter //
create trigger trg_before_update_prestamo_juego
before update on prestamo_juego
for each row
begin
	declare diff int;
    set diff = new.cantidad - old.cantidad;
    if diff > 0 then
		if (select stock_disponible from juego where id_juego = new.id_juego) < diff then
			signal sqlstate '45000' set message_text = 'No quedan mas copias de este juego para prestar.';
		end if;
        update juego set stock_disponible = stock_disponible - diff where id_juego = new.id_juego;
	elseif diff < 0 then
		update juego set stock_disponible = stock_disponible + abs(diff) where id_juego = new.id_juego;
	end if;
end//
delimiter ;