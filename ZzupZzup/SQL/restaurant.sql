-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `restaurant`;
DROP TABLE IF EXISTS `menu`;
DROP TABLE IF EXISTS `restaurant_time`;
DROP TABLE IF EXISTS `image`;
DROP TABLE IF EXISTS `community`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `restaurant` (
    `restaurant_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50),
    `owner_name` VARCHAR(10),
    `owner_image` VARCHAR(50),
    `restaurant_name` VARCHAR(50) NOT NULL,
    `restaurant_text` VARCHAR(100),
    `reservation_status` BOOLEAN DEFAULT 1,
    `parkable` BOOLEAN,
    `request_date` DATETIME DEFAULT NOW(),
    `judge_status` INT DEFAULT 1,
    `judge_date` DATETIME,
    `restaurant_reg_date` DATETIME,
    `restaurant_tel` VARCHAR(15) NOT NULL,
    `street_address` VARCHAR(50) NOT NULL,
    `area_address` VARCHAR(50) NOT NULL,
    `rest_address` VARCHAR(20),
    `latitude` VARCHAR(50),
    `longitude` VARCHAR(50),
    `menu_type` INT NOT NULL,
    PRIMARY KEY (`restaurant_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`)
);

CREATE TABLE `menu` (
    `menu_no` INT NOT NULL AUTO_INCREMENT,
    `restaurant_no` INT NOT NULL,
    `menu_title` VARCHAR(20) NOT NULL,
    `menu_price` INT NOT NULL,
    `main_menu_status` BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (`menu_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`)
);

CREATE TABLE `restaurant_time` (
    `restaurant_time_no` INT NOT NULL AUTO_INCREMENT,
    `post_no` INT,
    `restaurant_no` INT,
    `restaurant_day` INT,
    `restaurant_open` VARCHAR(10),
    `restaurant_close` VARCHAR(10),
    `restaurant_break` VARCHAR(10),
    `restaurant_last` VARCHAR(10),
    `restaurant_day_off` BOOLEAN DEFAULT 0,
    PRIMARY KEY (`restaurant_time_no`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`)
);

CREATE TABLE `image` (
    `image_no` INT NOT NULL AUTO_INCREMENT,
    `post_no` INT,
    `restaurant_no` INT,
    `review_no` INT,
    `image` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`image_no`),
    FOREIGN KEY (`review_no`) REFERENCES `review`(`review_no`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`)
);

CREATE TABLE `community` (
    `post_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `nickname` VARCHAR(10),
    `post_title` VARCHAR(100) NOT NULL,
    `post_text` VARCHAR(1000) NOT NULL,
    `post_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `post_show_status` BOOLEAN NOT NULL DEFAULT 1,
    `restaurant_name` VARCHAR(50) NOT NULL,
    `restaurant_tel` VARCHAR(15) NOT NULL,
    `street_address` VARCHAR(50) NOT NULL,
    `area_address` VARCHAR(50) NOT NULL,
    `rest_address` VARCHAR(20),
    `latitude` VARCHAR(50),
    `longitude` VARCHAR(50),
    `menu_type` INT NOT NULL,
    `main_menu_title` VARCHAR(20) NOT NULL,
    `main_menu_price` INT NOT NULL,
    `receipt_image` VARCHAR(50),
    `official_date` DATETIME,
    PRIMARY KEY (`post_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`)
);

