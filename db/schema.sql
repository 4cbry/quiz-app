-- ============================================================
-- QUIZ DE CATEGORÍAS - Base de Datos MySQL
-- Laboratorio ISW3 - 2026-1
-- ============================================================

CREATE DATABASE IF NOT EXISTS quiz_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE quiz_db;

-- ------------------------------------------------------------
-- TABLA: admins  (Módulo Administrativo)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admins (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  usuario     VARCHAR(50)  NOT NULL UNIQUE,
  password    VARCHAR(255) NOT NULL
);

-- Usuario por defecto: admin / admin123
INSERT INTO admins (usuario, password) VALUES ('admin', 'admin123');

-- ------------------------------------------------------------
-- TABLA: preguntas
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS preguntas (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  categoria   VARCHAR(50)  NOT NULL,
  titulo      TEXT         NOT NULL,
  opcion_a    VARCHAR(255) NOT NULL,
  opcion_b    VARCHAR(255) NOT NULL,
  opcion_c    VARCHAR(255) NOT NULL,
  opcion_d    VARCHAR(255) NOT NULL,
  correcta    CHAR(1)      NOT NULL   -- 'a' | 'b' | 'c' | 'd'
);

-- ------------------------------------------------------------
-- TABLA: jugadores  (histórico)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS jugadores (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  nombre        VARCHAR(100) NOT NULL,
  puntaje       INT          NOT NULL DEFAULT 0,
  num_preguntas INT          NOT NULL DEFAULT 0,
  jugado_en     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- DATOS INICIALES - 30 Preguntas (5 por categoría)
-- ============================================================
INSERT INTO preguntas (categoria, titulo, opcion_a, opcion_b, opcion_c, opcion_d, correcta) VALUES
-- General
('general','¿Cuál es el planeta más grande de nuestro sistema solar?','Tierra','Marte','Jupiter','Saturno','c'),
('general','¿Quién escribió "Cien años de soledad"?','Gabriel García Márquez','Julio Cortázar','Isabel Allende','Mario Vargas Llosa','a'),
('general','¿Cuál es el río más largo del mundo?','Amazonas','Nilo','Paraná','Misisipi','b'),
('general','¿Cuál es el componente principal del aire que respiramos?','Nitrógeno','Oxígeno','Dióxido de carbono','Hidrógeno','a'),
('general','¿En qué año comenzó la Primera Guerra Mundial?','1905','1914','1923','1939','b'),
-- Música
('musica','¿Quién es conocido como el Rey del Pop?','Elvis Presley','Michael Jackson','Madonna','Prince','b'),
('musica','¿Cuál es el género musical más popular en todo el mundo?','Rock','Electrónica','Rap','Pop','d'),
('musica','¿En qué década surgió el movimiento punk?','1960','1970','1980','1990','b'),
('musica','¿Quién es el guitarrista de la banda Queen?','John Lennon','Jimi Hendrix','Brian May','Eric Clapton','c'),
('musica','¿Cuál es el instrumento principal en una orquesta sinfónica?','Guitarra','Piano','Violín','Flauta','c'),
-- Deportes
('deportes','¿En qué deporte se utiliza una pelota de baloncesto?','Fútbol','Baloncesto','Golf','Tenis','b'),
('deportes','¿Cuál es el país de origen de la tenista Serena Williams?','Estados Unidos','Francia','España','Australia','a'),
('deportes','¿Cuántos jugadores conforman un equipo de fútbol en el campo?','8','10','11','12','c'),
('deportes','¿Quién es considerado el mejor nadador de todos los tiempos?','Michael Phelps','Usain Bolt','Simone Biles','Roger Federer','a'),
('deportes','¿En qué deporte se compite por la Copa Davis?','Fútbol','Tenis','Golf','Balonmano','b'),
-- Programación
('programacion','¿Cuál de los siguientes lenguajes es de tipado fuerte?','JavaScript','Python','C++','Java','c'),
('programacion','¿Qué significa HTML en desarrollo web?','HyperText Markup Language','High-Level Text Management Language','HyperTransfer Markup Language','High-Level Transfer Management Language','a'),
('programacion','¿Cuál es el propósito principal de CSS en desarrollo web?','Manejar la lógica del servidor','Estilizar la presentación de páginas web','Gestionar la interactividad del usuario','Definir las rutas de la aplicación','b'),
('programacion','¿Qué es un bucle "for" en programación?','Un tipo de dato','Una estructura condicional','Una función','Una estructura de control de flujo que se repite','d'),
('programacion','¿Cuál de los siguientes NO es un sistema de gestión de BD?','MySQL','MongoDB','Express','SQLite','c'),
-- Video Juegos
('juegos','¿Cuál es el fontanero más famoso en los videojuegos?','Sonic','Link','Mario','Master Chief','c'),
('juegos','¿En qué año se lanzó "The Legend of Zelda: Ocarina of Time"?','1996','1998','2000','2002','b'),
('juegos','¿Cuál es la empresa creadora de la consola PlayStation?','Microsoft','Sony','Nintendo','Sega','b'),
('juegos','¿Quién es el protagonista de "The Witcher 3: Wild Hunt"?','Geralt of Rivia','Ezio Auditore','Aloy','Joel','a'),
('juegos','¿Cuál es el juego más vendido de todos los tiempos?','Minecraft','Tetris','Grand Theft Auto V','Super Mario Bros.','b'),
-- Películas
('peliculas','¿Cuál es el nombre del león protagonista en "El Rey León"?','Simba','Mufasa','Scar','Timón','a'),
('peliculas','¿Qué juguete es el protagonista de "Toy Story"?','Buzz Lightyear','Woody','Slinky','Mr. Potato Head','b'),
('peliculas','¿En qué película de Disney una sirena sueña con vivir en tierra?','Cenicienta','La Sirenita','Blancanieves','Mulan','b'),
('peliculas','¿Quién es el monstruo protagonista en "Monsters, Inc."?','Sulley','Mike Wazowski','Randall','Boo','a'),
('peliculas','¿Cuál es la película de Pixar sobre emociones en la mente de una niña?','Inside Out','Finding Nemo','Up','Ratatouille','a');
