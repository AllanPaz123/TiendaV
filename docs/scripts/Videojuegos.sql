-- Tabla de Inventario (para productos físicos)
CREATE TABLE `inventario` (
    `inventarioid` INT AUTO_INCREMENT PRIMARY KEY,
    `videojuegocod` INT,
    `stock` INT DEFAULT 0,
    `ubicacion` VARCHAR(255),
    FOREIGN KEY (`videojuegocod`) REFERENCES `videojuegos`(`videojuegocod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabla de Carrito de Compras
CREATE TABLE `carrito` (
    `carritoid` INT AUTO_INCREMENT PRIMARY KEY,
    `usercod` BIGINT(10),
    `videojuegocod` INT,
    `cantidad` INT DEFAULT 1,
    `tipo_entrega` ENUM('digital', 'fisico') DEFAULT 'digital',
    `agregado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`),
    FOREIGN KEY (`videojuegocod`) REFERENCES `videojuegos`(`videojuegocod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabla de Transacciones
CREATE TABLE `transacciones` (
    `transaccionid` INT AUTO_INCREMENT PRIMARY KEY,
    `usercod` BIGINT(10),
    `total` DECIMAL(10,2),
    `estado` ENUM('pendiente', 'completado', 'fallido') DEFAULT 'completado',
    `metodo_pago` VARCHAR(50),
    `referencia_pago` VARCHAR(100),
    `fecha` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabla de Detalle de Transacciones
CREATE TABLE `detalle_transaccion` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `transaccionid` INT,
    `videojuegocod` INT,
    `precio_unitario` DECIMAL(10,2),
    `cantidad` INT,
    `tipo_entrega` ENUM('digital', 'fisico') DEFAULT 'digital',
    FOREIGN KEY (`transaccionid`) REFERENCES `transacciones`(`transaccionid`),
    FOREIGN KEY (`videojuegocod`) REFERENCES `videojuegos`(`videojuegocod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabla de Descargas
CREATE TABLE `descargas` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `usercod` BIGINT(10),
    `videojuegocod` INT,
    `transaccionid` INT,
    `descargado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`),
    FOREIGN KEY (`videojuegocod`) REFERENCES `videojuegos`(`videojuegocod`),
    FOREIGN KEY (`transaccionid`) REFERENCES `transacciones`(`transaccionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Tabla de Videojuegos
CREATE TABLE `videojuegos` (
    `videojuegocod` INT AUTO_INCREMENT PRIMARY KEY,
    `titulo` VARCHAR(150),
    `descripcion` TEXT,
    `precio` DECIMAL(10,2),
    `imagen` VARCHAR(255),
    `archivo_descarga` VARCHAR(255),
    `formato` ENUM('digital', 'fisico', 'ambos') DEFAULT 'digital',
    `creado_en` DATETIME DEFAULT CURRENT_TIMESTAMP,
    `videojuegoest` CHAR(3) DEFAULT 'ACT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `videojuegos` (`titulo`, `descripcion`, `precio`, `imagen`, `archivo_descarga`, `formato`, `videojuegoest`)
VALUES 
('The Last Quest', 'Un juego de rol épico con más de 100 horas de aventura.', 29.99, 'lastquest.jpg', 'lastquest.zip', 'ambos', 'ACT'),
('Cyber Battle 2077', 'Acción futurista en un mundo abierto con increíbles gráficos.', 49.99, 'cyberbattle.jpg', 'cyberbattle.zip', 'digital', 'ACT'),
('Racing Legends', 'Carreras realistas con más de 50 vehículos y pistas internacionales.', 39.99, 'racinglegends.jpg', NULL, 'fisico', 'ACT');
Nota:

