-- create the database
DROP DATABASE IF EXISTS changning;
CREATE DATABASE changning;

GRANT ALL PRIVILEGES ON changning.* TO cn@localhost IDENTIFIED BY "CNGZ6408HCLWYLK";

-- select the database
USE changning;

CREATE  TABLE IF NOT EXISTS `changning`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `mobile` VARCHAR(45) NOT NULL ,
  `name` VARCHAR(45) NULL ,
  `name_pinyin` VARCHAR(45) NULL ,
  `gender` VARCHAR(20) NULL ,
  `email` VARCHAR(45) NULL ,
  `cred_type` VARCHAR(20) NULL ,
  `cred_id` VARCHAR(45) NULL ,
  `cred_copy` BLOB NULL ,
  `password` VARCHAR(200) NULL ,
  `birth_date` DATE NULL ,
  `address` VARCHAR(500) NULL ,
    PRIMARY KEY (`id`) );

alter table `changning`.`users` add column `allow_status` VARCHAR(30) NULL;

CREATE  TABLE IF NOT EXISTS `changning`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `readable_id` VARCHAR(45) NULL ,
  `backend_notary_id` VARCHAR(45) NULL ,
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
  `cert_custom_purpose` VARCHAR(100) NULL ,
  `cert_copy_count` INT NULL ,
  `skip_send_doc` VARCHAR(20) NULL ,
  `send_doc` VARCHAR(20) NULL ,
  `send_address` VARCHAR(500) NULL ,
  `send_date` VARCHAR(20) NULL ,
  `requestor_name` VARCHAR(45) NULL ,
  `requestor_name_pinyin` VARCHAR(45) NULL ,
  `requestor_gender` VARCHAR(20) NULL ,
  `requestor_birth_date` DATE NULL ,
  `requestor_mobile` VARCHAR(45) NULL ,
  `reqeustor_email` VARCHAR(45) NULL ,
  `requestor_address` VARCHAR(500) NULL ,
  `accepter_id` INT NULL ,
  `upload_note` VARCHAR(1000) NULL ,
  `cancel_note` VARCHAR(1000) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `user_fk_idx` (`user_id` ASC) ,
  INDEX `accepter_fk_idx` (`accepter_id` ASC) ,
  CONSTRAINT `user_fk`
    FOREIGN KEY (`user_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `accepter_fk`
    FOREIGN KEY (`accepter_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`order_notes` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NULL ,
  `user_id` INT NULL ,
  `note_content` VARCHAR(1000) NULL ,
  `note_date` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `order_notes_order_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `order_notes_orders_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION);
    
CREATE  TABLE IF NOT EXISTS `changning`.`payment` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` int NULL ,
  `payment_date` DATE NULL ,
  `payment_total` DECIMAL(10,2) NULL ,
  `payment_reason` VARCHAR(400) NULL ,
  `refund_date` DATE NULL ,
  `refund_total` DECIMAL(10,2) NULL ,
  `status` VARCHAR(20) NULL ,  
  `title` VARCHAR(400) NULL ,
  `refund_reason` VARCHAR(400) NULL ,
  `order_txn_no` VARCHAR(50) NULL ,
  `alipay_txn_no` VARCHAR(50) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `order_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `order_pay_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

    
CREATE  TABLE IF NOT EXISTS `changning`.`sequence` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `category` VARCHAR(50) NULL ,
  `segment1` VARCHAR(50) NULL ,
  `segment2` INT NULL, 
  PRIMARY KEY (`id`));

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
    ON DELETE CASCADE
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
    ON DELETE CASCADE
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
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`relative_infos` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `relative_type` VARCHAR(20) NULL ,
  `relative_name` VARCHAR(50) NULL ,
  `relative_pinyin` VARCHAR(50) NULL ,
  `form_item_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `form_items_fk_idx` (`form_item_id` ASC) ,
  CONSTRAINT `form_items_fk`
    FOREIGN KEY (`form_item_id` )
    REFERENCES `changning`.`form_items` (`id` )
    ON DELETE CASCADE
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
    ON DELETE CASCADE
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
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `user_role_role_fk`
    FOREIGN KEY (`role_id` )
    REFERENCES `changning`.`roles` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`workdays` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `date` DATE NULL ,
  `year` INT NULL ,
  `month` INT NULL ,
  `day` INT NULL ,
  `type` VARCHAR(20) NULL ,
  `description` VARCHAR(500) NULL ,
  `batch` VARCHAR(20) NULL ,
  PRIMARY KEY (`id`) );

