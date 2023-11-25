// 7. Permitir a pesquisa de todos os videos de determinado autor;
SELECT * FROM videos WHERE author = 'Bruno';
+------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+
|author|selo_temporal_videos   |email                             |name                        |tags                                   |video_id|
+------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+
|Bruno |2023-11-13 00:00:00.000|interstellar@gmail.com            |Interstellar                |['ficção cientifica']                  |6       |
|Bruno |2020-11-13 00:00:00.000|brunolopes@gmail.com              |Bruno Lopes                 |['ação', 'ficção cientifica']          |1       |
|Bruno |1994-11-13 00:00:00.000|tenet@gmail.com                   |Tenet                       |['Aveiro', 'ação', 'ficção cientifica']|7       |
|Bruno |1985-11-13 00:00:00.000|reileao@gmail.com                 |Rei Leão                    |['animação', 'fantasia']               |8       |
|Bruno |1955-11-13 00:00:00.000|piratadascaraibas@gmail.com       |Pirata das caraibas         |['Aveiro', 'ação', 'thriller']         |10      |
|Bruno |1900-11-13 00:00:00.000|alicenopaisdasmaravilhas@gmail.com|Alice no país das maravilhas|['animação', 'fantasia']               |9       |
+------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+


// 8. Permitir a pesquisa de comentarios por utilizador, ordenado inversamente pela data;
SELECT * FROM commentsByUsers WHERE username = 'Brupez';
+--------+-----------------------------+----------+
|username|selo_temporal_commentsbyusers|comment   |
+--------+-----------------------------+----------+
|Brupez  |2023-11-16 12:34:56.000      |Cassandra!|
+--------+-----------------------------+----------+



// 9. Permitir a pesquisa de comentarios por videos, ordenado inversamente pela data;
SELECT * FROM commentsByVideos WHERE video_id = 9;
+--------+------------------------------+------------+
|video_id|selo_temporal_commentsbyvideos|comment     |
+--------+------------------------------+------------+
|9       |2023-11-16 20:12:34.000       |Not Perfect!|
+--------+------------------------------+------------+


// 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
SELECT author, video_id,AVG(rating), COUNT(rating) FROM rating_videos WHERE video_id = 10;

+------+--------+------------------+--------------------+
|author|video_id|system.avg(rating)|system.count(rating)|
+------+--------+------------------+--------------------+
|Bruno |10      |66                |2                   |
+------+--------+------------------+--------------------+




// 1. Os ultimos 3 comentarios introduzidos para um video;
SELECT * FROM commentsByVideos WHERE video_id = 10 LIMIT 3;
+------------------------------+----------------+--------+
|selo_temporal_commentsbyvideos|comment         |video_id|
+------------------------------+----------------+--------+
|2023-11-16 14:56:00.000       |Great!          |10      |
|2023-11-16 16:18:15.000       |Cassandra!      |10      |
|2023-11-16 21:23:45.000       |More sore above!|10      |
+------------------------------+----------------+--------+

// 2. Lista das tags de determinado video;
SELECT video_id, tags FROM videos WHERE video_id= 3;
+--------+-------------------------------+
|video_id|tags                           |
+--------+-------------------------------+
|3       |{'animação', 'ação', 'comédia'}|
+--------+-------------------------------+

// 3. Todos os videos com a tag Aveiro;

//Precisei de criar um index em tags para executar a query.
CREATE INDEX ON videos(tags);
SELECT * FROM videos WHERE  video_id tags CONTAINS 'Aveiro';
+--------+-----------------------+------+---------------------------+-------------------+---------------------------------------+
|video_id|selo_temporal_videos   |author|email                      |name               |tags                                   |
+--------+-----------------------+------+---------------------------+-------------------+---------------------------------------+
|5       |2023-11-13 08:50:00.000|Bruno |hercules@gmail.com         |Hercules           |['ação', 'ficção cientifica', 'Aveiro']|
|10      |2023-11-13 08:50:00.000|Bruno |piratadascaraibas@gmail.com|Pirata das caraibas|['Aveiro', 'ação', 'thriller']         |
|7       |2023-11-13 08:50:00.000|Bruno |tenet@gmail.com            |Tenet              |['Aveiro', 'ação', 'ficção cientifica']|
+--------+-----------------------+------+---------------------------+-------------------+---------------------------------------+

