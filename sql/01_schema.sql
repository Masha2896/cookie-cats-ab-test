CREATE TABLE cookie_cats (
    userid         integer PRIMARY KEY,
    version        varchar(10) NOT NULL,
    sum_gamerounds integer NOT NULL,
    retention_1    boolean NOT NULL,
    retention_7    boolean NOT NULL
);