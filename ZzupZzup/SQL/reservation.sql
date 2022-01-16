-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `reservation`;
DROP TABLE IF EXISTS `reservation_order`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `reservation` (
    `reservation_no` INT NOT NULL AUTO_INCREMENT,
    `reservation_number` VARCHAR(24) NOT NULL,
    `restaurant_no` INT NOT NULL,
    `chat_no` INT NOT NULL,
    `booker_id` VARCHAR(50) NOT NULL,
    `plan_date` DATETIME NOT NULL,
    `plan_time` VARCHAR(10) NOT NULL,
    `fixed_date` DATETIME,
    `member_count` INT NOT NULL,
    `reservation_status` INT NOT NULL,
    `fixed_status` BOOLEAN NOT NULL,
    `reservation_date` DATETIME NOT NULL,
    `total_price` INT NOT NULL,
    `pay_option` INT NOT NULL,
    `pay_method` VARCHAR(50),
    `cancel_date` DATETIME,
    `reservation_cancel_type` INT,
    `reservation_cancel_detail` VARCHAR(100),
    `refund_status` BOOLEAN,
    PRIMARY KEY (`reservation_no`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`),
    FOREIGN KEY (`booker_id`) REFERENCES `member`(`member_id`)
);

CREATE TABLE `reservation_order` (
    `order_no` INT NOT NULL AUTO_INCREMENT,
    `reservation_no` INT NOT NULL,
    `menu_title` VARCHAR(50) NOT NULL,
    `order_count` INT NOT NULL,
    `menu_price` INT NOT NULL,
    PRIMARY KEY (`order_no`),
    FOREIGN KEY (`reservation_no`) REFERENCES `reservation`(`reservation_no`)
);