

CREATE DATABASE IF NOT EXISTS quiz_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE quiz_db;

CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);


INSERT INTO admins (usuario, password) VALUES ('admin', 'admin123')

CREATE TABLE IF NOT EXISTS preguntas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria VARCHAR(50) NOT NULL,
    titulo TEXT NOT NULL,
    opcion_a VARCHAR(255) NOT NULL,
    opcion_b VARCHAR(255) NOT NULL,
    opcion_c VARCHAR(255) NOT NULL,
    opcion_d VARCHAR(255) NOT NULL,
    correcta CHAR(1) NOT NULL -- 'a' | 'b' | 'c' | 'd'
);

CREATE TABLE IF NOT EXISTS jugadores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puntaje INT NOT NULL DEFAULT 0,
    num_preguntas INT NOT NULL DEFAULT 0,
    jugado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO
    preguntas (
        categoria,
        titulo,
        opcion_a,
        opcion_b,
        opcion_c,
        opcion_d,
        correcta
    )
VALUES
    -- General
    (
        'general',
        '¿Cuál es el planeta más grande de nuestro sistema solar?',
        'Tierra',
        'Marte',
        'Jupiter',
        'Saturno',
        'c'
    ),
    (
        'general',
        '¿Quién escribió "Cien años de soledad"?',
        'Gabriel García Márquez',
        'Julio Cortázar',
        'Isabel Allende',
        'Mario Vargas Llosa',
        'a'
    ),
    (
        'general',
        '¿Cuál es el río más largo del mundo?',
        'Amazonas',
        'Nilo',
        'Paraná',
        'Misisipi',
        'b'
    ),
    (
        'general',
        '¿Cuál es el componente principal del aire que respiramos?',
        'Nitrógeno',
        'Oxígeno',
        'Dióxido de carbono',
        'Hidrógeno',
        'a'
    ),
    (
        'general',
        '¿En qué año comenzó la Primera Guerra Mundial?',
        '1905',
        '1914',
        '1923',
        '1939',
        'b'
    ),
    -- Música
    (
        'musica',
        '¿Quién es conocido como el Rey del Pop?',
        'Elvis Presley',
        'Michael Jackson',
        'Madonna',
        'Prince',
        'b'
    ),
    (
        'musica',
        '¿Cuál es el género musical más popular en todo el mundo?',
        'Rock',
        'Electrónica',
        'Rap',
        'Pop',
        'd'
    ),
    (
        'musica',
        '¿En qué década surgió el movimiento punk?',
        '1960',
        '1970',
        '1980',
        '1990',
        'b'
    ),
    (
        'musica',
        '¿Quién es el guitarrista de la banda Queen?',
        'John Lennon',
        'Jimi Hendrix',
        'Brian May',
        'Eric Clapton',
        'c'
    ),
    (
        'musica',
        '¿Cuál es el instrumento principal en una orquesta sinfónica?',
        'Guitarra',
        'Piano',
        'Violín',
        'Flauta',
        'c'
    ),
    -- Deportes
    (
        'deportes',
        '¿En qué deporte se utiliza una pelota de baloncesto?',
        'Fútbol',
        'Baloncesto',
        'Golf',
        'Tenis',
        'b'
    ),
    (
        'deportes',
        '¿Cuál es el país de origen de la tenista Serena Williams?',
        'Estados Unidos',
        'Francia',
        'España',
        'Australia',
        'a'
    ),
    (
        'deportes',
        '¿Cuántos jugadores conforman un equipo de fútbol en el campo?',
        '8',
        '10',
        '11',
        '12',
        'c'
    ),
    (
        'deportes',
        '¿Quién es considerado el mejor nadador de todos los tiempos?',
        'Michael Phelps',
        'Usain Bolt',
        'Simone Biles',
        'Roger Federer',
        'a'
    ),
    (
        'deportes',
        '¿En qué deporte se compite por la Copa Davis?',
        'Fútbol',
        'Tenis',
        'Golf',
        'Balonmano',
        'b'
    ),
    -- Programación
    (
        'programacion',
        '¿Cuál de los siguientes lenguajes es de tipado fuerte?',
        'JavaScript',
        'Python',
        'C++',
        'Java',
        'c'
    ),
    (
        'programacion',
        '¿Qué significa HTML en desarrollo web?',
        'HyperText Markup Language',
        'High-Level Text Management Language',
        'HyperTransfer Markup Language',
        'High-Level Transfer Management Language',
        'a'
    ),
    (
        'programacion',
        '¿Cuál es el propósito principal de CSS en desarrollo web?',
        'Manejar la lógica del servidor',
        'Estilizar la presentación de páginas web',
        'Gestionar la interactividad del usuario',
        'Definir las rutas de la aplicación',
        'b'
    ),
    (
        'programacion',
        '¿Qué es un bucle "for" en programación?',
        'Un tipo de dato',
        'Una estructura condicional',
        'Una función',
        'Una estructura de control de flujo que se repite',
        'd'
    ),
    (
        'programacion',
        '¿Cuál de los siguientes NO es un sistema de gestión de BD?',
        'MySQL',
        'MongoDB',
        'Express',
        'SQLite',
        'c'
    ),
    -- Video Juegos
    (
        'juegos',
        '¿Cuál es el fontanero más famoso en los videojuegos?',
        'Sonic',
        'Link',
        'Mario',
        'Master Chief',
        'c'
    ),
    (
        'juegos',
        '¿En qué año se lanzó "The Legend of Zelda: Ocarina of Time"?',
        '1996',
        '1998',
        '2000',
        '2002',
        'b'
    ),
    (
        'juegos',
        '¿Cuál es la empresa creadora de la consola PlayStation?',
        'Microsoft',
        'Sony',
        'Nintendo',
        'Sega',
        'b'
    ),
    (
        'juegos',
        '¿Quién es el protagonista de "The Witcher 3: Wild Hunt"?',
        'Geralt of Rivia',
        'Ezio Auditore',
        'Aloy',
        'Joel',
        'a'
    ),
    (
        'juegos',
        '¿Cuál es el juego más vendido de todos los tiempos?',
        'Minecraft',
        'Tetris',
        'Grand Theft Auto V',
        'Super Mario Bros.',
        'b'
    ),
    -- Películas
    (
        'peliculas',
        '¿Cuál es el nombre del león protagonista en "El Rey León"?',
        'Simba',
        'Mufasa',
        'Scar',
        'Timón',
        'a'
    ),
    (
        'peliculas',
        '¿Qué juguete es el protagonista de "Toy Story"?',
        'Buzz Lightyear',
        'Woody',
        'Slinky',
        'Mr. Potato Head',
        'b'
    ),
    (
        'peliculas',
        '¿En qué película de Disney una sirena sueña con vivir en tierra?',
        'Cenicienta',
        'La Sirenita',
        'Blancanieves',
        'Mulan',
        'b'
    ),
    (
        'peliculas',
        '¿Quién es el monstruo protagonista en "Monsters, Inc."?',
        'Sulley',
        'Mike Wazowski',
        'Randall',
        'Boo',
        'a'
    ),
    (
        'peliculas',
        '¿Cuál es la película de Pixar sobre emociones en la mente de una niña?',
        'Inside Out',
        'Finding Nemo',
        'Up',
        'Ratatouille',
        'a'
    );

