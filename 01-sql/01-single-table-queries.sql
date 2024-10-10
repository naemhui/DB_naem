-- 01. Querying data
SELECT
  LastName
FROM
  employees;
-- == SELECT LastName FROM employees;

SELECT
  LastName, FirstName
FROM
  employees;

SELECT
  *
FROM
  employees;

SELECT
  FirstName AS '이름'
FROM
  employees;

SELECT
  Name,
  Milliseconds / 60000 AS '재생 시간(분)' -- integer이라 나눌 수 있음
FROM
  tracks;


-- 02. Sorting data
SELECT
  FirstName
FROM
  employees
ORDER BY
  FirstName DESC;  -- ASC는 생략 가능

SELECT
  Country,
  City
FROM
  customers
ORDER BY
  Country DESC;
  City;

SELECT
  Name,
  Milliseconds / 60000 AS '재생 시간(분)'
FROM
  tracks
ORDER BY
  Milliseconds DESC;

-- NULL 정렬 예시
SELECT
  ReportsTo
FROM
  employees
ORDER BY
  ReportsTo;

-- 03. Filtering data
SELECT DISTINCT
  Country
FROM
  customers
ORDER BY
  Country;

-- WHERE
SELECT
  LastName, FirstName, City
FROM
  customers
WHERE
  City = 'Prague';  -- != not 연산자
-- 10개
SELECT
  LastName, FirstName, Company, Country
FROM
  customers
WHERE
  -- Company = NULL
  Company IS NULL  -- NULL은 IS 쓴다. 논리 연산자 안 씀.
  AND Country = 'USA';
-- 52개
SELECT
  LastName, FirstName, Company, Country
FROM
  customers
WHERE
  -- Company = NULL
  Company IS NULL  -- NULL은 IS 쓴다. 논리 연산자 안 씀.
  OR Country = 'USA';

SELECT
  Name, Bytes
FROM
  tracks
WHERE
  Bytes BETWEEN 10000 AND 500000
  --  Bytes >= 10000 AND Bytes <= 500000;  도 틀리지는 않지만
ORDER BY
  Bytes;

SELECT
  LastName, FirstName, Country
FROM
  customers
WHERE
  Country NOT IN ('Canada', 'Germany', 'France');
  -- Country = 'Canada'
  -- OR Country = 'Germany'
  -- OR Country = 'France';
  -- 위와 같은 OR 조건이 길어진다면?

SELECT
  LastName, FirstName
FROM
  customers
WHERE
  LastName LIKE '%son';

SELECT
  LastName, FirstName
FROM
  customers
WHERE
  FirstName LIKE '___a';
-- 내림차순으로 7개
SELECT
  TrackId, Name, Bytes
FROM
  tracks
ORDER BY
  Bytes DESC
LIMIT 7;
-- 4번째부터 7개
SELECT
  TrackId, Name, Bytes
FROM
  tracks
ORDER BY
  Bytes DESC
-- LIMIT 3, 4; 와 같은 코드
LIMIT 4 OFFSET 3;

-- 04. Grouping data
SELECT
  Country, COUNT(*)
FROM
  customers
GROUP BY
  Country;