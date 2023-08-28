# Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.
SELECT COUNT(likes.id) AS 'less then 12'
FROM likes
WHERE user_id IN (SELECT user_id FROM profiles WHERE birthday > '2011-08-27');

# Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT
CASE 
	WHEN (SELECT COUNT(*) IN (SELECT user_id FROM profiles WHERE gender = 'm') FROM likes) > (SELECT COUNT(*) IN (SELECT user_id FROM profiles WHERE gender = 'f') FROM likes)
		THEN 'Мужчины поставили больше лайков'
	ELSE 'Женщины поставили больше лайков'
END AS Gender;

# Вывести всех пользователей, которые не отправляли сообщения.
SELECT firstname, lastname
FROM users
WHERE NOT EXISTS (SELECT from_user_id FROM messages WHERE users.id = messages.from_user_id);



