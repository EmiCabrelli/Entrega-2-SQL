CREATE SCHEMA ludoteca_db;
USE ludoteca_db;
CREATE TABLE categoria (
id_categoria INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
descripcion VARCHAR(255)
);
CREATE TABLE juego (
id_juego INT AUTO_INCREMENT PRIMARY KEY,
titulo VARCHAR(100) NOT NULL,
id_categoria INT,
stock_disponible INT DEFAULT 0,
edad_minima TINYINT,
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);
CREATE TABLE socio (
id_socio INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
dni VARCHAR(50) UNIQUE,
telefono VARCHAR(20)
);
CREATE TABLE prestamo (
id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
id_socio INT,
fecha_prestamo DATE NOT NULL,
fecha_devolucion DATE,
FOREIGN KEY (id_socio) REFERENCES socio(id_socio)
);
CREATE TABLE prestamo_juego (
id_prestamo INT,
id_juego INT,
cantidad INT DEFAULT 1,
PRIMARY KEY (id_prestamo, id_juego),
FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo),
FOREIGN KEY (id_juego) REFERENCES juego(id_juego)
);
