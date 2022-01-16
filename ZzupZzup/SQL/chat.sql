-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `chat`;
DROP TABLE IF EXISTS `chat_member`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `chat` (
    `chat_no` INT NOT NULL AUTO_INCREMENT,
    `chat_leader_id` VARCHAR(50) NOT NULL,
    `restaurant_no` INT NOT NULL,
    `chat_title` VARCHAR(100) NOT NULL,
    `chat_image` VARCHAR(50) NOT NULL DEFAULT 'chatimg.jpg',
    `chat_text` VARCHAR(100),
    `chat_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `chat_gender` INT NOT NULL,
    `chat_member_count` INT NOT NULL DEFAULT 1,
    `chat_state` INT NOT NULL DEFAULT 1,
    `chat_show_status` BOOLEAN NOT NULL DEFAULT 1,
    `age_type` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`chat_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`),
    FOREIGN KEY (`chat_leader_id`) REFERENCES `member`(`member_id`)
);

CREATE TABLE `chat_member` (
    `chat_member_no` INT NOT NULL AUTO_INCREMENT,
    `chat_no` INT NOT NULL,
    `chat_member_id` VARCHAR(50) NOT NULL,
    `ready_check` BOOLEAN NOT NULL DEFAULT 0,
    `chat_leader_check` BOOLEAN NOT NULL DEFAULT 0,
    `in_out_check` BOOLEAN NOT NULL DEFAULT 1,
    `on_connected` BOOLEAN NOT NULL DEFAULT 1,
    `forbidden_member` BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (`chat_member_no`),
    FOREIGN KEY (`chat_member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`),
    UNIQUE KEY (`chat_no`, `chat_member_id`)
);