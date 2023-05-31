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
  description VARCHAR(1000),
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

INSERT INTO product (restaurant_id, name, description, price) VALUES
(1, 'Pizza Margherita', 'La Pizza Margherita es un clasico de la cocina italiana que combina ingredientes frescos y sabores autenticos. Esta deliciosa pizza cuenta con una base de salsa de tomate casera, suave mozzarella fresca y hojas de albahaca recien cortadas. El resultado es una explosión de sabores en cada bocado.', 10.99),
(1, 'Pasta Carbonara', 'Nuestra Pasta Carbonara es un plato que te transportara directamente a las trattorias de Roma. Preparada con pasta al dente y una irresistible salsa de huevo, panceta crujiente y queso parmesano rallado, cada bocado es una experiencia de sabor autentico. El equilibrio perfecto entre cremosidad y salinidad hace de esta receta un clasico de la cocina italiana.', 12.99),
(1, 'Risotto ai Funghi', 'Nuestro Risotto ai Funghi es un plato elegante y reconfortante que combina la cremosidad del arroz Arborio con la exquisitez de los champiñones frescos, la cebolla caramelizada y el queso parmesano rallado. Cada cucharada es una explosión de sabores terrosos y una textura suave que deleitara tus sentidos.', 14.99),
(1, 'Lasagna Bolognese', 'Nuestra Lasagna Bolognese es una deliciosa combinación de capas de pasta fresca, carne de res jugosa y salsa boloñesa casera. Cada porción esta cuidadosamente preparada con ingredientes de alta calidad y horneada hasta obtener una capa superior dorada y gratinada.', 16.99),
(1, 'Pollo alla Cacciatora', 'El Pollo alla Cacciatora es un plato tradicional italiano que combina tierna carne de pollo guisada con tomate, cebolla, aceitunas y especias aromaticas. Cada bocado te transportara a la campiña italiana con sus sabores ricos y reconfortantes.', 15.99),
(1, 'Bruschetta Caprese', 'Nuestras Bruschettas Caprese son tostadas de pan crujiente cubiertas con tomate fresco, mozzarella de bufala, hojas de albahaca y un chorrito de aceite de oliva virgen extra. Estas deliciosas y coloridas tostadas son perfectas como aperitivo o entrante.', 8.99),
(1, 'Tiramisu', 'El Tiramisu es un clasico postre italiano hecho con capas de bizcocho bañado en cafe, crema de mascarpone y espolvoreado con cacao en polvo. Cada cucharada de este postre es una mezcla de texturas suaves y sabores delicados.', 9.99),
(1, 'Cannoli Siciliani', 'Los Cannoli Siciliani son postres tradicionales de Sicilia hechos con una masa crujiente y rellenos de crema de ricota dulce y chispas de chocolate. Estos deliciosos dulces son un verdadero placer para los amantes de la reposteria italiana.', 7.99),
(1, 'Gelato al Cioccolato', 'El Gelato al Cioccolato es un helado italiano cremoso y rico, elaborado con chocolate oscuro de alta calidad. Disfruta de este clasico sabor italiano que te refrescara en los dias calurosos o te deleitara en cualquier momento.', 6.99),
(1, 'Panna Cotta', 'La Panna Cotta es un postre italiano suave y sedoso hecho a base de crema cocida, azucar y gelatina de vainilla. Esta delicada y deliciosa creación es el final perfecto para una comida italiana inolvidable.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(2, 'Croque Monsieur', 'Un delicioso y clasico sandwich frances relleno de jamón y queso gruyère, tostado hasta obtener una textura crujiente por fuera y un interior suave y derretido.', 14.99),
(2, 'Escargots de Bourgogne', 'Una exquisita especialidad francesa que consiste en caracoles de Borgoña cocinados con mantequilla y ajo, presentados en su propia concha. Cada bocado ofrece una combinación de sabores delicados y aromaticos.', 18.99),
(2, 'Boeuf Bourguignon', 'Un reconfortante estofado frances preparado con trozos tiernos de ternera cocinados a fuego lento en vino tinto y acompañados de verduras frescas, creando un plato lleno de sabores profundos y suculentos.', 22.99),
(2, 'Salade Nicoise', 'Una ensalada clasica de la cocina francesa que combina ingredientes frescos y vibrantes. Esta compuesta por atun, huevos, tomates, aceitunas y judias verdes, todo ello aliñado con una vinagreta de hierbas aromaticas.', 12.99),
(2, 'Soupe à l\'Oignon', 'Una reconfortante sopa francesa de cebolla que se sirve gratinada con queso y croutons. Cada cucharada es una explosión de sabores, con la dulzura de las cebollas caramelizadas y la riqueza del caldo.', 10.99),
(2, 'Coq au Vin', 'Un plato tradicional de la cocina francesa que consiste en pollo guisado en vino tinto junto con champiñones y cebolla. El resultado es una carne tierna y jugosa impregnada de los sabores ricos y complejos de los ingredientes.', 20.99),
(2, 'Crème Brûlee', 'Un postre icónico de la gastronomia francesa que consta de una delicada crema pastelera con una capa superior de caramelo crujiente. Cada cucharada ofrece una combinación de texturas suaves y crujientes, junto con un sabor dulce y fragante.', 8.99),
(2, 'Tarte Tatin', 'Una tentadora tarta francesa que destaca por sus manzanas caramelizadas y su base de masa crujiente. Se sirve tibia y se puede disfrutar tal cual o acompañada de una bola de helado de vainilla para un contraste perfecto.', 10.99),
(2, 'Ratatouille', 'Un plato provenzal lleno de colores y sabores. Se compone de una mezcla de verduras asadas, como berenjena, calabacin y tomate, que se combinan en perfecta armonia. Es una opción saludable y deliciosa para los amantes de las verduras.', 16.99),
(2, 'Macarons', 'Estos exquisitos dulces franceses hechos a base de almendra son famosos por su apariencia colorida y su sabor delicado. Cada macaron ofrece una combinación de sabores unicos, desde frutas hasta chocolates, que se derriten en el paladar.', 7.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(3, 'Tacos al Pastor', 'Estos irresistibles tacos mexicanos presentan tiernas y jugosas rebanadas de cerdo marinado con una mezcla de especias tradicionales y un toque de piña, que le aporta un sabor agridulce unico.', 12.99),
(3, 'Enchiladas Verdes', 'Un plato clasico de la gastronomia mexicana que consiste en tortillas de maiz rellenas de pollo tierno y bañadas en una vibrante salsa verde hecha a base de tomatillos, chiles y especias. Cada bocado es una explosión de sabores autenticos.', 10.99),
(3, 'Chiles Rellenos', 'Estos chiles poblanos son rellenos generosamente con queso y luego bañados en una salsa de tomate casera llena de sabores ahumados y especiados. Es un plato picante y reconfortante que cautivara tu paladar.', 14.99),
(3, 'Mole Poblano', 'Un plato icónico de Mexico que presenta pollo tierno cocinado en una salsa de mole poblano. Esta salsa rica y compleja combina ingredientes como chiles, chocolate, especias y frutos secos para crear un sabor unico y sorprendente.', 16.99),
(3, 'Guacamole', 'Una deliciosa salsa mexicana hecha con aguacate fresco, tomate, cebolla y cilantro. Su textura cremosa y su sabor fresco y vibrante lo convierten en el acompañamiento perfecto para tus tacos y nachos favoritos.', 8.99),
(3, 'Tostadas de Ceviche', 'Estas tostadas de maiz crujientes estan coronadas con ceviche fresco de pescado y mariscos, marinados en limón y mezclado con ingredientes como cebolla, tomate y cilantro. Son una explosión de sabores y texturas.', 9.99),
(3, 'Quesadillas', 'Estas quesadillas mexicanas son tortillas de maiz rellenas de queso fundido, que se derrite hasta obtener una textura suave y cremosa. Se sirven con guacamole fresco para complementar su sabor y brindarte una experiencia deliciosa.', 7.99),
(3, 'Flan Napolitano', 'Un postre tradicional mexicano que consiste en un flan suave y sedoso, cubierto con un caramelo dorado y dulce. Cada cucharada te brinda una combinación irresistible de texturas y sabores que te dejaran deseando mas.', 6.99),
(3, 'Churros', 'Estos dulces fritos en forma de bastones son una delicia mexicana clasica. Estan cubiertos con una generosa capa de azucar y canela, y se sirven calientes para que puedas disfrutar de su exterior crujiente y su interior suave y esponjoso.', 5.99),
(3, 'Horchata', 'Una refrescante bebida mexicana hecha a base de arroz, canela y azucar. Su sabor dulce y ligeramente especiado la convierte en la compañia perfecta para tus comidas mexicanas, refrescandote y satisfaciendo tu paladar.', 4.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(4, 'Sashimi Variado', 'Disfruta de una exquisita selección de pescados crudos expertamente cortados en finas laminas. Cada bocado te transportara a la frescura del mar y te permitira apreciar la calidad y sabor de cada variedad.', 18.99),
(4, 'Roll de Salmon y Aguacate', 'Este delicioso maki roll combina la suavidad del salmón fresco con la cremosidad del aguacate. Envolto en una capa de arroz y alga nori, es un verdadero placer para los amantes de los sabores sutiles y equilibrados.', 12.99),
(4, 'Nigiri de Atun', 'Pequeñas bolitas de arroz perfectamente moldeadas y coronadas con laminas de atun fresco. Cada nigiri es una explosión de frescura y textura, resaltando la calidad y sabor del atun en cada bocado.', 10.99),
(4, 'Uramaki Tempura', 'Un roll invertido que combina la crujiente textura del langostino tempura con la suavidad del aguacate. Cada bocado te sorprendera con una mezcla de sabores y una textura contrastante que lo convierte en una opción irresistible.', 14.99),
(4, 'Gyoza', 'Estas empanadillas japonesas estan rellenas de una deliciosa mezcla de carne y verduras, y se cocinan al vapor y luego se doran en la sarten para obtener una textura crujiente por fuera y jugosa por dentro. Son el aperitivo perfecto para deleitar tu paladar.', 8.99),
(4, 'Yakitori', 'Sabrosas brochetas de pollo a la parrilla bañadas en una irresistible salsa teriyaki. Cada bocado te brinda el equilibrio perfecto entre el pollo jugoso y el sabor dulce y salado de la salsa, una combinación clasica de la cocina japonesa.', 9.99),
(4, 'Miso Soup', 'Una sopa japonesa reconfortante hecha a base de pasta de soja y caldo dashi. Su sabor umami y su textura suave te envolveran en una experiencia gustativa unica, ideal para comenzar tu comida japonesa.', 5.99),
(4, 'Tempura de Vegetales', 'Disfruta de una deliciosa variedad de vegetales frescos cubiertos con una masa ligera y crujiente. Cada bocado revela una textura increiblemente crujiente y un sabor naturalmente dulce de los vegetales. Es el acompañamiento perfecto o un plato por si solo.', 7.99),
(4, 'Tataki de Atun', 'Laminas de atun fresco ligeramente selladas y cubiertas con semillas de sesamo, aportando un toque de sabor y textura. Servido con salsa de soja, este plato resalta la calidad del atun y ofrece un contraste delicioso entre el exterior ligeramente crujiente y el centro suculento del pescado.', 16.99),
(4, 'Dorayaki', 'Estos panqueques japoneses rellenos de pasta de frijol azuki son una verdadera delicia. Con su textura esponjosa y su relleno dulce y suave, te brindaran un sabor autentico y reconfortante que te transportara a la tradicional reposteria japonesa.', 6.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(5, 'Bife de Chorizo', 'Disfruta de un jugoso corte de carne de res a la parrilla, cocinado a la perfección para resaltar su sabor y textura. Cada bocado te deleitara con su jugosidad y la intensidad de su sabor.', 22.99),
(5, 'Asado de Tira', 'Deleitate con unas costillas de res asadas a la parrilla, tiernas y sabrosas, acompañadas de una irresistible salsa chimichurri. Cada mordisco te transportara a la tradición de los asados argentinos.', 25.99),
(5, 'Empanadas Argentinas', 'Saborea autenticas empanadas argentinas, rellenas de jugosa carne, pollo o verduras, envueltas en una masa crujiente y horneadas hasta alcanzar la perfección. Cada bocado te sorprendera con su combinación de sabores y texturas.', 9.99),
(5, 'Matambre a la Pizza', 'Disfruta de un delicioso roll de carne relleno con los clasicos ingredientes de una pizza. El matambre, tierno y sabroso, envuelve el queso, tomate y oregano, creando una combinación irresistible de sabores.', 18.99),
(5, 'Provoleta', 'Degusta el autentico queso provolone a la parrilla, gratinado con tomate y oregano. Cada porción te brindara la combinación perfecta de queso derretido, tomate jugoso y aromatico oregano, creando una experiencia inigualable.', 14.99),
(5, 'Milanesa Napolitana', 'Prueba una deliciosa milanesa de carne empanizada, cubierta con salsa de tomate y queso gratinado. Cada bocado te brindara la combinación de sabores y texturas crujientes de la milanesa con la suavidad del queso derretido y la acidez de la salsa de tomate.', 16.99),
(5, 'Choripan', 'Disfruta del clasico sabor argentino con un choripan, un delicioso sandwich relleno de chorizo a la parrilla. El sabor ahumado del chorizo se combina con la frescura del pan y los condimentos, creando una explosión de sabores en cada bocado.', 10.99),
(5, 'Alfajores', 'Endulza tu paladar con los clasicos alfajores argentinos, rellenos de dulce de leche y cubiertos de chocolate. Cada mordisco te brindara la combinación perfecta de suave textura, dulce sabor a caramelo y el toque de chocolate que los hace irresistibles.', 7.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(6, 'Escargots de Bourgogne', 'Sumergete en la exquisitez de los caracoles cocinados en mantequilla y ajo, una deliciosa y tradicional preparación francesa. Cada bocado te transportara a los sabores autenticos de la región de Borgoña.', 19.99),
(6, 'Coq au Vin', 'Disfruta de un plato clasico de la gastronomia francesa: pollo guisado en vino tinto con champiñones y cebollas. Cada porción te sorprendera con su tierna carne de pollo impregnada de los sabores ricos y robustos del vino.', 21.99),
(6, 'Bouillabaisse', 'Dejate seducir por los sabores mediterraneos de la bouillabaisse, una exquisita sopa de pescado y mariscos. Disfruta de la frescura del mar en cada cucharada, con una combinación de sabores y aromas que te transportaran a la costa de Francia.', 24.99),
(6, 'Tarte Tatin', 'Prueba la tentación de una tarta de manzana caramelizada invertida. Cada porción te brindara la combinación perfecta de manzanas suavemente caramelizadas y una base de masa crujiente, creando un contraste de sabores y texturas inigualable.', 12.99),
(6, 'Quiche Lorraine', 'Deleitate con una exquisita tarta salada conocida como Quiche Lorraine. Esta delicia francesa combina tocino ahumado, queso y una suave crema en una base de masa dorada, creando una combinación de sabores salados y cremosos.', 15.99),
(6, 'Creme Brulee', 'Satisface tu paladar con un postre clasico: el creme brulee. Disfruta de la suave crema quemada en la parte superior, contrastando con la dulzura y la delicadeza de la crema en su interior. Cada cucharada es una experiencia de sabor unica.', 10.99),
(6, 'Ratatouille', 'Descubre el encanto de un plato provenzal de verduras asadas como berenjena, calabacin y tomate. Cada bocado te sumergira en la frescura y la riqueza de los sabores mediterraneos, creando una experiencia culinaria llena de colores y texturas.', 16.99),
(6, 'Profiteroles', 'Deleitate con las bolitas de masa rellenas de crema y bañadas en chocolate que conforman los profiteroles. Cada bocado te brindara la combinación perfecta de suave y esponjosa masa, cremosa crema y el rico sabor del chocolate.', 9.99),
(6, 'Salade Nicoise', 'Disfruta de una refrescante ensalada que combina atun, tomate, huevo, aceitunas y judias verdes. Cada bocado te deleitara con la frescura de los ingredientes y la combinación de sabores mediterraneos.', 14.99),
(6, 'Crepes Suzette', 'Dejate seducir por las crepes flameadas con salsa de naranja y Grand Marnier. Cada bocado te brindara la combinación de suaves y delicadas crepes, la dulzura citrica de la salsa de naranja y el toque especial del licor Grand Marnier.', 17.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(7, 'Paella de Mariscos', 'Sumergete en los sabores del mar con nuestra exquisita paella de mariscos. Este plato tradicional combina arroz con langostinos, mejillones, calamares y otros deliciosos mariscos, todo cocinado a la perfección en un sabroso caldo.', 25.99),
(7, 'Ceviche Mixto', 'Disfruta de la frescura del mar con nuestro ceviche mixto. Pescado y mariscos maravillosamente marinados en limón con un toque de aji y cebolla, creando un plato refrescante y lleno de sabor.', 18.99),
(7, 'Pulpo a la Gallega', 'Dejate tentar por nuestro delicioso pulpo a la gallega. Tierno pulpo cocido a la perfección, acompañado de aceite de oliva, pimentón y patatas, creando una combinación de sabores tradicionales y reconfortantes.', 21.99),
(7, 'Gambas al Ajillo', 'Saborea nuestras gambas al ajillo, un clasico plato español. Gambas frescas salteadas en aceite de oliva con ajo y guindilla, creando una explosión de sabores y un toque picante que no podras resistir.', 16.99),
(7, 'Calamares a la Romana', 'Disfruta de nuestras crujientes y deliciosas anillas de calamar rebozadas y fritas. Cada bocado te brindara una combinación de texturas y un sabor marino unico que te transportara a las costas mediterraneas.', 12.99),
(7, 'Sopa de Pescado', 'Sumergete en la calidez de nuestra reconfortante sopa de pescado. Trozos de pescado y mariscos se combinan en un caldo lleno de sabor, creando una experiencia culinaria que te reconfortara en cada cucharada.', 10.99),
(7, 'Pargo a la Veracruzana', 'Prueba nuestro pargo a la veracruzana, un plato lleno de sabores vibrantes. Pargo asado con una deliciosa salsa de tomate, aceitunas y alcaparras, que le brindan un toque mediterraneo y una explosión de sabores.', 22.99),
(7, 'Flan de Coco', 'Deleita tu paladar con nuestro exquisito flan de coco. Cada cucharada te transportara a un paraiso tropical con su suave textura y su sabor dulce a coco, todo coronado con un rico caramelo.', 8.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(8, 'Pizza Margherita', 'Sumergete en la clasica pizza Margherita, con salsa de tomate, mozzarella y albahaca fresca. Cada bocado es una explosión de sabores italianos autenticos y la combinación perfecta de ingredientes simples pero deliciosos.', 14.99),
(8, 'Pizza Pepperoni', 'Prueba nuestra deliciosa pizza Pepperoni, con salsa de tomate, generosas capas de mozzarella y rodajas de pepperoni picante. Cada mordisco te brinda el equilibrio perfecto entre el queso fundido y el sabor ahumado de los pepperoni.', 16.99),
(8, 'Pizza Hawaiana', 'Disfruta de nuestra polemica pero irresistible pizza Hawaiana, con salsa de tomate, mozzarella, jugoso jamón y trozos de piña. La combinación de sabores salados y dulces te transportara a la costa tropical.', 15.99),
(8, 'Pizza Capricciosa', 'Explora los sabores autenticos de Italia con nuestra pizza Capricciosa. Cubierta con salsa de tomate, mozzarella, jamón, champiñones y aceitunas, cada porción es un festin de ingredientes frescos y sabores equilibrados.', 17.99),
(8, 'Pizza Prosciutto e Funghi', 'Prueba nuestra deliciosa pizza Prosciutto e Funghi, con salsa de tomate, mozzarella, lonchas de jamón y champiñones frescos. Cada bocado te transportara a la autentica experiencia de la cocina italiana.', 16.99),
(8, 'Calzone', 'Disfruta de un giro emocionante con nuestro calzone, una pizza en forma de empanada rellena de mozzarella, jamón y champiñones. Cada mordisco es una explosión de sabores en un paquete deliciosamente crujiente.', 18.99),
(8, 'Lasagna', 'Sumergete en las capas de sabor con nuestra lasagna casera. Pasta horneada en capas con carne, queso y salsa de tomate, creando un plato reconfortante que deleitara a tus papilas gustativas.', 19.99),
(8, 'Ravioli di Spinaci e Ricotta', 'Descubre la perfección de nuestros raviolis caseros rellenos de espinacas y ricotta, acompañados de una deliciosa salsa de tomate. Cada bocado es una combinación de suavidad, frescura y sabores italianos autenticos.', 17.99),
(8, 'Tiramisu', 'Termina tu comida con nuestro clasico tiramisu italiano. Capas de bizcocho empapado en cafe y crema de mascarpone, creando una mezcla irresistible de texturas y sabores que te transportaran a la dulzura de Italia.', 9.99),
(8, 'Gelato', 'No puedes perderte nuestro helado italiano artesanal en una variedad de sabores exquisitos. Desde los clasicos como vainilla y chocolate hasta opciones mas audaces como pistacho y fresa, cada cucharada es una experiencia refrescante y deliciosa.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(9, 'Salmón Teriyaki', 'Disfruta de nuestro exquisito salmón a la parrilla con salsa teriyaki y verduras frescas. Cada bocado es una combinación de sabores delicados y jugosos que te transportaran a la cocina asiatica.', 23.99),
(9, 'Filete Mignon', 'Degusta nuestro filete mignon, un corte de ternera de primera calidad a la parrilla acompañado de una guarnición de tu elección. Cada porción es tierna, jugosa y llena de sabor.', 27.99),
(9, 'Risotto de Champiñones', 'Sumergete en la cremosidad de nuestro risotto de champiñones, elaborado con arroz al dente, champiñones frescos y queso parmesano. Cada cucharada es una explosión de sabores y texturas.', 18.99),
(9, 'Ensalada Caprese', 'Refresca tu paladar con nuestra ensalada Caprese, compuesta por tomates jugosos, mozzarella fresca y hojas de albahaca, todo aderezado con un toque de vinagre balsamico. Una combinación simple pero deliciosa.', 14.99),
(9, 'Carpaccio de Res', 'Deleitate con nuestro carpaccio de res, finas laminas de carne de res marinadas en aceite de oliva y limón, acompañadas de ingredientes frescos y sabrosos. Una opción ligera pero llena de sabor.', 16.99),
(9, 'Cordero al Horno', 'Saborea nuestra pierna de cordero asada al horno con hierbas y especias, que se derrite en tu boca con cada bocado. Una opción de lujo para los amantes de la carne.', 25.99),
(9, 'Tarta de Chocolate', 'Termina tu experiencia gastronómica con nuestra deliciosa tarta de chocolate, cubierta con ganache de chocolate y decorada con frutas frescas. Cada porción es un placer para los amantes del chocolate.', 11.99),
(9, 'Crema de Calabaza', 'Disfruta de una crema suave y reconfortante de calabaza, con crujientes de panceta que añaden un contraste de texturas. Perfecta para calentar el alma en cualquier epoca del año.', 10.99),
(9, 'Gazpacho Andaluz', 'Refresca tu paladar con nuestro gazpacho andaluz, una sopa fria a base de tomate, pepino, pimiento y ajo. Cada cucharada te transportara a los sabores mediterraneos de España.', 9.99),
(9, 'Mousse de Mango', 'Finaliza tu comida con nuestro mousse de mango, un postre ligero y refrescante que combina la suavidad del mango con una textura aireada. Cada cucharada es una explosión de sabor tropical.', 8.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(10, 'Fabada Asturiana', 'Disfruta de nuestro delicioso guiso de alubias blancas con chorizo y panceta, un plato tradicional de la región de Asturias en España. Cada cucharada es una explosión de sabores reconfortantes.', 16.99),
(10, 'Chuletón de Ternera', 'Prueba nuestro generoso chuletón de ternera a la parrilla, jugoso y lleno de sabor. Cada bocado es una experiencia carnivora que satisfara tu apetito.', 29.99),
(10, 'Pulpo a Feira', 'Disfruta de nuestro pulpo a feira, una receta clasica de pulpo cocido con aceite de oliva, pimentón y patatas. Cada tentaculo es tierno y se deshace en tu boca.', 21.99),
(10, 'Croquetas de Jamón', 'Prueba nuestras cremosas croquetas rellenas de jamón iberico, crujientes por fuera y suaves por dentro. Cada bocado es una explosión de sabor y textura.', 12.99),
(10, 'Tortilla Española', 'Saborea nuestra clasica tortilla española, elaborada con patatas, cebolla y huevo. Cada porción es un deleite para los amantes de los platos tradicionales españoles.', 13.99),
(10, 'Gambas al Ajillo', 'Degusta nuestras gambas salteadas en aceite de oliva con ajo y guindilla, un clasico de la cocina española. Cada langostino esta impregnado de sabores intensos y picantes.', 16.99),
(10, 'Patatas Bravas', 'Disfruta de nuestras patatas fritas acompañadas de salsa brava picante y alioli, una combinación irresistible. Cada bocado es crujiente por fuera y tierno por dentro.', 9.99),
(10, 'Flan Casero', 'Prueba nuestro delicioso flan casero con caramelo liquido, un postre clasico que terminara tu comida con dulzura. Cada cucharada es suave, cremosa y llena de sabor.', 7.99),
(10, 'Queso Manchego', 'Degusta nuestro queso manchego curado de oveja, un queso español de alta calidad con un sabor y textura unicos. Cada porción es una muestra del rico patrimonio quesero de España.', 10.99),
(10, 'Tarta de Santiago', 'Disfruta de nuestra tradicional tarta de Santiago, una deliciosa tarta de almendras tipica de la ciudad de Santiago de Compostela. Cada porción es un homenaje a la reposteria gallega.', 11.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(11, 'Filete de Res en Salsa de Vino Tinto', 'Disfruta de nuestro tierno filete de res bañado en una deliciosa salsa de vino tinto. Cada bocado es una explosión de sabores intensos y jugosos.', 26.99),
(11, 'Pechuga de Pollo Rellena', 'Degusta nuestra pechuga de pollo rellena de espinacas y queso, acompañada de pure de papas. Cada porción es una combinación de sabores suaves y texturas reconfortantes.', 22.99),
(11, 'Risotto de Mariscos', 'Saborea nuestro arroz cremoso con una selección de mariscos frescos. Cada cucharada es una mezcla de sabores del mar que te transportara a las costas mediterraneas.', 24.99),
(11, 'Ensalada Cesar', 'Prueba nuestra ensalada clasica con pollo a la parrilla, croutones y aderezo Cesar. Cada bocado es una explosión de frescura y sabores equilibrados.', 16.99),
(11, 'Ceviche Mixto', 'Disfruta de nuestra mezcla de pescado y mariscos marinados en limón con cebolla y aji. Cada cucharada es una combinación de sabores citricos y marinos que deleitaran tu paladar.', 18.99),
(11, 'Rabo de Toro Estofado', 'Prueba nuestro delicioso estofado de rabo de toro con verduras y vino tinto. Cada porción es una muestra de la cocina tradicional y sabrosa de nuestra región.', 28.99),
(11, 'Tarta Tatin', 'Disfruta de nuestra tarta invertida de manzanas caramelizadas con masa hojaldrada. Cada porción es una combinación perfecta de dulzura y textura crujiente.', 13.99),
(11, 'Sopa de Cebolla', 'Saborea nuestra sopa de cebolla gratinada con queso fundido. Cada cucharada es reconfortante y llena de sabores profundos.', 11.99),
(11, 'Pure de Zanahoria y Jengibre', 'Degusta nuestro pure suave de zanahoria y jengibre con especias. Cada cucharada es una explosión de sabores frescos y saludables.', 9.99),
(11, 'Mousse de Frambuesa', 'Prueba nuestro postre ligero y cremoso de mousse de frambuesa. Cada cucharada es refrescante y llena de sabor a frutas.', 8.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(12, 'Bife de Chorizo', 'Disfruta de nuestro jugoso bife de chorizo a la parrilla con chimichurri. Cada corte es tierno y lleno de sabor.', 25.99),
(12, 'Asado de Tira', 'Saborea nuestras tiernas costillas de res asadas a la parrilla. Cada bocado es una experiencia carnivora unica.', 27.99),
(12, 'Matambre a la Pizza', 'Prueba nuestro matambre relleno con salsa de tomate, mozzarella y los ingredientes de tu elección. Cada porción es un festin de sabores y texturas.', 23.99),
(12, 'Empanadas Argentinas', 'Degusta nuestras empanadas caseras de carne, pollo o verduras. Cada una esta hecha con masa crujiente y un relleno jugoso y sabroso.', 10.99),
(12, 'Parrillada Mixta', 'Disfruta de nuestra selección de carnes a la parrilla: chorizo, morcilla, churrasco, pollo y cerdo. Cada porción es un festin para los amantes de la carne.', 29.99),
(12, 'Ensalada Criolla', 'Prueba nuestra ensalada tradicional argentina con tomate, cebolla y pimientos. Cada bocado es fresco y lleno de sabores vibrantes.', 12.99),
(12, 'Provoleta', 'Degusta nuestro queso provolone a la parrilla con especias y aceite de oliva. Cada porción es un derroche de sabores intensos y cremosidad.', 14.99),
(12, 'Helado de Dulce de Leche', 'Prueba nuestro clasico helado argentino de dulce de leche. Cada cucharada es suave, dulce y llena de indulgencia.', 8.99),
(12, 'Mollejas a la Parrilla', 'Saborea nuestras mollejas de ternera a la parrilla con limón y sal gruesa. Cada bocado es tierno y lleno de sabor.', 19.99),
(12, 'Alfajores', 'Degusta nuestros dulces tipicos argentinos: dos galletas rellenas de dulce de leche y cubiertas de chocolate. Cada bocado es una combinación perfecta de texturas y dulzura.', 9.99);


INSERT INTO product (restaurant_id, name, description, price)
VALUES
(13, 'Filet Mignon', 'Disfruta de nuestro exquisito filete mignon con salsa de champiñones. Cada corte es tierno y jugoso, y la salsa complementa perfectamente los sabores.', 28.99),
(13, 'Ratatouille', 'Prueba nuestro plato vegetariano de ratatouille con berenjena, calabacin, pimientos y tomate al horno. Cada porción es una explosión de sabores y texturas.', 16.99),
(13, 'Sopa de Calabaza', 'Deleitate con nuestra sopa cremosa de calabaza con un toque de jengibre. Cada cucharada es reconfortante y llena de sabores calidos.', 11.99),
(13, 'Ensalada Caprese', 'Prueba nuestra clasica ensalada italiana Caprese con tomate, mozzarella y albahaca. Cada bocado es fresco y lleno de sabores mediterraneos.', 14.99),
(13, 'Risotto de Hongos', 'Disfruta de nuestro risotto cremoso con una variedad de hongos frescos. Cada cucharada es reconfortante y llena de sabores terrosos.', 22.99),
(13, 'Tarta de Espinacas y Queso de Cabra', 'Degusta nuestra deliciosa tarta salada con espinacas, queso de cabra y cebolla caramelizada. Cada porción es una combinación perfecta de sabores salados y dulces.', 19.99),
(13, 'Crema Catalana', 'Prueba nuestro postre tradicional español similar al crème brûlee. Cada cucharada de nuestra crema catalana es suave, cremosa y llena de sabores a caramelo y citricos.', 10.99);
 

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(14, 'Pad Thai', 'Disfruta del famoso plato tailandes de fideos de arroz salteados con pollo, camarones o tofu. Cada bocado esta lleno de sabores autenticos y especias exquisitas.', 17.99),
(14, 'Curry de Coco', 'Prueba nuestro delicioso curry tailandes con leche de coco, pollo, verduras y especias. Cada cucharada es una explosión de sabores picantes y cremosos.', 19.99),
(14, 'Sushi Variado', 'Disfruta de una variedad de sushi que incluye nigiri, maki y sashimi. Cada pieza esta hecha con los ingredientes mas frescos y presenta una combinación perfecta de sabores.', 24.99),
(14, 'Rollitos de Primavera', 'Degusta nuestros deliciosos rollitos de primavera rellenos de vegetales y carne, acompañados de salsa agridulce. Cada bocado es crujiente y lleno de sabores deliciosos.', 12.99),
(14, 'Tom Kha Gai', 'Prueba nuestra autentica sopa tailandesa de coco con pollo y hierbas aromaticas. Cada cucharada es reconfortante y esta llena de sabores equilibrados y exóticos.', 15.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(15, 'Lasagna de Carne', 'Prueba nuestra deliciosa lasagna casera con carne, pasta y salsa de tomate. Cada capa esta llena de sabores reconfortantes y autenticos.', 14.99),
(15, 'Milanesa Napolitana', 'Disfruta de nuestra milanesa de ternera empanizada cubierta con salsa de tomate y queso. Cada bocado es crujiente por fuera y tierno por dentro.', 17.99),
(15, 'Pollo al Horno', 'Saborea nuestro pollo jugoso asado al horno con hierbas y especias. Cada pieza esta llena de sabor y se derrite en tu boca.', 16.99),
(15, 'Guiso de Lentejas', 'Prueba nuestro guiso tradicional de lentejas con chorizo y verduras. Cada cucharada te brinda una experiencia reconfortante y llena de sabor.', 12.99),
(15, 'Ensalada de Pollo', 'Disfruta de nuestra ensalada fresca con pollo a la parrilla, vegetales y aderezo de tu elección. Cada bocado es saludable y sabroso.', 13.99),
(15, 'Tarta de Verduras', 'Degusta nuestra deliciosa tarta salada de verduras mixtas con masa quebrada. Cada porción es una combinación perfecta de sabores y texturas.', 11.99),
(15, 'Arroz con Leche', 'Endulza tu paladar con nuestro postre cremoso de arroz con leche, canela y azucar. Cada cucharada es un deleite reconfortante.', 8.99),
(15, 'Pure de Papa', 'Prueba nuestro pure suave y cremoso de papas. Cada cucharada es reconfortante y se derrite en tu boca.', 7.99),
(15, 'Ensalada de Frutas', 'Refresca tu paladar con nuestra ensalada de frutas frescas. Cada bocado es jugoso y lleno de sabores naturales.', 9.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(16, 'Hamburguesa Clasica', 'Deleitate con nuestra jugosa hamburguesa de carne de res, lechuga, tomate y aderezo especial. ¡Un clasico irresistible!', 12.99),
(16, 'Fish and Chips', 'Prueba nuestro clasico plato ingles de pescado rebozado y papas fritas. Cada bocado es crujiente y lleno de sabor.', 14.99),
(16, 'Alitas de Pollo', 'Disfruta de nuestras alitas de pollo marinadas y fritas, con salsa a elección. Cada alita es sabrosa y jugosa.', 10.99),
(16, 'Nachos con Queso', 'Satisface tus antojos con nuestros nachos crujientes cubiertos de queso derretido, jalapeños y guacamole. ¡El acompañamiento perfecto para compartir!', 9.99),
(16, 'Ensalada Cesar', 'Disfruta de nuestra ensalada clasica con pollo a la parrilla, croutones y aderezo Cesar. Una combinación fresca y deliciosa.', 13.99),
(16, 'Sandwich de Pastrami', 'Prueba nuestro sabroso sandwich relleno de pastrami, pepinillos y mostaza. Cada bocado es una explosión de sabores.', 11.99),
(16, 'Cheesecake de Frutos Rojos', 'Endulza tu paladar con nuestro cheesecake cremoso con salsa de frutos rojos. Cada porción es suave y deliciosa.', 8.99),
(16, 'Papas Fritas', 'Degusta nuestras papas fritas doradas y crujientes. El acompañamiento perfecto para cualquier plato.', 6.99),
(16, 'Cerveza Artesanal', 'Descubre nuestra variedad de cervezas artesanales para disfrutar. Cada sorbo es una experiencia unica y refrescante.', 7.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(17, 'Paella Valenciana', 'Disfruta de nuestro plato tradicional español de arroz con mariscos, pollo y verduras. Una explosión de sabores mediterraneos.', 25.99),
(17, 'Gazpacho', 'Refrescante sopa fria de tomate, pepino, pimiento y aceite de oliva. Perfecta para los dias calurosos.', 11.99),
(17, 'Lomo de Cerdo al Horno', 'Prueba nuestro jugoso lomo de cerdo asado al horno con hierbas mediterraneas. Una delicia para el paladar.', 18.99),
(17, 'Ensalada Griega', 'Disfruta de nuestra ensalada fresca con tomate, pepino, cebolla, aceitunas y queso feta. Un clasico de la cocina griega.', 14.99),
(17, 'Moussaka', 'Degusta nuestro plato griego de berenjena, carne picada y salsa bechamel gratinada. Una combinación irresistible.', 19.99),
(17, 'Tzatziki', 'Prueba nuestra salsa griega a base de yogur, pepino, ajo y hierbas frescas. El complemento perfecto para tus platos.', 7.99),
(17, 'Baklava', 'Endulza tu paladar con nuestro dulce tradicional griego hecho con nueces y hojaldre bañado en almibar. Una exquisitez.', 9.99),
(17, 'Tabbouleh', 'Disfruta de nuestra ensalada de bulgur, perejil, menta, tomate y limón. Una opción refrescante y llena de sabor.', 12.99),
(17, 'Pita Gyro', 'Saborea nuestro delicioso sandwich griego relleno de carne de cerdo asada, tzatziki y vegetales. Una explosión de sabores.', 16.99);

INSERT INTO product (restaurant_id, name, description, price)
VALUES
(18, 'Asado de Tira', 'Disfruta de nuestro delicioso corte de carne de res asado a la parrilla. Nuestro asado de tira se prepara con esmero, utilizando los mejores cortes de carne de res seleccionada. Cada bocado es jugoso, tierno y lleno de sabor, con ese inconfundible aroma a parrilla que te transportara a los autenticos asados argentinos. Acompañado de guarniciones y aderezos que realzan su sabor, nuestro asado de tira es una experiencia culinaria que no puedes perderte. ¡Ven y disfrutalo con nosotros!', 29.99),
(18, 'Choripan', 'Prueba nuestro clasico sandwich argentino con chorizo a la parrilla. El choripan es una verdadera delicia que combina la intensidad y jugosidad del chorizo argentino con el pan recien horneado. Nuestro chorizo se elabora con una mezcla de carnes seleccionadas y especias tradicionales, y se cocina a la perfección en nuestra parrilla para lograr ese sabor irresistible. Acompañado de aderezos y salsas caseras, el choripan es el bocadillo ideal para satisfacer tus antojos. ¡Ven y pruebalo!', 12.99),
(18, 'Empanadas', 'Deleitate con nuestras empanadas argentinas rellenas de carne, pollo o verduras. Cada empanada se elabora cuidadosamente a mano, utilizando masa casera y rellenos de alta calidad. Nuestra empanada de carne esta hecha con un jugoso relleno de carne de res sazonada con especias tradicionales. La empanada de pollo combina tierna carne de pollo con sabrosas verduras, y la empanada de verduras te sorprendera con una mezcla de vegetales frescos y sabrosos condimentos. Cada bocado es una explosión de sabores y texturas que te transportara a la autentica cocina argentina. ¡No te las pierdas!', 9.99),
(18, 'Provoleta', 'Saborea nuestro queso provolone asado a la parrilla con aceite de oliva y especias. La provoleta es un plato emblematico de la cocina argentina que destaca por su sabor intenso y su textura suave y cremosa. Utilizamos queso provolone de calidad y lo asamos a la parrilla hasta que se derrite y adquiere un delicado sabor ahumado. Luego, lo rociamos con aceite de oliva y especias que realzan su sabor y aroma. Cada porción de provoleta es un deleite para los amantes del queso y una excelente opción para comenzar una comida o disfrutar como aperitivo. ¡Ven y prueba nuestra exquisita provoleta!', 16.99),
(18, 'Mollejas', 'Disfruta de nuestras mollejas de ternera a la parrilla con limón y sal. Las mollejas son un manjar muy apreciado en la cocina argentina y te invitamos a descubrir su delicioso sabor en nuestro restaurante. Nuestras mollejas se seleccionan cuidadosamente, se marinan con hierbas y especias, y se asan a la parrilla hasta obtener una textura tierna por dentro y crujiente por fuera. Les añadimos el toque fresco del limón y la pizca de sal que realza su sabor unico. Si eres amante de los sabores intensos y las texturas irresistibles, las mollejas son una elección perfecta. ¡Ven y deleitate con nuestras mollejas!', 19.99),
(18, 'Papas Provenzal', 'Degusta nuestras papas fritas condimentadas con ajo y perejil. Nuestras papas provenzal son el acompañamiento perfecto para cualquier plato. Utilizamos papas de calidad, las cortamos en finas rodajas y las freimos hasta obtener una textura dorada y crujiente. Luego, les añadimos una mezcla de ajo y perejil fresco que les otorga un sabor aromatico y delicioso. Ya sea como guarnición o como aperitivo, nuestras papas provenzal son irresistibles y complementan a la perfección nuestros platos principales. ¡Ven y disfruta de nuestras papas provenzal!', 7.99),
(18, 'Tiramisu', 'Endulza tu paladar con nuestro postre italiano de capas de bizcocho, cafe y crema de mascarpone. El tiramisu es un clasico de la cocina italiana y en nuestro restaurante te ofrecemos una versión excepcional. Preparamos nuestro tiramisu con ingredientes de calidad, desde el bizcocho empapado en cafe hasta la cremosa capa de mascarpone y cacao en polvo que lo corona. Cada cucharada es una explosión de sabores y texturas que te transportara a Italia. Si eres amante de los postres, no puedes dejar de probar nuestro delicioso tiramisu. ¡Te encantara!', 10.99),
(18, 'Ensalada Mixta', 'Disfruta de nuestra ensalada fresca con lechuga, tomate, cebolla y aceitunas. Nuestra ensalada mixta es una opción saludable y sabrosa para aquellos que desean comer ligero sin renunciar al sabor. Utilizamos ingredientes frescos y de calidad, combinados con un aderezo ligero que realza los sabores naturales de los vegetales. La lechuga crujiente, los tomates jugosos, la cebolla picante y las aceitunas sabrosas se complementan a la perfección en esta ensalada clasica. Ya sea como acompañamiento o como plato principal, nuestra ensalada mixta te dejara satisfecho y satisfecha. ¡Ven y pruebala!', 8.99),
(18, 'Helado de Dulce de Leche', 'Prueba nuestro delicioso helado de dulce de leche artesanal. Nuestro helado de dulce de leche esta elaborado con dedicación y cuidado, utilizando los mejores ingredientes y tecnicas tradicionales. Cada cucharada de nuestro helado te transportara a un mundo de sabores y texturas cremosas. El dulce de leche, con su rico sabor a caramelo, se combina a la perfección con la suavidad y frescura del helado. Si eres amante de los postres helados, no puedes dejar de probar nuestro irresistible helado de dulce de leche. ¡Te encantara!', 6.99);
INSERT INTO product (restaurant_id, name, description, price)
VALUES
(19, 'Carpaccio de Res', 'Deleitate con finas laminas de carne de res marinadas en aceite de oliva y acompañadas con queso parmesano. Este plato italiano es una deliciosa y elegante opción para comenzar tu comida.', 15.99),
(19, 'Ceviche de Camarón', 'Disfruta de camarones frescos marinados en limón, cebolla y cilantro, que le dan un toque refrescante y picante a este plato peruano tradicional. Es una explosión de sabores marinos que te encantara.', 18.99),
(19, 'Lomo Saltado', 'Prueba este sabroso plato peruano que combina trozos de lomo de res salteados con cebolla y tomate, sazonados con especias y servidos con arroz y papas fritas. Es una explosión de sabores y texturas que te transportara a la cocina peruana.', 21.99),
(19, 'Causa Limeña', 'Deleitate con una deliciosa masa de papa amarilla suave y cremosa, rellena de pollo o mariscos, aliñada con limón y especias. Es un plato tradicional peruano que te sorprendera con su combinación unica de sabores.', 14.99),
(19, 'Tiradito de Pescado', 'Prueba este plato peruano similar al ceviche, donde finas laminas de pescado fresco son marinadas en limón y cubiertas con una deliciosa salsa de aji amarillo. Es una explosión de sabores citricos y picantes que te encantara.', 19.99),
(19, 'Suspiro Limeño', 'Date un capricho con este clasico postre peruano que combina leche condensada y merengue, creando una textura cremosa y dulce. Es el final perfecto para una comida peruana autentica.', 11.99),
(19, 'Anticuchos', 'Disfruta de estas deliciosas brochetas de carne marinadas y asadas a la parrilla. Son un bocado sabroso y jugoso que refleja la tradición culinaria peruana.', 12.99),
(19, 'Pisco Sour', 'Prueba el famoso cóctel peruano elaborado con pisco, limón, azucar y clara de huevo, que resulta en una bebida refrescante y llena de sabor. Es el acompañante perfecto para tu experiencia culinaria peruana.', 9.99),
(19, 'Arroz con Mariscos', 'Deleitate con este sabroso arroz preparado con una variedad de mariscos frescos, como camarones, calamares y mejillones, sazonados con especias y hierbas aromaticas. Es un plato abundante y lleno de sabores marinos.', 23.99),
(19, 'Papa a la Huancaina', 'Prueba esta deliciosa preparación peruana en la que las papas cocidas se sirven con una cremosa salsa de aji amarillo y queso fresco. Es un plato reconfortante y lleno de sabor.', 10.99);
 
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
