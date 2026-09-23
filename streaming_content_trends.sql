SELECT * FROM streaming_content_project.streaming_content_trends;

USE streaming_content_project;
SELECT *FROM streaming_content_trends;

-- =========================================
-- 1. NUMERICAL CALCULATIONS
-- =========================================
SELECT COUNT(*) AS total_records,
    ROUND(AVG(popularity), 2) AS avg_popularity,
    MIN(popularity) AS min_popularity,
    MAX(popularity) AS max_popularity,
    ROUND(AVG(vote_average), 2) AS avg_rating,
    MIN(vote_average) AS min_rating,
    MAX(vote_average) AS max_rating,
	ROUND(AVG(vote_count), 2) AS avg_votes,
    MIN(vote_count) AS min_votes,
    MAX(vote_count) AS max_votes
FROM streaming_content_trends;

-- =========================================
-- 2. DATA CHECKING
-- =========================================
SELECT *FROM streaming_content_trends
LIMIT 10;

-- =========================================
-- 3. CHECK MISSING VALUES
-- =========================================
SELECT SUM(id IS NULL) AS missing_id,
    SUM(title IS NULL) AS missing_title,
    SUM(popularity IS NULL) AS missing_popularity,
    SUM(vote_average IS NULL) AS missing_rating,
    SUM(vote_count IS NULL) AS missing_votes,
    SUM(release_year IS NULL) AS missing_year
FROM streaming_content_trends;

-- =========================================
-- 4. MOVIE / TV ANALYSIS
-- =========================================
SELECT media_type,
    COUNT(*) AS total_content,
    ROUND(AVG(popularity), 2) AS average_popularity,
    ROUND(AVG(vote_average), 2) AS average_rating,
    ROUND(AVG(vote_count), 2) AS average_votes
FROM streaming_content_trends
GROUP BY media_type;

-- =========================================
-- 5. TOP 10 POPULAR CONTENT
-- =========================================
SELECT title,
    media_type,
    popularity,
    vote_average,
    vote_count
FROM streaming_content_trends
ORDER BY popularity DESC
LIMIT 10;

-- =========================================
-- 6. TOP RATED CONTENT
-- =========================================
SELECT title,
    media_type,
    vote_average,
    vote_count
FROM streaming_content
WHERE vote_count >= 100
ORDER BY vote_average DESC
LIMIT 10;

-- =========================================
-- 7. YEAR-WISE ANALYSIS
-- =========================================
SELECT release_year,
    COUNT(*) AS total_content,
    ROUND(AVG(vote_average), 2) AS average_rating,
    ROUND(AVG(popularity), 2) AS average_popularity,
    SUM(vote_count) AS total_votes
FROM streaming_content
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

-- =========================================
-- 8. LANGUAGE ANALYSIS
-- =========================================
SELECT original_language,
    COUNT(*) AS total_content,
    ROUND(AVG(vote_average), 2) AS average_rating
FROM streaming_content_trends
GROUP BY original_language
ORDER BY total_content DESC;

-- =========================================
-- 9. DUPLICATE CHECK
-- =========================================
SELECT id,
    COUNT(*) AS duplicate_count
FROM streaming_content_trends
GROUP BY id
HAVING COUNT(*) > 1;

-- =========================================
-- 10. Find content released after 2020
-- =========================================
SELECT title, release_year
FROM streaming_content_trends
WHERE release_year > 2020;

-- =========================================
-- 11. Find highly rated content
-- =========================================
SELECT title, vote_average
FROM streaming_content_trends
WHERE vote_average >= 8;

-- =========================================
-- 12. Find content with more than 1000 votes
-- =========================================
SELECT title, vote_count
FROM streaming_content_trends
WHERE vote_count > 1000;

-- =========================================
-- 13. Find content between two years
-- =========================================
SELECT title, release_year
FROM streaming_content_trends
WHERE release_year BETWEEN 2015 AND 2020;

-- =========================================
-- 14. Combine conditions
-- =========================================
SELECT title,
    media_type,
    vote_average,
    popularity
FROM streaming_content
WHERE vote_average >= 7
AND popularity >= 50;

-- =========================================
-- 15. Find movies only
-- =========================================
SELECT title, vote_average
FROM streaming_content_trends
WHERE media_type = 'movie';

-- =========================================
-- 16. JOIN ANALYSIS
-- =========================================

CREATE TABLE media_type_info (
    media_type VARCHAR(20),
    description VARCHAR(100)
);
INSERT INTO media_type_info
VALUES
('movie', 'Film Content'),
('tv', 'Television Content');
SELECT s.title,
    s.media_type,
    s.vote_average,
    m.description
FROM streaming_content_trends AS s
JOIN media_type_info AS m
ON s.media_type = m.media_type;












