// 4. Os ultimos 5 eventos de determinado video realizados por um utilizador;
SELECT * FROM events WHERE video_id=1 AND user_id = 1 LIMIT 5 ;
+--------+-------+-----------------------+----------+-------------+
|video_id|user_id|selo_temporal_event    |event_type|video_seconds|
+--------+-------+-----------------------+----------+-------------+
|1       |1      |2020-10-22 07:55:00.000|play      |680          |
|1       |1      |2019-05-05 11:50:00.000|stop      |2000         |
|1       |1      |2005-12-12 20:50:00.000|stop      |6            |
|1       |1      |1999-11-15 08:50:00.000|pause     |900          |
|1       |1      |1990-07-13 04:50:00.000|play      |600          |
+--------+-------+-----------------------+----------+-------------+
// 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);
SELECT * FROM videosByAuthor WHERE author='Bruno' AND selo_temporal_videosByAuthor< '2020-11-13';
+------+----------------------------+--------+
|author|selo_temporal_videosbyauthor|video_id|
+------+----------------------------+--------+
|Bruno |2013-11-13 00:00:00.000     |9       |
|Bruno |2010-11-13 00:00:00.000     |8       |
|Bruno |2009-11-13 00:00:00.000     |7       |
|Bruno |2005-11-13 00:00:00.000     |10      |
|Bruno |2000-11-13 00:00:00.000     |5       |
|Bruno |1800-11-13 00:00:00.000     |10      |
+------+----------------------------+--------+


// 6. Os ultimos 10 videos, ordenado inversamente pela data da partilhada;
SELECT * FROM videos LIMIT 10;
+-------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+
|author |selo_temporal_videos   |email                             |name                        |tags                                   |video_id|
+-------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+
|Marcos |1994-09-09 00:00:00.000|shreck@gmail.com                  |Shrek                       |['ação', 'animação']                   |2       |
|Marques|2023-11-13 00:00:00.000|inception@gmail.com               |Inception                   |['ação', 'ficção cientifica']          |4       |
|Diogo  |2023-11-13 00:00:00.000|pandakungfu@gmail.com             |Panda Kung Fu               |['ação', 'animação', 'comédia']        |3       |
|Bruno  |2023-11-13 00:00:00.000|interstellar@gmail.com            |Interstellar                |['ficção cientifica']                  |6       |
|Bruno  |2020-11-13 00:00:00.000|thematrix@gmail.com               |The Matrix                  |['ação', 'ficção cientifica']          |1       |
|Bruno  |1994-11-13 00:00:00.000|tenet@gmail.com                   |Tenet                       |['Aveiro', 'ação', 'ficção cientifica']|7       |
|Bruno  |1985-11-13 00:00:00.000|reileao@gmail.com                 |Rei Leão                    |['animação', 'fantasia']               |8       |
|Bruno  |1955-11-13 00:00:00.000|piratadascaraibas@gmail.com       |Pirata das caraibas         |['Aveiro', 'ação', 'thriller']         |10      |
|Bruno  |1900-11-13 00:00:00.000|alicenopaisdasmaravilhas@gmail.com|Alice no país das maravilhas|['animação', 'fantasia']               |9       |
+-------+-----------------------+----------------------------------+----------------------------+---------------------------------------+--------+

