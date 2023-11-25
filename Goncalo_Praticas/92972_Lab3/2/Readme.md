# Sistema de partilha de vídeos em Cassandra

Gonçalo Matos, 92972



Para gerar dados para popular a minha base de dados local utilizei o script `generateData.py` localizado na pasta deste ficheiro.

Os *queries* DML gerados para os inserir na base de dados estão em `dml.cassandra`.

Os  registos no formato JSON estão na pasta `/jsons`.



## a) Modelo de dados

Para modelar este problema, criei um *keyspace* denominado `VideoShare`.

```cassandra
CREATE KEYSPACE videoshare WITH replication={'class':'SimpleStrategy', 'replication_factor':3};
```



#### Gestão de utilizadores

Assumindo que não há mais do que um utilizador com o mesmo `username`.

```cassandra
CREATE TABLE users (
	username ascii,
    name ascii,
    email ascii,
    registerMoment timestamp,
    PRIMARY KEY (username, name)
);
```



#### Gestão de vídeos

```cassandra
CREATE TABLE videos (
    videoid int,
	author ascii,
    name ascii,
    description ascii,
    tags set<ascii>,
    uploadMoment timestamp,    
    PRIMARY KEY(author, uploadMoment, videoid)
) WITH CLUSTERING ORDER BY (uploadMoment DESC);
```

Para permitir a pesquisa por videoid.

```cassandra
CREATE INDEX videos_by_videoid ON videos (videoid);
```



#### Gestão de comentários

```cassandra
CREATE TABLE comments (
    id int,
	author ascii,
    videoid int,
    moment timestamp,
    comment ascii,
    PRIMARY KEY (videoid, moment, id)
) WITH CLUSTERING ORDER BY (moment DESC);
```

Para permitir pesquisa por autores, para além do ID do vídeo, criei outra tabela, com o autor como partition key.

```cassandra
CREATE TABLE comments_by_author (
    id int,
	author ascii,
    videoid int,
    moment timestamp,
    comment ascii,
    PRIMARY KEY (author, moment, id)
) WITH CLUSTERING ORDER BY (moment DESC);
```



#### Gestão de seguidores de cada vídeo

```cassandra
CREATE TABLE videofollowers (
	videoid int,
    username ascii,
    PRIMARY KEY(videoid, username),
);
```



#### Registo de eventos

```cassandra
CREATE TABLE events (
	videoid int,
    username ascii,
    type ascii, 		//play, pause, stop
    moment timestamp,
    videomoment int,
    PRIMARY KEY((videoid, username), moment)
) WITH CLUSTERING ORDER BY (moment DESC);
```



#### Rating de vídeos

```cassandra
CREATE TABLE ratings (
	videoid int,
    rating int, // 1 to 5
    ratingid int,
    PRIMARY KEY(videoid, ratingid)
);
```



## c) Pesquisas base

7. Pesquisa de todos os vídeos de determinado autor

```cassandra
SELECT * FROM videos WHERE author='fideliusadorable';
// 3 Rows
```

8. Pesquisa de comentários por utilizador, ordenado inversamente pela data

```cassandra
SELECT * FROM comments_by_author WHERE author='planetafford';
// 11 Rows (First row has date 2020-12-13 and last 2020-01-26)
```

9. Pesquisa de comentários por vídeos, <u>ordenado inversamente pela data</u>

```cassandra
SELECT * FROM comments WHERE videoid=1616;
// 5 rows (First row has date 2020-12-14 and last 2020-01-15)
```

10. Pesquisa do rating médio de um vídeo e quantas vezes foi votado

```cassandra
SELECT AVG(rating) AS averageRating, COUNT(ratingid) AS numbervotes FROM ratings WHERE videoid=4176; 
// average of 2 for 19 votes
```



## d) Pesquisas avançadas

Como os requisitos da base de dados são definidos na alínea a), assumi que os *queries* pedidos nesta alínea teriam de ser feitos sem alterações na sua estrutura, nomeadamente, sem a criação de tabelas adicionais ou alterações às existentes. Assumi no entanto que seria possível criar índices sobre as tabelas existentes.



1. Os últimos 3 comentários introduzidos para um vídeo

Como os comentários são ordenados dentro de cada partição (vídeo) pelo momento em que foram criados de forma decrescente, basta limitarmos o resultado às 3 primeiras linhas.

```cassandra
SELECT * FROM comments WHERE videoid=4176 LIMIT 3;
```



2. Lista das tags de determinado vídeo.

Como os vídeos estão particionados de acordo com o autor, criei um índice secundário com base no videoid.

```cassandra
SELECT tags FROM videos WHERE videoid=4568;
```



3. Todos os vídeos com a tag Dentistry

> Como não usei os dados pedidos no problema, adaptei à minha amostra.

```cassandra
SELECT videoid, tags FROM videos WHERE tags CONTAINS 'Dentistry' ALLOW FILTERING ;
```



4. Os últimos 5 eventos de determinado vídeo realizados por um utilizador

```cassandra
SELECT * FROM events  WHERE videoid=5897 AND username='bakerauthentic' LIMIT 5;
```



5. Vídeos partilhados por determinado utilizador (maria1987, por exemplo) num
   determinado período de tempo (Agosto de 2017, por exemplo)

> Como não usei os dados pedidos no problema, adaptei à minha amostra.

```cassandra
SELECT * FROM videos WHERE author='bakerauthentic' AND uploadmoment>'2020-03-04T21:59:55.000+0000';
```



6. Os últimos 10 vídeos, ordenado inversamente pela data da partilhada

Como os vídeos são particionados pelo autor e apenas dentro de cada partição ordenados inversamentre pela data de partilha, <u>não é possível obter os últimos 10 vídeos de todos os utilizadores</u>. 

Esta pesquisa torna-se possível se for os últimos 10 vídeos de determinado utilizador.



7. Todos os seguidores (followers) de determinado vídeo

```cassandra
SELECT * FROM videofollowers WHERE videoid=4143;
```



8. Todos os comentários (dos vídeos) que determinado utilizador está a seguir (following)

Para fazer esta pesquisa seria necessária agregação de tabelas, que <u>não é permitida</u> em Cassandra.



9. Os 5 vídeos com maior rating

<u>Não é possível</u> pois apesar de ser possível a soma dos ratings agrupados por vídeo, a ordenação que permitiria obter o vídeo com maior rating não é possível quando a pesquisa não restringe a chave primária, que neste caso será o videoid.

É no entanto possível obter o rating para cada vídeo.

```cassandra
SELECT videoid, SUM(rating) AS totalrating FROM ratings GROUP BY videoid;
```



## Referências

https://www.datastax.com/blog/most-important-thing-know-cassandra-data-modeling-primary-key

