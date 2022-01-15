-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `rating`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `rating` (
    `rating_no` INT NOT NULL AUTO_INCREMENT,
    `chat_no` INT NOT NULL,
    `rating_to_id` VARCHAR(50) NOT NULL,
    `rating_from_id` VARCHAR(50) NOT NULL,
    `rating_score` INT NOT NULL,
    `rating_type` INT NOT NULL,
    `rating_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (`rating_no`),
    FOREIGN KEY (`rating_to_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`),
    FOREIGN KEY (`rating_from_id`) REFERENCES `member`(`member_id`),
    UNIQUE KEY (`chat_no`, `rating_to_id`, `rating_from_id`)
);