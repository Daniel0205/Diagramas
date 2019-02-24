--Tabla Sedes
DROP TABLE IF EXISTS sedes CASCADE;
CREATE TABLE sedes(
   id_sede        INT NOT NULL PRIMARY KEY,
   direccion      CHAR(50) NOT NULL,
   nombre         CHAR(20) NOT NULL,
   telefono	  BIGINT NOT NULL,
   empleado_a_cargo    BIGINT    --foreing key
);


-- empleados --
CREATE EXTENSION pgcrypto; --to enable pgcrypto
DROP TABLE IF EXISTS empleados CASCADE;
CREATE TABLE empleados (
	cedula		BIGINT NOT NULL PRIMARY KEY,
	contrasena 	TEXT NOT NULL,
	nombres		CHAR(28) NOT NULL,
	apellidos 	CHAR(28) ,
	direccion 	CHAR(50) ,
	numero		BIGINT NULL,
	email	 	TEXT NOT NULL,
	tipo_usuario 	CHAR(14) NOT NULL,
	sede	 	INT NOT NULL REFERENCES sedes(id_sede),
	activo  	BOOL NOT NULL
CHECK (tipo_usuario IN ('Vendedor', 'Jefe de taller'))
);

--Tabla Producto
DROP TABLE IF EXISTS producto CASCADE;
CREATE TABLE producto(
   id_producto    INT NOT NULL PRIMARY KEY,
   nombre 	  CHAR(20) NOT NULL,
   precio         BIGINT NOT NULL,
   descripcion    TEXT
);

--Tabla Ordenes_de_Trabajo
DROP TABLE IF EXISTS ordenes_de_trabajo CASCADE;
CREATE TABLE ordenes_de_trabajo(
   id_ordenes     BIGINT NOT NULL PRIMARY KEY,
   asignada_a     TEXT NOT NULL,
   precio         BIGINT NOT NULL,
   fecha_entrega  DATE NOT NULL,
   cantidad       INT NOT NULL,
   finalizada     BOOL NOT NULL,
   id_producto    BIGINT NOT NULL  REFERENCES producto (id_producto),
   id_usuario     BIGINT NOT NULL  REFERENCES empleados (cedula)
);

--Tabla Venta_Cotizaciones
DROP TABLE IF EXISTS venta_cotizaciones CASCADE;
CREATE TABLE venta_cotizaciones (
   id_cotizacion    BIGINT NOT NULL PRIMARY KEY,
   id_empleado      BIGINT NOT NULL  REFERENCES empleados (cedula),
   fecha_cotizacion DATE,
   nombre_cotizante TEXT,
   precio_final     BIGINT NOT NULL
);

--Tabla Usuario_Producto
DROP TABLE IF EXISTS usuario_productos CASCADE;
CREATE TABLE usuario_producto (
   id_sedes            BIGINT NOT NULL  REFERENCES sedes (id_sede),
   id_producto         BIGINT NOT NULL  REFERENCES producto (id_producto),
   cantidad_disponible INT NOT NULL
);

--Tabla Ventas_Cotizaciones_Producto
DROP TABLE IF EXISTS ventas_cotizaciones_producto CASCADE;
CREATE TABLE ventas_cotizaciones_producto (
   id_producto      BIGINT NOT NULL  REFERENCES producto (id_producto),
   cantidad_compra  INT NOT NULL,
   id_cotizacion    BIGINT NOT NULL  REFERENCES venta_cotizaciones (id_cotizacion)
);