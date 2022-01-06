-- 테이블 자료 입력
-- MEMBER
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('admin@admin.com', 'admin', '관리자', '010-1111-1111','1', '10대', 'male', 'admin', '관리자입니다', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user01@zzupzzup.com', 'owner', '유희주', '010-0000-0001','1', '20대', 'female', 'Yoo', '김가네 오너, 그게 바로 나다', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user02@zzupzzup.com', 'user', '권도윤', '010-0000-0002','1', '30대', 'male', 'Kwon', '안녕하세요', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user03@zzupzzup.com', 'user', '김관우', '010-0000-0003','1', '20대', 'male', 'Kim', '안녕하세요', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user04@zzupzzup.com', 'user', '이소희', '010-0000-0004','1', '20대', 'female', 'Lee', '안녕하세요', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user05@zzupzzup.com', 'user', '조영주', '010-0000-0005','1', '20대', 'female', 'Cho', '안녕하세요', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('user06@zzupzzup.com', 'owner', '홍진호', '010-0000-0006','1', '20대', 'male', 'Hong', '거구장 오너, 그게 바로 나다', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('owner01@zzupzzup.com', 'owner', '박송화', '010-7777-7777','1', '30대', 'female', 'Park', '안녕하세요', '0', '0', NOW());
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE, REG_DATE) VALUES ('hihi@a.com', 'user', '조주영', '010-9999-9999','1', '20대', 'female', 'unknown', '너 나 알아?', '0', '0', NOW());
-- RESTAURANT
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user06@zzupzzup.com', '홍진호', 'zzazang.jpg', '짜파게티보다 맛있는집', '0', '거구장',
'02-734-2485', '서울시 종로구 인사동3길 29', '서울시 종로구 인사동 215-1', '37.57181718717052', '126.98540675579265', '2');
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user06@zzupzzup.com', '홍진호', 'zzazang.jpg', '짜짜로니보다 맛있는집', '0', '거구장2',
'02-734-2485', '서울시 용산구 인사동3길 29', '서울시 용산구 인사동 215-1', '37.57181718717052', '126.98540675579265', '2');
INSERT INTO restaurant(member_id, owner_name,
owner_image, restaurant_text, parkable, restaurant_name, 
restaurant_tel, street_address, area_address, rest_address, latitude, longitude, menu_type)
VALUES('user01@zzupzzup.com', '유희주', 'gimbab.jpg', '편의점도시락보다 맛있는집', '0', '김가네',
'02-722-0123', '서울시 종로구 종로 65', '서울시 종로구 종로2가 8-4', '37.570529034739934', '126.98470904510523', '1');
-- MENU
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
-- CHAT
INSERT INTO CHAT (CHAT_LEADER_ID, RESTAURANT_NO, CHAT_TITLE, CHAT_TEXT, CHAT_GENDER , CHAT_MEMBER_COUNT, AGE_TYPE) VALUES ('hihi@a.com',1,'쩝쩝친구 구해유','소개한다',
1,1,'1,2,3');
-- CHAT_MEMBER
INSERT INTO CHAT_MEMBER (CHAT_NO, CHAT_MEMBER_ID) VALUES (1,'hihi@a.com');
-- CHAT_LOG
INSERT INTO CHAT_LOG (CHAT_NO, CHAT_CONTENTS, CHAT_TIME) VALUES (1,'하이하이','2021-01-01');
-- RATING
INSERT INTO RATING (CHAT_NO, RATING_TO_ID, RATING_FROM_ID, RATING_SCORE, RATING_TYPE) VALUES (1,'hihi@a.com', 'user02@zzupzzup.com', 1, 1);
-- RESERVATION
INSERT INTO RESERVATION(RESERVATION_NO, RESTAURANT_NO, CHAT_NO, BOOKER_ID, PLAN_DATE, FIXED_DATE,
MEMBER_COUNT, RESERVATION_STATUS, FIXED_STATUS, RESERVATION_DATE, TOTAL_PRICE, PAY_OPTION, PAY_METHOD, 
CANCEL_DATE, RESERVATION_CANCEL_TYPE, RESERVATION_CANCEL_DETAIL, REFUND_STATUS)
VALUES(CONCAT(DATE_FORMAT(NOW(), "%Y%m%e%H%i%S"),'_',FLOOR(RAND()*1000000000)),'1','1','hihi@a.com', NOW(), NOW(),'3','1', '0', NOW(), '30000','2','1', NOW(), '1', '재고없음~~~','0');
-- RESERVATION_ORDER ** RESERVATION_NO 값은 랜덤으로 생성된 값으로 변경하여 입력
INSERT INTO RESERVATION_ORDER(RESERVATION_NO, MENU_TITLE, ORDER_COUNT, MENU_PRICE)
VALUES('20211217032326_901071983', '짜장면', '3', '3500');
-- NOTICE
INSERT INTO NOTICE(MEMBER_ID, POST_TITLE, POST_TEXT, POST_CATEGORY, POST_MEMBER_ROLE) VALUES 
('hihi@a.com','배고파서 CU에 갔더니...','CU에서 닭가슴살 원플러스텐! 개이득봤다!!', '1', 'user');
-- HASHTAG
INSERT INTO HASHTAG(HASHTAG) VALUES ("#인스타 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#여성이 많이 찾는 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#남성이 많이 찾는 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#자녀와 함께하기 좋은 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#부모님과 함께하기 좋은 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#반려견과 함께하기 좋은 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#가성비 좋은 맛집");
INSERT INTO HASHTAG(HASHTAG) VALUES ("#데이트하기 좋은 맛집");


commit;