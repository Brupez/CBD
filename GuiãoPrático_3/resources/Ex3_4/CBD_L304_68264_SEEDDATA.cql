//TEACHERS
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (1, 'John Doe', 'john.doe@email.com', {'Ballet', 'Contemporary'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (2, 'Jane Smith', 'jane.smith@email.com', {'Hip Hop', 'Jazz'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (3, 'Mike Johnson', 'mike.johnson@email.com', {'Salsa', 'Tango'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (4, 'Emily White', 'emily.white@email.com', {'Ballroom', 'Swing'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (5, 'David Brown', 'david.brown@email.com', {'Tap', 'Irish Dance'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (6, 'Sophie Miller', 'sophie.miller@email.com', {'Breakdance', 'Krumping'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (7, 'Alex Turner', 'alex.turner@email.com', {'Flamenco', 'Samba'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (8, 'Mia Davis', 'mia.davis@email.com', {'Zumba', 'Latin Dance'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (9, 'Chris Harris', 'chris.harris@email.com', {'Street Jazz', 'Funk'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (10, 'Emma Wilson', 'emma.wilson@email.com', {'Pole Dance', 'Burlesque'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (11, 'Ryan Adams', 'ryan.adams@email.com', {'Bollywood', 'Bhangra'});
INSERT INTO teachers (teacher_id, name, email, danceClasses) VALUES (12, 'Lily Johnson', 'lily.johnson@email.com', {'African Dance', 'Hula'});

//STUDENTS
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(1, 'Alice Johnson', 'alice.johnson@email.com', 20, {'mobile': 1234567890}, {'Ballet', 'Jazz'}, '2023-11-25T12:00:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(2, 'Bob Miller', 'bob.miller@email.com', 22, {'home': 987653211}, {'Hip Hop', 'Contemporary'}, '2023-11-25T13:30:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(3, 'Eva Davis', 'eva.davis@email.com', 25, {'mobile': 555123567}, {'Salsa', 'Tango'}, '2023-11-25T14:45:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(4, 'Charlie White', 'charlie.white@email.com', 28, {'home': 778889999}, {'Ballroom', 'Swing'}, '2023-11-25T16:00:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(5, 'Olivia Brown', 'olivia.brown@email.com', 19, {'mobile': 112223333}, {'Contemporary', 'Irish Dance'}, '2023-11-25T17:15:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(6, 'Daniel Smith', 'daniel.smith@email.com', 23, {'home': 445556666}, {'Breakdance', 'Krumping'}, '2023-11-25T18:30:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(7, 'Grace Turner', 'grace.turner@email.com', 26, {'mobile': 998887777}, {'Flamenco', 'Samba'}, '2023-11-25T19:45:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(8, 'Luke Adams', 'luke.adams@email.com', 30, {'home': 567778888}, {'Contemporary', 'Latin Dance'}, '2023-11-25T21:00:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(9, 'Zoe Harris', 'zoe.harris@email.com', 21, {'mobile': 434445555}, {'Street Jazz', 'Funk'}, '2023-11-25T22:15:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(10, 'Noah Wilson', 'noah.wilson@email.com', 24, {'home': 123334444}, {'Pole Dance', 'Contemporary'}, '2023-11-25T23:30:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(11, 'Ava Turner', 'ava.turner@email.com', 27, {'mobile': 1119998888}, {'Bollywood', 'Contemporary'}, '2023-11-26T09:00:00Z');
INSERT INTO students (student_id, name, email, age, phone_number, frequented_classes, entry_time) VALUES(12, 'Liam Johnson', 'liam.johnson@email.com', 22, {'home': 1112223333}, {'African Dance', 'Ballet'}, '2023-11-26T10:15:00Z');


//DANCE CLASSES
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES (1, 1, {'Monday', 'Wednesday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(2, 2, {'Tuesday', 'Thursday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(3, 3, {'Friday', 'Saturday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(4, 4, {'Sunday', 'Tuesday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(5, 5, {'Wednesday', 'Thursday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(6, 6, {'Monday', 'Friday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(7, 7, {'Saturday', 'Sunday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(8, 8, {'Tuesday', 'Thursday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(9, 9, {'Monday', 'Wednesday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(10, 10, {'Friday', 'Saturday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(11, 11, {'Sunday', 'Tuesday'});
INSERT INTO dance_classes (dance_class_id, teacher_id, week_days)VALUES(12, 12, {'Wednesday', 'Thursday'});

//DANCE SCHOOLS
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES (1, 1, 'Aveiro', {'Monday', 'Wednesday'}, '2012-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(2, 2, 'Aveiro', {'Tuesday', 'Thursday'}, '2000-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(3, 3, 'Aveiro', {'Friday', 'Saturday'}, '1990-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(3, 4, 'Aveiro', {'Sunday', 'Tuesday'}, '1995-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(4, 5, 'Aveiro', {'Wednesday', 'Thursday'}, '1999-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(5, 6, 'Aveiro', {'Monday', 'Friday'}, '1880-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(7, 7, 'Lisboa', {'Saturday', 'Sunday'}, '1980-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(8, 8, 'Lisboa', {'Tuesday', 'Thursday'}, '2020-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(9, 9, 'Coimbra', {'Monday', 'Wednesday'}, '2019-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(10, 10, 'Coimbra', {'Friday', 'Saturday'}, '2016-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(11, 11, 'Aveiro',{'Sunday', 'Tuesday'}, '2015-11-12');
INSERT INTO dance_schools (dance_school_id, teacher_id, district,days, creation_date) VALUES(12, 12, 'Aveiro', {'Wednesday', 'Thursday'}, '2013-11-12');

