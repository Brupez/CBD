CREATE KEYSPACE IF NOT EXISTS Ex3_4 WITH REPLICATION = {'class' : 'SimpleStrategy', 'replication_factor' : 3};
USE Ex3_4;

CREATE TABLE teachers
(
    teacher_id int,
    name  text,
    email  text,
    danceClasses set<text>,
    PRIMARY KEY ( teacher_id )
);

CREATE TABLE students
(
    student_id int,
    name  text,
    email  text,
    age int,
    phone_number map<text, int>,
    frequented_classes set<text>,
    entry_time timestamp,
    PRIMARY KEY (student_id, entry_time)
) WITH CLUSTERING ORDER BY (entry_time DESC);
CREATE INDEX ON students(frequented_classes);
CREATE INDEX ON students(phone_number);


CREATE TABLE dance_classes
(
    dance_class_id int,
    teacher_id int,
    week_days set<text>,
    PRIMARY KEY (dance_class_id)
);
CREATE INDEX ON dance_classes(week_days);


CREATE TABLE dance_schools
(
    dance_school_id int,
    teacher_id int,
    district text,
    days set<text>,
    creation_date timestamp,
    PRIMARY KEY (dance_school_id, creation_date)
);
CREATE INDEX ON dance_schools(district);