CREATE TABLE develop_book(
	book_id			INTEGER,
	pub_date		INTEGER,
	book_name		VARCHAR(80),
	price			MONEY
)
;

INSERT INTO develop_book(book_id, pub_date, book_name, price)
VALUES(1, 20231013, '책', 3000)
;

SELECT * FROM develop_book;

-- 날짜 및 시간
CREATE TABLE datetime_study(
	type_ts		TIMESTAMP,
	type_tstz	TIMESTAMPTZ,
	type_date	DATE,
	type_time	TIME
)
;

INSERT INTO datetime_study(type_ts, type_tstz, type_date, type_time)
VALUES(
	'2023-10-13 10:00:01+09', '2023-10-13 10:00:02+09', '2023-10-13', '10:00:01'
)
;

SELECT * FROM datetime_study;

-- 배열형 테이블 
CREATE TABLE contact_info(
	cont_id        NUMERIC(3), 
	name           VARCHAR(15), 
	tel            INTEGER[], 
	email          VARCHAR
);


-- 데이터 추가
INSERT INTO contact_info
VALUES(001, 'BEAN', ARRAY[01046170614, 01231231223], 'beankonic@gmail.com');

SELECT * FROM contact_info;

-- JSON 형
CREATE TABLE develop_book_order(
	id			NUMERIC(3),
	order_info	JSON NOT NULL
);

INSERT INTO develop_book_order
VALUES(001, '{"customer" : "evan", "books" : {"product" : "postgreSQL", "qty":2}}');

SELECT * FROM develop_book_order;

-- 형변환 : CAST 메서드 활용
SELECT CAST('3000' AS INTEGER);

SELECT * FROM develop_book;

SELECT book_id, CAST(pub_date AS VARCHAR) FROM develop_book;
SELECT book_id, pub_date::VARCHAR FROM develop_book;

-- 제품정보, 주문, 공장, 고객 테이블 생성
-- Primary Key, Foreign Key 미 기재
CREATE TABLE prod_info(
	prod_no    NUMERIC(5),
	prod_name  VARCHAR(40),
	prod_date  DATE, 
	prod_price MONEY,
	fact_no    NUMERIC(7)
);

CREATE TABLE prod_order(
	ord_no     NUMERIC(6), 
	cust_id    CHAR(8), 
	prod_name  VARCHAR(40), 
	qty        NUMERIC(1000), 
	prod_price MONEY, 
	ord_date   TIMESTAMPTZ
);

CREATE TABLE factory(
	fact_no    NUMERIC(7), 
	fact_name  VARCHAR(45), 
	city       VARCHAR(25), 
	fact_admin VARCHAR(40), 
	fact_tel   NUMERIC(11), 
	prod_name  VARCHAR[], 
	estab_date DATE
);

CREATE TABLE customer(
	cust_id    CHAR(8), 
	cust_name  VARCHAR(40), 
	cust_tel   NUMERIC(11), 
	email      VARCHAR(100), 
	birth      NUMERIC(6), 
	identify   BOOLEAN
);

-- 도메인 무결성 예시
-- 숫자가 0~9의 숫자만 입력되도록 설정
CREATE DOMAIN phoneint AS INTEGER CHECK (VALUE > 0 AND VALUE < 9);

-- 테이블 생성
CREATE TABLE domain_type_study(
	id phoneint
);

INSERT INTO domain_type_study VALUES(1); -- 성공
INSERT INTO domain_type_study VALUES(10); -- 실패

-- 5가지 제약 조건
-- NOT NULL & UNIQUE
-- DROP TABLE IF EXISTS contact_info;
CREATE TABLE contact_info(
	cont_id		NUMERIC(3)	UNIQUE NOT NULL,
	name		VARCHAR(15)	NOT NULL,
	tel 		INTEGER[]	NOT NULL,
	email		VARCHAR
);

-- INSERT 추가해서 테스트 해볼 것

-- NOT NULL & UNIQUE
DROP TABLE IF EXISTS contact_info;
CREATE TABLE contact_info(
	cont_id     NUMERIC(3)      UNIQUE NOT NULL, 
	name        VARCHAR(15)     NOT NULL, 
	tel         INTEGER[]       NOT NULL, 
	email       VARCHAR
);

-- 여러 칼럼에 UNIQUE 적용
DROP TABLE IF EXISTS contact_info;
CREATE TABLE contact_info(
	cont_id     NUMERIC(3)      NOT NULL, 
	name        VARCHAR(15)     NOT NULL, 
	tel         INTEGER[]       NOT NULL, 
	email       VARCHAR, 
	UNIQUE(cont_id, tel, email)
);

-- 기본키 지정
DROP TABLE IF EXISTS contact_info;
CREATE TABLE contact_info(
	cont_id		SERIAL		NOT NULL PRIMARY KEY,
	name		VARCHAR(15)		NOT NULL,
	tel			INTEGER[]		NOT NULL,
	email		VARCHAR
);

INSERT INTO contact_info(email) VALUES('abc@gmail.com');

-- 외래키 지정
CREATE TABLE book(
	book_id		SERIAL		NOT NULL,
	name		VARCHAR(15)	NOT NULL,
	admin_no	SERIAL		NOT NULL REFERENCES contact_info(cont_id),
	email		VARCHAR,
	PRIMARY KEY (book_id, admin_no)
);

-- 학교 / 수업, 선생님
CREATE TABLE subject(
	subj_id		NUMERIC(5)		NOT NULL PRIMARY KEY,
	subj_name	VARCHAR(10)		NOT NULL	
);

INSERT INTO subject VALUES(00001, '수학'), (00002, '과학'), (00003, '사회');
INSERT INTO subject VALUES(00004, '국어');

CREATE TABLE teacher(
	teac_id		NUMERIC(5)	NOT NULL PRIMARY KEY,
	teac_name	VARCHAR(20)	NOT NULL,
	subj_id		NUMERIC(5)	REFERENCES subject,
	teach_certifi_date DATE
);

SELECT * FROM subject;
INSERT INTO teacher VALUES(00011, '정선생', 00001, '2023-10-12');
INSERT INTO teacher VALUES(00021, '김선생', 00002, '2023-10-12');
INSERT INTO teacher VALUES(00031, '박선생', 00003, '2023-10-12');
INSERT INTO teacher VALUES(00041, '이선생', 00004, '2023-10-12');

SELECT * FROM teacher;

-- CASE WHEN
SELECT * FROM student_score;
SELECT
	id
	, name
	, score
	, CASE WHEN score <= 100 AND score >= 90 THEN 'A'
			WHEN score <= 89 AND score >= 80 THEN 'B'
			WHEN score <= 79 AND score >= 70 THEN 'C'
			WHEN score <= 69 AND score >= 60 THEN 'D'
			WHEN score <= 59 THEN 'F'
		END AS grade
FROM student_score;

SELECT * FROM real_amount;
SELECT * FROM assumption_amount;

SELECT * FROM real_amount
WHERE EXISTS (
	SELECT * FROM assumption_amount
);

SELECT * FROM real_amount
WHERE EXISTS (
	SELECT * FROM drink
);

SELECT * FROM real_amount
WHERE EXISTS (
	SELECT * FROM exception
);


-- MySQL SUBSTR
-- PostgreSQL
SELECT SUBSTR('bean_110614', 1, 4);

SELECT LEFT('bean_110614', 5);