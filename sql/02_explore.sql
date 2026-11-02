--Общая картина по числу раундов
SELECT
    MIN(sum_gamerounds)                                         AS min_rounds,
    MAX(sum_gamerounds)                                         AS max_rounds,
    ROUND(AVG(sum_gamerounds), 1)                               AS avg_rounds,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS median_rounds
FROM cookie_cats;

--Самые «активные» игроки
SELECT userid, version, sum_gamerounds
FROM cookie_cats
ORDER BY sum_gamerounds DESC
LIMIT 10;

--Игроки, которые не сыграли ни одного раунда
SELECT COUNT(*) AS zero_rounds_players
FROM cookie_cats
WHERE sum_gamerounds = 0;

-- Те же показатели по группам
SELECT
    version,
    COUNT(*)                                                    AS players,
    ROUND(AVG(sum_gamerounds), 1)                               AS avg_rounds,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sum_gamerounds) AS median_rounds,
    MAX(sum_gamerounds)                                         AS max_rounds
FROM cookie_cats
GROUP BY version;

--Проверка среднего без выброса
SELECT
    version,
    COUNT(*)                        AS players,
    ROUND(AVG(sum_gamerounds), 1)   AS avg_rounds
FROM cookie_cats
WHERE sum_gamerounds < 10000
GROUP BY version;

--Как игроки распределены по активности
SELECT
    CASE
        WHEN sum_gamerounds = 0   THEN '0'
        WHEN sum_gamerounds < 10  THEN '1-9'
        WHEN sum_gamerounds < 50  THEN '10-49'
        WHEN sum_gamerounds < 100 THEN '50-99'
        ELSE '100+'
    END AS rounds_bucket,
    COUNT(*) AS players
FROM cookie_cats
GROUP BY rounds_bucket
ORDER BY MIN(sum_gamerounds);