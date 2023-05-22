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
  delivery_price int,
  rating DECIMAL(3,1)
);

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings(
user_id int,
restaurant_id int,
rating int,
PRIMARY KEY (user_id, restaurant_id),
FOREIGN KEY (user_id) REFERENCES `user`(id),
FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

DROP TABLE IF EXISTS favorites;
CREATE TABLE favorites(
user_id int,
restaurant_id int,
PRIMARY KEY (user_id, restaurant_id),
FOREIGN KEY (user_id) REFERENCES `user`(id),
FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
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
('Emma', 'Wright', 'emma.wright@example.com', 'pwd1234567', '147852390', 500),
('Pablo','Sanjuan','pablo@mail.com','Sanjusanju19','722483050',500);

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

INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (1, 1, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (2, 1, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (3, 1, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (4, 2, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (5, 2, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (6, 2, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (7, 3, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (8, 3, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (9, 3, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (10, 4, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (11, 4, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (12, 4, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (13, 5, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (14, 5, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (15, 5, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 6, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 6, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 6, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (19, 7, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (20, 7, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (21, 7, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (1, 8, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (2, 8, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (3, 8, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (4, 9, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (5, 9, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (6, 9, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (7, 10, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (8, 10, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (9, 10, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (10, 11, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (11, 11, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (12, 11, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (13, 12, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (14, 12, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (15, 12, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 13, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 13, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 13, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 14, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 14, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 14, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 15, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 15, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 15, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 16, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 16, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 16, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 17, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 17, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 17, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 18, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 18, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 18, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (16, 19, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (17, 19, FLOOR(RAND() * 4) + 2);
INSERT INTO ratings (user_id, restaurant_id, rating) VALUES (18, 19, FLOOR(RAND() * 4) + 2);


UPDATE restaurant r SET r.rating = ( SELECT AVG(rt.rating) FROM ratings rt WHERE rt.restaurant_id = r.id);


INSERT INTO favorites (user_id, restaurant_id) VALUES (1, 1), (1, 2), (1, 3), (2, 4), (2, 5), (2, 6), (3, 7), (3, 8), (3, 9), (4, 10),(4, 11), (4, 12), (5, 13), (5, 14), (5, 15), (6, 16), (6, 17), (6, 18), (7, 19),(8, 1), (8, 2), (8, 3), (9, 4), (9, 5), (9, 6), (10, 7), (10, 8),(10, 9), (11, 10), (11, 11), (11, 12), (12, 13), (12, 14), (12, 15), (13, 16),(13, 17), (13, 18), (14, 19), (15, 1), (15, 2), (15, 3), (16, 4),(16, 5), (16, 6), (17, 7), (17, 8), (17, 9), (18, 10), (18, 11), (18, 12), (19, 13),(19, 14), (19, 15), (20, 16), (20, 17), (20, 18), (21, 19);
