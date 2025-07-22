
DROP SCHEMA IF EXISTS laVacaStore;
DROP USER IF EXISTS 'usuario_prueba'@'%';

CREATE SCHEMA laVacaStore;

CREATE USER 'usuario_prueba'@'%' IDENTIFIED BY 'Usuario_Clave.';

GRANT ALL PRIVILEGES ON laVacaStore.* TO 'usuario_prueba'@'%';
FLUSH PRIVILEGES;

USE laVacaStore;

CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE producto (
  id_producto INT NOT NULL AUTO_INCREMENT,
  id_categoria INT NOT NULL,
  descripcion VARCHAR(30) NOT NULL,
  talla VARCHAR(20) NOT NULL,
  color VARCHAR(30) NOT NULL,
  precio DOUBLE,
  existencias INT,
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_producto),
  CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria(id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


CREATE TABLE usuario (
  id_usuario INT NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  password varchar(512) NOT NULL,
  nombre VARCHAR(20) NOT NULL,
  apellidos VARCHAR(30) NOT NULL,
  correo VARCHAR(75) NULL,
  telefono VARCHAR(15) NULL,
  ruta_imagen varchar(1024),
  activo boolean,
  PRIMARY KEY (`id_usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


INSERT INTO categoria (descripcion, ruta_imagen, activo) VALUES
  ('Hombres', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Men-Fashion.jpg', true),
  ('Mujeres', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Women-Fashion.jpg', true),
  ('Novedades', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Women-Fashion.jpg', true);


INSERT INTO producto (id_categoria, descripcion, talla, color, precio, existencias, ruta_imagen, activo) VALUES
  (1, 'Camiseta Clásica', 'M', 'Negro', 9500, 10,'https://static.bershka.net/assets/public/9bd2/a00a/40c840ea8c9c/48ac40c78a0c/02976071800-a4o/02976071800-a4o.jpg?ts=1743431758067&w=1920', true),
  (1, 'Jeans Slim Fit', '32', 'Azul', 18900, 5, 'https://static.bershka.net/assets/public/c05d/71e3/88d74ccc8605/375394a1601d/05334156400-a4o/05334156400-a4o.jpg?ts=1721299642883&w=1920', true),
  (1, 'Camisa Formal', 'L', 'Blanco', 22000, 7, 'https://static.bershka.net/assets/public/2440/160c/fc664ccca638/39f178923364/02777623250-a4o/02777623250-a4o.jpg?ts=1736757889979&w=1920', true),
  (1, 'Chaqueta Casual', 'XL', 'Gris', 29900, 3, 'https://static.bershka.net/assets/public/6dd8/4573/7a0e4c03b9d1/a2728c7f6570/01854663802-a4o/01854663802-a4o.jpg?ts=1739178835071&w=800', true);


INSERT INTO producto (id_categoria, descripcion, talla, color, precio, existencias, ruta_imagen, activo) VALUES
  (2, 'Blusa Estampada', 'S', 'Celeste', 11500, 12, 'https://static.pullandbear.net/assets/public/5cfa/1a8a/bc3d4c1d90dc/18b377fab8ee/03248355807-A6M/03248355807-A6M.jpg?ts=1740054013064&w=1124&f=auto', true),
  (2, 'Falda Plisada', 'M', 'Negro', 16900, 6, 'https://static.pullandbear.net/assets/public/6244/3de2/1d154b38b7cb/5f749d9d538f/03360419800-A6M/03360419800-A6M.jpg?ts=1742488426452&w=1124&f=auto', true),
  (2, 'Vestido Largo', 'L', 'Rojo', 24500, 4, 'https://static.pullandbear.net/assets/public/92aa/adfc/617f4a478362/5a42ff7ad9ea/03397346670-C/03397346670-C.jpg?ts=1741621948285&w=1124&f=auto', true),
  (2, 'Chaqueta de Jean', 'M', 'Azul Claro', 27500, 5, 'https://static.pullandbear.net/assets/public/6802/ea72/2d1f4bfc976e/01aff93e8432/03716343406-A6M/03716343406-A6M.jpg?ts=1742492512218&w=1124&f=auto', true);


INSERT INTO producto (id_categoria, descripcion, talla, color, precio, existencias, ruta_imagen, activo) VALUES
  (3, 'Camiseta Clásica', 'M', 'Negro', 9500, 10, 'https://static.bershka.net/assets/public/9bd2/a00a/40c840ea8c9c/48ac40c78a0c/02976071800-a4o/02976071800-a4o.jpg?ts=1743431758067&w=1920', true),
  (3, 'Jeans Slim Fit', '32', 'Azul', 18900, 5, 'https://static.bershka.net/assets/public/c05d/71e3/88d74ccc8605/375394a1601d/05334156400-a4o/05334156400-a4o.jpg?ts=1721299642883&w=1920', true),
  (3, 'Camisa Formal', 'L', 'Blanco', 22000, 7, 'https://static.bershka.net/assets/public/2440/160c/fc664ccca638/39f178923364/02777623250-a4o/02777623250-a4o.jpg?ts=1736757889979&w=1920', true),
  (3, 'Chaqueta Casual', 'XL', 'Gris', 29900, 3, 'https://static.bershka.net/assets/public/6dd8/4573/7a0e4c03b9d1/a2728c7f6570/01854663802-a4o/01854663802-a4o.jpg?ts=1739178835071&w=800', true);

INSERT INTO usuario (id_usuario, username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
(1,'Sebas','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Sebastian', 'Gonzalez Jara',    'sgonzalez@gmail.com',    '4556-8978', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Juan_Diego_Madrigal.jpg/250px-Juan_Diego_Madrigal.jpg',true),
(2,'Miguel','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Miguel',  'Ortega Salazar', 'mortega@gmail.com', '5456-8789','https://upload.wikimedia.org/wikipedia/commons/0/06/Photo_of_Rebeca_Arthur.jpg',true),
(3,'Camila','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Camila', 'Chacon Gomez',     'cgomez@gmail.com',      '7898-8936','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Eduardo_de_Pedro_2019.jpg/480px-Eduardo_de_Pedro_2019.jpg?20200109230854',true);


create table rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  foreign key fk_rol_usuario (id_usuario) references usuario(id_usuario)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

insert into rol (id_rol, nombre, id_usuario) values
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',1), (3,'ROLE_USER',1),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);


CREATE TABLE request_matcher (
    id_request_matcher INT AUTO_INCREMENT NOT NULL,
    pattern VARCHAR(255) NOT NULL,
    role_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_request_matcher))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO request_matcher (pattern, role_name) VALUES ('/producto/nuevo', 'ROLE_ADMIN'),
('/producto/guardar', 'ROLE_ADMIN'),
('/producto/modificar/** ', 'ROLE_ADMIN'),
('/producto/eliminar/**', 'ROLE_ADMIN'),
('/categoria/nuevo', 'ROLE_ADMIN'),
('/categoria/guardar', 'ROLE_ADMIN'),
('/categoria/modificar/** ', 'ROLE_ADMIN'),
('/categoria/eliminar/**', 'ROLE_ADMIN'),
('/usuario/nuevo', 'ROLE_ADMIN'),
('/usuario/guardar', 'ROLE_ADMIN'),
('/usuario/modificar/** ', 'ROLE_ADMIN'),
('/usuario/eliminar/**', 'ROLE_ADMIN'),
('/reportes/**', 'ROLE_ADMIN'),
('/producto/listado', 'ROLE_VENDEDOR'),
('/categoria/listado', 'ROLE_VENDEDOR'),
('/usuario/listado', 'ROLE_VENDEDOR'),
('/facturar/carrito', 'ROLE_USER');

CREATE TABLE request_matcher_all (
    id_request_matcher INT AUTO_INCREMENT NOT NULL,
    pattern VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_request_matcher))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

INSERT INTO request_matcher_all (pattern) VALUES ('/'),
('/index'),
('/errores/**'),
('/carrito/**'),
('/pruebas/**'),
('/reportes/**'),
('/registro/**'),
('/js/**'),
('/webjars/**');