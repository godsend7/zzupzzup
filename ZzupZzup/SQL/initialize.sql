-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `member`;
DROP TABLE IF EXISTS `activity_score`;
DROP TABLE IF EXISTS `rating`;
DROP TABLE IF EXISTS `restaurant_time`;
DROP TABLE IF EXISTS `notice`;
DROP TABLE IF EXISTS `menu`;
DROP TABLE IF EXISTS `community`;
DROP TABLE IF EXISTS `restaurant`;
DROP TABLE IF EXISTS `hashtag`;
DROP TABLE IF EXISTS `review`;
DROP TABLE IF EXISTS `chat`;
DROP TABLE IF EXISTS `chat_member`;
DROP TABLE IF EXISTS `reservation`;
DROP TABLE IF EXISTS `reservation_order`;
DROP TABLE IF EXISTS `chat_log`;
DROP TABLE IF EXISTS `report`;
DROP TABLE IF EXISTS `hashtag_log`;
DROP TABLE IF EXISTS `mark`;
DROP TABLE IF EXISTS `alarm`;
DROP TABLE IF EXISTS `image`;
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
    `profile_image` VARCHAR(50) NOT NULL DEFAULT 'defaultImage.jpg',
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

CREATE TABLE `restaurant` (
    `restaurant_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `owner_name` VARCHAR(10) NOT NULL,
    `owner_image` VARCHAR(50) NOT NULL,
    `restaurant_text` VARCHAR(100) NOT NULL,
    `reservation_status` BOOLEAN NOT NULL DEFAULT 1,
    `parkable` BOOLEAN,
    `request_date` DATE,
    `judge_status` BOOLEAN,
    `judge_date` DATE,
    `restaurant_name` VARCHAR(50) NOT NULL,
    `restaurant_tel` VARCHAR(15) NOT NULL,
    `street_address` VARCHAR(50) NOT NULL,
    `area_address` VARCHAR(50) NOT NULL,
    `rest_address` VARCHAR(20),
    `menu_type` INT NOT NULL,
    `restaurant_reg_date` DATE,
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

CREATE TABLE `community` (
    `post_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `post_title` VARCHAR(100) NOT NULL,
    `post_text` VARCHAR(1000) NOT NULL,
    `receipt_image` VARCHAR(50),
    `post_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `post_show_status` BOOLEAN NOT NULL DEFAULT 1,
    `restaurant_name` VARCHAR(50) NOT NULL,
    `restaurant_tel` VARCHAR(15) NOT NULL,
    `street_address` VARCHAR(50) NOT NULL,
    `area_address` VARCHAR(50) NOT NULL,
    `rest_address` VARCHAR(20),
    `menu_type` INT NOT NULL,
    `main_menu_title` VARCHAR(20) NOT NULL,
    `main_menu_price` INT NOT NULL,
    `official_date` DATETIME,
    PRIMARY KEY (`post_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`)
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
    PRIMARY KEY (`chat_member_no`),
    FOREIGN KEY (`chat_member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`)
);

CREATE TABLE `chat_log` (
    `chat_log_no` INT NOT NULL AUTO_INCREMENT,
    `chat_no` INT NOT NULL,
    `chat_contents` VARCHAR(400) NOT NULL,
    `chat_time` DATE NOT NULL,
    PRIMARY KEY (`chat_log_no`),
    FOREIGN KEY (`chat_no`) REFERENCES `chat`(`chat_no`)
);

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
    FOREIGN KEY (`rating_from_id`) REFERENCES `member`(`member_id`)
);

CREATE TABLE `reservation` (
    `reservation_no` INT NOT NULL AUTO_INCREMENT,
    `reservation_number` VARCHAR(24) NOT NULL,
    `restaurant_no` INT NOT NULL,
    `chat_no` INT NOT NULL,
    `booker_id` VARCHAR(50) NOT NULL,
    `plan_date` DATETIME NOT NULL,
    `fixed_date` DATETIME,
    `member_count` INT NOT NULL,
    `reservation_status` INT NOT NULL,
    `fixed_status` BOOLEAN NOT NULL,
    `reservation_date` DATE NOT NULL,
    `total_price` INT NOT NULL,
    `pay_option` INT NOT NULL,
    `pay_mothod` INT,
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

CREATE TABLE `notice` (
    `post_no` INT NOT NULL AUTO_INCREMENT,
    `member_id` VARCHAR(50) NOT NULL,
    `post_title` VARCHAR(50) NOT NULL,
    `post_text` VARCHAR(1000) NOT NULL,
    `post_reg_date` DATETIME NOT NULL DEFAULT NOW(),
    `post_category` INT NOT NULL,
    `post_member_role` VARCHAR(5) NOT NULL DEFAULT 'user',
    PRIMARY KEY (`post_no`),
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`)
);

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

