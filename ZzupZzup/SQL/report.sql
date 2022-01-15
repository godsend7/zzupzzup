-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `report`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `report` (
    `report_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `chat_no` INT,
    `chat_member_id` VARCHAR(50),
    `review_no` INT,
    `post_no` INT,
    `restaurant_no` INT,
    `report_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `report_type` INT NOT NULL,
    `report_detail` VARCHAR(100),
    `report_check` BOOLEAN NOT NULL DEFAULT 0,
    `report_category` INT NOT NULL,
    PRIMARY KEY (`report_no`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`),
    FOREIGN KEY (`review_no`) REFERENCES `review`(`review_no`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`chat_member_id`) REFERENCES `member`(`member_id`)
);