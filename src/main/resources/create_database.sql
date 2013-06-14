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

CREATE  TABLE users (
  id INT NOT NULL AUTO_INCREMENT ,
  mobile VARCHAR(45) NOT NULL ,
  name VARCHAR(45) NOT NULL ,
  email VARCHAR(45) ,
  cred_type VARCHAR(10) ,
  cred_num VARCHAR(45) NOT NULL ,
  password VARCHAR(200) NOT NULL ,
  birth_date DATE ,
  address VARCHAR(500) ,
  cred_copy BLOB ,
  PRIMARY KEY (id) ,
  UNIQUE INDEX mobile_UNIQUE (mobile ASC) ,
  UNIQUE INDEX cred_id_UNIQUE (cred_id ASC) );

CREATE  TABLE orders (
  id INT NOT NULL AUTO_INCREMENT ,
  readable_id VARCHAR(45) ,
  user_id INT ,
  order_date DATETIME ,
  payment_total DECIMAL(10,2) ,
  payment_status VARCHAR(10) ,
  payment_paid VARCHAR(45) ,
  order_status VARCHAR(10) ,
  translate_1 VARCHAR(10) ,
  translate_2 VARCHAR(10) ,
  translate_3 VARCHAR(10) ,
  destination VARCHAR(10) ,
  cert_num INT ,
  cert_purpose VARCHAR(10) ,
  PRIMARY KEY (id) );
