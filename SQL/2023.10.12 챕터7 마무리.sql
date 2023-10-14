-- p.206
USE mydata;

-- RFM : 가치있는 고객을 추출하는 방법론, 고객 세그먼트 
-- p.207
-- R : 제일 최근에 구입한 시기
-- F : 어느 정도로 자주 구입했는가? 
-- M : 구입한 총 금액은 얼마인가? 

-- Recency : 계산해보자, 거래의 최근성을 나타내는 지표
SELECT 
	customerid
    , MAX(invoiceDate) MXDT 
FROM dataset3
GROUP BY 1;

-- 2011-12-02 부터의 Timer Interval 계산 
SELECT 
	customerid
    , datediff('2011-12-02', mxdt) RECENCY 
FROM (
	SELECT 
		customerid
		, MAX(invoiceDate) MXDT 
	FROM dataset3
	GROUP BY 1
) A
;

-- Frequency, Monetary 계산 (p.209)
SELECT 
	customerid
    , COUNT(DISTINCT invoiceno) AS frequency
    , SUM(quantity * unitprice) AS monetary 
FROM dataset3
GROUP BY 1
;

-- RFM 전체 쿼리 
SELECT 
	customerid
    , datediff('2011-12-02', mxdt) RECENCY 
    , frequency
    , monetary
FROM (
	SELECT 
		customerid
		, MAX(invoiceDate) MXDT 
		, COUNT(DISTINCT invoiceno) AS frequency
		, SUM(quantity * unitprice) AS monetary 
	FROM dataset3
	GROUP BY 1
) A
;

-- 재구매 segment
-- 동일한 상품을 2개 연도에 걸쳐서 구매한 고객과 그렇지 않은 고객을 segment로 나눔.
-- 파생변수를 만드는 과정.
-- 고객별, 상품별 구매 연도를 unique 하게 count
SELECT
	customerid
    , stockcode
    , COUNT(DISTINCT SUBSTR(invoicedate, 1, 4)) UNIQUE_YY
FROM dataset3
GROUP BY 1, 2
;

-- UNIQEUE_YY 가 2 이상인 고객과 그렇지 않은 고객을 구분한다.
SELECT
	customerid
    , MAX(UNIQUE_YY) mx_unique_yy
FROM (
	SELECT
		customerid
		, stockcode
		, COUNT(DISTINCT SUBSTR(invoicedate, 1, 4)) UNIQUE_YY
	FROM dataset3
	GROUP BY 1, 2
) A
GROUP BY 1
ORDER BY 2 DESC
;

-- 문제 mx_unique_yy 2 이상이면 1, 그 외에는 0
-- CASE WHEN 사용해서 처리함.
SELECT
	customerid
    , CASE WHEN mx_unique_yy >= 2 THEN 1 ELSE 0 END R_SEGMENT
FROM (
	SELECT
		customerid
		, MAX(UNIQUE_YY) mx_unique_yy
	FROM (
		SELECT
			customerid
			, stockcode
			, COUNT(DISTINCT SUBSTR(invoicedate, 1, 4)) UNIQUE_YY
		FROM dataset3
		-- 집계함수를 사용하면 그룹바이 사용해야함.
        GROUP BY 1, 2
	) A
	GROUP BY 1
	ORDER BY 2 DESC
) A
;

-- 일자별 첫 구매자 수
-- 신규 유저를 확인.
-- 고객별 첫 구매일
SELECT
	customerid
    , MIN(invoicedate) MNDT
FROM dataset3
GROUP BY customerid

-- 일자별로 고객 수를 CNT 일자별 첫구매 고객 수를 계산할 수 있음.
SELECT
	MNDT
    , COUNT(DISTINCT customerid) BU
FROM (
	SELECT
		customerid
		, MIN(invoicedate) MNDT
	FROM dataset3
	GROUP BY customerid
) A
GROUP BY 1
;

-- 고객별, 상품별 첫 구매 일자
SELECT
	customerid
    , stockcode
    , MIN(invoicedate) MNDT
FROM dataset3
GROUP BY 1, 2
;

-- 고객별 구매와 기준 순위 생성
SELECT
	*
    , ROW_NUMBER() OVER(PARTITION BY customerid ORDER BY MNDT) RNK
FROM (
	SELECT
		customerid
		, stockcode
		, MIN(invoicedate) MNDT
	FROM dataset3
	GROUP BY 1, 2
) A
;

-- 고객별 첫 구매 내역 조회
SELECT *
FROM (
	SELECT
		*
		, ROW_NUMBER() OVER(PARTITION BY customerid ORDER BY MNDT) RNK
	FROM (
		SELECT
			customerid
			, stockcode
			, MIN(invoicedate) MNDT
		FROM dataset3
		GROUP BY 1, 2
	) A
) A
WHERE RNK = 1
;

-- 상품별 첫 구매 고객 수 집계
SELECT
	stockcode
    , COUNT(DISTINCT customerid) FIRST_BU
FROM (
	SELECT *
	FROM (
		SELECT
			*
			, ROW_NUMBER() OVER(PARTITION BY customerid ORDER BY MNDT) RNK
		FROM (
			SELECT
				customerid
				, stockcode
				, MIN(invoicedate) MNDT
			FROM dataset3
			GROUP BY 1, 2
		) A
	) A
	WHERE RNK = 1
) A
GROUP BY 1
ORDER BY 2 DESC
;

SELECT
	-- customerid
    SUM(CASE WHEN F_DATE = 1 THEN 1 ELSE 0 END) / SUM(1) AS BOUNC_RATE
FROM (
	SELECT
		customerid
		, COUNT(DISTINCT invoicedate) F_DATE
	FROM dataset3
    GROUP BY 1
) A
;

SELECT
	customerid
    , country
    , COUNT(DISTINCT invoicedate) AS F_DATE
FROM dataset3
GROUP BY 1, 2
;

SELECT
	country
    , SUM(CASE WHEN F_DATE = 1 THEN 1 ELSE 0 END) / SUM(1) AS BOUNC_RATE
FROM (
	SELECT
		customerid
		, country
		, COUNT(DISTINCT invoicedate) AS F_DATE
	FROM dataset3
	GROUP BY 1, 2
) A
GROUP BY 1
ORDER BY 1
;