CREATE  TABLE IF NOT EXISTS `changning`.`time_segments` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `start_time` VARCHAR(45) NULL ,
  `duration` INT NULL ,
  `resv_count` INT NULL ,
  `workday_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `ts_wk_fk_idx` (`workday_id` ASC) ,
  CONSTRAINT `ts_wk_fk`
    FOREIGN KEY (`workday_id` )
    REFERENCES `changning`.`workdays` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`Reservations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `readable_id` VARCHAR(45) NULL ,
  `user_id` INT NULL ,
  `requestor_name` VARCHAR(45) NULL ,
  `requestor_mobile` VARCHAR(45) NULL ,
  `reserve_key` VARCHAR(50) NULL ,
  `reserve_status` VARCHAR(20) NULL ,
  `reserve_date` DATE NULL ,
  `reserve_time_segment` VARCHAR(50) NULL,
  `creation_date` DATE NULL ,
  `accepter_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `Reservations_Users_Fk_idx` (`user_id` ASC) ,
  INDEX `reserv_accepter_fk_idx` (`accepter_id` ASC) ,
  CONSTRAINT `reservations_users_fk`
    FOREIGN KEY (`user_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `reserv_accepter_fk`
    FOREIGN KEY (`accepter_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE  TABLE IF NOT EXISTS `changning`.`doc_extra_items` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NULL ,
  `extra_doc_names` VARCHAR(1000) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `doc_extra_order_fk_idx` (`order_id` ASC) ,
  CONSTRAINT `doc_extra_order_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION);

CREATE  TABLE IF NOT EXISTS `changning`.`interactions` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NULL ,
  `user_id` INT NULL ,
  `interaction_date` DATE NULL ,
  `interaction_content` VARCHAR(1000) NULL ,
  `interaction_type` VARCHAR(20) NULL ,
  `completed` VARCHAR(20) NULL ,
  `extra_data` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `interactions_order_fk_idx` (`order_id` ASC) ,
  INDEX `interactions_user_fk_idx` (`user_id` ASC) ,
  CONSTRAINT `interactions_order_fk`
    FOREIGN KEY (`order_id` )
    REFERENCES `changning`.`orders` (`id` )
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `interactions_user_fk`
    FOREIGN KEY (`user_id` )
    REFERENCES `changning`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
