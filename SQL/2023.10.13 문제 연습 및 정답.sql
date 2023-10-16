-- 1번 문제

SELECT * FROM populations;

SELECT *
FROM populations
WHERE year = 2015
;

SELECT *
FROM(
	SELECT *
	FROM populations
	WHERE year = 2015
) A
WHERE fertility_rate >= 1.15
;


-- 2번 문제
SELECT * FROM countries;
SELECT * FROM cities;

SELECT capital AS name
FROM countries;

SELECT
	name
	, country_code
	, urbanarea_pop
FROM cities;

SELECT
	A.name
	, country_code
	, urbanarea_pop
FROM cities A
LEFT
JOIN countries B
ON A.name = B.capital
GROUP BY A.name
ORDER BY urbanarea_pop DESC
;


-- 3번 문제
SELECT 
	B.name AS country
	, COUNT(*) AS cities_num
FROM cities A
INNER
JOIN countries B 
ON B.code = A.country_code
GROUP BY country
ORDER BY cities_num DESC, country;

-- 4번 문제
SELECT * FROM countries;
SELECT * FROM economies;

SELECT *
FROM countries A
INNER
JOIN economies B
ON A.code = B.code
;

SELECT
	A.code
	, continent
	, inflation_rate
FROM (
	SELECT *
	FROM countries A
	INNER
	JOIN economies B
	ON A.code = B.code
) A
GROUP BY continent
;


----------------- 정답
-- 1번 문제

-- 메인쿼리 :
SELECT * FROM populations;

-- 서브쿼리 : 평균 기대 수명보다 1.15배 높은 모든 데이터
SELECT AVG(life_expectancy) FROM populations WHERE year = 2015;

-- 최종 정답
SELECT * FROM populations
WHERE life_expectancy >= 1.15 * (SELECT AVG(life_expectancy)
								 FROM populations
								 WHERE year = 2015)
;


-- 2번 문제

-- 메인쿼리 : cities에서 country_code, name, urbanarea_pop 조회
SELECT * FROM countries; -- code
SELECT * FROM cities; -- country code

SELECT
	name
	, country_code
	, urbanarea_pop
FROM cities
;

-- 서브쿼리 : countries에서 capital만 조회
SELECT capital FROM countries;

-- 최종 정답
SELECT
	name
	, country_code
	, urbanarea_pop
FROM cities
WHERE name IN (SELECT capital FROM countries)
ORDER BY urbanarea_pop DESC
;


-- 3번 문제
SELECT 
	B.name AS country
	, COUNT(*) AS cities_num
FROM cities A
INNER
JOIN countries B 
ON B.code = A.country_code
GROUP BY country
ORDER BY cities_num DESC, country;

-- 서브쿼리로 전환하는게 문제.

-- 메인쿼리 :
SELECT 
	A.name AS country
	, ~
FROM countries A
ORDER BY cities_num DESC, country;

-- 서브쿼리 :
SELECT COUNT(*)
	   FROM cities
	   WHERE A.code = cities.country_code

-- 최종 정답
EXPLAIN -- 쿼리 돌아가는 시간 순서 측정.
SELECT 
	A.name AS country
	, (SELECT COUNT(*)
	   FROM cities
	   WHERE A.code = cities.country_code) AS cities_num
FROM countries A
ORDER BY cities_num DESC, country;


-- 4번 문제
-- 각 대륙별 가장 높은 인플레이션을 구하는게 핵심!

-- 메인쿼리 :
-- countries 테이블의 국가, 대륙, 인플레이션
SELECT * FROM countries;
SELECT * FROM economies;

SELECT
	name
	, continent
	, inflation_rate
	, year
FROM countries A
INNER
JOIN economies B
ON A.code = B.code
WHERE year = 2015
	AND inflation_rate IN (-1.549, 10.287, 1.896)
;

-- 서브쿼리 :
SELECT 
	continent
	, MAX(inflation_rate)
FROM (
	SELECT
		name
		, continent
		, inflation_rate
		, year
	FROM countries A
	INNER
	JOIN economies B
	ON A.code = B.code
	WHERE year = 2015
) A
GROUP BY continent
;

-- 최종 정답

SELECT
	name
	, continent
	, inflation_rate
	, year
FROM countries A
INNER
JOIN economies B
ON A.code = B.code
WHERE year = 2015
	AND inflation_rate IN (
		SELECT 
			MAX(inflation_rate)
		FROM (
			SELECT
				name
				, continent
				, inflation_rate
				, year
			FROM countries A
			INNER
			JOIN economies B
			ON A.code = B.code
			WHERE year = 2015
) A
GROUP BY continent)
;