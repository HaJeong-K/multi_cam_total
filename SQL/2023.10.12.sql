SELECT * FROM accident;

-- 테이블 생성
-- DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  name                    VARCHAR   PRIMARY KEY,
  country_code            VARCHAR,
  city_proper_pop         REAL,
  metroarea_pop           REAL,
  urbanarea_pop           REAL
);

-- DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  code                  VARCHAR     PRIMARY KEY,
  name                  VARCHAR,
  continent             VARCHAR,
  region                VARCHAR,
  surface_area          REAL,
  indep_year            INTEGER,
  local_name            VARCHAR,
  gov_form              VARCHAR,
  capital               VARCHAR,
  cap_long              REAL,
  cap_lat               REAL
);

-- DROP TABLE IF EXISTS economies;
CREATE TABLE economies (
  econ_id               INTEGER     PRIMARY KEY,
  code                  VARCHAR,
  year                  INTEGER,
  income_group          VARCHAR,
  gdp_percapita         REAL,
  gross_savings         REAL,
  inflation_rate        REAL,
  total_investment      REAL,
  unemployment_rate     REAL,
  exports               REAL,
  imports               REAL
);

-- DROP TABLE IF EXISTS populations;
CREATE TABLE populations (
  pop_id                INTEGER     PRIMARY KEY,
  country_code          VARCHAR,
  year                  INTEGER,
  fertility_rate        REAL,
  life_expectancy       REAL,
  size                  REAL
);

-- DROP TABLE IF EXISTS summer_medals;
CREATE TABLE summer_medals
(
    year integer,
    city character varying(42),
    sport character varying(34),
    discipline character varying(34),
    athlete character varying(94),
    country character(6),
    gender character varying(10),
    event character varying(98),
    medal character varying(12)
);

SELECT * FROM cities;
SELECT * FROM countries;
SELECT * FROM economies;
SELECT * FROM populations;
SELECT * FROM summer_medals;