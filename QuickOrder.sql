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
  `credit` INT,
  photo varchar(100) DEFAULT "profile.png"
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
  photo VARCHAR(100) default "product.png",
  description VARCHAR(100),
  price INT,
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
);

DROP TABLE IF EXISTS order_line;
CREATE TABLE order_line (
  id INT AUTO_INCREMENT,
  order_id INT,
  product_id INT NOT NULL,
  qty INT,
  price INT,
  unit_price INT,
  PRIMARY KEY(id, order_id),
  FOREIGN KEY (order_id) REFERENCES `order`(id),
  FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO restaurant (name, nif, password, photo, city, direction, delivery_time, delivery_price) VALUES
('La Trattoria', '123456789', 'pass123', 'photo1.png', 'Ciudad del Sol', 'Calle de la Luna, 123', 30, FLOOR(RAND() * 11)),
('El Bistro Parisino', '987654321', 'secret456', 'photo2.png', 'Ciudad Encantada', 'Avenida de los Suenos, 456', 45, FLOOR(RAND() * 11)),
('La Cantina Mexicana', '456123789', 'pwd789', 'photo3.png', 'Pueblo del Rio', 'Calle del Arco Iris, 789', 20, FLOOR(RAND() * 11)),
('Sushi House', '789321456', 'password321', 'photo4.png', 'Villa Primavera', 'Avenida de las Flores, 321', 40, FLOOR(RAND() * 11)),
('El Asador Argentino', '654789321', 'pass987', 'photo5.png', 'Ciudad del Viento', 'Calle del Abeto, 987', 15, FLOOR(RAND() * 11)),
('La Brasserie', '321456789', 'secret654', 'photo6.png', 'Pueblo de las Montanas', 'Avenida de los Pinos, 654', 30, FLOOR(RAND() * 11)),
('El Rincon del Mar', '789654321', 'pwd321', 'photo7.png', 'Villa del Mar', 'Calle de la Playa, 321', 35, FLOOR(RAND() * 11)),
('La Pizzeria Bella Italia', '456321789', 'password987', 'photo8.png', 'Ciudad de los Sabores', 'Avenida de las Delicias, 987', 25, FLOOR(RAND() * 11)),
('El Gourmet Moderno', '963852741', 'pass123987', 'photo9.png', 'Pueblo de la Luna', 'Calle de las Estrellas, 123', 30, FLOOR(RAND() * 11)),
('La Taberna Tradicional', '741852963', 'secret987', 'photo10.png', 'Villa del Bosque', 'Avenida del Roble, 987', 20, FLOOR(RAND() * 11)),
('El Restaurante del Chef', '852963741', 'pwd123987', 'photo11.png', 'Ciudad del Arte', 'Calle del Pincel, 123', 40, FLOOR(RAND() * 11)),
('La Parrilla de la Abuela', '369258147', 'password1234', 'photo12.png', 'Pueblo de la Cascada', 'Avenida del Agua, 456', 35, FLOOR(RAND() * 11)),
('El Bistro de los Sabores', '258147369', 'pass1234', 'photo13.png', 'Villa del Sol', 'Calle del Girasol, 789', 30, FLOOR(RAND() * 11)),
('La Cocina Exotica', '147369258', 'secret1234', 'photo14.png', 'Ciudad del Mar', 'Avenida de los Corales, 123', 45, FLOOR(RAND() * 11)),
('El Comedor Familiar', '963147852', 'pwd1234', 'photo15.png', 'Pueblo de la Colina', 'Calle del Mirador, 456', 20, FLOOR(RAND() * 11)),
('La Cerveceria Artesanal', '258369147', 'password5678', 'photo16.png', 'Villa del Rio', 'Avenida del Puente, 789', 30, FLOOR(RAND() * 11)),
('El Bistro Mediterraneo', '369852147', 'pass5678', 'photo17.png', 'Ciudad del Encanto', 'Calle de los Suenos, 123', 15, FLOOR(RAND() * 11)),
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
(2, 'Frances'),
(2, 'Romantico'),
(3, 'Mexicano'),
(3, 'Picante'),
(4, 'Japones'),
(4, 'Sushi'),
(5, 'Argentino'),
(5, 'Asado'),
(6, 'Frances'),
(6, 'Brasserie'),
(7, 'Mariscos'),
(7, 'Playa'),
(8, 'Italiano'),
(8, 'Pizza'),
(9, 'Fusion'),
(9, 'Gourmet'),
(10, 'Tradicional'),
(10, 'Tapas'),
(11, 'Gastronomia'),
(11, 'Chef'),
(12, 'Parrilla'),
(12, 'Carnes'),
(13, 'Internacional'),
(13, 'Exotico'),
(14, 'Familiar'),
(14, 'Casero'),
(15, 'Cerveceria'),
(15, 'Artesanal'),
(16, 'Mediterraneo'),
(16, 'Mariscos'),
(17, 'Parrilla'),
(17, 'Carnes'),
(18, 'Gastronomia'),
(18, 'Esquina'),
(19, 'Sensaciones'),
(19, 'Degustacion');

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

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(1, 'Pizza Margherita', 'Deliciosa pizza con salsa de tomate, mozzarella y albahaca fresca.', 10.99),
(1, 'Pasta Carbonara', 'Clasica pasta italiana con salsa de huevo, panceta y queso parmesano.', 12.99),
(1, 'Risotto ai Funghi', 'Sabroso risotto con champinones, cebolla y queso parmesano.', 14.99),
(1, 'Lasagna Bolognese', 'Deliciosa lasana con carne de res, salsa bolognesa y queso gratinado.', 16.99),
(1, 'Pollo alla Cacciatora', 'Pollo guisado con tomate, cebolla, aceitunas y especias.', 15.99),
(1, 'Bruschetta Caprese', 'Tostadas de pan con tomate fresco, mozzarella, albahaca y aceite de oliva.', 8.99),
(1, 'Tiramisu', 'Postre italiano hecho con capas de bizcocho, cafe, mascarpone y cacao.', 9.99),
(1, 'Cannoli Siciliani', 'Postre siciliano con masa crujiente rellena de crema de ricota y chispas de chocolate.', 7.99),
(1, 'Gelato al Cioccolato', 'Helado italiano de chocolate oscuro y cremoso.', 6.99),
(1, 'Panna Cotta', 'Postre italiano a base de crema cocida, azucar y gelatina de vainilla.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(2, 'Croque Monsieur', 'Sandwich frances con jamon, queso gruyere y bechamel.', 14.99),
(2, 'Escargots de Bourgogne', 'Caracoles de Borgona preparados con mantequilla y ajo.', 18.99),
(2, 'Boeuf Bourguignon', 'Estofado de ternera cocinado a fuego lento con vino tinto y verduras.', 22.99),
(2, 'Salade Nicoise', 'Ensalada francesa con atun, huevo, tomate, aceitunas y judias verdes.', 12.99),
(2, 'Soupe a l\'Oignon', 'Sopa francesa de cebolla gratinada con queso y crutones.', 10.99),
(2, 'Coq au Vin', 'Pollo guisado en vino tinto con champinones y cebolla.', 20.99),
(2, 'Creme Brulee', 'Postre frances de crema pastelera caramelizada.', 8.99),
(2, 'Tarte Tatin', 'Tarta francesa de manzana caramelizada y masa crujiente.', 10.99),
(2, 'Ratatouille', 'Plato provenzal de verduras asadas como berenjena, calabacin y tomate.', 16.99),
(2, 'Macarons', 'Dulces franceses de almendra con diferentes sabores y colores.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(3, 'Tacos al Pastor', 'Tacos de cerdo marinado con especias y pina.', 12.99),
(3, 'Enchiladas Verdes', 'Tortillas de maiz rellenas de pollo y banadas en salsa verde.', 10.99),
(3, 'Chiles Rellenos', 'Chiles poblanos rellenos de queso y banados en salsa de tomate.', 14.99),
(3, 'Mole Poblano', 'Plato tradicional de pollo en salsa de mole poblano.', 16.99),
(3, 'Guacamole', 'Deliciosa salsa de aguacate con tomate, cebolla y cilantro.', 8.99),
(3, 'Tostadas de Ceviche', 'Tostadas de maiz con ceviche de pescado y mariscos.', 9.99),
(3, 'Quesadillas', 'Tortillas de maiz rellenas de queso y acompanadas de guacamole.', 7.99),
(3, 'Flan Napolitano', 'Postre mexicano de flan con caramelo.', 6.99),
(3, 'Churros', 'Dulces fritos en forma de bastones con azucar y canela.', 5.99),
(3, 'Horchata', 'Refrescante bebida de arroz con canela y azucar.', 4.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(4, 'Sashimi Variado', 'Seleccion de pescados crudos cortados en finas laminas.', 18.99),
(4, 'Roll de Salmon y Aguacate', 'Maki roll con salmon fresco y aguacate.', 12.99),
(4, 'Nigiri de Atun', 'Bolitas de arroz con laminas de atun fresco por encima.', 10.99),
(4, 'Uramaki Tempura', 'Roll invertido con langostino tempura y aguacate.', 14.99),
(4, 'Gyoza', 'Empanadillas japonesas rellenas de carne y verduras.', 8.99),
(4, 'Yakitori', 'Brochetas de pollo a la parrilla con salsa teriyaki.', 9.99),
(4, 'Miso Soup', 'Sopa japonesa a base de pasta de soja y caldo dashi.', 5.99),
(4, 'Tempura de Vegetales', 'Vegetales fritos en masa ligera y crujiente.', 7.99),
(4, 'Tataki de Atun', 'Laminas de atun sellado con sesamo y salsa de soja.', 16.99),
(4, 'Dorayaki', 'Panqueques japoneses rellenos de pasta de frijol azuki.', 6.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES
(5, 'Bife de Chorizo', 'Jugoso corte de carne de res a la parrilla.', 22.99),
(5, 'Asado de Tira', 'Costillas de res asadas a la parrilla con chimichurri.', 25.99),
(5, 'Empanadas Argentinas', 'Empanadas rellenas de carne, pollo o verduras.', 9.99),
(5, 'Matambre a la Pizza', 'Roll de carne relleno con ingredientes de pizza.', 18.99),
(5, 'Provoleta', 'Queso provolone a la parrilla con tomate y oregano.', 14.99),
(5, 'Milanesa Napolitana', 'Milanesa de carne empanizada con salsa de tomate y queso gratinado.', 16.99),
(5, 'Choripan', 'Clasico sandwich argentino con chorizo a la parrilla.', 10.99),
(5, 'Alfajores', 'Dulces argentinos rellenos de dulce de leche y cubiertos de chocolate.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(6, 'Escargots de Bourgogne', 'Caracoles cocinados en mantequilla y ajo.', 19.99),
(6, 'Coq au Vin', 'Pollo guisado en vino tinto con champinones y cebollas.', 21.99),
(6, 'Bouillabaisse', 'Sopa de pescado y mariscos con sabores mediterraneos.', 24.99),
(6, 'Tarte Tatin', 'Tarta de manzana caramelizada invertida.', 12.99),
(6, 'Quiche Lorraine', 'Tarta salada con tocino, queso y crema.', 15.99),
(6, 'Creme Brulee', 'Postre de crema quemada con azucar caramelizada.', 10.99),
(6, 'Ratatouille', 'Plato provenzal de verduras asadas como berenjena, calabacin y tomate.', 16.99),
(6, 'Profiteroles', 'Bolitas de masa rellenas de crema y banadas en chocolate.', 9.99),
(6, 'Salade Nicoise', 'Ensalada con atun, tomate, huevo, aceitunas y judias verdes.', 14.99),
(6, 'Crepes Suzette', 'Crepes flameadas con salsa de naranja y Grand Marnier.', 17.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(7, 'Paella de Mariscos', 'Plato de arroz con mariscos como langostinos, mejillones y calamares.', 25.99),
(7, 'Ceviche Mixto', 'Pescado y mariscos marinados en limon con aji y cebolla.', 18.99),
(7, 'Pulpo a la Gallega', 'Pulpo cocido con aceite de oliva, pimenton y patatas.', 21.99),
(7, 'Gambas al Ajillo', 'Gambas salteadas en aceite de oliva con ajo y guindilla.', 16.99),
(7, 'Calamares a la Romana', 'Anillas de calamar rebozadas y fritas.', 12.99),
(7, 'Sopa de Pescado', 'Sopa de pescado con trozos de pescado y mariscos.', 10.99),
(7, 'Pargo a la Veracruzana', 'Pargo asado con salsa de tomate, aceitunas y alcaparras.', 22.99),
(7, 'Flan de Coco', 'Postre de flan con sabor a coco y caramelo.', 8.99);
  
 
 INSERT INTO product (restaurant_id, name, description, price)
VALUES
(8, 'Pizza Margherita', 'Clasica pizza con salsa de tomate, mozzarella y albahaca.', 14.99),
(8, 'Pizza Pepperoni', 'Pizza con salsa de tomate, mozzarella y pepperoni.', 16.99),
(8, 'Pizza Hawaiana', 'Pizza con salsa de tomate, mozzarella, jamon y pina.', 15.99),
(8, 'Pizza Capricciosa', 'Pizza con salsa de tomate, mozzarella, jamon, champinones y aceitunas.', 17.99),
(8, 'Pizza Prosciutto e Funghi', 'Pizza con salsa de tomate, mozzarella, jamon y champinones.', 16.99),
(8, 'Calzone', 'Pizza en forma de empanada rellena de mozzarella, jamon y champinones.', 18.99),
(8, 'Lasagna', 'Pasta horneada en capas con carne, queso y salsa de tomate.', 19.99),
(8, 'Ravioli di Spinaci e Ricotta', 'Raviolis rellenos de espinacas y ricotta con salsa de tomate.', 17.99),
(8, 'Tiramisu', 'Postre italiano de capas de bizcocho, cafe y crema de mascarpone.', 9.99),
(8, 'Gelato', 'Helado italiano en diversos sabores.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(9, 'Salmon Teriyaki', 'Salmon a la parrilla con salsa teriyaki y verduras.', 23.99),
(9, 'Filete Mignon', 'Ternera de primera calidad a la parrilla con guarnicion.', 27.99),
(9, 'Risotto de Champinones', 'Arroz cremoso con champinones y parmesano.', 18.99),
(9, 'Ensalada Caprese', 'Ensalada de tomate, mozzarella y albahaca con aderezo balsamico.', 14.99),
(9, 'Carpaccio de Res', 'Finas laminas de carne de res marinadas con aceite de oliva y limon.', 16.99),
(9, 'Cordero al Horno', 'Pierna de cordero asada con hierbas y especias.', 25.99),
(9, 'Tarta de Chocolate', 'Deliciosa tarta de chocolate con ganache y frutas frescas.', 11.99),
(9, 'Crema de Calabaza', 'Crema suave de calabaza con crujientes de panceta.', 10.99),
(9, 'Gazpacho Andaluz', 'Sopa fria de tomate, pepino, pimiento y ajo.', 9.99),
(9, 'Mousse de Mango', 'Postre ligero y refrescante de mousse de mango.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(10, 'Fabada Asturiana', 'Guiso de alubias blancas con chorizo y panceta.', 16.99),
(10, 'Chuleton de Ternera', 'Generoso chuleton de ternera a la parrilla.', 29.99),
(10, 'Pulpo a Feira', 'Pulpo cocido con aceite de oliva, pimenton y patatas.', 21.99),
(10, 'Croquetas de Jamon', 'Croquetas cremosas rellenas de jamon iberico.', 12.99),
(10, 'Tortilla Espanola', 'Clasica tortilla de patatas con cebolla y huevo.', 13.99),
(10, 'Gambas al Ajillo', 'Gambas salteadas en aceite de oliva con ajo y guindilla.', 16.99),
(10, 'Patatas Bravas', 'Patatas fritas con salsa brava picante y alioli.', 9.99),
(10, 'Flan Casero', 'Delicioso flan casero con caramelo liquido.', 7.99),
(10, 'Queso Manchego', 'Queso manchego curado de oveja.', 10.99),
(10, 'Tarta de Santiago', 'Tarta de almendras tradicional de Santiago de Compostela.', 11.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES
(11, 'Filete de Res en Salsa de Vino Tinto', 'Tierno filete de res banado en una deliciosa salsa de vino tinto.', 26.99),
(11, 'Pechuga de Pollo Rellena', 'Pechuga de pollo rellena de espinacas y queso, acompanada de pure de papas.', 22.99),
(11, 'Risotto de Mariscos', 'Arroz cremoso con una seleccion de mariscos frescos.', 24.99),
(11, 'Ensalada Cesar', 'Ensalada clasica con pollo a la parrilla, croutones y aderezo Cesar.', 16.99),
(11, 'Ceviche Mixto', 'Mezcla de pescado y mariscos marinados en limon con cebolla y aji.', 18.99),
(11, 'Rabo de Toro Estofado', 'Delicioso estofado de rabo de toro con verduras y vino tinto.', 28.99),
(11, 'Tarta Tatin', 'Tarta invertida de manzanas caramelizadas con masa hojaldrada.', 13.99),
(11, 'Sopa de Cebolla', 'Sopa de cebolla gratinada con queso fundido.', 11.99),
(11, 'Pure de Zanahoria y Jengibre', 'Pure suave de zanahoria y jengibre con especias.', 9.99),
(11, 'Mousse de Frambuesa', 'Postre ligero y cremoso de mousse de frambuesa.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(12, 'Bife de Chorizo', 'Jugoso bife de chorizo a la parrilla con chimichurri.', 25.99),
(12, 'Asado de Tira', 'Tiernas costillas de res asadas a la parrilla.', 27.99),
(12, 'Matambre a la Pizza', 'Matambre relleno con salsa de tomate, mozzarella y ingredientes a eleccion.', 23.99),
(12, 'Empanadas Argentinas', 'Empanadas caseras de carne, pollo o verduras.', 10.99),
(12, 'Parrillada Mixta', 'Seleccion de carnes a la parrilla: chorizo, morcilla, churrasco, pollo y cerdo.', 29.99),
(12, 'Ensalada Criolla', 'Ensalada tradicional argentina con tomate, cebolla y pimientos.', 12.99),
(12, 'Provoleta', 'Queso provolone a la parrilla con especias y aceite de oliva.', 14.99),
(12, 'Helado de Dulce de Leche', 'Clasico helado argentino de dulce de leche.', 8.99),
(12, 'Mollejas a la Parrilla', 'Mollejas de ternera a la parrilla con limon y sal gruesa.', 19.99),
(12, 'Alfajores', 'Dulce tipico argentino: dos galletas rellenas de dulce de leche y cubiertas de chocolate.', 9.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(13, 'Filet Mignon', 'Exquisito filete mignon con salsa de champinones.', 28.99),
(13, 'Ratatouille', 'Plato vegetariano con berenjena, calabacin, pimientos y tomate al horno.', 16.99),
(13, 'Sopa de Calabaza', 'Sopa cremosa de calabaza con un toque de jengibre.', 11.99),
(13, 'Ensalada Caprese', 'Ensalada clasica italiana con tomate, mozzarella y albahaca.', 14.99),
(13, 'Risotto de Hongos', 'Arroz cremoso con una variedad de hongos frescos.', 22.99),
(13, 'Tarta de Espinacas y Queso de Cabra', 'Tarta salada con espinacas, queso de cabra y cebolla caramelizada.', 19.99),
(13, 'Crema Catalana', 'Postre tradicional espanol similar al creme brulee.', 10.99);
 
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(14, 'Pad Thai', 'Famoso plato tailandes de fideos de arroz salteados con pollo, camarones o tofu.', 17.99),
(14, 'Curry de Coco', 'Curry tailandes con leche de coco, pollo, verduras y especias.', 19.99),
(14, 'Sushi Variado', 'Variedad de sushi: nigiri, maki y sashimi.', 24.99),
(14, 'Rollitos de Primavera', 'Deliciosos rollitos rellenos de vegetales y carne, acompanados de salsa agridulce.', 12.99),
(14, 'Tom Kha Gai', 'Sopa tailandesa de coco con pollo y hierbas aromaticas.', 15.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(15, 'Lasaña de Carne', 'Lasaña casera con carne, pasta y salsa de tomate.', 14.99),
(15, 'Milanesa Napolitana', 'Milanesa de ternera empanizada cubierta con salsa de tomate y queso.', 17.99),
(15, 'Pollo al Horno', 'Pollo jugoso asado al horno con hierbas y especias.', 16.99),
(15, 'Guiso de Lentejas', 'Guiso tradicional de lentejas con chorizo y verduras.', 12.99),
(15, 'Ensalada de Pollo', 'Ensalada fresca con pollo a la parrilla, vegetales y aderezo de tu eleccion.', 13.99),
(15, 'Tarta de Verduras', 'Tarta salada de verduras mixtas con masa quebrada.', 11.99),
(15, 'Arroz con Leche', 'Postre cremoso de arroz con leche, canela y azucar.', 8.99),
(15, 'Pure de Papa', 'Pure suave y cremoso de papas.', 7.99),
(15, 'Ensalada de Frutas', 'Ensalada refrescante con una variedad de frutas frescas.', 9.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES 
  (16, 'Hamburguesa Clasica', 'Jugosa hamburguesa con carne de res, lechuga, tomate y aderezo especial.', 12.99),
  (16, 'Fish and Chips', 'Clasico plato ingles de pescado rebozado y papas fritas.', 14.99),
  (16, 'Alitas de Pollo', 'Alitas de pollo marinadas y fritas, con salsa a elección.', 10.99),
  (16, 'Nachos con Queso', 'Nachos crujientes cubiertos de queso derretido, jalapenos y guacamole.', 9.99),
  (16, 'Ensalada Cesar', 'Ensalada clasica con pollo a la parrilla, croutones y aderezo Cesar.', 13.99),
  (16, 'Sandwich de Pastrami', 'Sandwich relleno de pastrami, pepinillos y mostaza.', 11.99),
  (16, 'Cheesecake de Frutos Rojos', 'Cheesecake cremoso con salsa de frutos rojos.', 8.99),
  (16, 'Papas Fritas', 'Papas fritas doradas y crujientes.', 6.99),
  (16, 'Cerveza Artesanal', 'Variedad de cervezas artesanales para disfrutar.', 7.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES 
  (17, 'Paella Valenciana', 'Plato tradicional espanol de arroz con mariscos, pollo y verduras.', 25.99),
  (17, 'Gazpacho', 'Sopa fria de tomate, pepino, pimiento y aceite de oliva.', 11.99),
  (17, 'Lomo de Cerdo al Horno', 'Lomo de cerdo asado al horno con hierbas mediterraneas.', 18.99),
  (17, 'Ensalada Griega', 'Ensalada fresca con tomate, pepino, cebolla, aceitunas y queso feta.', 14.99),
  (17, 'Moussaka', 'Plato griego de berenjena, carne picada y salsa bechamel gratinada.', 19.99),
  (17, 'Tzatziki', 'Salsa griega a base de yogur, pepino, ajo y hierbas frescas.', 7.99),
  (17, 'Baklava', 'Dulce tradicional griego hecho con nueces y hojaldre banado en almibar.', 9.99),
  (17, 'Tabbouleh', 'Ensalada de bulgur, perejil, menta, tomate y limon.', 12.99),
  (17, 'Pita Gyro', 'Sandwich griego relleno de carne de cerdo asada, tzatziki y vegetales.', 16.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES 
  (18, 'Asado de Tira', 'Delicioso corte de carne de res asado a la parrilla.', 29.99),
  (18, 'Choripán', 'Clasico sandwich argentino con chorizo a la parrilla.', 12.99),
  (18, 'Empanadas', 'Empanadas argentinas rellenas de carne, pollo o verduras.', 9.99),
  (18, 'Provoleta', 'Queso provolone asado a la parrilla con aceite de oliva y especias.', 16.99),
  (18, 'Mollejas', 'Mollejas de ternera a la parrilla con limon y sal.', 19.99),
  (18, 'Papas Provenzal', 'Papas fritas condimentadas con ajo y perejil.', 7.99),
  (18, 'Tiramisu', 'Postre italiano de capas de bizcocho, cafe y crema de mascarpone.', 10.99),
  (18, 'Ensalada Mixta', 'Ensalada fresca con lechuga, tomate, cebolla y aceitunas.', 8.99),
  (18, 'Helado de Dulce de Leche', 'Delicioso helado de dulce de leche artesanal.', 6.99);

 INSERT INTO product (restaurant_id, name, description, price)
VALUES 
  (19, 'Carpaccio de Res', 'Finas laminas de carne de res marinada con aceite de oliva y parmesano.', 15.99),
  (19, 'Ceviche de Camaron', 'Camarones frescos marinados en limon con cebolla y cilantro.', 18.99),
  (19, 'Lomo Saltado', 'Plato peruano con trozos de lomo de res salteados con cebolla y tomate.', 21.99),
  (19, 'Causa Limena', 'Deliciosa masa de papa amarilla rellena de pollo o mariscos.', 14.99),
  (19, 'Tiradito de Pescado', 'Finas laminas de pescado marinadas en limon con salsa de aji amarillo.', 19.99),
  (19, 'Suspiro Limeno', 'Postre peruano de leche condensada y merengue.', 11.99),
  (19, 'Anticuchos', 'Brochetas de carne marinadas y asadas.', 12.99),
  (19, 'Pisco Sour', 'Coctel peruano hecho con pisco, limon, azucar y clara de huevo.', 9.99),
  (19, 'Arroz con Mariscos', 'Arroz preparado con una variedad de mariscos frescos.', 23.99),
  (19, 'Papa a la Huancaina', 'Papas cocidas con salsa de aji amarillo y queso fresco.', 10.99);