INSERT INTO preguntas (categoria, titulo, opcion_a, opcion_b, opcion_c, opcion_d, correcta) VALUES
('general','¿Cuál es el país más grande del mundo por superficie?','China','Rusia','Canadá','Estados Unidos','b'),
('general','¿Cuántos huesos tiene el cuerpo humano adulto?','206','208','212','200','a'),
('general','¿Cuál es el océano más grande del mundo?','Atlántico','Índico','Ártico','Pacífico','d'),
('general','¿En qué año llegó el hombre a la Luna?','1965','1969','1972','1968','b'),
('general','¿Cuál es el elemento químico más abundante en el universo?','Oxígeno','Helio','Hidrógeno','Nitrógeno','c'),
('general','¿Qué país tiene más habitantes en el mundo?','India','China','Estados Unidos','Indonesia','a'),
('general','¿Cuántos continentes hay en el mundo?','5','6','7','8','c'),
('general','¿Cuál es la capital de Australia?','Sídney','Melbourne','Brisbane','Canberra','d'),
('general','¿Qué planeta está más cerca del Sol?','Venus','Mercurio','Tierra','Marte','b'),
('general','¿Cuántos lados tiene un hexágono?','5','7','8','6','d'),
('general','¿Qué animal es el más rápido del mundo?','León','Guepardo','Halcón peregrino','Águila','c'),
('general','¿En qué país se inventó el papel?','Egipto','Grecia','China','India','c'),
('general','¿Cuál es el metal más caro del mundo?','Platino','Oro','Rodio','Paladio','c'),
('general','¿Qué es la fotosíntesis?','Proceso de reproducción vegetal','Proceso de obtención de energía solar en plantas','Tipo de nutrición animal','Proceso de respiración celular','b'),
('general','¿Cuántos planetas tiene el sistema solar?','7','8','9','10','b'),
('general','¿Cuál es el idioma más hablado en el mundo?','Español','Inglés','Mandarín','Hindi','c'),
('general','¿Dónde se celebraron los primeros Juegos Olímpicos modernos?','Roma','París','Londres','Atenas','d'),
('general','¿Cuánto dura un año bisiesto?','364 días','365 días','366 días','367 días','c'),
('general','¿Qué instrumento mide la temperatura?','Barómetro','Termómetro','Higrómetro','Anemómetro','b'),
('general','¿Cuál es el desierto más grande del mundo?','Gobi','Sahara','Antártico','Arábigo','c'),
('general','¿Quién pintó la Mona Lisa?','Miguel Ángel','Rafael','Leonardo da Vinci','Botticelli','c'),
('general','¿Cuál es el hueso más largo del cuerpo humano?','Tibia','Húmero','Peroné','Fémur','d'),
('general','¿En qué continente está Egipto?','Asia','Europa','África','Oceanía','c'),
('general','¿Cuántos colores tiene el arcoíris?','5','6','7','8','c'),
('general','¿Qué velocidad tiene la luz aproximadamente?','100,000 km/s','200,000 km/s','300,000 km/s','400,000 km/s','c'),


