/* 1. Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой 
можно переместить любого (одного) пользователя из таблицы users в таблицу users_old (использование 
транзакции с выбором commit или rollback – обязательно).*/
-- DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id INT PRIMARY KEY auto_increment, 
    firstname varchar(50), 
    lastname varchar(50), 
    email varchar(120)
);

DROP PROCEDURE IF EXISTS move_person;
DELIMITER //
CREATE PROCEDURE move_person (IN num_person INT) 
BEGIN
START TRANSACTION;
INSERT INTO users_old (firstname, lastname, email) 
SELECT firstname, lastname, email 
	FROM users 
	WHERE users.id = num_person;
DELETE FROM users 
	WHERE id = num_person;
COMMIT;
END //

DELIMITER ;

CALL move_person(6);

SELECT * FROM users_old;

/* 2. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего 
времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция 
должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй 
ночи".*/

DELIMITER //
-- DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello() 
	RETURNS VARCHAR(25)
	DETERMINISTIC
BEGIN
DECLARE phrase VARCHAR(25);
SELECT CASE 
	WHEN CURRENT_TIME >= '06:00:00' AND CURRENT_TIME < '12:00:00' THEN 'Доброе утро'
    WHEN CURRENT_TIME >= '12:00:00' AND CURRENT_TIME < '18:00:00' THEN 'Добрый день'
	WHEN CURRENT_TIME >= '18:00:00' AND CURRENT_TIME <= '23:59:59' THEN 'Добрый вечер'
	ELSE 'Доброй ночи'
END INTO phrase;
RETURN phrase;
END //

DELIMITER ;

SELECT hello();