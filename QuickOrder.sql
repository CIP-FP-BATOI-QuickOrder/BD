DROP DATABASE IF EXISTS quick_order;
CREATE DATABASE quick_order;

USE quick_order;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50),
  `surname` VARCHAR(60),
  `email` VARCHAR(50) unique,
  `password` VARCHAR(50),
  `phone` VARCHAR(9),
  `credit` INT
);

DROP TABLE IF EXISTS address;
CREATE TABLE address (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  address VARCHAR(100),
  number INT,
  name VARCHAR(100),
  city VARCHAR(100),
  cp INT,
  FOREIGN KEY (user_id) REFERENCES `user`(id)
);

DROP TABLE IF EXISTS payment_method;
CREATE TABLE payment_method (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  credit_cart INT,
  expiration_date VARCHAR(50),
  name VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES `user`(id)
);

DROP TABLE IF EXISTS restaurant;
CREATE TABLE restaurant (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  nif VARCHAR(9) UNIQUE,
  password VARCHAR(50),
  photo VARCHAR(50),
  city varchar(50),
  direction varchar(100),
  delivery_time int,
  delivery_price int
);

DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT,
  name varchar(50),
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

DROP TABLE IF EXISTS raider;
CREATE TABLE raider (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50),
  surname VARCHAR(60),
  nif VARCHAR(9) UNIQUE,
  status ENUM('Not working', 'Looking for orders', 'Working'),
  password VARCHAR(50),
  city VARCHAR(50)
);

DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  restaurant_id INT NOT NULL,
  raider_id INT,
  price INT,
  delivery_address_id INT,
  delivery_time TIME,
  discount INT,
  FOREIGN KEY (user_id) REFERENCES `user`(id),
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id),
  FOREIGN KEY (raider_id) REFERENCES raider(id),
  FOREIGN KEY (delivery_address_id) REFERENCES address(id)
);

