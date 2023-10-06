USE mulcamp;

-- 테이블 생성
CREATE TABLE IF NOT EXISTS tasks (
	-- 데이터 타입, 자동으로 올라가라는 뜻
    task_id INT AUTO_INCREMENT
    , title VARCHAR(255) NOT NULL
    , start_date DATE
    , due_date DATE
    , priority TINYINT NOT NULL DEFAULT 3
    , DESCRIPTION TEXT
    , PRIMARY KEY (task_id)
);

-- 교재 72페이지 문법 확인
INSERT INTO tasks(title, priority)
VALUES ('learn MySql', 1);

-- [SELECT]
SELECT * FROM tasks;

INSERT INTO tasks(title, priority)
VALUES ('learn Oracle', DEFAULT);

SELECT * FROM tasks;

INSERT INTO tasks(title, priority)
VALUES ('콩 사랑해', 0);

SELECT * FROM tasks;

-- 다중 행 추가 INSERT
INSERT INTO tasks(title, priority)
VALUES
	('Learn AWS', 1),
    ('Learn Python', 2),
    ('Learn R', 4);
    
SELECT * FROM tasks;

INSERT INTO tasks(title, priority)
VALUES
	('adsp 따기', 1),
    ('sqld 따기', 2),
    ('취업하기', 2);
    
SELECT * FROM tasks;

-- 날짜 추가
INSERT INTO tasks(title, start_date, due_date)
VALUES ('Learn INSERT', '2023-10-05', '2023-10-05');

SELECT * FROM tasks;

INSERT INTO tasks(title, start_date, due_date)
VALUES ('ADSP 준비', '2023-10-05', '2023-10-20');

SELECT * FROM tasks;

INSERT INTO tasks(title, start_date, due_date)
VALUES ('Learn INSERT', CURRENT_DATE(), CURRENT_DATE());

SELECT * FROM tasks;

CREATE TABLE IF NOT EXISTS customer (
	-- 데이터 타입, 자동으로 올라가라는 뜻
    customer_id INT AUTO_INCREMENT
    , product VARCHAR(255) NOT NULL
    , sale_start_date DATE
    , sale_due_date DATE
    , first_come TINYINT NOT NULL DEFAULT 2
    , DESCRIPTION TEXT
    , PRIMARY KEY (customer_id)
);

INSERT INTO customer(customer_id, product, sale_start_date, sale_due_date, first_come)
VALUES (2, '배추', CURRENT_DATE(), CURRENT_DATE()+2, 100);

INSERT INTO customer(product, sale_start_date, sale_due_date, first_come)
VALUES ('청경채', CURRENT_DATE()-1, CURRENT_DATE()+1, 50);

SELECT * FROM customer;

-- [DELETE]
DELETE FROM customer WHERE customer_id = 3;
SELECT * FROM customer;

DELETE FROM tasks WHERE title = 'Learn INSERT';
SELECT * FROM tasks;

-- 날짜 추가, COMMIT, ROLLBACK
INSERT INTO tasks(title, start_date, due_date)
VALUES ('Learn INSERT', '2023-10-03', '2023-10-04');

SELECT * FROM tasks;

INSERT INTO tasks(title, start_date, due_date)
VALUES ('ADSP 준비', '2023-10-05', '2023-10-20');

SELECT * FROM tasks;

INSERT INTO tasks(title, start_date, due_date)
VALUES ('Learn INSERT', CURRENT_DATE(), CURRENT_DATE());

SELECT * FROM tasks;

-- [Update] 75페이지.
SELECT * FROM tasks WHERE task_id = 5;

-- 말그대로 다른 내용으로 변경해줌.
UPDATE tasks
SET priority = 10
WHERE task_id = 7;

SELECT * FROM tasks;

UPDATE tasks
SET
	due_date = DATE('2023-10-05')
    , priority = 5
WHERE task_id = 6;

SELECT * FROM tasks;

-- Procedure, trigger는 일종의 사용자 정의함수
-- PL/SQL 이라는 개념을 알아야함.
DELIMITER $$
CREATE PROCEDURE mulcamp.GetTasks()
BEGIN
	SELECT *
    FROM tasks
    ORDER BY task_id;
END $$
DELIMITER ;

CALL mulcamp.GetTasks();

-- [VIEW]
DROP VIEW tasksView;
CREATE VIEW tasksView 
AS 
SELECT * 
FROM tasks
WHERE task_id = 4;

SELECT * FROM tasksView;