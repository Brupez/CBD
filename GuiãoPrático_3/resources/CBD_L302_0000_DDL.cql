CREATE TABLE users
(
    username  text PRIMARY KEY ,
    name  text,
    email  text,
    selo_temporal timestamp
);

DROP TABLE videos;
CREATE TABLE videos
(
    video_id int,
    author  text,
    name  text,
    email  text,
    tags set<text>,
    selo_temporal_videos timestamp,
    PRIMARY KEY (video_id, selo_temporal_videos)
) WITH CLUSTERING ORDER BY (selo_temporal_videos DESC);
CREATE INDEX ON videos(tags);



CREATE TABLE videosByAuthor
(
    video_id int,
    author text,
    selo_temporal_videosByAuthor timestamp,
    PRIMARY KEY (author, selo_temporal_videosByAuthor)
) WITH CLUSTERING ORDER BY (selo_temporal_videosByAuthor DESC);


CREATE TABLE comments
(
    comment_id int,
    user_id int,
    video_id int,
    comment text,
    selo_temporal_comment timestamp,
    PRIMARY KEY (user_id,selo_temporal_comment)
) WITH CLUSTERING ORDER BY (selo_temporal_comment DESC);


CREATE TABLE video_followers
(
    video_id int,
    user_id int,
    PRIMARY KEY (video_id, user_id)
);


CREATE TABLE events
(
    video_id int ,
    user_id int,
    event_type text,
    video_seconds int,
    selo_temporal_event timestamp,
    PRIMARY KEY ((video_id, user_id), selo_temporal_event)
) WITH CLUSTERING ORDER BY (selo_temporal_event DESC );

DROP TABLE rating_videos;
CREATE TABLE rating_videos
(
    rating_id UUID,
    video_id int,
    author text,
    rating int,
    PRIMARY KEY (video_id, rating)
) WITH CLUSTERING ORDER BY (rating DESC);


DROP TABLE commentsByVideos;
CREATE TABLE commentsByUsers
(
    username text,
    comment text,
    selo_temporal_commentsByUsers timestamp,
    PRIMARY KEY ( username, selo_temporal_commentsByUsers )

) WITH CLUSTERING ORDER BY (selo_temporal_commentsByUsers DESC);


CREATE TABLE commentsByVideos
(
    video_id int,
    comment text,
    selo_temporal_commentsByVideos timestamp,
    PRIMARY KEY ( video_id,  selo_temporal_commentsByVideos)

) WITH CLUSTERING ORDER BY (selo_temporal_commentsByVideos DESC);