('musica','¿Cuántas cuerdas tiene una guitarra estándar?','4','5','6','7','c'),
('musica','¿Quién compuso la Quinta Sinfonía?','Mozart','Bach','Beethoven','Chopin','c'),
('musica','¿De qué país es originario el reggae?','Brasil','Cuba','Trinidad','Jamaica','d'),
('musica','¿Cómo se llama la cantante de "Bad Guy"?','Ariana Grande','Billie Eilish','Dua Lipa','Olivia Rodrigo','b'),
('musica','¿Qué banda lanzó el álbum "Dark Side of the Moon"?','Led Zeppelin','The Rolling Stones','Pink Floyd','The Doors','c'),
('musica','¿Cuántas notas tiene la escala musical?','5','6','7','8','c'),
('musica','¿Qué instrumento toca Yo-Yo Ma?','Violín','Viola','Contrabajo','Cello','d'),
('musica','¿Cómo se llama el padre del pop latino Carlos Santana?','Él mismo','Su hijo','No tiene relación','Es el mismo artista','d'),
('musica','¿Qué banda es de Liverpool, Inglaterra?','The Rolling Stones','The Beatles','Led Zeppelin','Coldplay','b'),
('musica','¿Quién es conocido como "El Rey" del rock and roll?','Chuck Berry','Jerry Lee Lewis','Elvis Presley','Little Richard','c'),
('musica','¿Qué significa BPM en música?','Best Popular Music','Beats Por Minuto','Bass Progression Mode','Band Play Music','b'),
('musica','¿De qué país es Shakira?','Argentina','Venezuela','Colombia','México','c'),
('musica','¿Qué instrumento es el piano?','Instrumento de viento','Instrumento de cuerda percutida','Instrumento de percusión','Instrumento de viento madera','b'),
('musica','¿Quién compuso "Las Cuatro Estaciones"?','Bach','Handel','Vivaldi','Scarlatti','c'),
('musica','¿Cómo se llama el festival de música más famoso de Reino Unido?','Coachella','Lollapalooza','Glastonbury','Tomorrowland','c'),
('musica','¿Qué banda grabó "Bohemian Rhapsody"?','The Who','Queen','David Bowie','Elton John','b'),
('musica','¿Cuántos miembros tenía ABBA?','2','3','4','5','c'),
('musica','¿De qué país es Coldplay?','Estados Unidos','Australia','Canadá','Reino Unido','d'),
('musica','¿Qué artista lanzó el álbum "Thriller"?','Prince','Michael Jackson','Stevie Wonder','James Brown','b'),
('musica','¿Qué significa forte en música?','Suave','Rápido','Fuerte','Lento','c'),
('musica','¿Cuántas teclas tiene un piano estándar?','76','85','88','92','c'),
('musica','¿Quién es la artista más premiada en la historia de los Grammy?','Beyoncé','Taylor Swift','Adele','Whitney Houston','b'),
('musica','¿Qué banda lanzó "Smells Like Teen Spirit"?','Pearl Jam','Soundgarden','Alice in Chains','Nirvana','d'),
('musica','¿De qué país es el género musical K-pop?','Japón','Corea del Sur','China','Tailandia','b'),
('musica','¿Qué instrumento es la trompeta?','Cuerda','Percusión','Viento madera','Viento metal','d'),