DROP TABLE IF EXISTS product;
CREATE TABLE product (
  id INT AUTO_INCREMENT PRIMARY KEY,
  restaurant_id INT,
  name VARCHAR(50),
  photo VARCHAR(50),
  description VARCHAR(100),
  price INT,
  stock INT,
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

DROP TABLE IF EXISTS order_line;
CREATE TABLE order_line (
  id INT AUTO_INCREMENT,
  order_id INT,
  product_id INT NOT NULL,
  qty INT,
  price INT,
  unitPrice INT,
  PRIMARY KEY(id, order_id),
  FOREIGN KEY (order_id) REFERENCES `order`(id),
  FOREIGN KEY (product_id) REFERENCES product(id)
);

use quick_order;
INSERT INTO restaurant (name, nif, password, photo, city, direction, delivery_time, delivery_price) VALUES
('La Trattoria', '123456789', 'pass123', 'photo1.png', 'Ciudad del Sol', 'Calle de la Luna, 123', 30, FLOOR(RAND() * 11)),
('El Bistro Parisino', '987654321', 'secret456', 'photo2.png', 'Ciudad Encantada', 'Avenida de los Sueños, 456', 45, FLOOR(RAND() * 11)),
('La Cantina Mexicana', '456123789', 'pwd789', 'photo3.png', 'Pueblo del Río', 'Calle del Arco Iris, 789', 20, FLOOR(RAND() * 11)),
('Sushi House', '789321456', 'password321', 'photo4.png', 'Villa Primavera', 'Avenida de las Flores, 321', 40, FLOOR(RAND() * 11)),
('El Asador Argentino', '654789321', 'pass987', 'photo5.png', 'Ciudad del Viento', 'Calle del Abeto, 987', 15, FLOOR(RAND() * 11)),
('La Brasserie', '321456789', 'secret654', 'photo6.png', 'Pueblo de las Montañas', 'Avenida de los Pinos, 654', 30, FLOOR(RAND() * 11)),
('El Rincón del Mar', '789654321', 'pwd321', 'photo7.png', 'Villa del Mar', 'Calle de la Playa, 321', 35, FLOOR(RAND() * 11)),
('La Pizzeria Bella Italia', '456321789', 'password987', 'photo8.png', 'Ciudad de los Sabores', 'Avenida de las Delicias, 987', 25, FLOOR(RAND() * 11)),
('El Gourmet Moderno', '963852741', 'pass123987', 'photo9.png', 'Pueblo de la Luna', 'Calle de las Estrellas, 123', 30, FLOOR(RAND() * 11)),
('La Taberna Tradicional', '741852963', 'secret987', 'photo10.png', 'Villa del Bosque', 'Avenida del Roble, 987', 20, FLOOR(RAND() * 11)),
('El Restaurante del Chef', '852963741', 'pwd123987', 'photo11.png', 'Ciudad del Arte', 'Calle del Pincel, 123', 40, FLOOR(RAND() * 11)),
('La Parrilla de la Abuela', '369258147', 'password1234', 'photo12.png', 'Pueblo de la Cascada', 'Avenida del Agua, 456', 35, FLOOR(RAND() * 11)),
('El Bistró de los Sabores', '258147369', 'pass1234', 'photo13.png', 'Villa del Sol', 'Calle del Girasol, 789', 30, FLOOR(RAND() * 11)),
('La Cocina Exótica', '147369258', 'secret1234', 'photo14.png', 'Ciudad del Mar', 'Avenida de los Corales, 123', 45, FLOOR(RAND() * 11)),
('El Comedor Familiar', '963147852', 'pwd1234', 'photo15.png', 'Pueblo de la Colina', 'Calle del Mirador, 456', 20, FLOOR(RAND() * 11)),
('La Cervecería Artesanal', '258369147', 'password5678', 'photo16.png', 'Villa del Río', 'Avenida del Puente, 789', 30, FLOOR(RAND() * 11)),
('El Bistró Mediterráneo', '369852147', 'pass5678', 'photo17.png', 'Ciudad del Encanto', 'Calle de los Sueños, 123', 15, FLOOR(RAND() * 11)),
('La Parrilla de la Esquina', '852369147', 'secret5678', 'photo18.png', 'Pueblo del Bosque', 'Avenida del Roble, 456', 25, FLOOR(RAND() * 11)),
('El Restaurante de los Sentidos', '147852369', 'pwd5678', 'photo19.png', 'Villa del Mar', 'Calle de la Playa, 789', 30, FLOOR(RAND() * 11));



INSERT INTO user (name, surname, email, password, phone, credit) VALUES
('John', 'Doe', 'john.doe@example.com', 'password123', '722483050', 500),
('Jane', 'Smith', 'jane.smith@example.com', 'pass456', '987654320', 1000),
('Michael', 'Johnson', 'michael.johnson@example.com', 'secret123', '456789123', 750),
('Emily', 'Brown', 'emily.brown@example.com', 'pwd456', '789123450', 250),
('William', 'Taylor', 'william.taylor@example.com', 'password1234', '321659870', 1500),
('Olivia', 'Martinez', 'olivia.martinez@example.com', 'pass1234', '654983210', 100),
('James', 'Anderson', 'james.anderson@example.com', 'secret456', '987321540', 300),
('Sophia', 'Thomas', 'sophia.thomas@example.com', 'pwd123', '369851470', 800),
('Alexander', 'Garcia', 'alexander.garcia@example.com', 'password1345', '852691470', 600),
('Mia', 'Hernandez', 'mia.hernandez@example.com', 'pass12345', '147852690', 200),
('Benjamin', 'Lopez', 'benjamin.lopez@example.com', 'secret12345', '961478520', 400),
('Ava', 'Gonzalez', 'ava.gonzalez@example.com', 'pwd12345', '258361470', 700),
('Henry', 'Rodriguez', 'henry.rodriguez@example.com', 'password123456', '362581470', 350),
('Charlotte', 'Lee', 'charlotte.lee@example.com', 'pass123456', '852937410', 900),
('Daniel', 'Walker', 'daniel.walker@example.com', 'secret123456', '147362580', 550),
('Sofia', 'Hall', 'sofia.hall@example.com', 'pwd123456', '963857410', 1000),
('Matthew', 'Young', 'matthew.young@example.com', 'password1234567', '741829630', 400),
('Amelia', 'Allen', 'amelia.allen@example.com', 'pass1234567', '852749630', 700),
('David', 'King', 'david.king@example.com', 'secret1234567', '369147520', 200),
('Emma', 'Wright', 'emma.wright@example.com', 'pwd1234567', '147852390', 500);

INSERT INTO tags (restaurant_id, name) VALUES
(1, 'Italiano'),
(1, 'Pasta'),
(2, 'Francés'),
(2, 'Romántico'),
(3, 'Mexicano'),
(3, 'Picante'),
(4, 'Japonés'),
(4, 'Sushi'),
(5, 'Argentino'),
(5, 'Asado'),
(6, 'Francés'),
(6, 'Brasserie'),
(7, 'Mariscos'),
(7, 'Playa'),
(8, 'Italiano'),
(8, 'Pizza'),
(9, 'Fusión'),
(9, 'Gourmet'),
(10, 'Tradicional'),
(10, 'Tapas'),
(11, 'Gastronomía'),
(11, 'Chef'),
(12, 'Parrilla'),
(12, 'Carnes'),
(13, 'Internacional'),
(13, 'Exótico'),
(14, 'Familiar'),
(14, 'Casero'),
(15, 'Cervecería'),
(15, 'Artesanal'),
(16, 'Mediterráneo'),
(16, 'Mariscos'),
(17, 'Parrilla'),
(17, 'Carnes'),
(18, 'Gastronomía'),
(18, 'Esquina'),
(19, 'Sensaciones'),
(19, 'Degustación');

