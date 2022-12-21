CREATE TABLE t_User(
    id                  TEXT NOT NULL PRIMARY KEY
    ,[name]             TEXT NOT NULL
    ,email              TEXT NOT NULL
    ,birthDate          TEXT NOT NULL
    ,avatarLink         TEXT
);
CREATE TABLE t_UserActivity(
    id                  TEXT NOT NULL PRIMARY KEY
    ,postsAmount        INTEGER NOT NULL
    ,followersAmount    INTEGER NOT NULL
    ,followingAmount    INTEGER NOT NULL
    ,FOREIGN KEY(id) REFERENCES t_User(id)
);
CREATE TABLE t_Post(
    id                  TEXT NOT NULL PRIMARY KEY
    ,[annotation]       TEXT
    ,authorId           TEXT NOT NULL
    ,uploadDate         TEXT NOT NULL
    ,FOREIGN KEY(authorId) REFERENCES t_User(id)
);
CREATE TABLE t_PostAttach(
    id                  TEXT NOT NULL PRIMARY KEY
    ,[name]             TEXT NOT NULL
    ,mimeType           TEXT NOT NULL
    ,attachLink         TEXT NOT NULL
    ,postId             TEXT NOT NULL
    ,FOREIGN KEY(postId) REFERENCES t_Post(id)
);
CREATE TABLE t_PostStats(
    id                  TEXT NOT NULL PRIMARY KEY
    ,commentsAmount     INTEGER NOT NULL
    ,likesAmount        INTEGER NOT NULL
    ,isLiked            INTEGER NOT NULL
);