-- Active:

-- 1. 테이블 생성
CREATE TABLE examples (
  ExamId INTEGER PRIMARY KEY AUTOINCREMENT,
  LastName VARCHAR(50) NOT NULL,
  FirstName VARCHAR(50) NOT NULL
);

PRAGMA table_info('examples');


ALTER TABLE
  examples
ADD COLUMN
  Age INTEGER NOT NULL DEFAULT 0;

ALTER TABLE
  examples
ADD COLUMN
  Address VARCHAR(100) NOT NULL DEFAULT 'default value';

# 그 다음에 배워볼 것
-- 
ALTER TABLE
  examples
RENAME COLUMN
  Address TO PostCode;

-- 삭제
ALTER TABLE
  examples
DROP COLUMN
  PostCode;

ALTER TABLE
  examples
RENAME TO
  new_examples;

-- 테이블 삭제
DROP TABLE
  new_examples;

------
-- 실습 테이블 생성
CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(100) NOT NULL,
  content VARCHAR(200) NOT NULL,
  createdAt DATE NOT NULL
);

-- INSERT syntax
INSERT INTO
  articles (title, content, createdAt)  -- id는 알아서 생성하니까 안 넣어줘도 됨
VALUES
  ('hello', 'world', '2000-01-01');

SELECT * FROM articles;

-- articles 테이블에 데이터 추가 입력
INSERT INTO
  articles (title, content, createdAt)
VALUES
  ('title1', 'content1', '1900-01-01'),
  ('title2', 'content2', '1800-01-01'),
  ('title3', 'content3', '1700-01-01');

INSERT INTO
  articles (title, content, createdAt)
VALUES
  ('mytitle', 'mycontent', DATE());  -- DATE() 알아서 오늘 날짜 입력함

-- UPDATE syntax
UPDATE
  articles
SET
  title = 'update Title'
WHERE
  id = 1;  -- 근데 어떤 데이터? id가 1인 데이터

UPDATE
  articles
SET
  title = 'update Title',  -- , 빼먹지 마라 진쫘
  content = 'update Content'
WHERE
  id = 2;

DELETE FROM
  articles
WHERE
  id = 1;
-- articles 테이블에서 작성일이 오래된 순으로 레코드 2개 삭제
DELETE FROM
  articles
WHERE id IN (
  SELECT id FROM articles
  ORDER BY createdAt
  LIMIT 2
);  -- 실행 계속 했더니 다 삭제됨..


CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE articles (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(50) NOT NULL,
  content VARCHAR(100) NOT NULL,
  userId INTEGER NOT NULL,
  FOREIGN KEY (userId)
    REFERENCES users(id)
);

INSERT INTO
  users (name)
VALUES
  ('하석주'),
  ('송윤미'),
  ('유하선');
INSERT INTO
  articles (title, content, userId)
VALUES
  ('제목1', '내용1', 1),
  ('제목2', '내용2', 2),
  ('제목3', '내용3', 3),
  ('제목4', '내용4', 4),
  ('제목5', '내용5', 1);

SELECT *
FROM
  articles INNER JOIN users
  ON users.id = articles.userId
WHERE users.id = 1;

SELECT *
FROM
  articles LEFT JOIN users
  ON users.id = articles.userId

SELECT *
FROM
  users FULL OUTER JOIN articles
  ON users.id = articles.userId;

SELECT *
FROM users, articles
WHERE users.id = articles.userId;

-- CROSS JOIN : 두 테이블 간의 가능한 모든 경우의 수 출력
-- 출력 결과 : 왼쪽 테이블 * 오른쪽 테이블
-- SELECT *
-- FROM users, articles;