-- 테이블 자료 입력
-- member
INSERT INTO member(member_id, member_role, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('admin@admin.com', 'admin', '관리자', '010-1111-0000','1', '20대', 'female', 'admin', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user01@zzupzzup.com', 'user', 'user01', '010-0000-0001','1', '20대', 'male', 'user01', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user02@zzupzzup.com', 'user', 'user02', '010-0000-0002','1', '30대', 'male', 'user02', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('owner01@zzupzzup.com', 'owner', 'owner01', '010-0000-0003','1', '30대', 'male', 'user02', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('hihi@a.com', 'user', '조영주', '010-0000-0000','1', '20대', 'female', 'czro', '-', '0', '0', now());
-- restaurant
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, menu_type)
VALUES('hihi@a.com', '홍진호', 'zzazang.jpg', '짜파게티보다 맛있는집', '0', '거구장',
'010-1234-5678', '서울시 종로구 인사동3길 29', '서울시 종로구 인사동 215-1', '1');
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, restaurant_name, 
restaurant_tel, street_address, area_address, menu_type)
VALUES('hihi@a.com', '유희주', 'bab.jpg', '도시락보다 맛있는집', '김가네',
'010-1111-2222', '서울시 종로구 종로 65', '서울시 종로구 종로2가 8-4', '1');
-- menu
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('1', '짜장면', '3500', '0');
-- chat
INSERT INTO CHAT (chat_leader_id, restaurant_no, chat_title, chat_text, chat_gender, age_type) VALUES ('hihi@a.com',1,'쩝쩝친구 구해유','소개한다',1,'1,2,3');
-- chat_member
INSERT INTO chat_member (chat_no, chat_member_id) VALUES (1,'hihi@a.com');
-- chat_log
INSERT INTO chat_log (chat_no, chat_contents, chat_time) VALUES (1,'하이하이','2021-01-01');
-- rating
INSERT INTO rating (chat_no, rating_to_id, rating_from_id, rating_score, rating_type) VALUES (1,'hihi@a.com', 'user01@zzupzzup.com', 1, 1);
-- reservation
INSERT INTO reservation(reservation_number, restaurant_no, chat_no, booker_id, plan_date, fixed_date,
member_count, reservation_status, fixed_status, reservation_date, total_price, pay_option, pay_mothod, 
cancel_date, reservation_cancel_type, reservation_cancel_detail, refund_status)
VALUES(CONCAT(DATE_FORMAT(NOW(), "%Y%m%e%H%i%S"),'_',FLOOR(RAND()*1000000000)),'1','1','hihi@a.com', NOW(), NOW(),'3','1', '0', NOW(), '30000','2','1', NOW(), '1', '재고없음~~~','0');
-- reservation_order
INSERT INTO reservation_order(reservation_no, menu_title, order_count, menu_price)
VALUES('1', '짜장면', '3', '3500');
-- notice
INSERT INTO notice(member_id, post_title, post_text,post_category, post_member_role) VALUES 
('hihi@a.com','배고픈데 cu','cu에서 닭가슴살 투플러스원!!!', '1', 'user');
-- hashtag
INSERT INTO hashtag(hashtag) VALUES ("#인스타 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#여성이 많이 찾는 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#남성이 많이 찾는 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#자녀와 함께하기 좋은 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#부모님과 함께하기 좋은 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#반려견과 함께하기 좋은 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#가성비 좋은 맛집");
INSERT INTO hashtag(hashtag) VALUES ("#데이트하기 좋은 맛집");
-- activity_score
INSERT INTO activity_score(member_id, accumulate_type, accumulate_score)
VALUES('hihi@a.com', 1, 10);

commit;