USE mydata;
SELECT
	`REVIEW TEXT`
    -- size 라는 단어가 들어가면 1 아니면 0
    , CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END SIZE_YN
FROM dataset2
;

SELECT
	-- N_SIZE 컬럼을 바로 사용하지 못해 에러남.
	SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE
    , COUNT(*) AS N_TOTAL
    , N_SIZE / N_TOTAL AS RATE
FROM dataset2
;

SELECT
	A.*
    -- 소수점 자리 조정.
    , ROUND(N_SIZE / N_TOTAL, 2) AS RATE
FROM (
	SELECT
		SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) AS N_SIZE,
			COUNT(*) AS N_TOTAL
		FROM dataset2
) A;

SELECT
	`department name`
	, SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) AS N_SIZE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) AS N_LARGE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) AS N_LOOSE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) AS N_SMALL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) AS N_TIGHT
    -- count 함수와 동일한 기능
    , SUM(1) N_TOTAL
FROM dataset2
-- 각 분류별 전체값을 표현.
GROUP BY 1
;

-- 146 페이지
SELECT
	floor(AGE/10) * 10 AGEBAND
	, `department name`
	, SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) AS N_SIZE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END) AS N_LARGE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END) AS N_LOOSE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END) AS N_SMALL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END) AS N_TIGHT
    -- count 함수와 동일한 기능
    , SUM(1) N_TOTAL
FROM dataset2
-- 조건절
-- WHERE `department name` = 'Dresses'
-- 각 분류별 전체값을 표현.
GROUP BY 1, 2
ORDER BY 1, 2
;

SELECT
	floor(AGE/10) * 10 AGEBAND
	, `department name`
	, SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SIZE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LARGE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LOOSE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SMALL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END)/ SUM(1) AS N_TIGHT
    , SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1, 2
ORDER BY 1, 2
;

-- Clothing ID별 Size Review
SELECT
	`clothing id`
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) AS N_SIZE
FROM dataset2
GROUP BY 1
;

SELECT
	`clothing id`
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SIZE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LARGE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LOOSE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SMALL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END)/ SUM(1) AS N_TIGHT
    , SUM(1) N_TOTAL
FROM dataset2
GROUP BY 1
;

SELECT * FROM dataset2;

DROP TABLE size_stat_as;
CREATE TABLE size_stat_as
SELECT
	`clothing id`
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END) N_SIZE_T
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SIZE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SIZE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LARGE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LARGE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%LOOSE%' THEN 1 ELSE 0 END)/ SUM(1) AS N_LOOSE
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%SMALL%' THEN 1 ELSE 0 END)/ SUM(1) AS N_SMALL
    , SUM(CASE WHEN `REVIEW TEXT` LIKE '%TIGHT%' THEN 1 ELSE 0 END)/ SUM(1) AS N_TIGHT
    , SUM(1) N_TOTAL
FROM dataset2
GROUP BY `clothing id`
;

