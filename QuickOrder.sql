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
  address_name varchar(30),
  FOREIGN KEY (user_id) REFERENCES `user`(id)
);

DROP TABLE IF EXISTS payment_method;
CREATE TABLE payment_method (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  credit_cart varchar(50),
  expiration_date VARCHAR(50),
  name VARCHAR(50),
  bank varchar(50),
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
  rating DECIMAL(3,1) default 0
);

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings(
user_id int,
restaurant_id int,
rating decimal(5,2),
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
  description VARCHAR(1000),
  price decimal(5,2),
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

DROP TABLE IF EXISTS review;
CREATE TABLE review (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  restaurant_id INT,
  content VARCHAR(500),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES `user`(id),
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
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

INSERT INTO product (restaurant_id, name, description, price) VALUES
(1, 'Pizza Margherita', 'La Pizza Margherita es un clasico de la cocina italiana que combina ingredientes frescos y sabores autenticos. Esta deliciosa pizza cuenta con una base de salsa de tomate casera, suave mozzarella fresca y hojas de albahaca recien cortadas. El resultado es una explosion de sabores en cada bocado.', 10.99),
(1, 'Pasta Carbonara', 'Nuestra Pasta Carbonara es un plato que te transportara directamente a las trattorias de Roma. Preparada con pasta al dente y una irresistible salsa de huevo, panceta crujiente y queso parmesano rallado, cada bocado es una experiencia de sabor autentico. El equilibrio perfecto entre cremosidad y salinidad hace de esta receta un clasico de la cocina italiana.', 12.99),
(1, 'Risotto ai Funghi', 'Nuestro Risotto ai Funghi es un plato elegante y reconfortante que combina la cremosidad del arroz Arborio con la exquisitez de los champinones frescos, la cebolla caramelizada y el queso parmesano rallado. Cada cucharada es una explosion de sabores terrosos y una textura suave que deleitara tus sentidos.', 14.99),
(1, 'Lasagna Bolognese', 'Nuestra Lasagna Bolognese es una deliciosa combinacion de capas de pasta fresca, carne de res jugosa y salsa bolonesa casera. Cada porcion esta cuidadosamente preparada con ingredientes de alta calidad y horneada hasta obtener una capa superior dorada y gratinada.', 16.99),
(1, 'Pollo alla Cacciatora', 'El Pollo alla Cacciatora es un plato tradicional italiano que combina tierna carne de pollo guisada con tomate, cebolla, aceitunas y especias aromaticas. Cada bocado te transportara a la campina italiana con sus sabores ricos y reconfortantes.', 15.99),
(1, 'Bruschetta Caprese', 'Nuestras Bruschettas Caprese son tostadas de pan crujiente cubiertas con tomate fresco, mozzarella de bufala, hojas de albahaca y un chorrito de aceite de oliva virgen extra. Estas deliciosas y coloridas tostadas son perfectas como aperitivo o entrante.', 8.99),
(1, 'Tiramisu', 'El Tiramisu es un clasico postre italiano hecho con capas de bizcocho banado en cafe, crema de mascarpone y espolvoreado con cacao en polvo. Cada cucharada de este postre es una mezcla de texturas suaves y sabores delicados.', 9.99),
(1, 'Cannoli Siciliani', 'Los Cannoli Siciliani son postres tradicionales de Sicilia hechos con una masa crujiente y rellenos de crema de ricota dulce y chispas de chocolate. Estos deliciosos dulces son un verdadero placer para los amantes de la reposteria italiana.', 7.99),
(1, 'Gelato al Cioccolato', 'El Gelato al Cioccolato es un helado italiano cremoso y rico, elaborado con chocolate oscuro de alta calidad. Disfruta de este clasico sabor italiano que te refrescara en los dias calurosos o te deleitara en cualquier momento.', 6.99),
(1, 'Panna Cotta', 'La Panna Cotta es un postre italiano suave y sedoso hecho a base de crema cocida, azucar y gelatina de vainilla. Esta delicada y deliciosa creacion es el final perfecto para una comida italiana inolvidable.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(2, 'Croque Monsieur', 'Un delicioso y clasico sandwich frances relleno de jamon y queso gruyère, tostado hasta obtener una textura crujiente por fuera y un interior suave y derretido.', 14.99),
(2, 'Escargots de Bourgogne', 'Una exquisita especialidad francesa que consiste en caracoles de Borgona cocinados con mantequilla y ajo, presentados en su propia concha. Cada bocado ofrece una combinacion de sabores delicados y aromaticos.', 18.99),
(2, 'Boeuf Bourguignon', 'Un reconfortante estofado frances preparado con trozos tiernos de ternera cocinados a fuego lento en vino tinto y acompanados de verduras frescas, creando un plato lleno de sabores profundos y suculentos.', 22.99),
(2, 'Salade Nicoise', 'Una ensalada clasica de la cocina francesa que combina ingredientes frescos y vibrantes. Esta compuesta por atun, huevos, tomates, aceitunas y judias verdes, todo ello alinado con una vinagreta de hierbas aromaticas.', 12.99),
(2, 'Soupe à l\'Oignon', 'Una reconfortante sopa francesa de cebolla que se sirve gratinada con queso y croutons. Cada cucharada es una explosion de sabores, con la dulzura de las cebollas caramelizadas y la riqueza del caldo.', 10.99),
(2, 'Coq au Vin', 'Un plato tradicional de la cocina francesa que consiste en pollo guisado en vino tinto junto con champinones y cebolla. El resultado es una carne tierna y jugosa impregnada de los sabores ricos y complejos de los ingredientes.', 20.99),
(2, 'Crème Brûlee', 'Un postre iconico de la gastronomia francesa que consta de una delicada crema pastelera con una capa superior de caramelo crujiente. Cada cucharada ofrece una combinacion de texturas suaves y crujientes, junto con un sabor dulce y fragante.', 8.99),
(2, 'Tarte Tatin', 'Una tentadora tarta francesa que destaca por sus manzanas caramelizadas y su base de masa crujiente. Se sirve tibia y se puede disfrutar tal cual o acompanada de una bola de helado de vainilla para un contraste perfecto.', 10.99),
(2, 'Ratatouille', 'Un plato provenzal lleno de colores y sabores. Se compone de una mezcla de verduras asadas, como berenjena, calabacin y tomate, que se combinan en perfecta armonia. Es una opcion saludable y deliciosa para los amantes de las verduras.', 16.99),
(2, 'Macarons', 'Estos exquisitos dulces franceses hechos a base de almendra son famosos por su apariencia colorida y su sabor delicado. Cada macaron ofrece una combinacion de sabores unicos, desde frutas hasta chocolates, que se derriten en el paladar.', 7.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(3, 'Tacos al Pastor', 'Estos irresistibles tacos mexicanos presentan tiernas y jugosas rebanadas de cerdo marinado con una mezcla de especias tradicionales y un toque de pina, que le aporta un sabor agridulce unico.', 12.99),
(3, 'Enchiladas Verdes', 'Un plato clasico de la gastronomia mexicana que consiste en tortillas de maiz rellenas de pollo tierno y banadas en una vibrante salsa verde hecha a base de tomatillos, chiles y especias. Cada bocado es una explosion de sabores autenticos.', 10.99),
(3, 'Chiles Rellenos', 'Estos chiles poblanos son rellenos generosamente con queso y luego banados en una salsa de tomate casera llena de sabores ahumados y especiados. Es un plato picante y reconfortante que cautivara tu paladar.', 14.99),
(3, 'Mole Poblano', 'Un plato iconico de Mexico que presenta pollo tierno cocinado en una salsa de mole poblano. Esta salsa rica y compleja combina ingredientes como chiles, chocolate, especias y frutos secos para crear un sabor unico y sorprendente.', 16.99),
(3, 'Guacamole', 'Una deliciosa salsa mexicana hecha con aguacate fresco, tomate, cebolla y cilantro. Su textura cremosa y su sabor fresco y vibrante lo convierten en el acompanamiento perfecto para tus tacos y nachos favoritos.', 8.99),
(3, 'Tostadas de Ceviche', 'Estas tostadas de maiz crujientes estan coronadas con ceviche fresco de pescado y mariscos, marinados en limon y mezclado con ingredientes como cebolla, tomate y cilantro. Son una explosion de sabores y texturas.', 9.99),
(3, 'Quesadillas', 'Estas quesadillas mexicanas son tortillas de maiz rellenas de queso fundido, que se derrite hasta obtener una textura suave y cremosa. Se sirven con guacamole fresco para complementar su sabor y brindarte una experiencia deliciosa.', 7.99),
(3, 'Flan Napolitano', 'Un postre tradicional mexicano que consiste en un flan suave y sedoso, cubierto con un caramelo dorado y dulce. Cada cucharada te brinda una combinacion irresistible de texturas y sabores que te dejaran deseando mas.', 6.99),
(3, 'Churros', 'Estos dulces fritos en forma de bastones son una delicia mexicana clasica. Estan cubiertos con una generosa capa de azucar y canela, y se sirven calientes para que puedas disfrutar de su exterior crujiente y su interior suave y esponjoso.', 5.99),
(3, 'Horchata', 'Una refrescante bebida mexicana hecha a base de arroz, canela y azucar. Su sabor dulce y ligeramente especiado la convierte en la compania perfecta para tus comidas mexicanas, refrescandote y satisfaciendo tu paladar.', 4.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(4, 'Sashimi Variado', 'Disfruta de una exquisita seleccion de pescados crudos expertamente cortados en finas laminas. Cada bocado te transportara a la frescura del mar y te permitira apreciar la calidad y sabor de cada variedad.', 18.99),
(4, 'Roll de Salmon y Aguacate', 'Este delicioso maki roll combina la suavidad del salmon fresco con la cremosidad del aguacate. Envolto en una capa de arroz y alga nori, es un verdadero placer para los amantes de los sabores sutiles y equilibrados.', 12.99),
(4, 'Nigiri de Atun', 'Pequenas bolitas de arroz perfectamente moldeadas y coronadas con laminas de atun fresco. Cada nigiri es una explosion de frescura y textura, resaltando la calidad y sabor del atun en cada bocado.', 10.99),
(4, 'Uramaki Tempura', 'Un roll invertido que combina la crujiente textura del langostino tempura con la suavidad del aguacate. Cada bocado te sorprendera con una mezcla de sabores y una textura contrastante que lo convierte en una opcion irresistible.', 14.99),
(4, 'Gyoza', 'Estas empanadillas japonesas estan rellenas de una deliciosa mezcla de carne y verduras, y se cocinan al vapor y luego se doran en la sarten para obtener una textura crujiente por fuera y jugosa por dentro. Son el aperitivo perfecto para deleitar tu paladar.', 8.99),
(4, 'Yakitori', 'Sabrosas brochetas de pollo a la parrilla banadas en una irresistible salsa teriyaki. Cada bocado te brinda el equilibrio perfecto entre el pollo jugoso y el sabor dulce y salado de la salsa, una combinacion clasica de la cocina japonesa.', 9.99),
(4, 'Miso Soup', 'Una sopa japonesa reconfortante hecha a base de pasta de soja y caldo dashi. Su sabor umami y su textura suave te envolveran en una experiencia gustativa unica, ideal para comenzar tu comida japonesa.', 5.99),
(4, 'Tempura de Vegetales', 'Disfruta de una deliciosa variedad de vegetales frescos cubiertos con una masa ligera y crujiente. Cada bocado revela una textura increiblemente crujiente y un sabor naturalmente dulce de los vegetales. Es el acompanamiento perfecto o un plato por si solo.', 7.99),
(4, 'Tataki de Atun', 'Laminas de atun fresco ligeramente selladas y cubiertas con semillas de sesamo, aportando un toque de sabor y textura. Servido con salsa de soja, este plato resalta la calidad del atun y ofrece un contraste delicioso entre el exterior ligeramente crujiente y el centro suculento del pescado.', 16.99),
(4, 'Dorayaki', 'Estos panqueques japoneses rellenos de pasta de frijol azuki son una verdadera delicia. Con su textura esponjosa y su relleno dulce y suave, te brindaran un sabor autentico y reconfortante que te transportara a la tradicional reposteria japonesa.', 6.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(5, 'Bife de Chorizo', 'Disfruta de un jugoso corte de carne de res a la parrilla, cocinado a la perfeccion para resaltar su sabor y textura. Cada bocado te deleitara con su jugosidad y la intensidad de su sabor.', 22.99),
(5, 'Asado de Tira', 'Deleitate con unas costillas de res asadas a la parrilla, tiernas y sabrosas, acompanadas de una irresistible salsa chimichurri. Cada mordisco te transportara a la tradicion de los asados argentinos.', 25.99),
(5, 'Empanadas Argentinas', 'Saborea autenticas empanadas argentinas, rellenas de jugosa carne, pollo o verduras, envueltas en una masa crujiente y horneadas hasta alcanzar la perfeccion. Cada bocado te sorprendera con su combinacion de sabores y texturas.', 9.99),
(5, 'Matambre a la Pizza', 'Disfruta de un delicioso roll de carne relleno con los clasicos ingredientes de una pizza. El matambre, tierno y sabroso, envuelve el queso, tomate y oregano, creando una combinacion irresistible de sabores.', 18.99),
(5, 'Provoleta', 'Degusta el autentico queso provolone a la parrilla, gratinado con tomate y oregano. Cada porcion te brindara la combinacion perfecta de queso derretido, tomate jugoso y aromatico oregano, creando una experiencia inigualable.', 14.99),
(5, 'Milanesa Napolitana', 'Prueba una deliciosa milanesa de carne empanizada, cubierta con salsa de tomate y queso gratinado. Cada bocado te brindara la combinacion de sabores y texturas crujientes de la milanesa con la suavidad del queso derretido y la acidez de la salsa de tomate.', 16.99),
(5, 'Choripan', 'Disfruta del clasico sabor argentino con un choripan, un delicioso sandwich relleno de chorizo a la parrilla. El sabor ahumado del chorizo se combina con la frescura del pan y los condimentos, creando una explosion de sabores en cada bocado.', 10.99),
(5, 'Alfajores', 'Endulza tu paladar con los clasicos alfajores argentinos, rellenos de dulce de leche y cubiertos de chocolate. Cada mordisco te brindara la combinacion perfecta de suave textura, dulce sabor a caramelo y el toque de chocolate que los hace irresistibles.', 7.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(6, 'Escargots de Bourgogne', 'Sumergete en la exquisitez de los caracoles cocinados en mantequilla y ajo, una deliciosa y tradicional preparacion francesa. Cada bocado te transportara a los sabores autenticos de la region de Borgona.', 19.99),
(6, 'Coq au Vin', 'Disfruta de un plato clasico de la gastronomia francesa: pollo guisado en vino tinto con champinones y cebollas. Cada porcion te sorprendera con su tierna carne de pollo impregnada de los sabores ricos y robustos del vino.', 21.99),
(6, 'Bouillabaisse', 'Dejate seducir por los sabores mediterraneos de la bouillabaisse, una exquisita sopa de pescado y mariscos. Disfruta de la frescura del mar en cada cucharada, con una combinacion de sabores y aromas que te transportaran a la costa de Francia.', 24.99),
(6, 'Tarte Tatin', 'Prueba la tentacion de una tarta de manzana caramelizada invertida. Cada porcion te brindara la combinacion perfecta de manzanas suavemente caramelizadas y una base de masa crujiente, creando un contraste de sabores y texturas inigualable.', 12.99),
(6, 'Quiche Lorraine', 'Deleitate con una exquisita tarta salada conocida como Quiche Lorraine. Esta delicia francesa combina tocino ahumado, queso y una suave crema en una base de masa dorada, creando una combinacion de sabores salados y cremosos.', 15.99),
(6, 'Creme Brulee', 'Satisface tu paladar con un postre clasico: el creme brulee. Disfruta de la suave crema quemada en la parte superior, contrastando con la dulzura y la delicadeza de la crema en su interior. Cada cucharada es una experiencia de sabor unica.', 10.99),
(6, 'Ratatouille', 'Descubre el encanto de un plato provenzal de verduras asadas como berenjena, calabacin y tomate. Cada bocado te sumergira en la frescura y la riqueza de los sabores mediterraneos, creando una experiencia culinaria llena de colores y texturas.', 16.99),
(6, 'Profiteroles', 'Deleitate con las bolitas de masa rellenas de crema y banadas en chocolate que conforman los profiteroles. Cada bocado te brindara la combinacion perfecta de suave y esponjosa masa, cremosa crema y el rico sabor del chocolate.', 9.99),
(6, 'Salade Nicoise', 'Disfruta de una refrescante ensalada que combina atun, tomate, huevo, aceitunas y judias verdes. Cada bocado te deleitara con la frescura de los ingredientes y la combinacion de sabores mediterraneos.', 14.99),
(6, 'Crepes Suzette', 'Dejate seducir por las crepes flameadas con salsa de naranja y Grand Marnier. Cada bocado te brindara la combinacion de suaves y delicadas crepes, la dulzura citrica de la salsa de naranja y el toque especial del licor Grand Marnier.', 17.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(7, 'Paella de Mariscos', 'Sumergete en los sabores del mar con nuestra exquisita paella de mariscos. Este plato tradicional combina arroz con langostinos, mejillones, calamares y otros deliciosos mariscos, todo cocinado a la perfeccion en un sabroso caldo.', 25.99),
(7, 'Ceviche Mixto', 'Disfruta de la frescura del mar con nuestro ceviche mixto. Pescado y mariscos maravillosamente marinados en limon con un toque de aji y cebolla, creando un plato refrescante y lleno de sabor.', 18.99),
(7, 'Pulpo a la Gallega', 'Dejate tentar por nuestro delicioso pulpo a la gallega. Tierno pulpo cocido a la perfeccion, acompanado de aceite de oliva, pimenton y patatas, creando una combinacion de sabores tradicionales y reconfortantes.', 21.99),
(7, 'Gambas al Ajillo', 'Saborea nuestras gambas al ajillo, un clasico plato espanol. Gambas frescas salteadas en aceite de oliva con ajo y guindilla, creando una explosion de sabores y un toque picante que no podras resistir.', 16.99),
(7, 'Calamares a la Romana', 'Disfruta de nuestras crujientes y deliciosas anillas de calamar rebozadas y fritas. Cada bocado te brindara una combinacion de texturas y un sabor marino unico que te transportara a las costas mediterraneas.', 12.99),
(7, 'Sopa de Pescado', 'Sumergete en la calidez de nuestra reconfortante sopa de pescado. Trozos de pescado y mariscos se combinan en un caldo lleno de sabor, creando una experiencia culinaria que te reconfortara en cada cucharada.', 10.99),
(7, 'Pargo a la Veracruzana', 'Prueba nuestro pargo a la veracruzana, un plato lleno de sabores vibrantes. Pargo asado con una deliciosa salsa de tomate, aceitunas y alcaparras, que le brindan un toque mediterraneo y una explosion de sabores.', 22.99),
(7, 'Flan de Coco', 'Deleita tu paladar con nuestro exquisito flan de coco. Cada cucharada te transportara a un paraiso tropical con su suave textura y su sabor dulce a coco, todo coronado con un rico caramelo.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(8, 'Pizza Margherita', 'Sumergete en la clasica pizza Margherita, con salsa de tomate, mozzarella y albahaca fresca. Cada bocado es una explosion de sabores italianos autenticos y la combinacion perfecta de ingredientes simples pero deliciosos.', 14.99),
(8, 'Pizza Pepperoni', 'Prueba nuestra deliciosa pizza Pepperoni, con salsa de tomate, generosas capas de mozzarella y rodajas de pepperoni picante. Cada mordisco te brinda el equilibrio perfecto entre el queso fundido y el sabor ahumado de los pepperoni.', 16.99),
(8, 'Pizza Hawaiana', 'Disfruta de nuestra polemica pero irresistible pizza Hawaiana, con salsa de tomate, mozzarella, jugoso jamon y trozos de pina. La combinacion de sabores salados y dulces te transportara a la costa tropical.', 15.99),
(8, 'Pizza Capricciosa', 'Explora los sabores autenticos de Italia con nuestra pizza Capricciosa. Cubierta con salsa de tomate, mozzarella, jamon, champinones y aceitunas, cada porcion es un festin de ingredientes frescos y sabores equilibrados.', 17.99),
(8, 'Pizza Prosciutto e Funghi', 'Prueba nuestra deliciosa pizza Prosciutto e Funghi, con salsa de tomate, mozzarella, lonchas de jamon y champinones frescos. Cada bocado te transportara a la autentica experiencia de la cocina italiana.', 16.99),
(8, 'Calzone', 'Disfruta de un giro emocionante con nuestro calzone, una pizza en forma de empanada rellena de mozzarella, jamon y champinones. Cada mordisco es una explosion de sabores en un paquete deliciosamente crujiente.', 18.99),
(8, 'Lasagna', 'Sumergete en las capas de sabor con nuestra lasagna casera. Pasta horneada en capas con carne, queso y salsa de tomate, creando un plato reconfortante que deleitara a tus papilas gustativas.', 19.99),
(8, 'Ravioli di Spinaci e Ricotta', 'Descubre la perfeccion de nuestros raviolis caseros rellenos de espinacas y ricotta, acompanados de una deliciosa salsa de tomate. Cada bocado es una combinacion de suavidad, frescura y sabores italianos autenticos.', 17.99),
(8, 'Tiramisu', 'Termina tu comida con nuestro clasico tiramisu italiano. Capas de bizcocho empapado en cafe y crema de mascarpone, creando una mezcla irresistible de texturas y sabores que te transportaran a la dulzura de Italia.', 9.99),
(8, 'Gelato', 'No puedes perderte nuestro helado italiano artesanal en una variedad de sabores exquisitos. Desde los clasicos como vainilla y chocolate hasta opciones mas audaces como pistacho y fresa, cada cucharada es una experiencia refrescante y deliciosa.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(9, 'Salmon Teriyaki', 'Disfruta de nuestro exquisito salmon a la parrilla con salsa teriyaki y verduras frescas. Cada bocado es una combinacion de sabores delicados y jugosos que te transportaran a la cocina asiatica.', 23.99),
(9, 'Filete Mignon', 'Degusta nuestro filete mignon, un corte de ternera de primera calidad a la parrilla acompanado de una guarnicion de tu eleccion. Cada porcion es tierna, jugosa y llena de sabor.', 27.99),
(9, 'Risotto de Champinones', 'Sumergete en la cremosidad de nuestro risotto de champinones, elaborado con arroz al dente, champinones frescos y queso parmesano. Cada cucharada es una explosion de sabores y texturas.', 18.99),
(9, 'Ensalada Caprese', 'Refresca tu paladar con nuestra ensalada Caprese, compuesta por tomates jugosos, mozzarella fresca y hojas de albahaca, todo aderezado con un toque de vinagre balsamico. Una combinacion simple pero deliciosa.', 14.99),
(9, 'Carpaccio de Res', 'Deleitate con nuestro carpaccio de res, finas laminas de carne de res marinadas en aceite de oliva y limon, acompanadas de ingredientes frescos y sabrosos. Una opcion ligera pero llena de sabor.', 16.99),
(9, 'Cordero al Horno', 'Saborea nuestra pierna de cordero asada al horno con hierbas y especias, que se derrite en tu boca con cada bocado. Una opcion de lujo para los amantes de la carne.', 25.99),
(9, 'Tarta de Chocolate', 'Termina tu experiencia gastronomica con nuestra deliciosa tarta de chocolate, cubierta con ganache de chocolate y decorada con frutas frescas. Cada porcion es un placer para los amantes del chocolate.', 11.99),
(9, 'Crema de Calabaza', 'Disfruta de una crema suave y reconfortante de calabaza, con crujientes de panceta que anaden un contraste de texturas. Perfecta para calentar el alma en cualquier epoca del ano.', 10.99),
(9, 'Gazpacho Andaluz', 'Refresca tu paladar con nuestro gazpacho andaluz, una sopa fria a base de tomate, pepino, pimiento y ajo. Cada cucharada te transportara a los sabores mediterraneos de Espana.', 9.99),
(9, 'Mousse de Mango', 'Finaliza tu comida con nuestro mousse de mango, un postre ligero y refrescante que combina la suavidad del mango con una textura aireada. Cada cucharada es una explosion de sabor tropical.', 8.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(10, 'Fabada Asturiana', 'Disfruta de nuestro delicioso guiso de alubias blancas con chorizo y panceta, un plato tradicional de la region de Asturias en España. Cada cucharada es una explosion de sabores reconfortantes que te transportaran a la rica cultura gastronomica de esta hermosa region. Nuestras alubias se cocinan a fuego lento para lograr una textura cremosa y se acompañan con trozos jugosos de chorizo y panceta ahumada, que aportan un sabor ahumado y delicioso al plato. Este plato abundante y nutritivo es perfecto para disfrutar en un dia frio y te dejara satisfecho y feliz.', 16.99),
(10, 'Chuleton de Ternera', 'Prueba nuestro generoso chuleton de ternera a la parrilla, jugoso y lleno de sabor. Cada bocado es una experiencia carnivora que satisfara tu apetito y despertara tus papilas gustativas. Nuestro chuleton esta cuidadosamente seleccionado y cocinado a la perfeccion, para que disfrutes de una carne tierna y jugosa en cada corte. Acompañado de guarniciones como patatas asadas o verduras salteadas, este plato es perfecto para los amantes de la carne que buscan una experiencia culinaria excepcional.', 29.99),
(10, 'Pulpo a Feira', 'Disfruta de nuestro pulpo a feira, una receta clasica de pulpo cocido con aceite de oliva, pimenton y patatas. Cada tentaculo es tierno y se deshace en tu boca, mientras que el aceite de oliva y el pimenton le dan un sabor ahumado y delicioso. Nuestro pulpo se cocina a la perfeccion, logrando una textura suave y jugosa que contrasta maravillosamente con las patatas tiernas y cremosas. Este plato tradicional gallego es una verdadera delicia que te transportara a las costas de España.', 21.99),
(10, 'Croquetas de Jamon', 'Prueba nuestras cremosas croquetas rellenas de jamon iberico, crujientes por fuera y suaves por dentro. Cada bocado es una explosion de sabor y textura que deleitara tus sentidos. El jamon iberico, con su intenso sabor y su delicada textura, se mezcla con una suave bechamel y se envuelve en una capa crujiente de pan rallado. Cada croqueta es cuidadosamente elaborada a mano para garantizar la maxima calidad y el mejor sabor. Este plato clasico español es perfecto como entrante o como acompañamiento.', 12.99),
(10, 'Tortilla Española', 'Saborea nuestra clasica tortilla española, elaborada con patatas, cebolla y huevo. Cada porcion es un deleite para los amantes de los platos tradicionales españoles. Nuestra tortilla esta hecha con ingredientes frescos y de alta calidad, cocinados a fuego lento para lograr una textura suave y jugosa. Las patatas se frien hasta quedar tiernas y doradas, se mezclan con la cebolla caramelizada y se unen con los huevos batidos para crear una deliciosa tortilla. Este plato es perfecto para cualquier momento del dia y es un verdadero clasico de la cocina española.', 13.99),
(10, 'Gambas al Ajillo', 'Degusta nuestras gambas salteadas en aceite de oliva con ajo y guindilla, un clasico de la cocina española. Cada langostino esta impregnado de sabores intensos y picantes que te haran agua la boca. Nuestras gambas se saltean a la perfeccion, conservando su textura jugosa y delicada, mientras que el aceite de oliva, el ajo y la guindilla le dan un toque de picante y sabor. Este plato es ideal como entrante o como parte de una seleccion de tapas para compartir.', 16.99),
(10, 'Patatas Bravas', 'Disfruta de nuestras patatas fritas acompañadas de salsa brava picante y alioli, una combinacion irresistible que te hara volver por mas. Nuestras patatas se frien hasta obtener una textura crujiente por fuera y tierna por dentro, y se sirven con una salsa brava casera que combina tomate, pimenton y un toque de picante. Ademas, tambien ofrecemos alioli, una salsa cremosa de ajo y aceite de oliva que complementa perfectamente el sabor de las patatas. Este plato es perfecto como acompañamiento o como una deliciosa opcion vegetariana.', 9.99),
(10, 'Flan Casero', 'Prueba nuestro delicioso flan casero con caramelo liquido, un postre clasico que terminara tu comida con dulzura. Cada cucharada es suave, cremosa y llena de sabor, haciendo que cada bocado sea un verdadero placer para el paladar. Nuestro flan se prepara con ingredientes frescos y se cocina lentamente para lograr una textura sedosa y delicada. El caramelo liquido añade un toque dulce y caramelizado que combina perfectamente con la suavidad del flan. Este postre es el final perfecto para una comida deliciosa.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(10, 'Paella Valenciana', 'Prueba nuestra autentica paella valenciana, un plato iconico de la cocina española. Cada cucharada es una explosion de sabores mediterraneos que te transportara a las costas de Valencia. Nuestra paella esta hecha con arroz bomba, pollo, conejo, judias verdes, tomate, azafran y caldo de marisco, todo cocido lentamente para que los sabores se mezclen a la perfeccion. Este plato abundante y sabroso es perfecto para compartir con amigos y familiares.', 19.99),
(10, 'Gazpacho Andaluz', 'Refresca tu paladar con nuestro gazpacho andaluz, una sopa fria a base de tomate, pepino, pimiento, cebolla, ajo, aceite de oliva y vinagre. Cada sorbo es una explosion de sabores frescos y vibrantes que te transportara al verano en el sur de España. Nuestro gazpacho se sirve bien frio y es perfecto para combatir el calor. Disfrutalo como entrante o como una opcion ligera y saludable para una comida.', 8.99),
(10, 'Rabo de Toro', 'Disfruta de nuestro rabo de toro estofado, un plato tradicional de la cocina española. Cada porcion es tierna y jugosa, ya que se cocina a fuego lento durante horas para lograr una carne tierna y sabrosa. Nuestro estofado se hace con rabo de toro, vino tinto, verduras y especias, creando una combinacion de sabores rica y reconfortante. Este plato es perfecto para los amantes de la carne y se sirve tradicionalmente con patatas fritas o arroz.', 22.99),
(10, 'Ensalada Cesar', 'Prueba nuestra refrescante ensalada Cesar, una combinacion clasica de lechuga romana, crutones, queso parmesano y aderezo Cesar. Cada bocado es una mezcla de texturas y sabores, desde la frescura de la lechuga hasta la cremosidad del aderezo y el crujido de los crutones. Nuestra ensalada se puede disfrutar como plato principal o como acompañamiento para complementar cualquier comida.', 10.99),
(10, 'Tarta de Santiago', 'Endulza tu dia con nuestra deliciosa tarta de Santiago, un postre tradicional gallego. Cada porcion es una combinacion de almendras molidas, azucar, huevos y ralladura de limon, creando una textura suave y un sabor dulce y almendrado. Nuestra tarta se hornea hasta obtener un exterior dorado y se espolvorea con azucar glas. Es el final perfecto para cualquier comida o simplemente para disfrutar con una taza de cafe.', 6.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(11, 'Filete de Res', 'Disfruta de nuestro tierno filete de res bañado en una deliciosa salsa de vino tinto. Cada bocado es una explosion de sabores intensos y jugosos que te transportara a un viaje culinario inolvidable. El filete se cocina a la perfeccion, conservando su jugosidad y suavidad, mientras que la salsa de vino tinto realza su sabor y lo complementa a la perfeccion. Acompañado de guarniciones exquisitas, este plato es una opcion imprescindible para los amantes de la carne.', 26.99),
(11, 'Pechuga de Pollo Rellena', 'Degusta nuestra jugosa pechuga de pollo rellena de espinacas frescas y queso derretido. Cada porcion es una combinacion perfecta de sabores suaves y texturas reconfortantes. El pollo se cocina a la perfeccion, conservando su jugosidad y sabor, mientras que el relleno de espinacas y queso agrega un toque de cremosidad y un sabor extra. Acompañada de un suave pure de papas, esta deliciosa opcion te dejara satisfecho y con ganas de mas.', 22.99),
(11, 'Risotto de Mariscos', 'Saborea nuestro arroz cremoso con una seleccion de mariscos frescos cuidadosamente elegidos. Cada cucharada es una explosion de sabores del mar que te transportara a las costas mediterraneas. El risotto se prepara con un caldo sabroso y se combina con una variedad de mariscos, como camarones, mejillones y calamares, que se cocinan a la perfeccion. La cremosidad del arroz y la combinacion de mariscos hacen de este plato una experiencia culinaria unica.', 24.99),
(11, 'Ensalada Cesar', 'Prueba nuestra version clasica de la famosa ensalada Cesar, con pollo a la parrilla, croutones crujientes y aderezo Cesar casero. Cada bocado es una explosion de frescura y sabores equilibrados que te dejara satisfecho y con ganas de mas. Los ingredientes frescos se combinan a la perfeccion, mientras que el aderezo Cesar casero agrega un toque de cremosidad y sabor irresistible. Esta ensalada es ideal como plato principal o como acompañamiento.', 16.99),
(11, 'Ceviche Mixto', 'Disfruta de nuestra exquisita mezcla de pescado y mariscos marinados en limon fresco con cebolla y aji. Cada cucharada es una combinacion perfecta de sabores citricos y marinos que deleitaran tu paladar. El ceviche se prepara con ingredientes frescos y se adereza con limon, que realza los sabores naturales de los mariscos. La combinacion de texturas y sabores hace que este plato sea una delicia refrescante para cualquier ocasion.', 18.99),
(11, 'Rabo de Toro Estofado', 'Prueba nuestro delicioso estofado de rabo de toro con verduras frescas y vino tinto. Cada porcion es una muestra de la cocina tradicional y sabrosa de nuestra region. El rabo de toro se cocina a fuego lento durante horas, lo que resulta en una carne tierna y jugosa que se deshace en la boca. El estofado se complementa con verduras frescas y un toque de vino tinto, que le confiere profundidad y riqueza de sabor.', 28.99),
(11, 'Tarta Tatin', 'Disfruta de nuestra irresistible tarta invertida de manzanas caramelizadas con masa hojaldrada crujiente. Cada porcion es una combinacion perfecta de dulzura y textura crujiente que te cautivara desde el primer bocado. Las manzanas se caramelizan lentamente, creando un delicioso caramelo dorado que impregna cada capa de la tarta. La masa hojaldrada aporta un contraste crujiente, haciendo de esta tarta un postre que no puedes dejar pasar.', 13.99),
(11, 'Sopa de Cebolla', 'Saborea nuestra reconfortante sopa de cebolla gratinada con queso fundido. Cada cucharada es reconfortante y llena de sabores profundos que te haran sentir como en casa. La sopa se prepara con cebollas caramelizadas lentamente, que aportan un sabor dulce y suave. La capa de queso fundido por encima crea una textura cremosa y un sabor extra. Esta sopa es el plato perfecto para disfrutar en dias frios o cuando necesitas un consuelo culinario.', 11.99),
(11, 'Pure de Zanahoria y Jengibre', 'Degusta nuestro suave pure de zanahoria y jengibre con especias cuidadosamente seleccionadas. Cada cucharada es una explosion de sabores frescos y saludables que te dejara satisfecho y con una sensacion de bienestar. El pure se prepara con zanahorias frescas y jengibre, que se combinan para crear un sabor unico y revitalizante. Las especias añaden un toque adicional de calidez y complejidad al plato.', 9.99),
(11, 'Mousse de Frambuesa', 'Prueba nuestro postre ligero y cremoso de mousse de frambuesa. Cada cucharada es refrescante y llena de sabor a frutas frescas que te transportara a un mundo de dulzura. La mousse se prepara con frambuesas frescas y se combina con una textura suave y aireada que se deshace en la boca. Este postre es el final perfecto para una comida deliciosa y dejara un sabor dulce en tu paladar.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(12, 'Bife de Chorizo', 'Disfruta de nuestro jugoso bife de chorizo a la parrilla con chimichurri. Cada corte es tierno y lleno de sabor, y la parrilla le agrega un toque ahumado irresistible. El bife de chorizo se cocina a la perfeccion para preservar su jugosidad y se sirve con una deliciosa salsa chimichurri, que realza aun mas su sabor. Este plato es una delicia para los amantes de la carne.', 25.99),
(12, 'Asado de Tira', 'Saborea nuestras tiernas costillas de res asadas a la parrilla. Cada bocado es una experiencia carnivora unica que te transportara a los autenticos asados argentinos. El asado de tira se cocina lentamente sobre las brasas, lo que resulta en una carne tierna y jugosa con un sabor ahumado irresistible. Este plato es perfecto para compartir y disfrutar de una comida tradicional.', 27.99),
(12, 'Matambre a la Pizza', 'Prueba nuestro matambre relleno con salsa de tomate, mozzarella y los ingredientes de tu eleccion. Cada porcion es un festin de sabores y texturas que combina la jugosidad del matambre con los sabores clasicos de una pizza. El matambre se cocina a la parrilla y se rellena con una generosa cantidad de salsa de tomate y queso, junto con los ingredientes que mas te gusten. Este plato es una opcion unica y deliciosa.', 23.99),
(12, 'Empanadas Argentinas', 'Degusta nuestras empanadas caseras de carne, pollo o verduras. Cada una esta hecha con masa crujiente y un relleno jugoso y sabroso que te cautivara desde el primer bocado. Nuestras empanadas se hornean hasta obtener un dorado perfecto, y cada variedad tiene su propio sabor distintivo. Ya sea que prefieras la clasica empanada de carne, la suculenta empanada de pollo o la deliciosa empanada de verduras, todas son una opcion excelente para disfrutar como aperitivo o plato principal.', 10.99),
(12, 'Parrillada Mixta', 'Disfruta de nuestra seleccion de carnes a la parrilla: chorizo, morcilla, churrasco, pollo y cerdo. Cada porcion es un festin para los amantes de la carne, ya que combina una variedad de sabores y cortes. Nuestra parrillada mixta incluye chorizos jugosos, morcillas sabrosas, tiernos churrascos, pollo jugoso y cerdo marinado. Cada corte se asa a la perfeccion para resaltar su sabor unico. Acompañado de guarniciones tradicionales, este plato te hara sentir como en una autentica parrillada argentina.', 29.99),
(12, 'Ensalada Criolla', 'Prueba nuestra ensalada tradicional argentina con tomate, cebolla y pimientos. Cada bocado es fresco y lleno de sabores vibrantes que te transportaran a los sabores autenticos de Argentina. La ensalada criolla combina ingredientes frescos y coloridos como tomates maduros, cebollas rojas y pimientos jugosos. Aliñada con un toque de aceite de oliva y vinagre, esta ensalada es el complemento perfecto para cualquier comida.', 12.99),
(12, 'Provoleta', 'Degusta nuestro queso provolone a la parrilla con especias y aceite de oliva. Cada porcion es un derroche de sabores intensos y cremosidad. La provoleta es un queso provolone que se derrite a la perfeccion en la parrilla, creando una capa dorada por fuera y cremosa por dentro. Se sazona con especias y se sirve con un chorrito de aceite de oliva, lo que le da un sabor irresistible. Esta opcion es ideal como entrada o acompañamiento.', 14.99),
(12, 'Helado de Dulce de Leche', 'Prueba nuestro clasico helado argentino de dulce de leche. Cada cucharada es suave, dulce y llena de indulgencia. El helado de dulce de leche es un postre emblematico de Argentina, conocido por su textura cremosa y su sabor dulce y acaramelado. Nuestro helado se elabora con autentico dulce de leche, que le brinda ese sabor distintivo y delicioso. Disfrutalo solo o como acompañamiento de otros postres.', 8.99),
(12, 'Mollejas a la Parrilla', 'Saborea nuestras mollejas de ternera a la parrilla con limon y sal gruesa. Cada bocado es tierno y lleno de sabor. Las mollejas de ternera se preparan a la parrilla, lo que les confiere un exterior crujiente y un interior suave y jugoso. Se sazonan con limon y sal gruesa para realzar su sabor natural. Este plato es una delicia para los amantes de las texturas tiernas y los sabores intensos.', 19.99),
(12, 'Alfajores', 'Degusta nuestros dulces tipicos argentinos: dos galletas rellenas de dulce de leche y cubiertas de chocolate. Cada bocado es una combinacion perfecta de texturas y dulzura que te encantara. Nuestros alfajores se elaboran con dos galletas suaves y delicadas que se unen con un generoso relleno de dulce de leche. Luego, se cubren con una capa de chocolate que añade un toque irresistible. Estos dulces son el acompañamiento ideal para una taza de cafe o como regalo para endulzar cualquier ocasion.', 9.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(13, 'Filet Mignon', 'Disfruta de nuestro exquisito filet mignon con salsa de champiñones. Cada corte es tierno y jugoso, y la salsa complementa perfectamente los sabores. El filet mignon es un corte premium de carne de res, conocido por su ternura y sabor. Nuestro filet mignon se cocina a la perfeccion para preservar su jugosidad y se sirve con una deliciosa salsa de champiñones, que realza aun mas su sabor. Este plato es una opcion sofisticada para los amantes de la carne.', 28.99),
(13, 'Ratatouille', 'Prueba nuestro plato vegetariano de ratatouille con berenjena, calabacin, pimientos y tomate al horno. Cada porcion es una explosion de sabores y texturas que te transportaran a la cocina mediterranea. El ratatouille combina una variedad de verduras frescas cortadas en rodajas y horneadas lentamente con hierbas aromaticas. El resultado es un plato colorido y lleno de sabores intensos. Esta opcion es ideal para los amantes de la cocina vegetariana.', 16.99),
(13, 'Sopa de Calabaza', 'Deleitate con nuestra sopa cremosa de calabaza con un toque de jengibre. Cada cucharada es reconfortante y llena de sabores calidos. La sopa de calabaza es un plato clasico y reconfortante, especialmente popular durante las estaciones mas frias. Nuestra version se prepara con calabaza fresca y se combina con especias y jengibre para crear un sabor suave y reconfortante. Disfruta de esta deliciosa sopa como entrada o plato principal.', 11.99),
(13, 'Ensalada Caprese', 'Prueba nuestra clasica ensalada italiana Caprese con tomate, mozzarella y albahaca. Cada bocado es fresco y lleno de sabores mediterraneos. La ensalada Caprese es una combinacion simple pero deliciosa de tomate fresco, mozzarella de bufala y hojas de albahaca. Se adereza con un chorrito de aceite de oliva y vinagre balsamico, lo que realza los sabores naturales de los ingredientes. Esta ensalada es perfecta como entrada refrescante o como guarnicion.', 14.99),
(13, 'Risotto de Hongos', 'Disfruta de nuestro risotto cremoso con una variedad de hongos frescos. Cada cucharada es reconfortante y llena de sabores terrosos. El risotto de hongos es un plato italiano clasico que combina arroz cremoso con una seleccion de hongos frescos como champiñones, porcini o shiitake. El arroz se cocina lentamente en caldo y se mezcla con los hongos para crear una textura suave y un sabor lleno de profundidad. Este plato es perfecto para los amantes de la cocina italiana.', 22.99),
(13, 'Tarta de Espinacas y Queso de Cabra', 'Degusta nuestra deliciosa tarta salada con espinacas, queso de cabra y cebolla caramelizada. Cada porcion es una combinacion perfecta de sabores salados y dulces. Nuestra tarta se prepara con una base de masa crujiente y se rellena con una mezcla de espinacas salteadas, queso de cabra cremoso y cebolla caramelizada para añadir un toque de dulzura. Esta opcion es ideal como plato principal o como entrada.', 19.99),
(13, 'Crema Catalana', 'Prueba nuestro postre tradicional español similar al crème brûlee. Cada cucharada de nuestra crema catalana es suave, cremosa y llena de sabores a caramelo y citricos. La crema catalana es un postre clasico de la cocina española. Nuestra version se elabora con una crema pastelera suave y aromatizada con cascara de limon y canela. Se carameliza la capa superior para obtener una textura crujiente. Disfruta de este postre indulgente para terminar tu comida con un toque dulce.', 10.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(14, 'Pad Thai', 'Disfruta del famoso plato tailandes de fideos de arroz salteados con pollo, camarones o tofu. Cada bocado esta lleno de sabores autenticos y especias exquisitas. El Pad Thai es un plato iconico de la cocina tailandesa que combina fideos de arroz salteados con una mezcla de proteinas, como pollo tierno, camarones jugosos o tofu sabroso. Los fideos se cocinan al dente y se mezclan con una salsa agridulce llena de sabores equilibrados. Ademas, se añaden ingredientes frescos como brotes de soja, cacahuetes picados y cilantro para darle textura y frescura al plato. Prueba este delicioso plato para experimentar la autentica cocina tailandesa.', 17.99),
(14, 'Curry de Coco', 'Prueba nuestro delicioso curry tailandes con leche de coco, pollo, verduras y especias. Cada cucharada es una explosion de sabores picantes y cremosos.', 19.99),
(14, 'Sushi Variado', 'Disfruta de una variedad de sushi que incluye nigiri, maki y sashimi. Cada pieza esta hecha con los ingredientes mas frescos y presenta una combinacion perfecta de sabores.', 24.99),
(14, 'Rollitos de Primavera', 'Degusta nuestros deliciosos rollitos de primavera rellenos de vegetales y carne, acompañados de salsa agridulce. Cada bocado es crujiente y lleno de sabores deliciosos.', 12.99),
(14, 'Tom Kha Gai', 'Prueba nuestra autentica sopa tailandesa de coco con pollo y hierbas aromaticas. Cada cucharada es reconfortante y esta llena de sabores equilibrados y exoticos.', 15.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(15, 'Lasagna de Carne', 'Prueba nuestra deliciosa lasagna casera con carne, pasta y salsa de tomate. Cada capa esta llena de sabores reconfortantes y autenticos.', 14.99),
(15, 'Milanesa Napolitana', 'Disfruta de nuestra milanesa de ternera empanizada cubierta con salsa de tomate y queso. Cada bocado es crujiente por fuera y tierno por dentro.', 17.99),
(15, 'Pollo al Horno', 'Saborea nuestro pollo jugoso asado al horno con hierbas y especias. Cada pieza esta llena de sabor y se derrite en tu boca.', 16.99),
(15, 'Guiso de Lentejas', 'Prueba nuestro guiso tradicional de lentejas con chorizo y verduras. Cada cucharada te brinda una experiencia reconfortante y llena de sabor.', 12.99),
(15, 'Ensalada de Pollo', 'Disfruta de nuestra ensalada fresca con pollo a la parrilla, vegetales y aderezo de tu eleccion. Cada bocado es saludable y sabroso.', 13.99),
(15, 'Tarta de Verduras', 'Degusta nuestra deliciosa tarta salada de verduras mixtas con masa quebrada. Cada porcion es una combinacion perfecta de sabores y texturas.', 11.99),
(15, 'Arroz con Leche', 'Endulza tu paladar con nuestro postre cremoso de arroz con leche, canela y azucar. Cada cucharada es un deleite reconfortante.', 8.99),
(15, 'Pure de Papa', 'Prueba nuestro pure suave y cremoso de papas. Cada cucharada es reconfortante y se derrite en tu boca.', 7.99),
(15, 'Ensalada de Frutas', 'Refresca tu paladar con nuestra ensalada de frutas frescas. Cada bocado es jugoso y lleno de sabores naturales.', 9.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(16, 'Hamburguesa Clasica', 'Deleitate con nuestra jugosa hamburguesa de carne de res, lechuga, tomate y aderezo especial. ¡Un clasico irresistible!', 12.99),
(16, 'Fish and Chips', 'Prueba nuestro clasico plato ingles de pescado rebozado y papas fritas. Cada bocado es crujiente y lleno de sabor.', 14.99),
(16, 'Alitas de Pollo', 'Disfruta de nuestras alitas de pollo marinadas y fritas, con salsa a eleccion. Cada alita es sabrosa y jugosa.', 10.99),
(16, 'Nachos con Queso', 'Satisface tus antojos con nuestros nachos crujientes cubiertos de queso derretido, jalapenos y guacamole. ¡El acompanamiento perfecto para compartir!', 9.99),
(16, 'Ensalada Cesar', 'Disfruta de nuestra ensalada clasica con pollo a la parrilla, croutones y aderezo Cesar. Una combinacion fresca y deliciosa.', 13.99),
(16, 'Sandwich de Pastrami', 'Prueba nuestro sabroso sandwich relleno de pastrami, pepinillos y mostaza. Cada bocado es una explosion de sabores.', 11.99),
(16, 'Cheesecake de Frutos Rojos', 'Endulza tu paladar con nuestro cheesecake cremoso con salsa de frutos rojos. Cada porcion es suave y deliciosa.', 8.99),
(16, 'Papas Fritas', 'Degusta nuestras papas fritas doradas y crujientes. El acompanamiento perfecto para cualquier plato.', 6.99),
(16, 'Cerveza Artesanal', 'Descubre nuestra variedad de cervezas artesanales para disfrutar. Cada sorbo es una experiencia unica y refrescante.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(17, 'Paella Valenciana', 'Disfruta de nuestro plato tradicional espanol de arroz con mariscos, pollo y verduras. Una explosion de sabores mediterraneos.', 25.99),
(17, 'Gazpacho', 'Refrescante sopa fria de tomate, pepino, pimiento y aceite de oliva. Perfecta para los dias calurosos.', 11.99),
(17, 'Lomo de Cerdo al Horno', 'Prueba nuestro jugoso lomo de cerdo asado al horno con hierbas mediterraneas. Una delicia para el paladar.', 18.99),
(17, 'Ensalada Griega', 'Disfruta de nuestra ensalada fresca con tomate, pepino, cebolla, aceitunas y queso feta. Un clasico de la cocina griega.', 14.99),
(17, 'Moussaka', 'Degusta nuestro plato griego de berenjena, carne picada y salsa bechamel gratinada. Una combinacion irresistible.', 19.99),
(17, 'Tzatziki', 'Prueba nuestra salsa griega a base de yogur, pepino, ajo y hierbas frescas. El complemento perfecto para tus platos.', 7.99),
(17, 'Baklava', 'Endulza tu paladar con nuestro dulce tradicional griego hecho con nueces y hojaldre banado en almibar. Una exquisitez.', 9.99),
(17, 'Tabbouleh', 'Disfruta de nuestra ensalada de bulgur, perejil, menta, tomate y limon. Una opcion refrescante y llena de sabor.', 12.99),
(17, 'Pita Gyro', 'Saborea nuestro delicioso sandwich griego relleno de carne de cerdo asada, tzatziki y vegetales. Una explosion de sabores.', 16.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(18, 'Asado de Tira', 'Disfruta de nuestro delicioso corte de carne de res asado a la parrilla. Nuestro asado de tira se prepara con esmero, utilizando los mejores cortes de carne de res seleccionada. Cada bocado es jugoso, tierno y lleno de sabor, con ese inconfundible aroma a parrilla que te transportara a los autenticos asados argentinos. Acompanado de guarniciones y aderezos que realzan su sabor, nuestro asado de tira es una experiencia culinaria que no puedes perderte. ¡Ven y disfrutalo con nosotros!', 29.99),
(18, 'Choripan', 'Prueba nuestro clasico sandwich argentino con chorizo a la parrilla. El choripan es una verdadera delicia que combina la intensidad y jugosidad del chorizo argentino con el pan recien horneado. Nuestro chorizo se elabora con una mezcla de carnes seleccionadas y especias tradicionales, y se cocina a la perfeccion en nuestra parrilla para lograr ese sabor irresistible. Acompanado de aderezos y salsas caseras, el choripan es el bocadillo ideal para satisfacer tus antojos. ¡Ven y pruebalo!', 12.99),
(18, 'Empanadas', 'Deleitate con nuestras empanadas argentinas rellenas de carne, pollo o verduras. Cada empanada se elabora cuidadosamente a mano, utilizando masa casera y rellenos de alta calidad. Nuestra empanada de carne esta hecha con un jugoso relleno de carne de res sazonada con especias tradicionales. La empanada de pollo combina tierna carne de pollo con sabrosas verduras, y la empanada de verduras te sorprendera con una mezcla de vegetales frescos y sabrosos condimentos. Cada bocado es una explosion de sabores y texturas que te transportara a la autentica cocina argentina. ¡No te las pierdas!', 9.99),
(18, 'Provoleta', 'Saborea nuestro queso provolone asado a la parrilla con aceite de oliva y especias. La provoleta es un plato emblematico de la cocina argentina que destaca por su sabor intenso y su textura suave y cremosa. Utilizamos queso provolone de calidad y lo asamos a la parrilla hasta que se derrite y adquiere un delicado sabor ahumado. Luego, lo rociamos con aceite de oliva y especias que realzan su sabor y aroma. Cada porcion de provoleta es un deleite para los amantes del queso y una excelente opcion para comenzar una comida o disfrutar como aperitivo. ¡Ven y prueba nuestra exquisita provoleta!', 16.99),
(18, 'Mollejas', 'Disfruta de nuestras mollejas de ternera a la parrilla con limon y sal. Las mollejas son un manjar muy apreciado en la cocina argentina y te invitamos a descubrir su delicioso sabor en nuestro restaurante. Nuestras mollejas se seleccionan cuidadosamente, se marinan con hierbas y especias, y se asan a la parrilla hasta obtener una textura tierna por dentro y crujiente por fuera. Les anadimos el toque fresco del limon y la pizca de sal que realza su sabor unico. Si eres amante de los sabores intensos y las texturas irresistibles, las mollejas son una eleccion perfecta. ¡Ven y deleitate con nuestras mollejas!', 19.99),
(18, 'Papas Provenzal', 'Degusta nuestras papas fritas condimentadas con ajo y perejil. Nuestras papas provenzal son el acompanamiento perfecto para cualquier plato. Utilizamos papas de calidad, las cortamos en finas rodajas y las freimos hasta obtener una textura dorada y crujiente. Luego, les anadimos una mezcla de ajo y perejil fresco que les otorga un sabor aromatico y delicioso. Ya sea como guarnicion o como aperitivo, nuestras papas provenzal son irresistibles y complementan a la perfeccion nuestros platos principales. ¡Ven y disfruta de nuestras papas provenzal!', 7.99),
(18, 'Tiramisu', 'Endulza tu paladar con nuestro postre italiano de capas de bizcocho, cafe y crema de mascarpone. El tiramisu es un clasico de la cocina italiana y en nuestro restaurante te ofrecemos una version excepcional. Preparamos nuestro tiramisu con ingredientes de calidad, desde el bizcocho empapado en cafe hasta la cremosa capa de mascarpone y cacao en polvo que lo corona. Cada cucharada es una explosion de sabores y texturas que te transportara a Italia. Si eres amante de los postres, no puedes dejar de probar nuestro delicioso tiramisu. ¡Te encantara!', 10.99),
(18, 'Ensalada Mixta', 'Disfruta de nuestra ensalada fresca con lechuga, tomate, cebolla y aceitunas. Nuestra ensalada mixta es una opcion saludable y sabrosa para aquellos que desean comer ligero sin renunciar al sabor. Utilizamos ingredientes frescos y de calidad, combinados con un aderezo ligero que realza los sabores naturales de los vegetales. La lechuga crujiente, los tomates jugosos, la cebolla picante y las aceitunas sabrosas se complementan a la perfeccion en esta ensalada clasica. Ya sea como acompanamiento o como plato principal, nuestra ensalada mixta te dejara satisfecho y satisfecha. ¡Ven y pruebala!', 8.99),
(18, 'Helado de Dulce de Leche', 'Prueba nuestro delicioso helado de dulce de leche artesanal. Nuestro helado de dulce de leche esta elaborado con dedicacion y cuidado, utilizando los mejores ingredientes y tecnicas tradicionales. Cada cucharada de nuestro helado te transportara a un mundo de sabores y texturas cremosas. El dulce de leche, con su rico sabor a caramelo, se combina a la perfeccion con la suavidad y frescura del helado. Si eres amante de los postres helados, no puedes dejar de probar nuestro irresistible helado de dulce de leche. ¡Te encantara!', 6.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(19, 'Carpaccio de Res', 'Deleitate con finas laminas de carne de res marinadas en aceite de oliva y acompanadas con queso parmesano. Este plato italiano es una deliciosa y elegante opcion para comenzar tu comida.', 15.99),
(19, 'Ceviche de Camaron', 'Disfruta de camarones frescos marinados en limon, cebolla y cilantro, que le dan un toque refrescante y picante a este plato peruano tradicional. Es una explosion de sabores marinos que te encantara.', 18.99),
(19, 'Lomo Saltado', 'Prueba este sabroso plato peruano que combina trozos de lomo de res salteados con cebolla y tomate, sazonados con especias y servidos con arroz y papas fritas. Es una explosion de sabores y texturas que te transportara a la cocina peruana.', 21.99),
(19, 'Causa Limena', 'Deleitate con una deliciosa masa de papa amarilla suave y cremosa, rellena de pollo o mariscos, alinada con limon y especias. Es un plato tradicional peruano que te sorprendera con su combinacion unica de sabores.', 14.99),
(19, 'Tiradito de Pescado', 'Prueba este plato peruano similar al ceviche, donde finas laminas de pescado fresco son marinadas en limon y cubiertas con una deliciosa salsa de aji amarillo. Es una explosion de sabores citricos y picantes que te encantara.', 19.99),
(19, 'Suspiro Limeno', 'Date un capricho con este clasico postre peruano que combina leche condensada y merengue, creando una textura cremosa y dulce. Es el final perfecto para una comida peruana autentica.', 11.99),
(19, 'Anticuchos', 'Disfruta de estas deliciosas brochetas de carne marinadas y asadas a la parrilla. Son un bocado sabroso y jugoso que refleja la tradicion culinaria peruana.', 12.99),
(19, 'Pisco Sour', 'Prueba el famoso coctel peruano elaborado con pisco, limon, azucar y clara de huevo, que resulta en una bebida refrescante y llena de sabor. Es el acompanante perfecto para tu experiencia culinaria peruana.', 9.99),
(19, 'Arroz con Mariscos', 'Deleitate con este sabroso arroz preparado con una variedad de mariscos frescos, como camarones, calamares y mejillones, sazonados con especias y hierbas aromaticas. Es un plato abundante y lleno de sabores marinos.', 23.99),
(19, 'Papa a la Huancaina', 'Prueba esta deliciosa preparacion peruana en la que las papas cocidas se sirven con una cremosa salsa de aji amarillo y queso fresco. Es un plato reconfortante y lleno de sabor.', 10.99);
 
 -- Direcciones adicionales para el usuario con ID 21
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(21, 'Calle del Carmen', 123, 'Diego Morales', 'Granada', 18009, 'Casa'),
(21, 'Avenida de la Libertad', 456, 'Laura Ramirez', 'Madrid', 28004, 'Trabajo'),
(21, 'Calle Goya', 789, 'Luisa Navarro', 'Madrid', 28001, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 16
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(16, 'Avenida Andalucia', 234, 'Pablo Jimenez', 'Malaga', 29007, 'Casa'),
(16, 'Calle Pintor Sorolla', 567, 'Ana Rosa', 'Valencia', 46002, 'Trabajo'),
(16, 'Avenida Gran Via de Colon', 890, 'Javier Ruiz', 'Granada', 18001, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 17
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(17, 'Calle Serrano Morales', 123, 'Maria Lopez', 'Murcia', 30001, 'Casa'),
(17, 'Avenida Ramon y Cajal', 456, 'Pedro Garcia', 'Madrid', 28016, 'Trabajo'),
(17, 'Calle Cervantes', 789, 'Sofia Herrera', 'Sevilla', 41004, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 18
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(18, 'Calle Gran Via', 123, 'Juan Perez', 'Madrid', 28013, 'Casa'),
(18, 'Avenida Diagonal', 456, 'Maria Rodriguez', 'Barcelona', 08013, 'Trabajo'),
(18, 'Calle Mayor', 789, 'Pedro Gomez', 'Valencia', 46002, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 19
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(19, 'Avenida Paseo de la Castellana', 234, 'Laura Lopez', 'Madrid', 28046, 'Casa'),
(19, 'Calle Serrano', 567, 'Carlos Martinez', 'Madrid', 28001, 'Trabajo'),
(19, 'Avenida de la Constitucion', 890, 'Ana Sanchez', 'Sevilla', 41004, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 20
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(20, 'Calle Rambla de Catalunya', 123, 'Luis Gonzalez', 'Barcelona', 08008, 'Casa'),
(20, 'Avenida Gran Capitan', 456, 'Elena Vargas', 'Cordoba', 14008, 'Trabajo'),
(20, 'Calle San Sebastian', 789, 'Miguel Torres', 'San Sebastian', 20003, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 11
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(11, 'Calle del Sol', 567, 'Maria Rodriguez', 'Barcelona', 08013, 'Casa'),
(11, 'Avenida Diagonal', 456, 'Juan Perez', 'Madrid', 28013, 'Trabajo'),
(11, 'Calle Mayor', 789, 'Pedro Gomez', 'Valencia', 46002, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 12
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(12, 'Avenida Libertador', 123, 'Laura Lopez', 'Madrid', 28046, 'Casa'),
(12, 'Calle Serrano', 567, 'Carlos Martinez', 'Madrid', 28001, 'Trabajo'),
(12, 'Avenida de la Constitucion', 890, 'Ana Sanchez', 'Sevilla', 41004, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 13
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(13, 'Calle Rambla', 123, 'Luis Gonzalez', 'Barcelona', 08008, 'Casa'),
(13, 'Avenida Gran Capitan', 456, 'Elena Vargas', 'Cordoba', 14008, 'Trabajo'),
(13, 'Calle San Sebastian', 789, 'Miguel Torres', 'San Sebastian', 20003, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 14
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(14, 'Avenida Paseo de la Castellana', 234, 'Sara Fernandez', 'Madrid', 28014, 'Casa'),
(14, 'Calle Alcala', 567, 'Javier Castro', 'Madrid', 28009, 'Trabajo'),
(14, 'Avenida Marques de Sotelo', 890, 'Isabel Mendoza', 'Valencia', 46002, 'Apartamento');

-- Direcciones adicionales para el usuario con ID 15
INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
(15, 'Calle del Carmen', 123, 'Diego Morales', 'Granada', 18009, 'Casa'),
(15, 'Avenida de la Libertad', 456, 'Laura Ramirez', 'Madrid', 28004, 'Trabajo'),
(15, 'Calle Goya', 789, 'Luisa Navarro', 'Madrid', 28001, 'Apartamento');

INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
-- Direcciones adicionales para el usuario con ID 5
(5, 'Calle Serrano', 567, 'Carlos Martinez', 'Madrid', 28001, 'Casa'),
(5, 'Avenida de la Constitucion', 890, 'Ana Sanchez', 'Sevilla', 41004, 'Trabajo'),
(5, 'Calle Rambla de Catalunya', 123, 'Luis Gonzalez', 'Barcelona', 08008, 'Apartamento'),

-- Direcciones adicionales para el usuario con ID 6
(6, 'Avenida Gran Capitan', 456, 'Elena Vargas', 'Cordoba', 14008, 'Casa'),
(6, 'Calle San Sebastian', 789, 'Miguel Torres', 'San Sebastian', 20003, 'Trabajo'),
(6, 'Avenida Paseo del Prado', 234, 'Sara Fernandez', 'Madrid', 28014, 'Apartamento'),

-- Direcciones adicionales para el usuario con ID 7
(7, 'Calle Alcala', 567, 'Javier Castro', 'Madrid', 28009, 'Casa'),
(7, 'Avenida Marques de Sotelo', 890, 'Isabel Mendoza', 'Valencia', 46002, 'Trabajo'),
(7, 'Calle del Carmen', 123, 'Diego Morales', 'Granada', 18009, 'Apartamento'),

-- Direcciones adicionales para el usuario con ID 8
(8, 'Avenida de la Libertad', 456, 'Laura Ramirez', 'Madrid', 28004, 'Casa'),
(8, 'Calle Goya', 789, 'Luisa Navarro', 'Madrid', 28001, 'Trabajo'),
(8, 'Avenida Andalucia', 234, 'Pablo Jimenez', 'Malaga', 29007, 'Apartamento'),

-- Direcciones adicionales para el usuario con ID 9
(9, 'Calle Pintor Sorolla', 567, 'Ana Rosa', 'Valencia', 46002, 'Casa'),
(9, 'Avenida Gran Via de Colon', 890, 'Javier Ruiz', 'Granada', 18001, 'Trabajo'),
(9, 'Calle Serrano Morales', 123, 'Maria Lopez', 'Murcia', 30001, 'Apartamento'),

-- Direcciones adicionales para el usuario con ID 10
(10, 'Avenida Ramon y Cajal', 456, 'Pedro Garcia', 'Madrid', 28016, 'Casa'),
(10, 'Calle Cervantes', 789, 'Sofia Herrera', 'Sevilla', 41004, 'Trabajo'),
(10, 'Calle Gran Via', 234, 'Luis Gonzalez', 'Madrid', 28013, 'Apartamento');

INSERT INTO address (user_id, address, number, name, city, cp, address_name) VALUES
-- Direcciones adicionales para el usuario con ID 1
(1, 'Calle Gran Via', 123, 'Juan Perez', 'Madrid', 28013, 'Casa'),
(1, 'Calle Mayor', 456, 'Maria Gomez', 'Madrid', 28013, 'Trabajo'),

-- Direcciones adicionales para el usuario con ID 2
(2, 'Avenida Diagonal', 789, 'Carlos Rodriguez', 'Barcelona', 08013, 'Casa'),
(2, 'Avenida Gran Via', 234, 'Laura Martinez', 'Barcelona', 08013, 'Apartamento'),
(2, 'Calle Rambla', 567, 'Pedro Lopez', 'Barcelona', 08013, 'Playa'),

-- Direcciones adicionales para el usuario con ID 3
(3, 'Calle Mayor', 789, 'Maria Gomez', 'Valencia', 46002, 'Casa'),
(3, 'Avenida del Puerto', 234, 'Sofia Torres', 'Valencia', 46002, 'Trabajo'),
(3, 'Calle de la Paz', 567, 'Javier Garcia', 'Valencia', 46002, 'Apartamento'),

-- Agrega aqui las direcciones adicionales para otros usuarios segun el mismo patron
-- (user_id, address, number, name, city, cp, address_name)

-- Por ejemplo, direcciones adicionales para el usuario con ID 4
(4, 'Avenida Paseo de la Castellana', 234, 'Laura Lopez', 'Madrid', 28046, 'Trabajo'),
(4, 'Calle Serrano', 567, 'Carlos Martinez', 'Madrid', 28001, 'Casa'),
(4, 'Avenida Gran Capitan', 890, 'Elena Vargas', 'Cordoba', 14008, 'Apartamento');

INSERT INTO payment_method (user_id, credit_cart, expiration_date, name, bank)
VALUES
(1, '1234567890123456', '01/25', 'John Doe', 'Visa'),
(1, '9876543210987654', '02/26', 'John Doe', 'Mastercard'),
(2, '2345678901234567', '03/27', 'Jane Smith', 'Visa'),
(2, '8765432109876543', '04/28', 'Jane Smith', 'American Express'),
(3, '3456789012345678', '05/29', 'Michael Johnson', 'Mastercard'),
(3, '7654321098765432', '06/30', 'Michael Johnson', 'Visa'),
(4, '4567890123456789', '07/31', 'Emily Davis', 'Discover'),
(4, '6543210987654321', '08/32', 'Emily Davis', 'Mastercard'),
(5, '5678901234567890', '09/33', 'David Johnson', 'Visa'),
(5, '5432109876543210', '10/34', 'David Johnson', 'American Express'),
(6, '6789012345678901', '11/35', 'Maria Rodriguez', 'Mastercard'),
(6, '4321098765432109', '12/36', 'Maria Rodriguez', 'Visa'),
(7, '7890123456789012', '01/37', 'Daniel Lee', 'Visa'),
(7, '3210987654321098', '02/38', 'Daniel Lee', 'Discover'),
(8, '8901234567890123', '03/39', 'Sarah Wilson', 'Mastercard'),
(8, '2109876543210987', '04/40', 'Sarah Wilson', 'American Express'),
(9, '9012345678901234', '05/41', 'Laura Martinez', 'Visa'),
(9, '1098765432109876', '06/42', 'Laura Martinez', 'Mastercard'),
(10, '0123456789012345', '07/43', 'Robert Brown', 'American Express'),
(10, '9876543210987654', '08/44', 'Robert Brown', 'Discover'),
(11, '1234509876543210', '09/45', 'Jennifer Clark', 'Visa'),
(11, '4321098765432109', '10/46', 'Jennifer Clark', 'Mastercard'),
(12, '2345678901234567', '11/47', 'Matthew Wright', 'Discover'),
(12, '2109876543210987', '12/48', 'Matthew Wright', 'Visa'),
(13, '3456789012345678', '01/49', 'Emily Hill', 'Mastercard'),
(13, '7654321098765432', '02/50', 'Emily Hill', 'American Express'),
(14, '4567890123456789', '03/51', 'Olivia Walker', 'Visa'),
(14, '6543210987654321', '04/52', 'Olivia Walker', 'Discover'),
(15, '5678901234567890', '05/53', 'Jacob Green', 'Mastercard'),
(15, '5432109876543210', '06/54', 'Jacob Green', 'Visa'),
(16, '6789012345678901', '07/55', 'Sophia Lewis', 'American Express'),
(16, '4321098765432109', '08/56', 'Sophia Lewis', 'Discover'),
(17, '7890123456789012', '09/57', 'Daniel Wright', 'Visa'),
(17, '3210987654321098', '10/58', 'Daniel Wright', 'Mastercard'),
(18, '8901234567890123', '11/59', 'Ava Perez', 'Discover'),
(18, '2109876543210987', '12/60', 'Ava Perez', 'Visa'),
(19, '9012345678901234', '01/61', 'James Rodriguez', 'Mastercard'),
(19, '1098765432109876', '02/62', 'James Rodriguez', 'American Express'),
(20, '0123456789012345', '03/63', 'Emma Turner', 'Visa'),
(21, '9876543210987654', '04/64', 'Emma Turner', 'Discover'),
(21, '1234509876543210', '05/65', 'Liam Hill', 'Mastercard');



-- Inserts para el restaurante con id 1
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (1, 1, '¡Excelente comida y servicio! Definitivamente volvere.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (2, 1, 'Me encanto la variedad de platos disponibles. Recomiendo las hamburguesas.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (3, 1, 'El ambiente del restaurante es muy acogedor. Ideal para una cena romantica.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (4, 1, 'Pedi a domicilio y la entrega fue rapida. La comida llego caliente y bien empacada.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (5, 1, 'El personal fue amable y atento durante toda la visita.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 2
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (6, 2, 'Muy buen lugar para disfrutar de la comida italiana. Las pastas son deliciosas.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (7, 2, 'Recomiendo probar la pizza de la casa. La masa es esponjosa y los ingredientes frescos.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (8, 2, 'La atencion al cliente es excepcional. Los meseros son muy amables y serviciales.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (9, 2, 'El restaurante tiene un ambiente familiar y acogedor. Ideal para ir con ninos.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);


-- Inserts para el restaurante con id 3
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (10, 3, 'Probe varios platos y todos estaban deliciosos. La presentacion es impecable.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (11, 3, 'El servicio fue rapido y eficiente. Los camareros estuvieron pendientes en todo momento.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (12, 3, 'Recomiendo reservar con anticipacion, especialmente los fines de semana.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (13, 3, 'El menu ofrece opciones vegetarianas y veganas. Muy buena alternativa para personas con dietas especiales.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 4
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (14, 4, 'El lugar tiene una hermosa vista al mar. Ideal para disfrutar de una cena romantica.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (15, 4, 'La calidad de los mariscos es excelente. Recomiendo probar el ceviche.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (16, 4, 'El personal es amable y conocedor de los platos. Pueden brindar recomendaciones segun tus preferencias.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (17, 4, 'Los postres son una delicia. No te vayas sin probar el pastel de chocolate.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 5
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (18, 5, 'Pedi comida a domicilio y llego en el tiempo estimado. Los platos estaban bien empacados.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (19, 5, 'La relacion calidad-precio es muy buena. Los precios son accesibles y la comida es sabrosa.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (20, 5, 'El ambiente del restaurante es animado y acogedor. Perfecto para ir con amigos.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (21, 5, 'El menu ofrece una gran variedad de opciones. Siempre encuentro algo que me gusta.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

 -- Inserts para el restaurante con id 6
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (1, 6, 'El lugar tiene una decoracion moderna y elegante. La atencion del personal fue excepcional.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (2, 6, 'Probe el menu degustacion y quede impresionado con cada plato. Una experiencia gastronomica unica.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (3, 6, 'El chef tiene un talento extraordinario. Cada plato es una obra de arte.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (4, 6, 'El precio es un poco elevado, pero vale la pena por la calidad de la comida y el servicio.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 7
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (5, 7, 'El ambiente del restaurante es acogedor y relajante. Perfecto para disfrutar de una cena tranquila.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (6, 7, 'El menu ofrece opciones para todos los gustos. Incluso tienen platos sin gluten para personas con intolerancias.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (7, 7, 'El personal es amigable y servicial. Estan dispuestos a adaptar los platos segun tus preferencias.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (8, 7, 'El postre de la casa es simplemente delicioso. No te lo puedes perder.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 8
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (9, 8, 'Pedi comida para llevar y llego caliente y bien empacada. Los sabores son autenticos.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (10, 8, 'El servicio de entrega fue rapido y puntual. No tuve que esperar mucho tiempo.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (11, 8, 'El menu incluye opciones vegetarianas y veganas. Es genial tener variedad para elegir.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (12, 8, 'Recomiendo probar los cocteles. Son deliciosos y estan cuidadosamente preparados.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 9
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (13, 9, 'El lugar tiene una vista panoramica impresionante. Es ideal para ocasiones especiales.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (14, 9, 'Los platos son creativos y sorprendentes. El chef se esmera en ofrecer una experiencia culinaria unica.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (15, 9, 'La atencion al detalle en cada plato es admirable. La presentacion es impecable.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY),
  (16, 9, 'El personal es atento y amable. Te hacen sentir bienvenido desde que llegas.', NOW() - INTERVAL FLOOR(RAND() * 90) DAY);

-- Inserts para el restaurante con id 10
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (1, 10, 'Excelente comida y servicio', NOW() - INTERVAL 3 DAY),
  (2, 10, 'Buena relacion calidad-precio', NOW() - INTERVAL 2 DAY),
  (3, 10, 'Ambiente agradable, recomendado', NOW() - INTERVAL 1 DAY),
  (4, 10, 'Comida deliciosa, definitivamente regresare', NOW() - INTERVAL 4 DAY),
  (5, 10, 'Buenas opciones vegetarianas', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 11
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (6, 11, 'El mejor lugar para comer pizza', NOW() - INTERVAL 2 DAY),
  (7, 11, 'Servicio rapido y amable', NOW() - INTERVAL 1 DAY),
  (8, 11, 'Pizza recien horneada y deliciosa', NOW() - INTERVAL 3 DAY),
  (9, 11, 'Gran variedad de sabores', NOW() - INTERVAL 4 DAY),
  (10, 11, 'Recomiendo probar la pizza de pepperoni', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 12
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (11, 12, 'Comida casera y autentica', NOW() - INTERVAL 1 DAY),
  (12, 12, 'Platos abundantes y sabrosos', NOW() - INTERVAL 2 DAY),
  (13, 12, 'Personal amable y atento', NOW() - INTERVAL 3 DAY),
  (14, 12, 'Excelente opcion para una cena romantica', NOW() - INTERVAL 4 DAY),
  (15, 12, 'Recomiendo probar el postre de tiramisu', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 13
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (16, 13, 'Gran seleccion de vinos', NOW() - INTERVAL 3 DAY),
  (17, 13, 'Platos exquisitos y bien presentados', NOW() - INTERVAL 1 DAY),
  (18, 13, 'Ambiente elegante y sofisticado', NOW() - INTERVAL 2 DAY),
  (19, 13, 'Excelente atencion al cliente', NOW() - INTERVAL 4 DAY),
  (20, 13, 'Ideal para ocasiones especiales', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 14
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (21, 14, 'Comida mexicana autentica', NOW() - INTERVAL 4 DAY),
  (1, 14, 'Los tacos al pastor son deliciosos', NOW() - INTERVAL 2 DAY),
  (2, 14, 'Buena relacion calidad-precio', NOW() - INTERVAL 1 DAY),
  (3, 14, 'Ambiente festivo y alegre', NOW() - INTERVAL 3 DAY),
  (4, 14, 'Recomiendo probar las quesadillas', NOW() - INTERVAL 5 DAY);

 
 -- Inserts para el restaurante con id 15
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (5, 15, 'Comida deliciosa y bien presentada', NOW() - INTERVAL 3 DAY),
  (6, 15, 'Atencion amable y rapida', NOW() - INTERVAL 1 DAY),
  (7, 15, 'Ambiente acogedor y relajado', NOW() - INTERVAL 2 DAY),
  (8, 15, 'Recomiendo probar la pasta carbonara', NOW() - INTERVAL 4 DAY),
  (9, 15, 'Postres caseros irresistibles', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 16
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (10, 16, 'Mariscos frescos y sabrosos', NOW() - INTERVAL 2 DAY),
  (11, 16, 'Excelente vista al mar', NOW() - INTERVAL 1 DAY),
  (12, 16, 'Servicio impecable', NOW() - INTERVAL 3 DAY),
  (13, 16, 'Ideal para disfrutar de una puesta de sol', NOW() - INTERVAL 4 DAY),
  (14, 16, 'Amplia variedad de platos de mariscos', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 17
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (15, 17, 'Sabores asiaticos autenticos', NOW() - INTERVAL 1 DAY),
  (16, 17, 'Platos picantes y deliciosos', NOW() - INTERVAL 2 DAY),
  (17, 17, 'Ambiente moderno y elegante', NOW() - INTERVAL 3 DAY),
  (18, 17, 'Recomiendo probar el sushi', NOW() - INTERVAL 4 DAY),
  (19, 17, 'Buenas opciones vegetarianas', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 18
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (20, 18, 'Carnes a la parrilla jugosas y tiernas', NOW() - INTERVAL 3 DAY),
  (21, 18, 'Gran variedad de cortes de carne', NOW() - INTERVAL 1 DAY),
  (1, 18, 'Excelente atencion al cliente', NOW() - INTERVAL 2 DAY),
  (2, 18, 'Ambiente rustico y acogedor', NOW() - INTERVAL 4 DAY),
  (3, 18, 'Ideal para los amantes de la carne', NOW() - INTERVAL 5 DAY);

-- Inserts para el restaurante con id 19
INSERT INTO review (user_id, restaurant_id, content, created_at)
VALUES
  (4, 19, 'Comida casera y reconfortante', NOW() - INTERVAL 2 DAY),
  (5, 19, 'Platos tradicionales y autenticos', NOW() - INTERVAL 1 DAY),
  (6, 19, 'Portiones generosas', NOW() - INTERVAL 3 DAY),
  (7, 19, 'Recomiendo probar las empanadas', NOW() - INTERVAL 4 DAY),
  (8, 19, 'Ambiente familiar y calido', NOW() - INTERVAL 5 DAY);
