# 3.4. Base de dados com temática livre

Gonçalo Matos, 92972



Para este exercício desenvolvi uma base de dados de suporte a um **sistema de lojas de uma empresa de revenda**, segundo os seguintes requisitos:

- O <u>cliente</u>, uma vez registado na empresa, pode comprar em todas as suas lojas, tendo a si associado um nome, o NIF e um conjunto de lojas favoritas;
  - Deve ser possível obter os dados de um cliente dado o seu NIF;
  - Deve ser possível obter os clientes que têm uma determinada loja como favorita, ordenados por ordem crescente do nome;
- O cliente pode criar <u>pedidos de ajuda</u> na aplicação móvel da loja, que são relativos a uma secção específica da loja e têm associado uma lista de mensagens trocadas para a resolução do pedido no chat da aplicação;
  - Deve ser possível obter os pedidos de ajuda para uma secção de uma loja, ordenados a partir do mais recente;
  - Deve ser possível obter os pedidos de ajuda para um cliente;
- No final de cada compra, é gerada uma <u>transação</u>, que ocorre numa caixa de uma loja a uma determinada data/hora e tem associada um valor e um conjunto de produtos, mapeados por preço/produto;
  - Deve ser possível obter as transações mais recentes para uma determinada caixa de uma loja;
  - Deve ser possível obter as transações para um cliente.



## a) c) d) Modelo de dados

Para modelar este problema, criei um *keyspace* denominado `supermercado`.

```cassandra
CREATE KEYSPACE supermercado WITH replication={'class':'SimpleStrategy', 'replication_factor':3};
```



### Clientes

```cassandra
CREATE TABLE clientes (
	nif int,
    nome ascii,
    lojas set<ascii>,
    PRIMARY KEY(nif)
);
```

```cassandra
CREATE TABLE clientes_loja (
	nif int,
    nome ascii,
    loja ascii,
    PRIMARY KEY(loja, nome, nif)
) WITH CLUSTERING ORDER BY (nome ASC);
```



### Pedidos de ajuda

```cassandra
CREATE TABLE ajudas (
	id int,
    loja ascii,
    seccao ascii,
    nifcliente int,
    mensagens list<ascii>,
    momento timestamp,
    PRIMARY KEY((loja, seccao), momento, id)
) WITH CLUSTERING ORDER BY (momento DESC);
```

```cassandra
CREATE INDEX ajudas_cliente ON ajudas (nifcliente);
```



### Transações

```cassandra
CREATE TABLE transacoes (
	id int,
    nifcliente int,
    loja ascii,
    caixa int,
    momento timestamp,
    produtos map<ascii, double>,
    valor double,
    PRIMARY KEY((loja, caixa), momento, id)
) WITH CLUSTERING ORDER BY (momento DESC);
```

```cassandra
CREATE INDEX transacoes_cliente ON transacoes (nifcliente);
```



## b) População da base de dados

Para gerar dados para popular a minha base de dados local utilizei o script `generateData.py` localizado na pasta deste ficheiro.

Os *queries* DML gerados para os inserir na base de dados estão em `dml.cassandra`.



## e) Queries de atualização e eliminação

**Atualização**

```cassandra
// Append a set
UPDATE clientes SET lojas = lojas + {'Braga'} WHERE nif = 635241812;

// Remover item de set
UPDATE clientes SET lojas = lojas - {'Braga'} WHERE nif = 635241812;

// Delete do set com update
UPDATE clientes SET lojas = {} WHERE nif = 635241812;

// Append a lista
UPDATE ajudas SET mensagens = mensagens + ['Mensagem de teste']  WHERE loja = 'Coimbra' AND seccao = 'Frutaria' AND momento = '2020-09-01 02:51:55+0000' AND id = 4757 ;

// Atualização de índice da lista
UPDATE ajudas SET mensagens[3] = 'Mensagem de testa'  WHERE loja = 'Coimbra' AND seccao = 'Frutaria' AND momento = '2020-09-01 02:51:55+0000' AND id = 4757 ;

// Append a dicionário
UPDATE transacoes SET produtos = produtos + {'Pilhas': 2.99}  WHERE loja = 'Lisboa' AND caixa = 2 AND momento = '2020-11-28 17:01:56+0000' AND id = 1971;

// Alternativa
UPDATE transacoes SET produtos['Gel de Banho'] = 1.99  WHERE loja = 'Lisboa' AND caixa = 2 AND momento = '2020-11-28 17:01:56+0000' AND id = 1971;
```