('deportes','¿Cuánto dura un partido de fútbol regular?','80 minutos','90 minutos','100 minutos','120 minutos','b'),
('deportes','¿En qué deporte se usa un birdie?','Tenis','Bádminton','Golf','Squash','c'),
('deportes','¿Cuántos jugadores hay en un equipo de voleibol?','5','6','7','8','b'),
('deportes','¿Qué país ha ganado más copas mundiales de fútbol?','Alemania','Italia','Argentina','Brasil','d'),
('deportes','¿En qué ciudad se celebraron los Juegos Olímpicos de 2016?','Londres','Tokio','Río de Janeiro','Atenas','c'),
('deportes','¿Cuántos sets se juegan en un partido de tenis Grand Slam masculino?','3','5','7','4','b'),
('deportes','¿Qué país inventó el béisbol?','Cuba','Japón','Estados Unidos','República Dominicana','c'),
('deportes','¿Cuánto mide una piscina olímpica?','45 metros','50 metros','55 metros','60 metros','b'),
('deportes','¿En qué deporte se usa el término "strike"?','Bolos','Béisbol','Ambos son correctos','Críquet','c'),
('deportes','¿Cuántos jugadores hay en un equipo de rugby union?','13','14','15','16','c'),
('deportes','¿En qué año se fundó la FIFA?','1900','1904','1910','1920','b'),
('deportes','¿Qué altura tiene un aro de baloncesto NBA?','2.90 m','3.05 m','3.10 m','3.20 m','b'),
('deportes','¿Qué deporte practica Roger Federer?','Golf','Tenis','Squash','Bádminton','b'),
('deportes','¿En cuántos metros corre Usain Bolt su récord de 100m?','9.57','9.58','9.60','9.63','b'),
('deportes','¿Qué país tiene más medallas olímpicas en la historia?','Rusia','China','Alemania','Estados Unidos','d'),
('deportes','¿Cuántos puntos vale un touchdown en el fútbol americano?','3','5','6','7','c'),
('deportes','¿En qué deporte se compite en el Tour de France?','Triatlón','Running','Ciclismo','Natación','c'),
('deportes','¿Qué significa F1 en el automovilismo?','Fast One','Formula 1','First League','Final Race','b'),
('deportes','¿Cuántos hoyos tiene un campo de golf estándar?','9','12','16','18','d'),
('deportes','¿En qué deporte se usa el término "jaque mate"?','Damas','Ajedrez','Go','Backgammon','b'),
('deportes','¿Qué selección ganó la Copa del Mundo 2022?','Francia','Brasil','Argentina','Croacia','c'),
('deportes','¿Cuántas ruedas tiene un auto de Fórmula 1?','4','6','8','3','a'),
('deportes','¿Qué deporte se juega en Wimbledon?','Bádminton','Squash','Tenis','Pádel','c'),
('deportes','¿Cuánto pesa una pelota de tenis estándar?','55 g','58 g','63 g','67 g','b'),
('deportes','¿En qué deporte se puede hacer un "slam dunk"?','Voleibol','Baloncesto','Balonmano','Rugby','b'),


