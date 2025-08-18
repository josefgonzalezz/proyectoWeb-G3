/* Reinicio de base de datos y usuario */
DROP SCHEMA IF EXISTS laVacaStore;
DROP USER IF EXISTS 'usuario_prueba'@'%';

CREATE SCHEMA laVacaStore;

CREATE USER 'usuario_prueba'@'%' IDENTIFIED BY 'Usuario_Clave.';
GRANT ALL PRIVILEGES ON laVacaStore.* TO 'usuario_prueba'@'%';
FLUSH PRIVILEGES;

USE laVacaStore;

/* Tabla de categorías */
CREATE TABLE categoria (
  id_categoria INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(30) NOT NULL,
  ruta_imagen VARCHAR(1024),
  activo BOOLEAN,
  PRIMARY KEY (id_categoria)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/* Tabla de productos */
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

/* Tabla de usuarios */
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
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/* --- NUEVO: Tablas de carrito/facturación --- */

/* Facturas */
CREATE TABLE factura (
  id_factura INT NOT NULL AUTO_INCREMENT,
  id_usuario INT NOT NULL,
  fecha date,  
  total double,
  estado int, /* 1: Activa, 2: Pagada, 3: Anulada */
  PRIMARY KEY (id_factura),
  FOREIGN KEY fk_factura_usuario (id_usuario) REFERENCES usuario(id_usuario)  
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/* Ventas */
CREATE TABLE venta (
  id_venta INT NOT NULL AUTO_INCREMENT,
  id_factura INT NOT NULL,
  id_producto INT NOT NULL,
  precio double, 
  cantidad int,
  PRIMARY KEY (id_venta),
  FOREIGN KEY fk_ventas_factura (id_factura) REFERENCES factura(id_factura),
  FOREIGN KEY fk_ventas_producto (id_producto) REFERENCES producto(id_producto) 
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/* Roles */
CREATE TABLE rol (
  id_rol INT NOT NULL AUTO_INCREMENT,
  nombre varchar(20),
  id_usuario int,
  PRIMARY KEY (id_rol),
  FOREIGN KEY fk_rol_usuario (id_usuario) REFERENCES usuario(id_usuario)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/* Request matcher */
CREATE TABLE request_matcher (
    id_request_matcher INT AUTO_INCREMENT NOT NULL,
    pattern VARCHAR(255) NOT NULL,
    role_name VARCHAR(50) NOT NULL,
	PRIMARY KEY (id_request_matcher))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE request_matcher_all (
    id_request_matcher INT AUTO_INCREMENT NOT NULL,
    pattern VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_request_matcher))
ENGINE = InnoDB DEFAULT CHARACTER SET = utf8mb4;

/* --- Inserciones de datos --- */

/* Categorías */
INSERT INTO categoria (descripcion, ruta_imagen, activo) VALUES
  ('Hombres', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Men-Fashion.jpg', true),
  ('Mujeres', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Women-Fashion.jpg', true),
  ('Novedades', 'https://cdn.shopify.com/s/files/1/0550/3481/0845/files/Women-Fashion.jpg', true);

/* Productos */
INSERT INTO producto (id_categoria, descripcion, talla, color, precio, existencias, ruta_imagen, activo) VALUES
  (1, 'Camiseta Clásica', 'M', 'Negro', 9500, 10,'https://static.bershka.net/assets/public/9bd2/a00a/40c840ea8c9c/48ac40c78a0c/02976071800-a4o/02976071800-a4o.jpg?ts=1743431758067&w=1920', true),
  (1, 'Jeans Slim Fit', '32', 'Azul', 18900, 5, 'https://static.bershka.net/assets/public/c05d/71e3/88d74ccc8605/375394a1601d/05334156400-a4o/05334156400-a4o.jpg?ts=1721299642883&w=1920', true),
  (1, 'Camisa Formal', 'L', 'Blanco', 22000, 7, 'https://static.bershka.net/assets/public/2440/160c/fc664ccca638/39f178923364/02777623250-a4o/02777623250-a4o.jpg?ts=1736757889979&w=1920', true),
  (1, 'Chaqueta Casual', 'XL', 'Gris', 29900, 3, 'https://static.bershka.net/assets/public/6dd8/4573/7a0e4c03b9d1/a2728c7f6570/01854663802-a4o/01854663802-a4o.jpg?ts=1739178835071&w=800', true),
  (2, 'Blusa Estampada', 'S', 'Celeste', 11500, 12, 'https://static.pullandbear.net/assets/public/5cfa/1a8a/bc3d4c1d90dc/18b377fab8ee/03248355807-A6M/03248355807-A6M.jpg?ts=1740054013064&w=1124&f=auto', true),
  (2, 'Falda Plisada', 'M', 'Negro', 16900, 6, 'https://static.pullandbear.net/assets/public/6244/3de2/1d154b38b7cb/5f749d9d538f/03360419800-A6M/03360419800-A6M.jpg?ts=1742488426452&w=1124&f=auto', true),
  (2, 'Vestido Largo', 'L', 'Rojo', 24500, 4, 'https://static.pullandbear.net/assets/public/92aa/adfc/617f4a478362/5a42ff7ad9ea/03397346670-C/03397346670-C.jpg?ts=1741621948285&w=1124&f=auto', true),
  (2, 'Chaqueta de Jean', 'M', 'Azul Claro', 27500, 5, 'https://static.pullandbear.net/assets/public/6802/ea72/2d1f4bfc976e/01aff93e8432/03716343406-A6M/03716343406-A6M.jpg?ts=1742492512218&w=1124&f=auto', true),
  (3, 'Sueta Azul', 'L', 'Celeste', 11500, 12, 'https://static.bershka.net/assets/public/db16/d2b7/c7e9439b90b9/eb3e054b248b/01597777400-a4o/01597777400-a4o.jpg?ts=1745492312953&w=1920', true),
  (3, 'Chaqueta', 'M', 'Cafe', 16900, 6, 'https://static.bershka.net/assets/public/ab9e/eb25/278240919bda/80e933b7048d/06796677700-a4o/06796677700-a4o.jpg?ts=1753791220966&w=1920', true),
  (3, 'Jeans', 'L', 'Azul', 24500, 4, 'https://static.bershka.net/assets/public/6b85/0f35/326240ad98aa/25a1c4baeda4/05356352400-a4o/05356352400-a4o.jpg?ts=1753175450587&w=800', true),
  (3, 'Zapatos Negros', 'M', 'Negro', 27500, 5, 'https://static.bershka.net/assets/public/5c77/3702/d5774346a3dc/eadab9510acf/12634560040-a4o/12634560040-a4o.jpg?ts=1740408217060&w=800', true);



/* Usuarios */
INSERT INTO usuario (id_usuario, username,password,nombre, apellidos, correo, telefono,ruta_imagen,activo) VALUES 
(1,'Sebas','$2a$10$P1.w58XvnaYQUQgZUCk4aO/RTRl8EValluCqB3S2VMLTbRt.tlre.','Sebastian', 'Gonzalez Jara',    'sgonzalez@gmail.com',    '4556-8978', 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Juan_Diego_Madrigal.jpg/250px-Juan_Diego_Madrigal.jpg',true),
(2,'Miguel','$2a$10$GkEj.ZzmQa/aEfDmtLIh3udIH5fMphx/35d0EYeqZL5uzgCJ0lQRi','Miguel',  'Ortega Salazar', 'mortega@gmail.com', '5456-8789','https://upload.wikimedia.org/wikipedia/commons/0/06/Photo_of_Rebeca_Arthur.jpg',true),
(3,'Camila','$2a$10$koGR7eS22Pv5KdaVJKDcge04ZB53iMiw76.UjHPY.XyVYlYqXnPbO','Camila', 'Chacon Gomez',     'cgomez@gmail.com',      '7898-8936','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Eduardo_de_Pedro_2019.jpg/480px-Eduardo_de_Pedro_2019.jpg?20200109230854',true);

/* Roles */
INSERT INTO rol (id_rol, nombre, id_usuario) VALUES
 (1,'ROLE_ADMIN',1), (2,'ROLE_VENDEDOR',1), (3,'ROLE_USER',1),
 (4,'ROLE_VENDEDOR',2), (5,'ROLE_USER',2),
 (6,'ROLE_USER',3);

/* Request matcher */
INSERT INTO request_matcher (pattern, role_name) VALUES 
('/producto/nuevo', 'ROLE_ADMIN'),
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

/* Request matcher all */
INSERT INTO request_matcher_all (pattern) VALUES 
('/'),
('/index'),
('/errores/**'),
('/carrito/**'),
('/pruebas/**'),
('/reportes/**'),
('/registro/**'),
('/js/**'),
('/webjars/**');
