USE classicmodels;
-- [SELECT]

SELECT customerNumber, phone FROM classicmodels.customers;

-- [COUNT] : 행의 갯수, 각 칼럼의 값의 갯수를 파악할 때
SELECT COUNT(checknumber) FROM payments;
SELECT COUNT(*) FROM payments;

-- 테이블 정의서
SELECT * FROM payments; -- 실무에서는 이 쿼리 사용하면 안됨
SELECT SUM(amount) FROM payments;

SELECT productname, productline
FROM products;

-- [특정 컬럼명 변경] : 주로 하나보단 여러개를 활용하는 경우가 많아서 아래의 문법으로 가독성을 높임. => 정답은 아니고 예시일 뿐.
SELECT
	COUNT(productcode) AS n_products
    , COUNT(productcode) n_products -- AS를 생략하고도 같은 결과값을 얻음.
    , COUNT(productcode)
    , COUNT(productcode) AS 갯수 -- 한글도 사용가능함.
FROM
	products
;

-- 교재 31 페이지
-- DISTINCT : 중복 제외하고 데이터 조회!
SELECT
	DISTINCT ordernumber
FROM
	orderdetails
;

SELECT 
	COUNT(ordernumber) AS 중복포함
    , COUNT(DISTINCT ordernumber) AS 중복제거
FROM 
	orderdetails
;

-- [WHERE] SQL 문법에서 WHERE절을 익히는 것이 60%
-- Online 튜토리얼, WHERE 절 집중적으로 익히시는 것 추천alter

-- [WHERE, BETWEEN]
SELECT *
FROM orderdetails
WHERE priceeach BETWEEN 30 AND 50;

-- [WHERE, 대소관계 연산자]
SELECT *
FROM orderdetails
WHERE priceeach < 30;

SELECT COUNT(*)
FROM orderdetails
WHERE priceeach < 30;

SELECT *
FROM payments
WHERE amount < 6066;

-- [WHERE, IN],
-- 주의할 점은 컬럼의 갓이 "값1" 또는 "값2" 인 데이터가 출력된다.
-- 서브쿼리 사용할 때 자주 사용되는 연산자.

SELECT
	customernumber
    , country
FROM customers
-- 1개만 사용할 경우 등호 사용이 편함.
WHERE country = 'USA' OR country = 'Canada' OR country = 'France'
;

SELECT
	customernumber
    , country
FROM customers
-- 2개 이상 사용할 경우 IN 사용이 편함.
WHERE country NOT IN ('USA', 'Canada', 'France')
;

-- [WHERE, IS NULL]

SELECT * FROM employees;

SELECT employeenumber
FROM employees
WHERE reportsto IS NOT NULL;

SELECT employeenumber
FROM employees
WHERE reportsto IS NULL;

SELECT
	COUNT(employeenumber)
    , COUNT(reportsto) -- NULL이 존재하면 COUNT 하지 않음.
    , COUNT(*)
FROM employees;


SELECT COUNT(reportsto) FROM employees;

-- [WHERE, LIKE '%TEXT%'] 42페이지.
-- %는 문자를 의미함.

SELECT
	addressline1
FROM customers
-- 해당 글자가 맨 뒤에만 와야함.
WHERE addressline1 LIKE '%ST.';

SELECT
	addressline1
FROM customers
-- 해당 글자가 맨 앞에만 와야함.
WHERE addressline1 LIKE 'ST%';

SELECT
	addressline1
FROM customers
-- 해당 글자가 어디에 위치하든 상관없음.
WHERE addressline1 LIKE '%ST%';

-- GROUP BY
SELECT
	country
    , city
    , COUNT(customernumber) AS n_customers
FROM customers
GROUP BY country, city
;
-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'classicmodels.customers.country'; this is incompatible with sql_mode=only_full_group_by


SELECT * FROM payments;
SELECT
	customernumber
    , checknumber
    , SUM(amount)
FROM
	payments
GROUP BY customernumber, checknumber;

-- [CASE WHEN] :  IF 조건문
-- 46 페이지, USA 거주자의 수 계산, 그 비중 구하기
SELECT
	SUM(CASE WHEN country = 'USA'THEN 1 ELSE 0 END) N_USA
FROM
	customers;

-- 위의 결과에 해당하는 값들 확인.
SELECT
	country
	, CASE WHEN country = 'USA'THEN 1 ELSE 0 END N_USA
FROM
	customers;
    
-- 비율을 같이 구함.
SELECT
	SUM(CASE WHEN country = 'USA'THEN 1 ELSE 0 END) N_USA
    , COUNT(*)
    , SUM(CASE WHEN country = 'USA' THEN 1 ELSE 0 END) / COUNT(*) AS USA_PORTION
FROM
	customers;
    
-- [JOIN]
-- 실무에서는 ERD를 그림을 보면서 어떻게 JOIN 할건지 계획짬.



-- LEFT JOIN
SELECT
	*
FROM orders A
LEFT
JOIN customers B
ON A.customernumber = B.customernumber
WHERE B.country = 'USA';

-- INNER JOIN
SELECT
	*
FROM orders A
INNER
JOIN customers B
ON A.customernumber = B.customernumber
WHERE B.country = 'USA';

-- FULL JOIN
SELECT
	*
FROM orders A
FULL
JOIN customers B
ON A.customernumber = B.customernumber;
-- order by : 정렬함.
-- 58 페이지.
-- 윈도우 함수 : RANK, DENSE_RANK, ROW_NUMBER 중요함!!
SELECT
	buyprice
    , ROW_NUMBER() OVER(ORDER BY buyprice) ROWNUMBER
    , RANK() OVER(ORDER BY buyprice) RNK
    , DENSE_RANK() OVER(ORDER BY buyprice) DENSERANK
FROM products;

-- 61 페이지.
-- PARTITON BY
SELECT
	productline
	, buyprice
    , ROW_NUMBER() OVER(PARTITION BY productline ORDER BY buyprice) ROWNUMBER
    , RANK() OVER(PARTITION BY productline ORDER BY buyprice) RNK
    , DENSE_RANK() OVER(PARTITION BY productline ORDER BY buyprice) DENSERANK
FROM products;

-- 62 페이지.
-- SubQuery : 매우 중요함!
-- 서브 쿼리 : 쿼리 안에 또 다른 쿼리를 사용하는 것 (갯수는 무제한!!)
SELECT
	(A(B(C)))
    , (B)
FROM (A(B(C)))
WHERE col IN (D)
GROUP BY
HAVING (E)
ORDER BY (F)

SELECT SUM(col)
FROM table
WHERE
GROUP BY
HAVING
ORDER BY