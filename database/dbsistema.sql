-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2021 at 03:13 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbsistema`
--

-- --------------------------------------------------------

--
-- Table structure for table `articulo`
--

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL,
  `idcategoria` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `articulo`
--

INSERT INTO `articulo` (`idarticulo`, `idcategoria`, `codigo`, `nombre`, `stock`, `descripcion`, `imagen`, `condicion`) VALUES
(1, 1, '1', 'redmi note 7', 97, 'ce', '', 1),
(2, 1, '12312', 'iphone', 11, 'iphone', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(256) DEFAULT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `condicion`) VALUES
(1, 'Celulares', 'telefonia', 1);

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ingreso`
--

CREATE TABLE `detalle_ingreso` (
  `iddetalle_ingreso` int(11) NOT NULL,
  `idingreso` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(11,2) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_ingreso`
--

INSERT INTO `detalle_ingreso` (`iddetalle_ingreso`, `idingreso`, `idarticulo`, `cantidad`, `precio_compra`, `precio_venta`) VALUES
(1, 1, 1, 1, '1.00', '1.00'),
(2, 2, 1, 100, '4.00', '4.00');

--
-- Triggers `detalle_ingreso`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock + NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_venta`
--

CREATE TABLE `detalle_venta` (
  `iddetalle_venta` int(11) NOT NULL,
  `idventa` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(11,2) NOT NULL,
  `descuento` decimal(11,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `detalle_venta`
--

INSERT INTO `detalle_venta` (`iddetalle_venta`, `idventa`, `idarticulo`, `cantidad`, `precio_venta`, `descuento`) VALUES
(1, 1, 1, 1, '10.00', '10.00'),
(2, 2, 1, 15, '4.00', '5.00');

--
-- Triggers `detalle_venta`
--
DELIMITER $$
CREATE TRIGGER `tr_updStockVenta` AFTER INSERT ON `detalle_venta` FOR EACH ROW BEGIN
 UPDATE articulo SET stock = stock - NEW.cantidad 
 WHERE articulo.idarticulo = NEW.idarticulo;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `ingreso`
--

CREATE TABLE `ingreso` (
  `idingreso` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_compra` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ingreso`
--

INSERT INTO `ingreso` (`idingreso`, `idproveedor`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_compra`, `estado`) VALUES
(1, 1, 3, 'Boleta', '1', '1', '2020-12-29 00:00:00', '99.99', '1.00', 'Aceptado'),
(2, 1, 3, 'Ticket', '1', '2', '2020-12-30 00:00:00', '14.00', '400.00', 'Aceptado');

-- --------------------------------------------------------

--
-- Table structure for table `permiso`
--

CREATE TABLE `permiso` (
  `idpermiso` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `permiso`
--

INSERT INTO `permiso` (`idpermiso`, `nombre`) VALUES
(1, 'Escritorio'),
(2, 'Almacen'),
(3, 'Compras'),
(4, 'Ventas'),
(5, 'Acceso'),
(6, 'Consulta Compras'),
(7, 'Consulta Ventas');

-- --------------------------------------------------------

--
-- Table structure for table `persona`
--

CREATE TABLE `persona` (
  `idpersona` int(11) NOT NULL,
  `tipo_persona` varchar(20) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) DEFAULT NULL,
  `num_documento` varchar(20) DEFAULT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `persona`
--

INSERT INTO `persona` (`idpersona`, `tipo_persona`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`) VALUES
(1, 'Proveedor', 'Mueblería Troncoso', 'INE', '123', '123131', '1233122313', ''),
(2, 'Cliente', 'Cliente', 'DNI', '123', '123', '123', '');

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo_documento` varchar(20) NOT NULL,
  `num_documento` varchar(20) NOT NULL,
  `direccion` varchar(70) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `cargo` varchar(20) DEFAULT NULL,
  `login` varchar(20) NOT NULL,
  `clave` varchar(64) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `condicion` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`idusuario`, `nombre`, `tipo_documento`, `num_documento`, `direccion`, `telefono`, `email`, `cargo`, `login`, `clave`, `imagen`, `condicion`) VALUES
(3, 'Luis andrés garcía perdomo', 'INE', '1234', '', '', '', '', 'admin', 'a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3', '1610244632.jpg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `usuario_permiso`
--

CREATE TABLE `usuario_permiso` (
  `idusuario_permiso` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `idpermiso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `usuario_permiso`
--

INSERT INTO `usuario_permiso` (`idusuario_permiso`, `idusuario`, `idpermiso`) VALUES
(133, 3, 1),
(134, 3, 2),
(135, 3, 3),
(136, 3, 4),
(137, 3, 5),
(138, 3, 6),
(139, 3, 7);

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--

CREATE TABLE `venta` (
  `idventa` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idusuario` int(11) NOT NULL,
  `tipo_comprobante` varchar(20) NOT NULL,
  `serie_comprobante` varchar(7) DEFAULT NULL,
  `num_comprobante` varchar(10) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `impuesto` decimal(4,2) NOT NULL,
  `total_venta` decimal(11,2) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`idventa`, `idcliente`, `idusuario`, `tipo_comprobante`, `serie_comprobante`, `num_comprobante`, `fecha_hora`, `impuesto`, `total_venta`, `estado`) VALUES
(1, 2, 3, 'Factura', '123', '1', '2020-12-30 00:00:00', '0.00', '5.00', 'Aceptado'),
(2, 2, 3, 'Boleta', '', '1', '2020-12-30 00:00:00', '6.00', '55.00', 'Aceptado');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articulo`
--
ALTER TABLE `articulo`
  ADD PRIMARY KEY (`idarticulo`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  ADD KEY `fk_articulo_categoria_idx` (`idcategoria`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`),
  ADD UNIQUE KEY `nombre_UNIQUE` (`nombre`);

--
-- Indexes for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD PRIMARY KEY (`iddetalle_ingreso`),
  ADD KEY `fk_detalle_ingreso_ingreso_idx` (`idingreso`),
  ADD KEY `fk_detalle_ingreso_articulo_idx` (`idarticulo`);

--
-- Indexes for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD PRIMARY KEY (`iddetalle_venta`),
  ADD KEY `fk_detalle_venta_venta_idx` (`idventa`),
  ADD KEY `fk_detalle_venta_articulo_idx` (`idarticulo`);

--
-- Indexes for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD PRIMARY KEY (`idingreso`),
  ADD KEY `fk_ingreso_persona_idx` (`idproveedor`),
  ADD KEY `fk_ingreso_usuario_idx` (`idusuario`);

--
-- Indexes for table `permiso`
--
ALTER TABLE `permiso`
  ADD PRIMARY KEY (`idpermiso`);

--
-- Indexes for table `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idusuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Indexes for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD PRIMARY KEY (`idusuario_permiso`),
  ADD KEY `fk_usuario_permiso_permiso_idx` (`idpermiso`),
  ADD KEY `fk_usuario_permiso_usuario_idx` (`idusuario`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`idventa`),
  ADD KEY `fk_venta_persona_idx` (`idcliente`),
  ADD KEY `fk_venta_usuario_idx` (`idusuario`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articulo`
--
ALTER TABLE `articulo`
  MODIFY `idarticulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  MODIFY `iddetalle_ingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  MODIFY `iddetalle_venta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ingreso`
--
ALTER TABLE `ingreso`
  MODIFY `idingreso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `permiso`
--
ALTER TABLE `permiso`
  MODIFY `idpermiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idusuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  MODIFY `idusuario_permiso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=140;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `idventa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `articulo`
--
ALTER TABLE `articulo`
  ADD CONSTRAINT `fk_articulo_categoria` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_ingreso`
--
ALTER TABLE `detalle_ingreso`
  ADD CONSTRAINT `fk_detalle_ingreso_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_ingreso_ingreso` FOREIGN KEY (`idingreso`) REFERENCES `ingreso` (`idingreso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `detalle_venta`
--
ALTER TABLE `detalle_venta`
  ADD CONSTRAINT `fk_detalle_venta_articulo` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_detalle_venta_venta` FOREIGN KEY (`idventa`) REFERENCES `venta` (`idventa`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `ingreso`
--
ALTER TABLE `ingreso`
  ADD CONSTRAINT `fk_ingreso_persona` FOREIGN KEY (`idproveedor`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ingreso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `usuario_permiso`
--
ALTER TABLE `usuario_permiso`
  ADD CONSTRAINT `fk_usuario_permiso_permiso` FOREIGN KEY (`idpermiso`) REFERENCES `permiso` (`idpermiso`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_usuario_permiso_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `fk_venta_persona` FOREIGN KEY (`idcliente`) REFERENCES `persona` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_venta_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
