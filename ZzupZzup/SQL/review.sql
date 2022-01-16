-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `review`;
DROP TABLE IF EXISTS `hashtag`;
DROP TABLE IF EXISTS `hashtag_log`;
DROP TABLE IF EXISTS `mark`;
SET FOREIGN_KEY_CHECKS = 1;

-- 테이블 생성
CREATE TABLE `review` (
    `review_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `reservation_no` INT NOT NULL,
    `restaurant_no` INT NOT NULL,
    `review_detail` VARCHAR(100),
    `review_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `review_show_status` BOOLEAN NOT NULL DEFAULT 1,
    `scope_TASTE` INT NOT NULL,
    `scope_KIND` INT NOT NULL,
    `scope_CLEAN` INT NOT NULL,
    `avg_scope` DECIMAL NOT NULL,
    PRIMARY KEY (`review_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`reservation_no`) REFERENCES `reservation`(`reservation_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`)
);

CREATE TABLE `hashtag` (
    `hashtag_no` INT NOT NULL AUTO_INCREMENT,
    `hashtag` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`hashtag_no`)
);

CREATE TABLE `hashtag_log` (
    `hashtag_log_no` INT NOT NULL AUTO_INCREMENT,
    `review_no` INT NOT NULL,
    `hashtag_no` INT NOT NULL,
    PRIMARY KEY (`hashtag_log_no`),
    FOREIGN KEY (`hashtag_no`) REFERENCES `hashtag`(`hashtag_no`),
    FOREIGN KEY (`review_no`) REFERENCES `review`(`review_no`)
);

CREATE TABLE `mark` (
    `mark_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `post_no` INT,
    `review_no` INT,
    `restaurant_no` INT,
    PRIMARY KEY (`mark_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`),
    FOREIGN KEY (`restaurant_no`) REFERENCES `restaurant`(`restaurant_no`),
    FOREIGN KEY (`review_no`) REFERENCES `review`(`review_no`)
);