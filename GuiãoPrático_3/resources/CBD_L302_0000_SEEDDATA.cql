//USERS
INSERT INTO users (username, name, email, selo_temporal) VALUES ('Brupez', 'Bruno', 'brunolop50@gmail.com', '2023-11-13 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('lets go', 'Rafael', 'brunolop@gmail.com', '2023-11-01 11:10:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('la', 'Santos', 'bruno@gmail.com', '2023-11-04 09:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('vamos', 'Lopes', '50@gmail.com', '2023-11-08 14:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('oGrande', 'Ines', 'ogrande@hotmail.com', '2023-11-11 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('aquilo', 'Isabel', 'enorme@outlook.com', '2023-08-13 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('isto', 'Pinheiro', 'brunolop50@gmail.com', '2023-09-13 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('outro', 'Lopes', 'outro@gmail.com', '2023-05-13 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('aquele', 'Ana', 'aquele@gmail.com', '2023-08-20 08:50:00');
INSERT INTO users (username, name, email, selo_temporal) VALUES ('este', 'Sofia', 'este@gmail.com', '2023-11-01 15:50:00');

SELECT json * FROM users;

+----------------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                                |
+----------------------------------------------------------------------------------------------------------------------+
|{"username": "lets go", "email": "brunolop@gmail.com", "name": "Rafael", "selo_temporal": "2023-11-01 11:10:00.000Z"} |
|{"username": "aquilo", "email": "enorme@outlook.com", "name": "Isabel", "selo_temporal": "2023-08-13 08:50:00.000Z"}  |
|{"username": "este", "email": "este@gmail.com", "name": "Sofia", "selo_temporal": "2023-11-01 15:50:00.000Z"}         |
|{"username": "aquele", "email": "aquele@gmail.com", "name": "Ana", "selo_temporal": "2023-08-20 08:50:00.000Z"}       |
|{"username": "outro", "email": "outro@gmail.com", "name": "Lopes", "selo_temporal": "2023-05-13 08:50:00.000Z"}       |
|{"username": "isto", "email": "brunolop50@gmail.com", "name": "Pinheiro", "selo_temporal": "2023-09-13 08:50:00.000Z"}|
|{"username": "la", "email": "bruno@gmail.com", "name": "Santos", "selo_temporal": "2023-11-04 09:50:00.000Z"}         |
|{"username": "oGrande", "email": "ogrande@hotmail.com", "name": "Ines", "selo_temporal": "2023-11-11 08:50:00.000Z"}  |
|{"username": "vamos", "email": "50@gmail.com", "name": "Lopes", "selo_temporal": "2023-11-08 14:50:00.000Z"}          |
|{"username": "Brupez", "email": "brunolop50@gmail.com", "name": "Bruno", "selo_temporal": "2023-11-13 08:50:00.000Z"} |
+----------------------------------------------------------------------------------------------------------------------+

//VIDEOS
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (1, 'Bruno', 'The Matrix','thematrix@gmail.com', {'ação', 'ficção cientifica'}, '2020-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (2, 'Marcos', 'Shrek','shreck@gmail.com', {'ação', 'animação'}, '1994-09-09');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (3, 'Diogo', 'Panda Kung Fu','pandakungfu@gmail.com', {'ação', 'animação', 'comédia'}, '2023-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (4, 'Marques', 'Inception','inception@gmail.com', {'ação', 'ficção cientifica'}, '2023-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (5, 'Bruno', 'Hercules','hercules@gmail.com', {'ação', 'ficção cientifica', 'Aveiro'}, '2023-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (6, 'Bruno', 'Interstellar','interstellar@gmail.com', {'ficção cientifica'}, '2023-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (7, 'Bruno', 'Tenet','tenet@gmail.com', {'Aveiro', 'ação', 'ficção cientifica'}, '1994-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (8, 'Bruno', 'Rei Leão','reileao@gmail.com', {'animação', 'fantasia'}, '1985-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (9, 'Bruno', 'Alice no país das maravilhas','alicenopaisdasmaravilhas@gmail.com', {'animação', 'fantasia'}, '1900-11-13');
INSERT INTO videos (video_id, author, name, email, tags, selo_temporal_videos) VALUES (10, 'Bruno', 'Pirata das caraibas','piratadascaraibas@gmail.com', {'Aveiro', 'ação', 'thriller'}, '1955-11-13');


SELECT json * FROM videos;

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                                                                                                                         |
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
|{"author": "Marcos", "selo_temporal_videos": "1994-09-09 00:00:00.000Z", "email": "shreck@gmail.com", "name": "Shrek", "tags": ["ação", "animação"], "video_id": 2}                                            |
|{"author": "Marques", "selo_temporal_videos": "2023-11-13 00:00:00.000Z", "email": "inception@gmail.com", "name": "Inception", "tags": ["ação", "ficção cientifica"], "video_id": 4}                           |
|{"author": "Diogo", "selo_temporal_videos": "2023-11-13 00:00:00.000Z", "email": "pandakungfu@gmail.com", "name": "Panda Kung Fu", "tags": ["ação", "animação", "comédia"], "video_id": 3}                     |
|{"author": "Lopez", "selo_temporal_videos": "2014-08-11 00:00:00.000Z", "email": "ac@gmail.com", "name": "Assassins Creed", "tags": ["ação", "historical"], "video_id": 11}                                    |
|{"author": "Bruno", "selo_temporal_videos": "2023-11-13 00:00:00.000Z", "email": "interstellar@gmail.com", "name": "Interstellar", "tags": ["ficção cientifica"], "video_id": 6}                               |
|{"author": "Bruno", "selo_temporal_videos": "2020-11-13 00:00:00.000Z", "email": "brunolopes@gmail.com", "name": "Bruno Lopes", "tags": ["ação", "ficção cientifica"], "video_id": 1}                          |
|{"author": "Bruno", "selo_temporal_videos": "1994-11-13 00:00:00.000Z", "email": "tenet@gmail.com", "name": "Tenet", "tags": ["Aveiro", "ação", "ficção cientifica"], "video_id": 7}                           |
|{"author": "Bruno", "selo_temporal_videos": "1985-11-13 00:00:00.000Z", "email": "reileao@gmail.com", "name": "Rei Leão", "tags": ["animação", "fantasia"], "video_id": 8}                                     |
|{"author": "Bruno", "selo_temporal_videos": "1955-11-13 00:00:00.000Z", "email": "piratadascaraibas@gmail.com", "name": "Pirata das caraibas", "tags": ["Aveiro", "ação", "thriller"], "video_id": 10}         |
|{"author": "Bruno", "selo_temporal_videos": "1900-11-13 00:00:00.000Z", "email": "alicenopaisdasmaravilhas@gmail.com", "name": "Alice no país das maravilhas", "tags": ["animação", "fantasia"], "video_id": 9}|
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

//COMMENTS
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (1, 1, 1, 'I am ready!', '1804-05-01 00:00:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (2, 3, 2, 'Lets go!', '1990-07-13 04:50:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (3, 2, 3, 'Great!', '1999-11-15 08:50:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (4, 10, 4, 'Beautifull!', '2001-01-01 14:50:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (5, 7, 5, 'Cassandra!', '2002-11-13 11:30:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (6, 6, 6, 'Oh yeah baby!', '2005-12-12 20:50:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (7, 5, 7, 'this is awesome!', '2023-10-13 08:50:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (8, 10, 8, 'Perfect!', '2020-10-22 07:55:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (9, 9, 9, 'Not Perfect!', '2021-08-13 22:45:00');
INSERT INTO comments (comment_id, user_id, video_id, comment, selo_temporal_comment) VALUES (10, 8, 10, 'More sore above!', '2019-05-05 11:50:00');

SELECT json * FROM comments;
+------------------------------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                                              |
+------------------------------------------------------------------------------------------------------------------------------------+
|{"user_id": 5, "selo_temporal_comment": "2023-10-13 08:50:00.000Z", "comment": "this is awesome!", "comment_id": 7, "video_id": 7}  |
|{"user_id": 10, "selo_temporal_comment": "2020-10-22 07:55:00.000Z", "comment": "Perfect!", "comment_id": 8, "video_id": 8}         |
|{"user_id": 10, "selo_temporal_comment": "2001-01-01 14:50:00.000Z", "comment": "Beautifull!", "comment_id": 4, "video_id": 4}      |
|{"user_id": 1, "selo_temporal_comment": "1804-05-01 00:00:00.000Z", "comment": "I am ready!", "comment_id": 1, "video_id": 1}       |
|{"user_id": 8, "selo_temporal_comment": "2019-05-05 11:50:00.000Z", "comment": "More sore above!", "comment_id": 10, "video_id": 10}|
|{"user_id": 2, "selo_temporal_comment": "1999-11-15 08:50:00.000Z", "comment": "Great!", "comment_id": 3, "video_id": 3}            |
|{"user_id": 7, "selo_temporal_comment": "2002-11-13 11:30:00.000Z", "comment": "Cassandra!", "comment_id": 5, "video_id": 5}        |
|{"user_id": 6, "selo_temporal_comment": "2005-12-12 20:50:00.000Z", "comment": "Oh yeah baby!", "comment_id": 6, "video_id": 6}     |
|{"user_id": 9, "selo_temporal_comment": "2021-08-13 22:45:00.000Z", "comment": "Not Perfect!", "comment_id": 9, "video_id": 9}      |
|{"user_id": 3, "selo_temporal_comment": "1990-07-13 04:50:00.000Z", "comment": "Lets go!", "comment_id": 2, "video_id": 2}          |
+------------------------------------------------------------------------------------------------------------------------------------+


//VIDEO FOLLOWERS
INSERT INTO video_followers (user_id, video_id) VALUES (1, 1);
INSERT INTO video_followers (user_id, video_id) VALUES (2, 1);
INSERT INTO video_followers (user_id, video_id) VALUES (3, 2);
INSERT INTO video_followers (user_id, video_id) VALUES (4, 2);
INSERT INTO video_followers (user_id, video_id) VALUES (5, 2);
INSERT INTO video_followers (user_id, video_id) VALUES (6, 2);
INSERT INTO video_followers (user_id, video_id) VALUES (7, 3);
INSERT INTO video_followers (user_id, video_id) VALUES (8, 3);
INSERT INTO video_followers (user_id, video_id) VALUES (9, 4);
INSERT INTO video_followers (user_id, video_id) VALUES (10, 5);

SELECT json * FROM video_followers;
+------------------------------+
|[json]                        |
+------------------------------+
|{"video_id": 5, "user_id": 10}|
|{"video_id": 1, "user_id": 1} |
|{"video_id": 1, "user_id": 2} |
|{"video_id": 2, "user_id": 3} |
|{"video_id": 2, "user_id": 4} |
|{"video_id": 2, "user_id": 5} |
|{"video_id": 2, "user_id": 6} |
|{"video_id": 4, "user_id": 9} |
|{"video_id": 3, "user_id": 7} |
|{"video_id": 3, "user_id": 8} |
+------------------------------+

//EVENTS
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'play', 300, '1804-05-01 00:00:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'play', 600, '1990-07-13 04:50:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'pause', 900, '1999-11-15 08:50:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (4,2, 'pause', 500, '2001-01-01 14:50:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (2,2, 'pause', 30, '2002-11-13 11:30:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'stop', 6, '2005-12-12 20:50:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (7,2, 'stop', 340, '2023-10-13 08:50:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'play', 680, '2020-10-22 07:55:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (9,3, 'play', 1000, '2021-08-13 22:45:00');
INSERT INTO events (video_id, user_id, event_type, video_seconds, selo_temporal_event) VALUES (1,1, 'stop', 2000, '2019-05-05 11:50:00');

SELECT json * FROM events;
+-----------------------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                                       |
+-----------------------------------------------------------------------------------------------------------------------------+
|{"video_id": 2, "user_id": 2, "selo_temporal_event": "2002-11-13 11:30:00.000Z", "event_type": "pause", "video_seconds": 30} |
|{"video_id": 4, "user_id": 2, "selo_temporal_event": "2001-01-01 14:50:00.000Z", "event_type": "pause", "video_seconds": 500}|
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "2020-10-22 07:55:00.000Z", "event_type": "play", "video_seconds": 680} |
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "2019-05-05 11:50:00.000Z", "event_type": "stop", "video_seconds": 2000}|
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "2005-12-12 20:50:00.000Z", "event_type": "stop", "video_seconds": 6}   |
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "1999-11-15 08:50:00.000Z", "event_type": "pause", "video_seconds": 900}|
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "1990-07-13 04:50:00.000Z", "event_type": "play", "video_seconds": 600} |
|{"video_id": 1, "user_id": 1, "selo_temporal_event": "1804-05-01 00:00:00.000Z", "event_type": "play", "video_seconds": 300} |
|{"video_id": 9, "user_id": 3, "selo_temporal_event": "2021-08-13 22:45:00.000Z", "event_type": "play", "video_seconds": 1000}|
|{"video_id": 7, "user_id": 2, "selo_temporal_event": "2023-10-13 08:50:00.000Z", "event_type": "stop", "video_seconds": 340} |
+-----------------------------------------------------------------------------------------------------------------------------+

//RATING_VIDEOS
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 10, 98);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 9, 95);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 8, 45);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 7, 30);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 6, 25);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 10, 35);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 4, 45);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 3, 56);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES (uuid(), 2, 60);
INSERT INTO rating_videos (rating_id, video_id, rating) VALUES ((uuid()), 1, 0);

SELECT json * FROM rating_videos;
+-----------------------------------------------------------------------------------+
|[json]                                                                             |
+-----------------------------------------------------------------------------------+
|{"rating_id": "364a2eb7-e5f4-4dc9-bbdc-5ab783a02014", "rating": 60, "video_id": 2} |
|{"rating_id": "28126a8f-3880-4d7a-8ea7-ab146a98c1ab", "rating": 60, "video_id": 2} |
|{"rating_id": "24df733c-5462-40c7-b54e-cd753b0297b2", "rating": 95, "video_id": 9} |
|{"rating_id": "3b67587c-233a-4036-88f3-30cc149b4dfa", "rating": 35, "video_id": 10}|
|{"rating_id": "47f4ec50-e4ad-4e18-bb34-b98a09545d98", "rating": 56, "video_id": 3} |
|{"rating_id": "6bf3f1b5-14b9-484d-bcff-f4ddc945af40", "rating": 45, "video_id": 8} |
|{"rating_id": "2c1b3606-5336-4b27-a790-9ab2074551ba", "rating": 98, "video_id": 10}|
|{"rating_id": "43f6be70-498d-482b-8d08-7d8ee7a694ed", "rating": 35, "video_id": 10}|
|{"rating_id": "e0af27c7-f41a-49bd-a250-0dee3476e9ea", "rating": 45, "video_id": 4} |
|{"rating_id": "bd11d117-1044-4312-8598-724652aaa57b", "rating": 56, "video_id": 3} |
|{"rating_id": "b494aaac-62c7-41e4-9e9e-5ad846b74b10", "rating": 30, "video_id": 7} |
|{"rating_id": "b95ce144-a1e4-4227-8d29-ac5b8fd041c2", "rating": 45, "video_id": 8} |
|{"rating_id": "7da64e88-859d-4ffc-b9cc-2a092c179543", "rating": 95, "video_id": 9} |
|{"rating_id": "bfe2dc3d-fe9c-4f79-8b8f-ee014db7daf7", "rating": 45, "video_id": 4} |
|{"rating_id": "68fa20a5-6744-42c3-9ab5-d649090ff22b", "rating": 0, "video_id": 1}  |
|{"rating_id": "9edb9188-c1ce-4a58-b76f-6dd6f3e47df6", "rating": 30, "video_id": 7} |
|{"rating_id": "c647cc25-adb9-46d2-8726-692fbda32e59", "rating": 25, "video_id": 6} |
|{"rating_id": "6b46ca36-67c6-47b8-9a7d-ca421238b75a", "rating": 25, "video_id": 6} |
|{"rating_id": "844f4fc4-1459-4000-8d8c-31b003c6bcfd", "rating": 0, "video_id": 1}  |
|{"rating_id": "05da923b-d141-4d44-9aee-0fc510b34764", "rating": 98, "video_id": 10}|
+-----------------------------------------------------------------------------------+

//COMMENTS BY USERS
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('Brupez', 'Cassandra!', '2023-11-16 12:34:56');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('lets go', 'Oh yeah baby!', '2022-11-16 13:45:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('la', 'Not Perfect!', '2020-11-16 14:56:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('vamos', 'I am ready!', '1999-11-16 15:20:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('oGrande', 'Lets go!', '1994-11-16 16:46:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('aquilo' ,'More sore above!', '2009-11-16 17:09:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('isto','Perfect!', '2015-11-16 18:00:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('outro', 'Beautifull!', '222-11-16 19:01:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('aquele', 'Great!', '2001-11-16 20:12:00');
INSERT INTO commentsByUsers (username, comment, selo_temporal_commentsByUsers) VALUES ('este', 'this is awesome!', '2000-11-16 21:23:00');

SELECT json * FROM commentsByUsers;
+------------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                            |
+------------------------------------------------------------------------------------------------------------------+
|{"username": "lets go", "selo_temporal_commentsbyusers": "2022-11-16 13:45:00.000Z", "comment": "Oh yeah baby!"}  |
|{"username": "aquilo", "selo_temporal_commentsbyusers": "2009-11-16 17:09:00.000Z", "comment": "More sore above!"}|
|{"username": "este", "selo_temporal_commentsbyusers": "2000-11-16 21:23:00.000Z", "comment": "this is awesome!"}  |
|{"username": "aquele", "selo_temporal_commentsbyusers": "2001-11-16 20:12:00.000Z", "comment": "Great!"}          |
|{"username": "outro", "selo_temporal_commentsbyusers": "0222-11-16 19:01:00.000Z", "comment": "Beautifull!"}      |
|{"username": "isto", "selo_temporal_commentsbyusers": "2015-11-16 18:00:00.000Z", "comment": "Perfect!"}          |
|{"username": "la", "selo_temporal_commentsbyusers": "2020-11-16 14:56:00.000Z", "comment": "Not Perfect!"}        |
|{"username": "oGrande", "selo_temporal_commentsbyusers": "1994-11-16 16:46:00.000Z", "comment": "Lets go!"}       |
|{"username": "vamos", "selo_temporal_commentsbyusers": "1999-11-16 15:20:00.000Z", "comment": "I am ready!"}      |
|{"username": "Brupez", "selo_temporal_commentsbyusers": "2023-11-16 12:34:56.000Z", "comment": "Cassandra!"}      |
+------------------------------------------------------------------------------------------------------------------+

//COMMENTS BY VIDEOS
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (1, 'I am ready!', '2023-11-16 12:34:56');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (2, 'Lets go!', '2023-11-16 13:45:00');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (3, 'Great!', '2023-11-16 14:56:00');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (4, 'Beautifull!', '2023-11-16 15:05:25');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (5, 'Cassandra!', '2023-11-16 16:18:15');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (6, 'Oh yeah baby!', '2023-11-16 17:40:01');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (7, 'this is awesome!', '2023-11-16 18:45:12');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (8, 'Perfect!', '2023-11-16 19:01:23');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (9, 'Not Perfect!', '2023-11-16 20:12:34');
INSERT INTO commentsByVideos (video_id, comment, selo_temporal_commentsByVideos) VALUES (10, 'More sore above!', '2023-11-16 21:23:45');

SELECT json * FROM commentsByVideos;+-------------------------------------------------------------------------------------------------------------+
|[json]                                                                                                       |
+-------------------------------------------------------------------------------------------------------------+
|{"video_id": 5, "selo_temporal_commentsbyvideos": "2023-11-16 16:18:15.000Z", "comment": "Cassandra!"}       |
|{"video_id": 10, "selo_temporal_commentsbyvideos": "2023-11-16 21:23:45.000Z", "comment": "More sore above!"}|
|{"video_id": 1, "selo_temporal_commentsbyvideos": "2023-11-16 12:34:56.000Z", "comment": "I am ready!"}      |
|{"video_id": 8, "selo_temporal_commentsbyvideos": "2023-11-16 19:01:23.000Z", "comment": "Perfect!"}         |
|{"video_id": 2, "selo_temporal_commentsbyvideos": "2023-11-16 13:45:00.000Z", "comment": "Lets go!"}         |
|{"video_id": 4, "selo_temporal_commentsbyvideos": "2023-11-16 15:05:25.000Z", "comment": "Beautifull!"}      |
|{"video_id": 7, "selo_temporal_commentsbyvideos": "2023-11-16 18:45:12.000Z", "comment": "this is awesome!"} |
|{"video_id": 6, "selo_temporal_commentsbyvideos": "2023-11-16 17:40:01.000Z", "comment": "Oh yeah baby!"}    |
|{"video_id": 9, "selo_temporal_commentsbyvideos": "2023-11-16 20:12:34.000Z", "comment": "Not Perfect!"}     |
|{"video_id": 3, "selo_temporal_commentsbyvideos": "2023-11-16 14:56:00.000Z", "comment": "Great!"}           |
+-------------------------------------------------------------------------------------------------------------+


//VIDEOS BY AUTHOR
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (1, 'Bruno','2023-05-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (2, 'Marcos','2023-08-20');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (3, 'Diogo', '1994-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (4, 'Marques', '1990-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (5, 'Bruno', '2000-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (10,'Bruno','2005-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (7, 'Bruno','2009-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (8, 'Bruno','2010-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (9, 'Bruno','2013-11-13');
INSERT INTO videosByAuthor (video_id, author, selo_temporal_videosByAuthor) VALUES (10, 'Bruno', '1800-11-13');

SELECT json * FROM videosByAuthor;

+------------------------------------------------------------------------------------------------+
|[json]                                                                                          |
+------------------------------------------------------------------------------------------------+
|{"author": "Marcos", "selo_temporal_videosbyauthor": "2023-08-20 00:00:00.000Z", "video_id": 2} |
|{"author": "Marques", "selo_temporal_videosbyauthor": "1990-11-13 00:00:00.000Z", "video_id": 4}|
|{"author": "Diogo", "selo_temporal_videosbyauthor": "1994-11-13 00:00:00.000Z", "video_id": 3}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2023-05-13 00:00:00.000Z", "video_id": 1}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2013-11-13 00:00:00.000Z", "video_id": 9}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2010-11-13 00:00:00.000Z", "video_id": 8}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2009-11-13 00:00:00.000Z", "video_id": 7}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2005-11-13 00:00:00.000Z", "video_id": 10} |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "2000-11-13 00:00:00.000Z", "video_id": 5}  |
|{"author": "Bruno", "selo_temporal_videosbyauthor": "1800-11-13 00:00:00.000Z", "video_id": 10} |
+------------------------------------------------------------------------------------------------+