CREATE  TABLE IF NOT EXISTS `changning`.`order_history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `order_id` INT NULL ,
  `user_id` INT NULL ,
  `operation_date` DATE NULL ,
  `operation_type` VARCHAR(200) NULL ,
  `flex1` VARCHAR(200) NULL ,
  `flex2` VARCHAR(200) NULL ,
  `flex3` VARCHAR(200) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `history_order_fk_idx` (`order_id` ASC) ,
  INDEX `history_user_fk_idx` (`user_id` ASC) );
  
  


insert into roles (role_name) values ('admin');
insert into roles (role_name) values ('staff');
insert into roles (role_name) values ('user');


INSERT INTO `changning`.`users` (mobile, name, gender, email, cred_type, cred_id, password, address) VALUES ('13817676005', '史静', 'FEMALE', 'test2@test.com', 'ID_CARD', '440306199983274259', 'e19d5cd5af0378da05f63f891c7467af', 'yyyyyyyyyyyyyy');

insert into user_roles (user_id, role_id) values (1, 1);


-- -----------------------------------------------------
-- Table `changning`.`chatban`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatban` (
  `banid` INT(11) NOT NULL AUTO_INCREMENT ,
  `dtmcreated` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `dtmtill` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `address` VARCHAR(255) NULL DEFAULT NULL ,
  `comment` VARCHAR(255) NULL DEFAULT NULL ,
  `blockedCount` INT(11) NULL DEFAULT '0' ,
  PRIMARY KEY (`banid`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatconfig`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatconfig` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `vckey` VARCHAR(255) NULL DEFAULT NULL ,
  `vcvalue` VARCHAR(255) NULL DEFAULT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 36
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatgroup`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatgroup` (
  `groupid` INT(11) NOT NULL AUTO_INCREMENT ,
  `vcemail` VARCHAR(64) NULL DEFAULT NULL ,
  `vclocalname` VARCHAR(64) NOT NULL ,
  `vccommonname` VARCHAR(64) NOT NULL ,
  `vclocaldescription` VARCHAR(1024) NOT NULL ,
  `vccommondescription` VARCHAR(1024) NOT NULL ,
  PRIMARY KEY (`groupid`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatgroupoperator`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatgroupoperator` (
  `groupid` INT(11) NOT NULL ,
  `operatorid` INT(11) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatmessage`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatmessage` (
  `messageid` INT(11) NOT NULL AUTO_INCREMENT ,
  `threadid` INT(11) NOT NULL ,
  `ikind` INT(11) NOT NULL ,
  `agentId` INT(11) NOT NULL DEFAULT '0' ,
  `tmessage` TEXT NOT NULL ,
  `dtmcreated` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `tname` VARCHAR(64) NULL DEFAULT NULL ,
  PRIMARY KEY (`messageid`) ,
  INDEX `idx_agentid` (`agentId` ASC) )
ENGINE = InnoDB
AUTO_INCREMENT = 152
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatnotification`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatnotification` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(8) NULL DEFAULT NULL ,
  `vckind` VARCHAR(16) NULL DEFAULT NULL ,
  `vcto` VARCHAR(256) NULL DEFAULT NULL ,
  `dtmcreated` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `vcsubject` VARCHAR(256) NULL DEFAULT NULL ,
  `tmessage` TEXT NOT NULL ,
  `refoperator` INT(11) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatoperator`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatoperator` (
  `operatorid` INT(11) NOT NULL AUTO_INCREMENT ,
  `vclogin` VARCHAR(64) NOT NULL ,
  `vcpassword` VARCHAR(64) NOT NULL ,
  `vclocalename` VARCHAR(64) NOT NULL ,
  `vccommonname` VARCHAR(64) NOT NULL ,
  `vcemail` VARCHAR(64) NULL DEFAULT NULL ,
  `dtmlastvisited` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `istatus` INT(11) NULL DEFAULT '0' ,
  `vcavatar` VARCHAR(255) NULL DEFAULT NULL ,
  `vcjabbername` VARCHAR(255) NULL DEFAULT NULL ,
  `iperm` INT(11) NULL DEFAULT '65535' ,
  `inotify` INT(11) NULL DEFAULT '0' ,
  `dtmrestore` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `vcrestoretoken` VARCHAR(64) NULL DEFAULT NULL ,
  PRIMARY KEY (`operatorid`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatresponses`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatresponses` (
  `id` INT(11) NOT NULL AUTO_INCREMENT ,
  `locale` VARCHAR(8) NULL DEFAULT NULL ,
  `groupid` INT(11) NULL DEFAULT NULL ,
  `vcvalue` VARCHAR(1024) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatrevision`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatrevision` (
  `id` INT(11) NOT NULL )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `changning`.`chatthread`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `changning`.`chatthread` (
  `threadid` INT(11) NOT NULL AUTO_INCREMENT ,
  `userName` VARCHAR(64) NOT NULL ,
  `userid` VARCHAR(255) NULL DEFAULT NULL ,
  `agentName` VARCHAR(64) NULL DEFAULT NULL ,
  `agentId` INT(11) NOT NULL DEFAULT '0' ,
  `dtmcreated` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `dtmmodified` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `lrevision` INT(11) NOT NULL DEFAULT '0' ,
  `istate` INT(11) NOT NULL DEFAULT '0' ,
  `ltoken` INT(11) NOT NULL ,
  `remote` VARCHAR(255) NULL DEFAULT NULL ,
  `referer` TEXT NULL DEFAULT NULL ,
  `nextagent` INT(11) NOT NULL DEFAULT '0' ,
  `locale` VARCHAR(8) NULL DEFAULT NULL ,
  `lastpinguser` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `lastpingagent` DATETIME NULL DEFAULT '0000-00-00 00:00:00' ,
  `userTyping` INT(11) NULL DEFAULT '0' ,
  `agentTyping` INT(11) NULL DEFAULT '0' ,
  `shownmessageid` INT(11) NOT NULL DEFAULT '0' ,
  `userAgent` VARCHAR(255) NULL DEFAULT NULL ,
  `messageCount` VARCHAR(16) NULL DEFAULT NULL ,
  `groupid` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`threadid`) )
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = utf8;




commit;


CREATE  TABLE IF NOT EXISTS `changning`.`site_news` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(500) NULL,
  `visible` VARCHAR(1) NULL,
  PRIMARY KEY (`id`));

ALTER TABLE orders  MODIFY COLUMN requestor_birth_date DATETIME;
ALTER TABLE orders  MODIFY COLUMN order_date DATETIME;
ALTER TABLE order_history  MODIFY COLUMN operation_date DATETIME;
ALTER TABLE interactions MODIFY COLUMN interaction_date DATETIME;
ALTER TABLE payment MODIFY COLUMN payment_date DATETIME;
ALTER TABLE payment MODIFY COLUMN refund_date DATETIME;
ALTER TABLE reservations MODIFY COLUMN reserve_date DATETIME;
ALTER TABLE reservations MODIFY COLUMN creation_date DATETIME;

CREATE  TABLE IF NOT EXISTS `changning`.`reservation_slots` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `tag` VARCHAR(45) NOT NULL ,
  `am` VARCHAR(1) NULL,  
    PRIMARY KEY (`id`) );
