/*
Insercion de datos
*/

insert into categoria (nombre, descripcion) values
('Estrategia', 'Juegos de planificación y táctica'),
('Cartas', 'Juegos con barajas y mazos'),
('Infantiles', 'Juegos para niños pequeños'),
('Cooperativos', 'Juegos donde todos ganan o pierden juntos'),
('Rol', 'Juegos de interpretación de personajes'),
('Trivia', 'Juegos de preguntas y respuestas'),
('Habilidad', 'Juegos que requieren destreza manual'),
('Clásicos', 'Juegos de mesa tradicionales'),
('Temáticos', 'Juegos con ambientaciones específicas'),
('Educativos', 'Juegos diseñados para aprender jugando');

insert into juego (titulo, id_categoria, stock_disponible, edad_minima) values
('Catan', 1, 10, 10),
('Carcassonne', 1, 8, 8),
('Uno', 2, 15, 6),
('Dixit', 9, 5, 8),
('Aventureros al Tren', 1, 7, 10),
('Jenga', 7, 12, 5),
('Monopoly', 8, 6, 8),
('Dobble', 3, 10, 5),
('Timeline', 6, 9, 8),
('Detective Club', 4, 4, 10);

insert into socio (nombre, apellido, dni, telefono) values
('Juan', 'Pérez', '12345678', '111-1111'),
('María', 'Gómez', '23456789', '222-2222'),
('Luis', 'Rodríguez', '34567890', '333-3333'),
('Ana', 'Martínez', '45678901', '444-4444'),
('Pedro', 'López', '56789012', '555-5555'),
('Lucía', 'Fernández', '67890123', '666-6666'),
('Carlos', 'Gutiérrez', '78901234', '777-7777'),
('Sofía', 'Torres', '89012345', '888-8888'),
('Martín', 'Díaz', '90123456', '999-9999'),
('Valentina', 'Ruiz', '01234567', '101-0101');

insert into prestamo (id_socio, fecha_prestamo, fecha_devolucion) values
(1, '2025-10-01', '2025-10-05'),
(2, '2025-10-03', '2025-10-06'),
(3, '2025-10-05', NULL),
(4, '2025-10-07', '2025-10-10'),
(5, '2025-10-08', NULL),
(6, '2025-10-10', '2025-10-13'),
(7, '2025-10-12', NULL),
(8, '2025-10-13', NULL),
(9, '2025-10-14', '2025-10-17'),
(10, '2025-10-15', NULL);

insert into prestamo_juego (id_prestamo, id_juego, cantidad) values
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(2, 5, 1),
(3, 4, 1),
(3, 6, 1),
(4, 7, 2),
(5, 8, 1),
(6, 9, 1),
(7, 1, 1),
(8, 10, 1),
(9, 3, 2),
(9, 5, 1),
(10, 2, 1),
(10, 7, 1);
