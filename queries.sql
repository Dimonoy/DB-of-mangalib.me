/* Group, join, subqueries
 * Список характерных выборок:
 *  - Что читает пользователь под id = ?
 * 	- Топ 10 читателей по уровню и рангу
 *  - Самая популярная манга
 *  - Процедура по заполнению временной таблицы, содержащей:
 * 		> название манги
 *  	> часть
 * 		> страница
 *  - Триггер для автовставки текущего года релиза (в default функция year не работает, поэтому создаём триггер)
 */
USE mangalib;

-- Представления:




-- Соединение пользователей и их профилей
DROP VIEW IF EXISTS users_profiles;
CREATE OR REPLACE VIEW users_profiles AS
SELECT 
	u.nickname,
	u.theme,
	u.gender,
	p.user_id,
	p.library_id,
	p.`level`,
	p.`rank`
FROM
	users u
JOIN `profiles` p ON u.id = p.user_id;




-- объединение библиотек и манг
DROP VIEW IF EXISTS mangas_libraries;
CREATE OR REPLACE VIEW mangas_libraries as
SELECT 
	m.en_title,
    m.ru_title,
	m.genres,
	m.tags,
    m.`type`,
	m.release_year,
    m.`format`,
    m.title_status,
    m.translation_status,
	m.age_limit,
	l.id AS library_id
FROM
	libraries l
JOIN mangas m ON l.manga_id = m.id;




-- Что читает пользователь под id = ? (если не показывает, значит пользователь не читает мангу, 
-- 									   или просто не сохраняет её в библиотеке, попробуйте другой id)
SET @id = 4;

SELECT 
    user_id,
    nickname,
    theme,
    gender,
    `level`,
    `rank`,
    en_title,
    genres,
    tags,
    release_year,
    age_limit
FROM
    users_profiles
JOIN
    mangas_libraries 
USING (library_id)
WHERE user_id = @id;




-- Топ 10 читателей по уровню и рангу
SELECT 
	nickname, `rank`, `level`, theme, gender 
FROM 
	users_profiles 
ORDER BY `rank`, `level` DESC 
LIMIT 10;




-- Самая популярная манга
SELECT 
    en_title, COUNT(library_id) AS popularity
FROM
    mangas_libraries
GROUP BY en_title
ORDER BY popularity DESC
LIMIT 1;




-- Процедура по заполнению новой таблицы, содержащей:
-- 		> название манги
--  	> часть
-- 		> страницы

DROP TEMPORARY TABLE IF EXISTS manga_builds;
CREATE TEMPORARY TABLE manga_builds (
	manga_title VARCHAR(255),
	chapter INT UNSIGNED,
	`page` INT UNSIGNED
) ENGINE=ARCHIVE;

drop temporary table if exists except_c;
drop temporary table if exists except_p;
create temporary table except_c (c_num INT);
create temporary table except_p (p_num INT);
delimiter //
DROP PROCEDURE IF EXISTS manga_build_update//
CREATE PROCEDURE manga_build_update()
BEGIN
	DECLARE count_of_mangas INT;
    DECLARE count_of_chapters INT;
    DECLARE count_of_pages INT;
    DECLARE counter_m INT DEFAULT 1;
    DECLARE counter_c INT DEFAULT 1;
    DECLARE counter_p INT DEFAULT 1;
    DECLARE value_c INT;
    DECLARE value_p INT;
    SET count_of_mangas = (SELECT COUNT(1) FROM mangas);
    WHILE counter_m <= count_of_mangas DO
		SET count_of_chapters = (SELECT COUNT(1) FROM chapters c JOIN mangas_chapters mc ON c.id = mc.chapter_id WHERE mc.manga_id = counter_m);
		WHILE counter_c <= count_of_chapters DO
			SET value_c = (SELECT DISTINCT chapter FROM chapters c JOIN mangas_chapters mc ON c.id = mc.chapter_id 
												   WHERE mc.manga_id = counter_m AND chapter NOT IN (SELECT * FROM except_c) LIMIT 1);
            INSERT INTO except_c VALUE (value_c);
			SET count_of_pages = (SELECT COUNT(1) FROM pages p JOIN chapters_pages cp ON p.id = cp.page_id WHERE cp.chapter_id = counter_p);
            cycle: WHILE counter_p <= count_of_pages DO
				SET value_p = (SELECT page_num FROM pages p JOIN chapters_pages cp ON p.id = cp.page_id 
												   WHERE cp.chapter_id = counter_c AND page_num NOT IN (SELECT * FROM except_p) LIMIT 1);
                INSERT INTO except_p VALUE (value_p);
				IF value_c IS NULL OR value_p IS NULL THEN
					LEAVE cycle;
                ELSE
					INSERT INTO manga_builds VALUE ((select distinct en_title from mangas where id = counter_m), value_c, value_p);
				END IF;
                SET counter_p = counter_p + 1;
            END WHILE cycle;
            TRUNCATE except_p;
			SET counter_c = counter_c + 1;
            SET counter_p = 1;
        END WHILE;
        TRUNCATE except_c;
		SET counter_m = counter_m + 1;
        SET counter_c = 1;
    END WHILE;
END
//
delimiter ;

CALL manga_build_update();
SELECT * FROM manga_builds ORDER BY 1, 2, 3;




-- Триггер для автовставки текущего года релиза
delimiter //
CREATE TRIGGER mangas_year_release_insert BEFORE INSERT ON mangas 
FOR EACH ROW
BEGIN
	IF new.release_year IS NULL THEN
		set new.release_year = YEAR(NOW());
	END IF;
END//
delimiter ;