-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 15-01-2015 a las 13:30:48
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;


-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consultapaciente`
--

CREATE TABLE IF NOT EXISTS `consultapaciente` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `idPaciente` int(11) NOT NULL,
  `dia` int(11) NOT NULL,
  `estadoDeAnimo` int(11) NOT NULL,
  `pregunta_1` int(11) NOT NULL,
  `pregunta_2` int(11) NOT NULL,
  `pregunta_3` int(11) NOT NULL,
  `pregunta_4` int(11) NOT NULL,
  `pregunta_5` int(11) NOT NULL,
  `totalPreguntas` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `consultapaciente`
--

INSERT INTO `consultapaciente` (`ID`, `idPaciente`, `dia`, `estadoDeAnimo`, `pregunta_1`, `pregunta_2`, `pregunta_3`, `pregunta_4`, `pregunta_5`, `totalPreguntas`) VALUES
(1, 1231344, 0, 1, 4, 3, 3, 4, 5, 19),
(2, 456789, 0, 1, 1, 5, 4, 4, 3, 17),
(3, 12345, 0, 1, 5, 5, 5, 5, 5, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE IF NOT EXISTS `paciente` (
  `ID` int(11) NOT NULL,
  `nombre` varchar(15) COLLATE utf8_spanish2_ci NOT NULL,
  `apellido` varchar(10) COLLATE utf8_spanish2_ci NOT NULL,
  `password` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`ID`, `nombre`, `apellido`, `password`) VALUES
(12345, 'alejandro', 'lopez', 'abc'),
(34567, 'tumadre', 'horjuela', '7890'),
(127890, 'vanessa', 'figueroa', '098'),
(321456, 'ricardo', 'lozano', '321'),
(456789, 'leandro', 'rengifo', '4567'),
(654321, 'vanessa', 'rodriguez', '098'),
(1231344, 'juan camilo', 'loaiza mar', '123');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
