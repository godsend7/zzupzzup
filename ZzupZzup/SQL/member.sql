-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `member`;
DROP TABLE IF EXISTS `activity_score`;
DROP TABLE IF EXISTS `alarm`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `member` (
    `member_id` VARCHAR(50) NOT NULL,
    `member_role` VARCHAR(5) NOT NULL,
    `password` VARCHAR(15),
    `member_name` VARCHAR(10) NOT NULL,
    `member_phone` VARCHAR(13) NOT NULL,
    `login_type` INT NOT NULL,
    `reg_date` DATETIME NOT NULL,
    `age_range` VARCHAR(6),
    `birth_year` INT,
    `gender` VARCHAR(6),
    `profile_image` VARCHAR(50) NOT NULL DEFAULT 'defaultImage.png',
    `nickname` VARCHAR(10),
    `status_message` VARCHAR(100) DEFAULT '',
    `activity_score` INT NOT NULL DEFAULT 0,
    `manner_score` INT NOT NULL DEFAULT 0,
    `delete_date` DATETIME,
    `delete_type` INT,
    `delete_detail` VARCHAR(100),
    `blacklist_reg_date` DATETIME,
    PRIMARY KEY (`member_id`)
);

CREATE TABLE `activity_score` (
    `activity_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `accumulate_date` DATETIME NOT NULL DEFAULT NOW(),
    `accumulate_type` INT NOT NULL,
    `accumulate_score` INT NOT NULL,
    PRIMARY KEY (`activity_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`)
);

CREATE TABLE `alarm` (
    `alarm_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `alarm_type` INT NOT NULL,
    `alarm_contents` VARCHAR(50) NOT NULL,
    `alarm_check` BOOLEAN NOT NULL DEFAULT 0,
    `alarm_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `post_no` INT,
    `chat_no` INT,
    `reservation_no` INT,
    `review_no` INT,
    PRIMARY KEY (`alarm_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`),
    FOREIGN KEY (`review_no`) REFERENCES `review`(`review_no`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`),
    FOREIGN KEY (`reservation_no`) REFERENCES `reservation`(`reservation_no`)
);







