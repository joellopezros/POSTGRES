/*Aquest és el projecte de Bases de Dades de Joel López Ros.

Enunciat 3. -Les bandes musicals estan formades per un conjunt de músics. Els músics componen cançons que
s’inclouen en àlbums discogràfics produïts per companyies discogràfiques. Les cançons tenen un nom i
la durada (en minuts). Les bandes tenen un nom, un estil, un país i una biografia. Els músics tenen un
nom, sexe, edat i el nom dels instruments que toquen. Els àlbums tenen un nom, any d’edició, i el
número de cançons que contenen.

Seguidament deixarè tot el contingut de creació de les taules etc. 
Avís: Aquest enunciat ha sigut modificat deixant fora a la clase Discogràfiques.*/


/*CREACIÓ DE L'ESQUEMA DE BASES DE DADES OBJECTE - RELACIONAL I INSERCIÓ DE DADES*/

    \! echo 1. En primer lloc borrem si existeix una BBDD que sanomena igual, després la creem i al finalitzar la he conectada per utilitzar-la. 
    DROP DATABASE IF EXISTS GruposMusicales;
    CREATE DATABASE GruposMusicales;
    \c gruposmusicales;

/*DDL*/
    /*Creació de Tipus*/
    \! echo Creació de Tipus.
    CREATE TYPE Sexo_Musico AS ENUM('Mujer', 'Hombre', 'Otros');
    CREATE TYPE TEstilo AS ENUM('Rock', 'Pop', 'Flamenco', 'Rap', 'Latino', 'Heavy Metal', 'Lírico');
    CREATE TYPE Instrumento AS ENUM('Piano', 'Guitarra', 'Bateria', 'Flauta', 'Saxofon', 'Violin', 'Triangulo','Guitarra Eléctrica', 'Tambor', 'Maracas');
    CREATE TYPE TCancion AS (
        Id_Cancion int,
        Id_Album int,
        Nombre_Cancion varchar(200),
        Duracion float,
        Anyo_Lanzamiento int
    );

    CREATE TYPE TBandas AS (
        Id_Banda int,
        Nombre_banda varchar(200),
        Estilo TEstilo,
        Pais varchar(50),
        Biografia text
    );
    
    CREATE TYPE TAlbum AS (
        Id_Album int,
        Nombre_album varchar(100),
        Anyo_Edicion int,
        Numero_Canciones int
    );
    \! echo Creados correctamente.

    /*Creación de Dominio, en este caso diremos que el dominio del correo de la persona sea "@musicos.com"*/
    \! echo Creación de Dominio, en este caso diremos que el dominio del correo de la persona sea "@musicos.com".
    CREATE DOMAIN Correo AS varchar(200) CHECK (VALUE LIKE '%@musicos.com');

    /*Creación de las Tablas */
    \! echo Creación tabla Persona para herenciarla con Musicos.
    CREATE TABLE Persona (
        DNI varchar(9),
        Nombre varchar(80),
        Edad int,
        Telefono int,
        Correo_Elec Correo,
        Sexo Sexo_Musico
    );

    \! echo Creación tabla Bandas.
    CREATE TABLE Bandas OF TBandas (
        primary key (Id_Banda)
    );

    \! echo Creación tabla Album.
    CREATE TABLE Album OF TAlbum(
        primary key (Id_Album)
    );

    \! echo Creación tabla Canciones.
    CREATE TABLE Canciones OF TCancion (
        primary key(Id_Cancion),
        foreign key (Id_Album) references Album (Id_Album) on delete cascade on update cascade
    );

    \! echo Creación tabla Musicos.
    CREATE TABLE Musicos (
        Id_Musico int primary key not null,
        Id_Cancion int,
        Id_Banda int,
        Nombre_Instrumento Instrumento [],
        foreign key (Id_Banda) references Bandas(Id_Banda) on delete cascade on update cascade,
        foreign key (Id_Cancion) references Canciones(Id_Cancion) on delete cascade on update cascade
    ) INHERITS (Persona);

    

    

    /*Inserts per la taula Bandas*/
    \! echo Creación INSERTS Bandas.
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(101, 'Guns N Roses', 'Rock', 'Estados Unidos', 'Grupo de Rock que ha sido uno de los grandes de la historia, muy conocidos por su canción Welcome To The Jungle.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(102, 'Banda de Melendi', 'Pop', 'España', 'Banda muy conocida en España por su canción "Caminando por la vida".');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(103, 'Banda David Bisbal', 'Pop', 'España', 'Bisbal y su banda, más conocidos por el Ave María y por su famoso baile que dio la vuelta al mundo.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(104, 'Banda Bustamante', 'Pop', 'España', 'Banda musical que lo petó con la canción Dos Hombres y un Destino con Alex.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(105, 'Banda El Barrio', 'Flamenco', 'España', 'Banda de arte callejero flamenco que ha dado la vuelta al mundo con canciones como "Nos fuimos pa Madrid".');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(106, 'Banda Lady Gaga', 'Pop', 'Reino Unido', 'Una banda que dio un boom muy grande con Poker Face, y que recientemente participó en la película "Ha Nacida una Estrella".');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(107, 'Banda Queen', 'Rock', 'Reino Unido', 'Uno de las mayores bandas de la historia que robó el corazon con Bohemian Rapsody hasta su último adiós con Show Must GO On.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(108, 'Banda Maneskin', 'Heavy Metal', 'Italia', 'Banda ganadora de Eurovision 2021 con un temazo llamado Zitti E Buonni.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(109, 'Banda Blas Canto', 'Pop', 'España', 'Banda representante de España en Eurovision 2021 con resultado nefasto pero con una gran actuación.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(110, 'Banda Rosario Flores', 'Flamenco', 'España', 'Banda con la Coach favorita de los niños en La Voz Kids.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(111, 'Banda Steve Aoki', 'Latino', 'Japones', 'Steve y su banda, sin duda uno de los grandes referentes del electro latino de la ultima decada.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(112, 'Banda Beret', 'Rap', 'España', 'Beret y sus guitarristas consiguen un rap profundo capaz de tocar el corazón más sensible de la gente.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(113, 'Banda Springsteen', 'Rock', 'Estados Unidos', 'Leyenda con Born In The USA');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(114, 'Banda Michael Jackson', 'Pop', 'Estados Unidos', 'Michael y su banda de pop que lo llevaron a ser el Rey Del Pop de toda la historia.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(115, 'Banda Steve Wonder', 'Lírico', 'Estados Unidos', 'Steve y su banda dieron un ejemplo al mundo de que no se necesitan todos los sentidos para tocar corazones.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(116, 'Banda Gloria Stefan', 'Lírico', 'Cuba', 'Gloria junto a los bongos y maracas de sus compañeros de la banda logra un estilo musical que se recordará toda la vida.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(117, 'Banda Vanessa Martín', 'Pop', 'España', 'Esta banda es capaz de erizar la piel a los menos sensibles con solo una guitarra y la voz de Vanessa.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(118, 'Banda Antonio Orozco', 'Pop', 'España', 'Esta banda es la más especial de España, capaz de pasar del llanto a la felicidad con una sola canción, grande Antonio.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(119, 'Banda Sebastian Yatra', 'Latino', 'Argentina', 'Yatra con su banda es de los artistas actuales con mas repercusión en el mundo gracias a su temas latinos con millones de visitas.');
    INSERT INTO Bandas (Id_Banda, Nombre_banda, Estilo, Pais, Biografia) VALUES(120, 'Banda Tini Stoessel', 'Latino', 'Argentina', 'Tini y su banda conocidos por aparecer de Joven en Disney Channel con la serie patito feo.');

    /*Inserts de la taula d'Album*/
    \! echo Creación INSERTS Album.
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(201, 'The Jungle', 1987, 12);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(202, 'La Vida', 2008, 9);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(203, 'Ave Maria', 2009, 15);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(204, 'Volar', 2006, 6);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(205, 'Las Costuras del Alma', 2018, 22);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(206, 'Bad Chance', 2008, 7);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(207, 'Must Go On Album', 1991, 9);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(208, 'Teatro D,Ira', 2020, 10);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(209, 'Camino Eurovision', 2021, 11);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(210, 'Color a la vida', 1995, 16);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(211, 'Step Up All In', 2014, 18);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(212, 'Ojala', 2017, 32);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(213, 'USA Love', 1992, 5);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(214, 'Thriller Album', 1991, 22);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(215, 'Wonders Loves', 1981, 15);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(216, 'Cuba Querida', 1985, 12);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(217, 'Los gatos no ladran', 2018, 11);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(218, 'Heroe 27', 2018, 13);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(219, 'Sencillo', 2020, 14);
    INSERT INTO Album (Id_Album, Nombre_album, Anyo_Edicion, Numero_Canciones) VALUES(220, 'Single', 2021, 8);

    /*Insert para la tabla canciones*/
    \! echo Creación INSERTS Canciones.
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(100, 201, 'Welcome To The Jungle', 4.29, 1987);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(200, 202, 'Caminando por la vida', 3.24, 2008);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(300, 203, 'Ave María', 2.59, 2009);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(400, 204, 'Por el Amor de esa Mujer', 3.09, 2006);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(500, 205, 'El Primer Amor', 3.54, 2018);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(600, 206, 'Poker Face', 5.59, 2008);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(700, 207, 'Show Must Go On', 6.26, 1991);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(800, 208, 'La Paura del Buio', 3.17, 2020);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(900, 209, 'Memoria', 3.20, 2021);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1000, 210, 'Café del campo', 5.30, 1995);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1100, 211, 'Earthquake', 7.54, 2014);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1200, 212, 'Ojala', 3.18, 2017);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1300, 213, 'Born in the USA', 5.23, 1992);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1400, 214, 'Thriller', 8.24, 1991);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1500, 215, 'I Just Call to Say I Love You', 4.21, 1981);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1600, 216, 'Puro Cubano', 4.54, 1985);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1700, 217, 'No te pude retener', 4.00, 2018);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1800, 218, 'Mi héroe', 3.56, 2018);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(1900, 219, 'Como mirarte', 3.56, 2020);
    INSERT INTO Canciones (Id_Cancion, Id_Album, Nombre_Cancion, Duracion, Anyo_Lanzamiento) VALUES(2000, 220, 'Te Olvidaré', 3.29, 2021);


    /*Afegirem els inserts per la taula Musicos que tindrà els camps de Persona*/
    \! echo Creación INSERTS Musicos.
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('41010673V', 'Axel Rose', 56, 695083558, 'axelrose@musicos.com', 'Hombre', 001, 100, 101, '{Guitarra Eléctrica}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('99708326Z', 'Melendi', 32, 746714572, 'melendi@musicos.com', 'Hombre', 002, 200, 102, '{Guitarra}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('62200123G', 'David Bisbal', 46, 637242334, 'bisbal@musicos.com', 'Hombre', 003, 300, 103, '{Piano}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('32454375H', 'Bustamante', 25, 729177811, 'bustamante@musicos.com', 'Hombre', 004, 400, 104, '{Flauta}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('48545671P', 'El Barrio', 62, 634636010, 'barrio@musicos.com', 'Hombre', 005, 500, 105, '{Bateria}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('86685472J', 'Lady Gaga', 18, 641680966, 'gaga@musicos.com', 'Mujer', 006, 600, 106, '{Saxofon}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('23402807P', 'Freddy Mercury', 70, 785512803, 'mercury@musicos.com', 'Hombre', 007, 700, 107, '{Triangulo}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('56475204S', 'Maneskin', 22, 771747302, 'maneskin@musicos.com', 'Otros', 008, 800, 108, '{Violin}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('95860814B', 'Blas Canto', 33, 756961394, 'blascanto@musicos.com', 'Hombre', 009, 900, 109, '{Maracas}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('45803123A', 'Rosario Flores', 50, 670264928, 'flores@musicos.com', 'Mujer', 010, 1000, 110, '{Tambor}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('46718986Y', 'Steve Aoki', 27, 726166732, 'aoki@musicos.com', 'Hombre', 011, 1100, 111, '{Guitarra Eléctrica}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('48440764G', 'Beret', 48, 662541243, 'beret@musicos.com', 'Hombre', 012, 1200, 112, '{Piano}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('11074713Y', 'Bruce Springsteen', 90, 629578119, 'springsteen@musicos.com', 'Hombre', 013, 1300, 113, '{Guitarra}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('86413438T', 'Michael Jackson', 43, 642501791, 'jackson@musicos.com', 'Hombre', 014, 1400, 114, '{Piano}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('21651959N', 'Steve Wonder', 54, 647522287, 'wonder@musicos.com', 'Hombre', 015, 1500, 115, '{Maracas}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('19850685Y', 'Gloria Stefan', 81, 628537457, 'stefan@musicos.com', 'Mujer', 016, 1600, 116, '{Saxofon}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('57814658H', 'Vanessa Martín', 9, 643905109, 'vanessa@musicos.com', 'Mujer', 017, 1700, 117, '{Saxofon}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('94658163F', 'Antonio Orozco', 19, 649516240, 'orozco@musicos.com', 'Hombre', 018, 1800, 118, '{Triangulo}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('97600336C', 'Sebastian Yatra', 21, 607086461, 'yatra@musicos.com', 'Hombre', 019, 1900, 119, '{Bateria}');
    INSERT INTO Musicos (DNI, Nombre, Edad, Telefono, Correo_Elec, Sexo, Id_Musico, Id_Cancion, Id_Banda, Nombre_Instrumento) VALUES('85201931H', 'Tini Stoessel', 49, 725741644, 'stoessel@musicos.com', 'Mujer', 020, 2000, 120, '{Guitarra}');
    


/*CREACIÓ DEL DOCUMENT AMB LES CONSULTES I PROVES*/
    /*Apartat A*/
    \! echo Ho podràs trobar al DOC que hi ha juntament amb el projecte, ja que aquest punt es pura 
    documentació conforme tot ha funcionat.

    /*Apartat B*/
        /*15 consultas, entre ellas algunas más complicadas y otras menos.*/
        \! echo Consulta 1. Mostrar cuantos cantantes menores hay que sean mujeres mostrando su nombre. 
        SELECT nombre, sexo from Musicos where edad < 18;

        \! echo Consulta 2. Mostrar todos los correos y nombres de los Musicos cuyo instrumento sea la Guitarra.
        SELECT nombre, correo_elec, nombre_instrumento[1] from musicos where nombre_instrumento = '{Guitarra}';

        \! echo Consulta 3. Quiero saber que canción canta Melendi y con que instrumento la tocó. 
        SELECT musicos.nombre, musicos.nombre_instrumento[1], canciones.nombre_cancion from Musicos, Canciones where musicos.Id_cancion = canciones.Id_Cancion and nombre = 'Melendi';
 
        \! echo Consulta 4. Queremos saber el nombre, su DNI, su correo electronico, su sexo, la canción que canta, el instrumento que toca y a que banda pertenece de cada musico.
        SELECT musicos.dni, musicos.nombre, musicos.correo_elec, musicos.sexo, canciones.nombre_cancion, musicos.nombre_instrumento[1], bandas.nombre_banda from Musicos, Canciones, Bandas where musicos.Id_cancion = canciones.Id_Cancion and musicos.id_banda = bandas.id_banda;

        \! echo Consulta 5. Queremos saber el nombre del instrumento, banda y nombre de la cancion cuyo sexo del musico sea mujer y otros.
        SELECT musicos.nombre, musicos.sexo, musicos.nombre_instrumento[1], canciones.nombre_cancion, bandas.nombre_banda from Musicos, Canciones, Bandas where musicos.Id_cancion = canciones.Id_Cancion and musicos.id_banda = bandas.id_banda and  musicos.sexo = 'Mujer';
        
        \! echo Consulta 6. Quiero saber la banda y biografia a la que pertenece el Musico Freddy Mercury. 
        SELECT musicos.nombre, bandas.nombre_banda, bandas.biografia FROM Musicos, Bandas where musicos.Id_Banda = bandas.id_banda and musicos.nombre = 'Freddy Mercury';
        
        \! echo Consulta 7. Quiero saber cual es el nombre del principal instrumento de la Banda Maneskin, también quiero saber su sexo, el nombre del músico y su correo y telefono y un poco de la biografia de ellos para así contactar con el para un bolo. 
        SELECT musicos.nombre, musicos.dni, musicos.sexo, musicos.correo_elec, musicos.telefono, musicos.nombre_instrumento[1], bandas.nombre_banda, bandas.biografia from Musicos, Bandas where musicos.id_banda = bandas.id_banda and bandas.nombre_banda = 'Banda Maneskin';

        \! echo Consulta 8. Quiero saber cuantas bandas hay, no quiero nombre, necesitamos un número exacto de bandas. 
        SELECT count(nombre_banda) from bandas;
        
        \!echo Consulta 9. Queremos saber de que país es cada musico, y a que banda pertenece. 
        SELECT musicos.nombre, bandas.nombre_banda, bandas.pais from Musicos, Bandas where musicos.id_banda = bandas.id_banda;
        

        \!echo Consulta 10. Quiero hacer una colaboración con todos los cantantes de Estados Unidos, es por eso que necesitamos el nombre del musico, telefono del musico, país del músico, el nombre de la banda a la que pertenece y que instrumento toca.
        SELECT musicos.nombre, musicos.nombre_instrumento[1], musicos.telefono, bandas.nombre_banda, bandas.pais from Musicos, Bandas where musicos.id_banda = bandas.id_banda and bandas.pais = 'Estados Unidos';
        
        \!echo Consulta 11. Necesitamos saber a que album pertenece cada canción y su año de lanzamiento.
        SELECT canciones.nombre_cancion, album.nombre_album, canciones.Anyo_Lanzamiento from Canciones, Album where canciones.id_album = album.id_album;

        \!echo Consulta 12. Queremos saber la duración de todas las canciones.
        SELECT nombre_cancion, duracion from Canciones;

        \!echo Consulta 13. Me gustaria saber los números de telefono de cada banda y el musico de cada una de ellas.
        SELECT musicos.nombre, musicos.telefono, bandas.nombre_banda from Musicos, Bandas where musicos.id_banda = bandas.id_banda;
        
        \!echo Consulta 14. Quiero buscar todas las duraciones cuya duración esté entre los 2 minutos y los 4 minutos. 
        SELECT nombre_cancion, duracion from Canciones where duracion >= 2.00 and duracion <= 4.00;

        \!echo Consulta 15. Queremos ordenar por orden de año de edición todos los albums y mostrar cuantas canción tiene cada album.
        SELECT nombre_album, Anyo_Edicion from album order by Anyo_Edicion;

        /*Actualització de dades d'emmagatzematge. Farem 6 actualitzacions*/

        \!echo Actualización 1. La Banda Maneskin se ha decidido cambiar el nombre a Maneskin Boys.
        UPDATE bandas SET nombre_banda = 'Maneskin Age of years' where id_banda = 108;

        \!echo Actualización 2. Queremos cambiar el nombre del cantante de Gloria Stefan a David Bowie.
        UPDATE musicos SET nombre = 'David Bowie', correo_elec = 'bowie@musicos.com' where id_musico = 16;

        \!echo Actualización 3. Queremos cambiar el ID de la cancion Caminando por la vida SOLO en la tabla de musica.
        UPDATE ONLY canciones SET id_cancion = 250 where id_cancion = 200;

        \!echo Actualización 4. Queremos cambiar el id de la banda de Guns N Roses a 9081.
        UPDATE bandas SET id_banda = 9081 where id_banda = 101;

        \!echo Actualización 5. Queremos cambiar que David Bisbal pase de tocar el piano a la guitarra. 
        UPDATE musicos SET nombre_instrumento = '{Guitarra}' where nombre = 'David Bisbal';

        \!echo Actualización 6. Al ver los años de edicion nos hemos dado cuenta que nos hemos equivoaco en el año de edición del Album Volar, está en el año 2006 pero su edición fue en 2008 y en vez de tener 6 canciones tiene 8.
        UPDATE album SET Anyo_Edicion = 2008, Numero_Canciones = 8 where nombre_album = 'Volar';