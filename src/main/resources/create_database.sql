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

CREATE  TABLE IF NOT EXISTS `changning`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `mobile` VARCHAR(45) NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `email` VARCHAR(45) NULL ,
  `cred_type` VARCHAR(20) NULL ,
  `cred_id` VARCHAR(45) NULL ,
  `cred_copy` BLOB NULL ,
  `password` VARCHAR(200) NULL ,
  `birth_date` DATE NULL ,
  `address` VARCHAR(500) NULL ,
  PRIMARY KEY (`id`) );

CREATE  TABLE IF NOT EXISTS `changning`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `readable_id` VARCHAR(45) NULL ,
  `user_id` INT NULL ,
  `order_date` DATE NULL ,
  `payment_total` DECIMAL(10,2) NULL ,
  `payment_status` VARCHAR(20) NULL ,
  `payment_paid` DECIMAL(10,2) NULL ,
  `order_status` VARCHAR(20) NULL ,
  `need_translation` VARCHAR(20) NULL ,
  `destination` VARCHAR(20) NULL ,
  `cert_purpose` VARCHAR(20) NULL ,
  `cert_copy_count` INT NULL ,
  `visit_for_doc` VARCHAR(20) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `user_fk_idx` (`user_id` ASC) ,
  CONSTRAINT `user_fk`
    FOREIGN KEY (`user_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`forms` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `form_key` VARCHAR(50) NULL ,
  `form_name` VARCHAR(50) NULL ,
  `order_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `order_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `order_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`form_items` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `form_id` INT NULL ,
  `item_key` VARCHAR(50) NULL ,
  `item_name` VARCHAR(50) NULL ,
  `item_value` VARCHAR(500) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `form_fk_idx` (`form_id` ASC) ,
  CONSTRAINT `form_fk`
    FOREIGN KEY (`form_id` )
    REFERENCES `changning`.`forms` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`doc_items` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NULL ,
  `doc_key` VARCHAR(50) NULL ,
  `doc_name` VARCHAR(50) NULL ,
  `doc_path` VARCHAR(500) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `doc_order_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `doc_order_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