// 7. Todos os seguidores (followers) de determinado video;
SELECT * FROM video_followers WHERE video_id=2;
+--------+-------+
|video_id|user_id|
+--------+-------+
|2       |3      |
|2       |4      |
|2       |5      |
|2       |6      |
+--------+-------+
// 8. Todos os comentarios (dos videos) que determinado utilizador esta a seguir (following);
// Não é possível pois não é possível fazer join as duas tabelas: video_followers e comments.

// 9. Os 5 videos com maior rating;
//Não dá porque a Cassandra não foi desenvolvida para suportar operações de agregação por todas as partições.

// 10. Uma query que retorne todos os videos e que mostre claramente a forma pela qual estao ordenados;
SELECT * FROM videos; //A tabela videos está ordenada de maneira descendente pelo timestamp.
+--------+-----------------------+-------+----------------------------------+----------------------------+---------------------------------------+
|video_id|selo_temporal_videos   |author |email                             |name                        |tags                                   |
+--------+-----------------------+-------+----------------------------------+----------------------------+---------------------------------------+
|5       |2023-11-13 00:00:00.000|Bruno  |hercules@gmail.com                |Hercules                    |{'Aveiro', 'ação', 'ficção cientifica'}|
|4       |2023-11-13 00:00:00.000|Marques|inception@gmail.com               |Inception                   |{'ação', 'ficção cientifica'}          |
|6       |2023-11-13 00:00:00.000|Bruno  |interstellar@gmail.com            |Interstellar                |{'ficção cientifica'}                  |
|3       |2023-11-13 00:00:00.000|Diogo  |pandakungfu@gmail.com             |Panda Kung Fu               |{'animação', 'ação', 'comédia'}        |
|1       |2020-11-13 00:00:00.000|Bruno  |thematrix@gmail.com               |The Matrix                  |{'ação', 'ficção cientifica'}          |
|7       |1994-11-13 00:00:00.000|Bruno  |tenet@gmail.com                   |Tenet                       |{'Aveiro', 'ação', 'ficção cientifica'}|
|2       |1994-09-09 00:00:00.000|Marcos |shreck@gmail.com                  |Shrek                       |{'animação', 'ação'}                   |
|8       |1985-11-13 00:00:00.000|Bruno  |reileao@gmail.com                 |Rei Leão                    |{'animação', 'fantasia'}               |
|10      |1955-11-13 00:00:00.000|Bruno  |piratadascaraibas@gmail.com       |Pirata das caraibas         |{'Aveiro', 'ação', 'thriller'}         |
|9       |1900-11-13 00:00:00.000|Bruno  |alicenopaisdasmaravilhas@gmail.com|Alice no país das maravilhas|{'animação', 'fantasia'}               |
+--------+-----------------------+-------+----------------------------------+----------------------------+---------------------------------------+



// 11. Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;
SELECT tags, COUNT(video_id) FROM videos GROUP BY video_id;
+---------------------------------------+----------------------+
|tags                                   |system.count(video_id)|
+---------------------------------------+----------------------+
|{'Aveiro', 'ação', 'ficção cientifica'}|1                     |
|{'Aveiro', 'ação', 'thriller'}         |1                     |
|{'ação', 'ficção cientifica'}          |1                     |
|{'animação', 'fantasia'}               |1                     |
|{'animação', 'ação'}                   |1                     |
|{'ação', 'ficção cientifica'}          |1                     |
|{'Aveiro', 'ação', 'ficção cientifica'}|1                     |
|{'ficção cientifica'}                  |1                     |
|{'animação', 'fantasia'}               |1                     |
|{'animação', 'ação', 'comédia'}        |1                     |
+---------------------------------------+----------------------+


// 12.Calcular a média de segundos de vídeo dos eventos.
SELECT AVG(video_seconds) FROM events;
+-------------------------+
|system.avg(video_seconds)|
+-------------------------+
|635                      |
+-------------------------+


// 13. Calcular a média total de ratings.
SELECT AVG(rating) FROM rating_videos;
+------------------+
|system.avg(rating)|
+------------------+
|48                |
+------------------+