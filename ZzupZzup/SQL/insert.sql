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
-- review
INSERT
INTO REVIEW(member_id, reservation_no, restaurant_no, review_detail, scope_taste, scope_kind, scope_clean, avg_scope)
VALUES ( 'hihi@a.com', 1, 1, '하이하이', 1, 1, 1, 1);


commit;