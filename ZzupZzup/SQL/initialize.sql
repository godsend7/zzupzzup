-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `member`;
DROP TABLE IF EXISTS `activity_score`;
DROP TABLE IF EXISTS `rating`;
DROP TABLE IF EXISTS `restaurant_time`;
DROP TABLE IF EXISTS `menu`;
DROP TABLE IF EXISTS `community`;
DROP TABLE IF EXISTS `restaurant`;
DROP TABLE IF EXISTS `hashtag`;
DROP TABLE IF EXISTS `review`;
DROP TABLE IF EXISTS `chat`;
DROP TABLE IF EXISTS `chat_member`;
DROP TABLE IF EXISTS `reservation`;
DROP TABLE IF EXISTS `reservation_order`;
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

CREATE TABLE `restaurant` (
    `restaurant_no` INT NOT NULL AUTO_INCREMENT,
    `post_no` INT,
    `member_id` VARCHAR(50),
    `owner_name` VARCHAR(10),
    `owner_image` VARCHAR(50),
    `restaurant_name` VARCHAR(50) NOT NULL,
    `restaurant_text` VARCHAR(100),
    `reservation_status` BOOLEAN DEFAULT 1,
    `parkable` BOOLEAN,
    `request_date` DATETIME,
    `judge_status` INT,
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
    FOREIGN KEY (`member_id`) REFERENCES `member`(`member_id`),
    FOREIGN KEY (`post_no`) REFERENCES `community`(`post_no`)
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
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('admin@admin.com', 'admin', 'admin', '관리자', '010-1111-1111','1', '10대', 'male', 'admin', '관리자입니다', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user01@zzupzzup.com', 'owner', '1111', '유희주', '010-0000-0001','1', '20대', 'female', 'Yoo', '김가네 오너, 그게 바로 나다', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user02@zzupzzup.com', 'user', '2222', '권도윤', '010-0000-0002','1', '30대', 'male', 'Kwon', '안녕하세요', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user03@zzupzzup.com', 'user', '3333', '김관우', '010-0000-0001','1', '20대', 'male', 'Kim', '안녕하세요', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user04@zzupzzup.com', 'user', '4444', '이소희', '010-0000-0003','1', '20대', 'female', 'Lee', '안녕하세요', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user05@zzupzzup.com', 'user', '5555', '조영주', '010-0000-0004','1', '20대', 'female', 'Cho', '안녕하세요', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('user06@zzupzzup.com', 'owner', '6666', '홍진호', '010-0000-0005','1', '20대', 'male', 'Hong', '거구장 오너, 그게 바로 나다', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('owner01@zzupzzup.com', 'owner', '0101', '박송화', '010-6666-6666','1', '30대', 'male', 'Park', '안녕하세요 오너입니다', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('hihi@a.com', 'user', '1234', '조주영', '010-4444-4444','1', '20대', 'female', 'jyp', '너 나 알아?', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('test0@test.com', 'user', '1010', '조영쥬', '010-9999-0001','1', '20대', 'male', 'test2', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('test1@test.com', 'user', '0011', '조영추', '010-9999-0002','1', '30대', 'female', 'test1', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('test3@test.com', 'user', '3030', '조용주', '010-9999-0003','1', '40대', 'male', 'test3', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('test4@test.com', 'user', '4040', '조융주', '010-9999-0004','1', '50대', 'female', 'test4', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('test5@test.com', 'user', '5050', '조양주', '010-9999-0005','1', '60대', 'male', 'test5', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('owner03@test.com', 'owner', '0303', '조영루', '010-0000-4444','1', '50대', 'female', 'owner1', '-', '0', '0', now());
INSERT INTO member(member_id, member_role, password, member_name, member_phone, login_type, age_range, gender, nickname, status_message, activity_score, manner_score, reg_date) VALUES ('owner04@test.com', 'owner', '0404', '조영후', '010-0000-5555','1', '60대', 'female', 'owner2', '-', '0', '0', now());
-- restaurant
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user06@zzupzzup.com', '홍진호', 'zzazang.jpg', '짜파게티보다 맛있는집', '0', '거구장',
'02-734-2485', '서울시 종로구 인사동3길 29', '서울시 종로구 인사동 215-1', null,'37.57181718717052', '126.98540675579265', '2');
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user06@zzupzzup.com', '홍진호', 'zzazang.jpg', '짜짜로니보다 맛있는집', '0', '거구장2',
'02-734-2485', '서울시 용산구 인사동3길 29', '서울시 용산구 인사동 215-1', null, '37.57181718717052', '126.98540675579265', '2');
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user01@zzupzzup.com', '유희주', 'gimbab.jpg', '편의점도시락보다 맛있는집', '0', '김가네',
'02-722-0123', '서울시 종로구 종로 65', '서울시 종로구 종로2가 8-4', null, '37.570529034739934', '126.98470904510523', '1');
-- menu
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('1', '짜장면', '5000', '1');
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('1', '볶음밥', '5500', '0');
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('2', '짬뽕', '6000', '1');
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('2', '티라미수', '4000', '0');
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('3', '참치김밥', '4500', '1');
INSERT INTO menu(restaurant_no, menu_title, menu_price, main_menu_status)
VALUES('3', '땅콩막걸리', '3500', '0');
-- chat
INSERT INTO CHAT (chat_leader_id, restaurant_no, chat_title, chat_text, chat_gender, age_type) VALUES ('hihi@a.com',1,'쩝쩝친구 구해유','소개한다',1,'1,2,3');
-- chat_member
INSERT INTO chat_member (chat_no, chat_member_id, ready_check, chat_leader_check) VALUES (1,'hihi@a.com',1,1,1);
-- reservation
INSERT INTO reservation(reservation_number, restaurant_no, chat_no, booker_id, plan_date, plan_time, fixed_date,
member_count, reservation_status, fixed_status, reservation_date, total_price, pay_option, pay_method, 
cancel_date, reservation_cancel_type, reservation_cancel_detail, refund_status)
VALUES(CONCAT(DATE_FORMAT(NOW(), "%Y%m%e%H%i%S"),'_',FLOOR(RAND()*1000000000)),'1','1','hihi@a.com', NOW(), '12:59', NOW(),'3','1', '0', NOW(), '30000','2','1', NOW(), '1', '재고없음~~~','0');
-- reservation_order
INSERT INTO reservation_order(reservation_no, menu_title, order_count, menu_price)
VALUES('1', '짜장면', '3', '3500');
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
-- review
INSERT
INTO REVIEW(member_id, reservation_no, restaurant_no, review_detail, scope_taste, scope_kind, scope_clean, avg_scope)
VALUES ( 'hihi@a.com', 1, 1, '하이하이', 1, 1, 1, 1);


commit;