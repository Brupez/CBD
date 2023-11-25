//QUERYS

//1. Pesquisar os 5 estudantes que entraram em último na escola.
SELECT * FROM students;
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+
|student_id|entry_time             |age|email                  |frequented_classes         |name         |phone_number          |
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+
|5         |2023-11-25 17:15:00.000|19 |olivia.brown@email.com |{'Irish Dance', 'Tap'}     |Olivia Brown |{'mobile': 112223333} |
|10        |2023-11-25 23:30:00.000|24 |noah.wilson@email.com  |{'Burlesque', 'Pole Dance'}|Noah Wilson  |{'home': 123334444}   |
|11        |2023-11-26 09:00:00.000|27 |ava.turner@email.com   |{'Bhangra', 'Bollywood'}   |Ava Turner   |{'mobile': 1119998888}|
|1         |2023-11-25 12:00:00.000|20 |alice.johnson@email.com|{'Ballet', 'Jazz'}         |Alice Johnson|{'mobile': 1234567890}|
|8         |2023-11-25 21:00:00.000|30 |luke.adams@email.com   |{'Latin Dance', 'Zumba'}   |Luke Adams   |{'home': 567778888}   |
|2         |2023-11-25 13:30:00.000|22 |bob.miller@email.com   |{'Contemporary', 'Hip Hop'}|Bob Miller   |{'home': 987653211}   |
|4         |2023-11-25 16:00:00.000|28 |charlie.white@email.com|{'Ballroom', 'Swing'}      |Charlie White|{'home': 778889999}   |
|7         |2023-11-25 19:45:00.000|26 |grace.turner@email.com |{'Flamenco', 'Samba'}      |Grace Turner |{'mobile': 998887777} |
|6         |2023-11-25 18:30:00.000|23 |daniel.smith@email.com |{'Breakdance', 'Krumping'} |Daniel Smith |{'home': 445556666}   |
|9         |2023-11-25 22:15:00.000|21 |zoe.harris@email.com   |{'Funk', 'Street Jazz'}    |Zoe Harris   |{'mobile': 434445555} |
|12        |2023-11-26 10:15:00.000|22 |liam.johnson@email.com |{'African Dance', 'Hula'}  |Liam Johnson |{'home': 1112223333}  |
|3         |2023-11-25 14:45:00.000|25 |eva.davis@email.com    |{'Salsa', 'Tango'}         |Eva Davis    |{'mobile': 555123567} |
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+


//2. Todos as aulas que à segunda feira
SELECT * FROM dance_classes WHERE week_days CONTAINS 'Monday';
+--------------+----------+-----------------------+
|dance_class_id|teacher_id|week_days              |
+--------------+----------+-----------------------+
|1             |1         |{'Monday', 'Wednesday'}|
|6             |6         |{'Friday', 'Monday'}   |
|9             |9         |{'Monday', 'Wednesday'}|
+--------------+----------+-----------------------+

//3. O número de telefone de um determinado aluno
SELECT name, phone_number FROM students WHERE student_id=2;
+----------+-------------------+
|name      |phone_number       |
+----------+-------------------+
|Bob Miller|{'home': 987653211}|
+----------+-------------------+

//4. Todos os alunos que têm números de telefone são fixos
SELECT * FROM students WHERE phone_number CONTAINS KEY 'home';
+----------+-----------------------+---+-----------------------+---------------------------+-------------+--------------------+
|student_id|entry_time             |age|email                  |frequented_classes         |name         |phone_number        |
+----------+-----------------------+---+-----------------------+---------------------------+-------------+--------------------+
|10        |2023-11-25 23:30:00.000|24 |noah.wilson@email.com  |{'Burlesque', 'Pole Dance'}|Noah Wilson  |{'home': 123334444} |
|8         |2023-11-25 21:00:00.000|30 |luke.adams@email.com   |{'Latin Dance', 'Zumba'}   |Luke Adams   |{'home': 567778888} |
|2         |2023-11-25 13:30:00.000|22 |bob.miller@email.com   |{'Contemporary', 'Hip Hop'}|Bob Miller   |{'home': 987653211} |
|4         |2023-11-25 16:00:00.000|28 |charlie.white@email.com|{'Ballroom', 'Swing'}      |Charlie White|{'home': 778889999} |
|6         |2023-11-25 18:30:00.000|23 |daniel.smith@email.com |{'Breakdance', 'Krumping'} |Daniel Smith |{'home': 445556666} |
|12        |2023-11-26 10:15:00.000|22 |liam.johnson@email.com |{'African Dance', 'Hula'}  |Liam Johnson |{'home': 1112223333}|
+----------+-----------------------+---+-----------------------+---------------------------+-------------+--------------------+

//5. O aluno que tem o número de telefone móvel igual a 112223333
SELECT name, phone_number FROM students WHERE phone_number CONTAINS KEY 'mobile' AND phone_number['mobile']=112223333 ALLOW FILTERING;
+------------+---------------------+
|name        |phone_number         |
+------------+---------------------+
|Olivia Brown|{'mobile': 112223333}|
+------------+---------------------+


//6. Os ultimos 5 alunos a entrar na escola
SELECT * FROM students LIMIT 5;
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+
|student_id|entry_time             |age|email                  |frequented_classes         |name         |phone_number          |
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+
|5         |2023-11-25 17:15:00.000|19 |olivia.brown@email.com |{'Irish Dance', 'Tap'}     |Olivia Brown |{'mobile': 112223333} |
|10        |2023-11-25 23:30:00.000|24 |noah.wilson@email.com  |{'Burlesque', 'Pole Dance'}|Noah Wilson  |{'home': 123334444}   |
|11        |2023-11-26 09:00:00.000|27 |ava.turner@email.com   |{'Bhangra', 'Bollywood'}   |Ava Turner   |{'mobile': 1119998888}|
|1         |2023-11-25 12:00:00.000|20 |alice.johnson@email.com|{'Ballet', 'Jazz'}         |Alice Johnson|{'mobile': 1234567890}|
|8         |2023-11-25 21:00:00.000|30 |luke.adams@email.com   |{'Latin Dance', 'Zumba'}   |Luke Adams   |{'home': 567778888}   |
+----------+-----------------------+---+-----------------------+---------------------------+-------------+----------------------+


//7. Idade Média de estudantes
SELECT AVG(age) FROM students;
+---------------+
|system.avg(age)|
+---------------+
|23             |
+---------------+

//8. Os alunos que frequentam as aulas de Ballet ou Contemporâneo
SELECT * FROM students WHERE frequented_classes CONTAINS 'Ballet' OR frequented_classes CONTAINS 'Contemporary';
//A query acima não é suportada por Cassandra (dado usarmos o termo OR que não existe) porque cada query está restrita a uma única partição.


//9.Listar as modalidades que existem e quantos alunos frequentam cada modalidade.
SELECT frequented_classes, count(student_id) FROM students GROUP BY student_id;
+-------------------------------+------------------------+
|frequented_classes             |system.count(student_id)|
+-------------------------------+------------------------+
|{'Contemporary', 'Irish Dance'}|1                       |
|{'Contemporary', 'Pole Dance'} |1                       |
|{'Bollywood', 'Contemporary'}  |1                       |
|{'Ballet', 'Jazz'}             |1                       |
|{'Contemporary', 'Latin Dance'}|1                       |
|{'Contemporary', 'Hip Hop'}    |1                       |
|{'Ballroom', 'Swing'}          |1                       |
|{'Flamenco', 'Samba'}          |1                       |
|{'Breakdance', 'Krumping'}     |1                       |
|{'Funk', 'Street Jazz'}        |1                       |
|{'African Dance', 'Ballet'}    |1                       |
|{'Salsa', 'Tango'}             |1                       |
+-------------------------------+------------------------+


//10. Listar todas as escolas que abriram antes do ano 2000 que se localizam em aveiro
SELECT * FROM dance_schools WHERE district='Aveiro' AND creation_date < '2000-11-12';
+---------------+-----------------------+-------------------------+--------+----------+
|dance_school_id|creation_date          |days                     |district|teacher_id|
+---------------+-----------------------+-------------------------+--------+----------+
|5              |1880-11-12 00:00:00.000|{'Friday', 'Monday'}     |Aveiro  |6         |
|4              |1999-11-12 00:00:00.000|{'Thursday', 'Wednesday'}|Aveiro  |5         |
|3              |1990-11-12 00:00:00.000|{'Friday', 'Saturday'}   |Aveiro  |3         |
|3              |1995-11-12 00:00:00.000|{'Sunday', 'Tuesday'}    |Aveiro  |4         |
+---------------+-----------------------+-------------------------+--------+----------+