('programacion','¿Qué significa IDE en programación?','Internet Developer Environment','Integrated Development Environment','Internal Design Engine','Interface Design Editor','b'),
('programacion','¿Cuál es el símbolo de comentario de una línea en Python?','//','/*','#','--','c'),
('programacion','¿Qué lenguaje creó Linus Torvalds para el kernel Linux?','C++','Java','C','Python','c'),
('programacion','¿Qué significa API?','Application Programming Interface','Automated Process Integration','Advanced Programming Index','Application Protocol Interface','a'),
('programacion','¿Cuál es el lenguaje base de la web?','CSS','JavaScript','HTML','PHP','c'),
('programacion','¿Qué hace el comando "git commit"?','Sube cambios al servidor','Guarda cambios en el repositorio local','Crea una nueva rama','Descarga cambios remotos','b'),
('programacion','¿Qué es un algoritmo?','Un lenguaje de programación','Un tipo de base de datos','Una secuencia de pasos para resolver un problema','Un editor de código','c'),
('programacion','¿Qué significa SQL?','Structured Query Language','Simple Query Logic','System Query Language','Standard Query List','a'),
('programacion','¿Cuál es la extensión de un archivo JavaScript?','.java','.jscript','.js','.jvs','c'),
('programacion','¿Qué es un array?','Una función','Una colección ordenada de elementos','Un tipo de bucle','Un operador lógico','b'),
('programacion','¿Qué hace la función console.log() en JavaScript?','Guarda datos','Muestra datos en consola','Borra la consola','Crea un error','b'),
('programacion','¿Qué significa HTTP?','HyperText Transfer Protocol','High Text Transfer Process','HyperText Technical Protocol','Home Transfer Text Protocol','a'),
('programacion','¿Qué es OOP?','Object Oriented Programming','Open Operation Process','Output Object Protocol','Optional Operation Parameter','a'),
('programacion','¿Cuál es la base del sistema binario?','8','10','2','16','c'),
('programacion','¿Qué lenguaje se usa principalmente para ciencia de datos?','Java','C#','Ruby','Python','d'),
('programacion','¿Qué es un bug en programación?','Una característica nueva','Un tipo de variable','Un error en el código','Un método de clase','c'),
('programacion','¿Qué significa CSS?','Cascading Style Sheets','Computer Style Syntax','Creative Style System','Code Style Script','a'),
('programacion','¿Cuál de estos es un framework de JavaScript?','Django','Laravel','React','Ruby on Rails','c'),
('programacion','¿Qué es la recursión?','Una función que llama a otra función','Una función que se llama a sí misma','Un tipo de bucle for','Un método de ordenamiento','b'),
('programacion','¿Qué significa RAM?','Random Access Memory','Read And Modify','Rapid Action Memory','Remote Access Module','a'),
('programacion','¿Cuál es la extensión de archivo Python?','.pt','.pyt','.py','.python','c'),
('programacion','¿Qué es Git?','Un lenguaje de programación','Un sistema de control de versiones','Un editor de código','Un servidor web','b'),
('programacion','¿Qué significa URL?','Unique Resource Location','Universal Resource Locator','Uniform Resource Locator','United Reference Link','c'),
('programacion','¿Qué operador se usa para la comparación estricta en JavaScript?','==','!=','===','!==','c'),
('programacion','¿Qué es JSON?','Java Script Object Notation','JavaScript Source Object Name','Java Simple Object Notation','JavaScript String Option Name','a'),


