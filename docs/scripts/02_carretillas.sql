CREATE TABLE
    `products` (
        `productId` int(11) NOT NULL AUTO_INCREMENT,
        `productName` varchar(255) NOT NULL,
        `productDescription` text NOT NULL,
        `productPrice` decimal(10, 2) NOT NULL,
        `productImgUrl` varchar(255) NOT NULL,
        `productStock` int(11) NOT NULL DEFAULT 0,
        `productStatus` char(3) NOT NULL,
        PRIMARY KEY (`productId`)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1 DEFAULT CHARSET = utf8mb4;

CREATE TABLE
    `carretilla` (
        `usercod` BIGINT(10) NOT NULL,
        `productId` int(11) NOT NULL,
        `crrctd` INT(5) NOT NULL,
        `crrprc` DECIMAL(12, 2) NOT NULL,
        `crrfching` DATETIME NOT NULL,
        PRIMARY KEY (`usercod`, `productId`),
        INDEX `productId_idx` (`productId` ASC),
        CONSTRAINT `carretilla_user_key` FOREIGN KEY (`usercod`) REFERENCES `usuario` (`usercod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
        CONSTRAINT `carretilla_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

CREATE TABLE
    `carretillaanon` (
        `anoncod` varchar(128) NOT NULL,
        `productId` int(11) NOT NULL,
        `crrctd` int(5) NOT NULL,
        `crrprc` decimal(12, 2) NOT NULL,
        `crrfching` datetime NOT NULL,
        PRIMARY KEY (`anoncod`, `productId`),
        INDEX `productId_idx` (`productId` ASC),
        CONSTRAINT `carretillaanon_prd_key` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE NO ACTION ON UPDATE NO ACTION
    );

    

    CREATE TABLE `transactions` (
    `txnId` INT NOT NULL AUTO_INCREMENT,
    `usercod` BIGINT(10) DEFAULT NULL,
    `paypal_order_id` VARCHAR(128) NOT NULL,
    `txnAmount` DECIMAL(12,2) NOT NULL,
    `txnStatus` VARCHAR(64) NOT NULL,
    `txnDate` DATETIME NOT NULL,
    `txnCurrency` VARCHAR(10) DEFAULT 'USD',
    `txnPayerEmail` VARCHAR(128),
    PRIMARY KEY (`txnId`),
    UNIQUE (`paypal_order_id`),
    FOREIGN KEY (`usercod`) REFERENCES `usuario`(`usercod`) ON DELETE SET NULL
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE `transaction_details` (
    `txnDetailId` INT AUTO_INCREMENT PRIMARY KEY,
    `txnId` INT NOT NULL,
    `productId` INT NOT NULL,
    `quantity` INT NOT NULL,
    `unitPrice` DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (`txnId`) REFERENCES `transactions`(`txnId`) ON DELETE CASCADE,
    FOREIGN KEY (`productId`) REFERENCES `products`(`productId`) ON DELETE CASCADE
   );



INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'The Legend of Zelda: Breath of the Wild',
  'Una aventura épica en un mundo abierto para Nintendo Switch donde exploras, resuelves acertijos y enfrentas peligros como Link.',
 59.99,
 'https://m.media-amazon.com/images/I/81KGsbq8ekL._UF1000,1000_QL80_.jpg',
 15,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Call of Duty Black Ops III',
  'Misiones tácticas futuristas en una guerra global con modo multijugador y zombies. Disponible en múltiples consolas.',
 69.99,
 'https://upload.wikimedia.org/wikipedia/en/b/b1/Black_Ops_3.jpg',
 10,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Halo Infinite',
  'El Jefe Maestro regresa para enfrentar una nueva amenaza en la galaxia, exclusivo para Xbox Series X|S y PC.',
 54.99,
 'https://www.certainaffinity.com/wp-content/uploads/2024/01/halo-infinite.png',
 12,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Super Mario Odyssey',
  'Únete a Mario en una increíble aventura por mundos 3D junto a su compañero Cappy en Nintendo Switch.',
 49.99,
 'https://m.media-amazon.com/images/I/91SF0Tzmv4L._UF1000,1000_QL80_.jpg',
 20,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Elden Ring',
  'Explora las Tierras Intermedias en este RPG de mundo abierto creado por FromSoftware y George R. R. Martin.',
 59.99,
 'https://upload.wikimedia.org/wikipedia/en/f/f0/Elden_Ring_Nightreign_cover_art.png',
 8,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Spider-Man: Miles Morales',
  'Vive la historia de Miles en esta espectacular aventura de superhéroes exclusiva de PlayStation.',
 39.99,
 'https://www.gamescard.net/wp-content/uploads/2023/11/Spiderman-Miles-Morales-For-Ps4.jpg',
 14,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Animal Crossing: New Horizons',
  'Crea tu propia isla y vive una vida tranquila en este adorable simulador para Nintendo Switch.',
 44.99,
 'https://upload.wikimedia.org/wikipedia/en/d/d7/Animal_Crossing_New_Horizons.jpg',
 18,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Forza Horizon 5',
  'Recorre México en este espectacular juego de carreras para Xbox y PC con mundo abierto.',
 59.99,
 'https://upload.wikimedia.org/wikipedia/en/thumb/8/86/Forza_Horizon_5_cover_art.jpg/250px-Forza_Horizon_5_cover_art.jpg',
 9,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Call of Duty: Modern Warfare II',
  'El clásico regresa con gráficos mejorados y nuevas misiones tácticas en PS5, Xbox y PC.',
 69.99,
 'https://upload.wikimedia.org/wikipedia/en/4/4a/Call_of_Duty_Modern_Warfare_II_Key_Art.jpg',
 11,
 'ACT');

INSERT INTO products (productName, productDescription, productPrice, productImgUrl, productStock, productStatus)
VALUES (
  'Final Fantasy VII Remake',
  'El clásico RPG vuelve con gráficos modernos y combates emocionantes en esta versión para PlayStation.',
 49.99,
 'https://image.api.playstation.com/vulcan/img/cfn/11307-dNapclgq_VqNtQ98Xp_LxovvAdjd5AknZhd_-k2Cckq9FPtKDXAHk-ODCfvDKChH6hkEO0VLtj7Vk4E-Z8G707oe0N.png',
 7,
 'ACT');


