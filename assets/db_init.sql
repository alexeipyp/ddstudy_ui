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
    ,whenLiked          TEXT
    ,FOREIGN KEY(id) REFERENCES t_Post(id)
);
CREATE TABLE t_PostSubscribed(
    id                  TEXT NOT NULL PRIMARY KEY
    ,FOREIGN KEY(id) REFERENCES t_Post(id)
);
CREATE TABLE t_PostSearched(
    id                  TEXT NOT NULL PRIMARY KEY
    ,FOREIGN KEY(id) REFERENCES t_Post(id)
);
CREATE TABLE t_Comment(
    id                  TEXT NOT NULL PRIMARY KEY
    ,[text]             TEXT NOT NULL
    ,authorId           TEXT NOT NULL
    ,postId             TEXT NOT NULL
    ,uploadDate         TEXT NOT NULL
    ,FOREIGN KEY(postId) REFERENCES t_Post(id)
    ,FOREIGN KEY(authorId) REFERENCES t_User(id)
);
CREATE TABLE t_CommentStats(
    id                  TEXT NOT NULL PRIMARY KEY
    ,likesAmount        INTEGER NOT NULL
    ,whenLiked          TEXT
    ,FOREIGN KEY(id) REFERENCES t_Comment(id)
);