('juegos','¿En qué año se lanzó el primer videojuego Pokémon?','1994','1996','1998','2000','b'),
('juegos','¿Qué consola lanzó Nintendo en 2017?','Wii U','3DS','Switch','GameBoy Advance','c'),
('juegos','¿Cómo se llama la princesa que rescata Mario?','Rosalinda','Daisy','Paulina','Peach','d'),
('juegos','¿Qué significa RPG en videojuegos?','Rapid Play Game','Role Playing Game','Real Player Gaming','Retro Play Game','b'),
('juegos','¿En qué año se lanzó Minecraft?','2008','2009','2011','2013','c'),
('juegos','¿Qué empresa creó Halo?','Epic Games','Bungie','Naughty Dog','Rockstar','b'),
('juegos','¿Cuántos personajes iniciales tiene Super Smash Bros Ultimate?','68','72','74','76','c'),
('juegos','¿Qué juego popularizó el Battle Royale?','PUBG','Fortnite','Apex Legends','Warzone','b'),
('juegos','¿De qué franquicia es el personaje Master Chief?','Gears of War','Destiny','Halo','Call of Duty','c'),
('juegos','¿Qué empresa creó el videojuego GTA?','Ubisoft','Rockstar Games','EA Games','Activision','b'),
('juegos','¿Cuántas generaciones de Pokémon existen hasta 2023?','7','8','9','10','c'),
('juegos','¿Qué videojuego tiene el lema "Stay a while and listen"?','World of Warcraft','Diablo','Starcraft','Warcraft','b'),
('juegos','¿En qué año se lanzó el primer Call of Duty?','2001','2003','2005','2007','b'),
('juegos','¿Qué personaje es Link en The Legend of Zelda?','El mago','El villano','El héroe','El rey','c'),
('juegos','¿Qué consola vendió más en la historia?','Wii','Game Boy','PlayStation 2','Nintendo DS','c'),
('juegos','¿Qué juego tiene el personaje Kratos?','Assassin´s Creed','God of War','Devil May Cry','Dante´s Inferno','b'),
('juegos','¿Qué empresa creó Fortnite?','Valve','Epic Games','Blizzard','Riot Games','b'),
('juegos','¿Cuántos jugadores puede tener una partida de Among Us?','8','10','12','15','b'),
('juegos','¿Qué mundo es el primero en Super Mario Bros?','Mundo 1','Mundo Hongo','Mundo Seta','Piso 1-1','a'),
('juegos','¿Qué juego presentó a Solid Snake?','Splinter Cell','Hitman','Metal Gear','Deus Ex','c'),
('juegos','¿Qué empresa creó Pac-Man?','Nintendo','Atari','Namco','Sega','c'),
('juegos','¿En qué año se lanzó el primer FIFA?','1991','1993','1995','1997','b'),
('juegos','¿Qué personaje famoso es un detective en L.A. Noire?','Max Payne','Cole Phelps','John Marston','Arthur Morgan','b'),
('juegos','¿Qué juego tiene el modo "Survival" más famoso?','Terraria','Minecraft','Subnautica','The Long Dark','b'),
('juegos','¿Quién es el creador de Minecraft?','Gabe Newell','Markus Persson','Shigeru Miyamoto','Todd Howard','b'),


