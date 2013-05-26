-- create the database
DROP DATABASE IF EXISTS changning;
CREATE DATABASE changning;

GRANT ALL PRIVILEGES ON changning.* TO cn@localhost IDENTIFIED BY "easy";

-- select the database
USE changning;

CREATE TABLE test
(
  test_id              INT            PRIMARY KEY   AUTO_INCREMENT,
  test_description     VARCHAR(300)    NOT NULL
);

INSERT INTO test VALUES
(1,'test1'),
(2,'test2'),
(3,'test3'),
(4,'test4'),
(5,'test5');