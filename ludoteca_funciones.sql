/*
Funciones
*/

delimiter //
create function fn_dias_prestados(p_id int) returns int
deterministic
begin
	declare dias int;
    declare fp date;
    declare fd date;
	select fecha_prestamo, fecha_devolucion into fp, fd
		from prestamo where id_prestamo = p_id;
	if fp is null then
		return 0;
	end if;
    if fd is null then
		set dias = datediff(curdate(), fp);
	else
		set dias = datediff(fp, fd);
	end if;
    return dias;
end//
delimiter ;

delimiter //
create function fn_total_juegos_prestados(j_id int) returns int
deterministic
begin
	declare total int;
    select ifnull(sum(cantidad),0) into total from prestamo_juego where id_juego = j_id;
    return total;
end//
delimiter ;
    
		