('peliculas','¿Quién dirigió Titanic?','Steven Spielberg','Christopher Nolan','James Cameron','Ridley Scott','c'),
('peliculas','¿En qué año se estrenó Star Wars: Una Nueva Esperanza?','1975','1977','1979','1980','b'),
('peliculas','¿Qué actor interpreta a Iron Man?','Chris Evans','Chris Hemsworth','Mark Ruffalo','Robert Downey Jr.','d'),
('peliculas','¿Cuál es la película más taquillera de la historia?','Avengers: Endgame','Avatar','Titanic','Star Wars','b'),
('peliculas','¿En qué ciudad transcurre Batman de Tim Burton?','Metrópolis','Star City','Ciudad Central','Ciudad Gótica','d'),
('peliculas','¿Quién interpreta a Hermione en Harry Potter?','Bonnie Wright','Emma Watson','Helena Bonham Carter','Evanna Lynch','b'),
('peliculas','¿Cuántas películas tiene la saga de El Señor de los Anillos original?','2','3','4','6','b'),
('peliculas','¿Qué animal es Dumbo?','Ratón','Conejo','Elefante','Ciervo','c'),
('peliculas','¿Quién es el villano principal de El Rey León?','Timón','Pumba','Scar','Shenzi','c'),
('peliculas','¿En qué película aparece el robot WALL-E?','Robots','Megamente','Ratatouille','WALL-E','d'),
('peliculas','¿Qué director hizo El Padrino?','Martin Scorsese','Brian De Palma','Sidney Lumet','Francis Ford Coppola','d'),
('peliculas','¿Cuántos oscars ganó Titanic?','9','11','12','14','b'),
('peliculas','¿Qué actor es Jack Sparrow en Piratas del Caribe?','Orlando Bloom','Keira Knightley','Johnny Depp','Geoffrey Rush','c'),
('peliculas','¿En qué año se estrenó El Padrino?','1970','1972','1974','1976','b'),
('peliculas','¿Qué es Interstellar?','Una película de terror','Una película de comedia','Una película de ciencia ficción','Una película de acción','c'),
('peliculas','¿Quién interpreta a Thor en el Universo Cinematográfico Marvel?','Chris Evans','Chris Pratt','Chris Hemsworth','Chris Pine','c'),
('peliculas','¿En qué película un niño ve personas muertas sin saberlo?','El Resplandor','El Sexto Sentido','Insidious','Poltergeist','b'),
('peliculas','¿Cuántas películas tiene la saga original de Indiana Jones?','3','4','5','6','b'),
('peliculas','¿Quién es el creador de Mickey Mouse?','Walt Disney','Ub Iwerks','Ambos lo crearon juntos','Roy Disney','c'),
('peliculas','¿De qué trata Matrix?','Viajes en el tiempo','Realidad virtual que esclaviza a la humanidad','Invasión alienígena','Apocalipsis nuclear','b'),
('peliculas','¿En qué país se desarrolla la historia de Kung Fu Panda?','Japón','China','Corea','Vietnam','b'),
('peliculas','¿Qué película tiene el personaje de Forrest Gump?','Cast Away','Forrest Gump','Philadelphia','The Green Mile','b'),
('peliculas','¿Quién interpreta a Joker en la película de 2019?','Jared Leto','Heath Ledger','Joaquin Phoenix','Jack Nicholson','c'),
('peliculas','¿Cuántas películas tiene el MCU hasta Endgame?','20','21','22','23','d'),
('peliculas','¿En qué película Dory dice "Sigue nadando"?','Buscando a Nemo','Buscando a Dory','Ambas','Ni una','c');
