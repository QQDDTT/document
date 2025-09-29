use my_database;

CREATE DATABASE IF NOT EXISTS my_database
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

DROP DATABASE IF EXISTS my_database;


CREATE TABLE user (
	id VARCHAR(7) NOT NULL PRIMARY KEY,
  name_zh VARCHAR(32) NOT NULL,
  name_ja VARCHAR(32) NOT NULL,
  name_en VARCHAR(32) NOT NULL,
  gender VARCHAR(8),
  birthday DATE,
  create_date DATE DEFAULT (CURRENT_DATE),
  end_date DATE DEFAULT (CURRENT_DATE + INTERVAL 1 YEAR),
	tel VARCHAR(13),
  mail VARCHAR(128),
  member_type VARCHAR(8) DEFAULT '普通',
  cell_permission VARCHAR(8) DEFAULT TRUE,
  cell_rate VARCHAR(8) DEFAULT '90',
  point_permission VARCHAR(8) DEFAULT TRUE,
  point VARCHAR(128) DEFAULT 0,
  description VARCHAR(256)
);

DROP TABLE user;

CREATE TABLE animal (name VARCHAR(16) NOT NULL PRIMARY KEY, gender VARCHAR(8), type VARCHAR(8), age INT);

DROP TABLE animal;

INSERT INTO animal VALUES (name = 'nick', age = 2);

INSERT INTO animal (name, age) VALUES ('tom', 2), ('jerry', 3);

INSERT INTO animal (name, age, gender, type) VALUES ('tom1', 2, "NULL", "NULL"), ('jerry1', 3, "NULL", "NULL");

INSERT INTO animal (name, age, gender, type) VALUES ('tom2', 2, "", ""), ('jerry2', 3, "", "");

INSERT INTO animal (name, age, gender, type) VALUES ('tom3', 2, " ", " "), ('jerry3', 3, " ", " ");

UPDATE animal SET gender = "man", type = "cat" WHERE name = "jerry";

UPDATE animal SET gender = "man", type = "mouse" WHERE name LIKE "jerry_";

UPDATE animal SET gender = "man", type = "cat" WHERE name LIKE "tom%";

UPDATE animal SET age = 4 WHERE age = 3;

UPDATE animal SET age = 3 WHERE age = 2;

SELECT * FROM animal WHERE 1=1 AND age = 3 AND name LIKE "j%";

UPDATE animal SET age = 4 WHERE age = 3;


SELECT name FROM animal WHERE age >= 2;

SELECT name, age FROM animal WHERE name = 'dog';

SELECT * FROM user WHERE name_zh LIKE '黃%';

SELECT * FROM user WHERE id = "TD10002";

SELECT * FROM user WHERE tel = '080-9199-6093';

SELECT * FROM user WHERE name_zh LIKE '黃%' AND gender = '女性';

UPDATE animal SET age = 3, name = 'cat' WHERE name = 'dog';

DELETE FROM animal WHERE name = 'cat';

SELECT * FROM animal WHERE name = 'cat';

SELECT COUNT(*) FROM animal;

SELECT COUNT(*) FROM user WHERE name_zh LIKE '黃%' AND gender = '女性';

SELECT * FROM animal ORDER BY name DESC;

SELECT * FROM user WHERE name_zh LIKE '黃%' AND gender = '女性' ORDER BY point DESC;

SELECT * FROM user WHERE gender = '女性' LIMIT 10 OFFSET 0;

SELECT * FROM user WHERE gender = '女性' LIMIT 10 OFFSET 10;

SELECT point_permission, cell_permission, COUNT(*) FROM user WHERE gender = '男性' GROUP BY point_permission, cell_permission;

SELECT * FROM animal WHERE name REGEXP '[a-z]+';