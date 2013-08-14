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
  `gender` VARCHAR(20) NULL ,
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
  `trans_lang` VARCHAR(20) NULL ,
  `need_verify` VARCHAR(20) NULL ,
  `destination` VARCHAR(20) NULL ,
  `cert_purpose` VARCHAR(20) NULL ,
  `cert_copy_count` INT NULL ,
  `send_doc` VARCHAR(20) NULL ,
  `send_address` VARCHAR(500) NULL ,
  `send_date` DATE NULL ,
  `requestor_name` VARCHAR(45) NULL ,
  `requestor_gender` VARCHAR(20) NULL ,
  `requestor_mobile` VARCHAR(45) NULL ,
  `reqeustor_email` VARCHAR(45) NULL ,
  `requestor_address` VARCHAR(500) NULL ,
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
  `doc_size` INT NULL ,
  `content_type` VARCHAR(50) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `order_doc_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `order_doc_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`relative_infos` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `relative_type` VARCHAR(20) NULL ,
  `relative_name` VARCHAR(50) NULL ,
  `form_item_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `form_items_fk_idx` (`form_item_id` ASC) ,
  CONSTRAINT `form_items_fk`
    FOREIGN KEY (`form_item_id` )
    REFERENCES `changning`.`form_items` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`fee_items` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `fee_key` VARCHAR(45) NULL ,
  `fee_name` VARCHAR(45) NULL ,
  `notary_fee` DECIMAL(10,2) NULL ,
  `copy_fee` DECIMAL(10,2) NULL ,
  `word_trans_fee` DECIMAL(10,2) NULL ,
  `file_trans_fee` DECIMAL(10,2) NULL ,
  `investigate_fee` DECIMAL(10,2) NULL ,
  `form_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fee_form_fk_idx` (`form_id` ASC) ,
  CONSTRAINT `fee_form_fk`
    FOREIGN KEY (`form_id` )
    REFERENCES `changning`.`forms` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `role_name` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) );

CREATE  TABLE IF NOT EXISTS `changning`.`user_roles` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NULL ,
  `role_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `user_role_user_fk_idx` (`user_id` ASC) ,
  INDEX `user_role_role_fk_idx` (`role_id` ASC) ,
  CONSTRAINT `user_role_user_fk`
    FOREIGN KEY (`user_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `user_role_role_fk`
    FOREIGN KEY (`role_id` )
    REFERENCES `changning`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

insert into roles (role_name) values ('admin');
insert into roles (role_name) values ('staff');
insert into roles (role_name) values ('user');

INSERT INTO `changning`.`users` (mobile, name, gender, email, cred_type, cred_id, password, address)
VALUES ('13524173173', '刘峻', 'MALE', 'pairliu@gmail.com', 'ID_CARD', '440306199983273137', 'e19d5cd5af0378da05f63f891c7467af', 'adfadfasdfasdf');
INSERT INTO `changning`.`users` (mobile, name, gender, email, cred_type, cred_id, password, address)
VALUES ('18621910893', 'aaa', 'MALE', 'test@test.com', 'ID_CARD', '440306199983274248', 'e19d5cd5af0378da05f63f891c7467af', 'zzzzzzzzzzzz');

insert into user_roles (user_id, role_id) values (1, 3);
insert into user_roles (user_id, role_id) values (2, 2);
