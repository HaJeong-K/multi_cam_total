USE mydata;

SELECT * FROM dataset3;

-- 196 페이지 가장 많이 판매된 2개 상품 조회
-- 2개만 나오도록 출력

-- 가장 많이 판매된 2개 상품 조회
SELECT
	StockCode
	, SUM(Quantity) QTY
FROM dataset3
GROUP BY 1
;

-- 순위 지정 (ROW_NUMBER() 사용)
SELECT
	*,
    ROW_NUMBER() OVER(ORDER BY QTY DESC) AS RNK
FROM (
	SELECT
		StockCode
		, SUM(Quantity) QTY
	FROM dataset3
	GROUP BY 1
) A
;

SELECT stockcode
FROM (
	SELECT
		*,
		ROW_NUMBER() OVER(ORDER BY QTY DESC) AS RNK
	FROM (
		SELECT
			StockCode
			, SUM(Quantity) QTY
		FROM dataset3
		GROUP BY 1
	) A
) A
WHERE RNK <= 2
;

-- 가장 많이 판매된 2개 상품을 모두 구매한 구매자가 구매한 상품
SELECT * FROM dataset3 ORDER BY stockcode, customerID;
CREATE TABLE BU_LIST AS
SELECT
	customerID
FROM dataset3
GROUP BY 1
HAVING MAX(CASE WHEN stockcode = '84077' THEN 1 ELSE 0 END) = 1 -- TRUE
	AND MAX(CASE WHEN stockcode = '85123A' THEN 1 ELSE 0 END) = 1 -- TRUE
;

SELECT *
FROM dataset3
WHERE customerID IN (SELECT customerID FROM BU_LIST)
	AND stockcode NOT IN ('84077', '85123A');

SELECT customerid, stockcode, quantity
FROM dataset3
WHERE customerID IN (SELECT customerID FROM BU_LIST)
	AND stockcode NOT IN ('84077', '85123A');

-- 국가별, 상품별 구매 지표 추출
-- 200 페이지
-- A 고객 2018년 구매, 2019년 구매
-- B 고객 2018년 구매
-- C 고객 2017년 구매, 2019년 구매
SELECT
	A.country
    , SUBSTR(A.invoicedate, 1, 4) AS YY
    , COUNT(DISTINCT B.customerid) / COUNT(DISTINCT A.customerid) AS R_RATE
FROM(
	SELECT
		DISTINCT country
		, invoicedate
		, customerid
	FROM dataset3
) A
LEFT
JOIN (SELECT DISTINCT country, invoicedate, customerid FROM dataset3) B
ON SUBSTR(A.invoicedate, 1, 4) = SUBSTR(B.invoicedate, 1, 4) - 1
	AND A.country = B.country
    AND A.customerid = B.customerid
GROUP BY 1, 2
ORDER BY 1, 2
;

-- 코호트 분석 (Retention)
-- 디지털 마케일 : 코호트 분석 (Retention) 정의, SQL 쿼리
-- 구글 애널리틱스 자동으로 만들어줌
-- 코호트 분석을 통해 특정 기간에 구매한 또는 가입한 고객들의 이후 구매액 및 리텐션
-- GA, SQL, Python, 엑셀(스프레드시트)

-- 고객별로 구매일 확인
SELECT
	customerid
    , MIN(invoicedate) MNDT
FROM dataset3
GROUP BY 1;


-- 각 고객의 주문 일자, 구매액을 조회
SELECT
	 customerid
     , invoicedate
     -- 구매금액 확인
     , unitprice * quantity AS SALES
FROM dataset3
;

-- 첫번째로 구매했던 고객별 첫 구매일 테이블에 고객의 구매내역을 JOIN한다.
SELECT *
FROM (
	SELECT
		 customerid
		 , MIN(invoicedate) MNDT
FROM dataset3
GROUP BY 1
) A
LEFT
JOIN (SELECT
		 customerid
		 , invoicedate
		 -- 구매금액 확인
		 , unitprice * quantity AS SALES
	FROM dataset3
    ) B
ON A.customerid = B.customerid
;

-- 205 페이지
-- MNDT는 각 고객의 최초 구매월 의미
-- 몇 개월 후에 재구매가 이뤄졌는지를 파악
-- TIMESTAMPDIFF(month/days, start, end)
SELECT SUBSTR(MNDT, 1, 7) MM,
TIMESTAMPDIFF(MONTH, MNDT, INVOICEDATE) DATEDIFF,
		COUNT(DISTINCT A.customerid) BU,
		SUM(SALES) SALES
FROM (
	SELECT
		 customerid
		 , MIN(invoicedate) MNDT
FROM dataset3
GROUP BY 1
) A
LEFT
JOIN (SELECT
		 customerid
		 , invoicedate
		 -- 구매금액 확인
		 , unitprice * quantity AS SALES
	FROM dataset3
    ) B
ON A.customerid = B.customerid
GROUP BY 1, 2
;