**Eliminação**

```cassandra
// Eliminação de set
DELETE lojas FROM clientes WHERE nif = 918001820;

// Eliminação de item da lista
DELETE mensagens[2] FROM ajudas  WHERE loja = 'Coimbra' AND seccao = 'Frutaria' AND momento = '2020-09-01 02:51:55+0000' AND id = 4757 ;

// Eliminação de lista
DELETE mensagens FROM ajudas WHERE loja = 'Coimbra' AND seccao = 'Frutaria' AND momento = '2020-09-01 02:51:55+0000' AND id = 4757 ;

// Eliminação de par chave/valor do dicionário
DELETE produtos['Gel de Banho'] FROM transacoes WHERE loja = 'Lisboa' AND caixa = 2 AND momento = '2020-11-28 17:01:56+0000' AND id = 1971;

// Eliminação de dicionário
DELETE produtos FROM transacoes WHERE loja = 'Lisboa' AND caixa = 2 AND momento = '2020-11-28 17:01:56+0000' AND id = 1971;
```



## f) Queries SELECT

Para conseguir criar os *queries* 4 e 5 criei a UDF abaixo.

```cassandra
CREATE OR REPLACE FUNCTION lsizeof(data list<ascii>) CALLED ON NULL INPUT RETURNS int LANGUAGE java AS 'if (data == null) return 0;return data.size();';
```

Para conseguir criar o *query* 9 criei a UDF abaixo.

```cassandra
CREATE OR REPLACE FUNCTION mapsizeof(data map<ascii, double>) CALLED ON NULL INPUT RETURNS int LANGUAGE java AS 'if (data == null) return 0;return data.size();';
```

Para conseguir criar o *query* 10 criei a UDF abaixo.

```cassandra
CREATE OR REPLACE FUNCTION mapsum(data map<ascii, double>) CALLED ON NULL INPUT RETURNS double LANGUAGE java AS 'if (data == null) return 0.0; double sum = 0; for(double d:data.values()) sum+= d; return sum;';
```



1. Lojas favoritas do cliente com NIF 625196487.

```cassandra
SELECT lojas FROM clientes WHERE nif = 625196487;
```

2. Número de clientes que têm a loja de Lisboa como favorita.

```cassandra
SELECT COUNT(nif) FROM clientes_loja WHERE loja = 'Lisboa';
```

3. Número de pedidos de ajuda na secção Frutaria da loja de Coimbra

```cassandra
SELECT COUNT(*) FROM ajudas WHERE loja = 'Coimbra' AND seccao = 'Frutaria' ;
```

4. Número de mensagens para cada pedido de ajuda

```cassandra
SELECT loja, seccao, momento, id, lsizeof(mensagens) FROM ajudas ;
```

5. Número médio de mensagens para cada pedido de ajuda

```cassandra
SELECT avg(lsizeof(mensagens)) FROM ajudas ; 
```

6. Número de pedidos de ajuda para cada seccção de cada loja

```cassandra
SELECT loja, seccao, COUNT(id) FROM ajudas GROUP BY loja, seccao ;
```

7. Número de transações realizadas no segundo semestre de 2020

```cassandra
SELECT COUNT(*) FROM transacoes WHERE momento > '2020-07-01 00:00:00+0000' AND momento < '2020-12-31 23:59:59+0000' ALLOW FILTERING ;
```

8. O valor total das transações realizadas na caixa 2 da loja do Porto no dia 28/09/2020

```cassandra
SELECT SUM(valor) FROM transacoes WHERE loja = 'Porto' AND caixa = 2 AND momento > '2020-09-28' AND momento < '2020-09-29' ;
```

9. O número médio de variedades de produtos comprados em cada transação na loja de Coimbra

```cassandra
SELECT avg( mapsizeof(produtos)) FROM transacoes WHERE loja = 'Coimbra' ALLOW FILTERING ;
```

10. O valor médio das compras feitas em todas as lojas da empresa, sem recorrer ao atributo valor de cada transação.

```cassandra
SELECT avg(mapsum(produtos)) FROM transacoes ;
```

