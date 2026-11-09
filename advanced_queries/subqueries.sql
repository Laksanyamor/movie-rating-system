-- Query 1: Find movies rated above the overall average

SELECT
    m.title,
    ROUND(AVG(r.rating_value), 2) AS movie_average
FROM MOVIE m
INNER JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
HAVING AVG(r.rating_value) > (
    SELECT AVG(rating_value)
    FROM RATES
)
ORDER BY movie_average DESC;


-- Query 2: Find users who rated Action movies

SELECT
    u.user_id,
    u.username
FROM USER u
WHERE u.user_id IN (
    SELECT r.user_id
    FROM RATES r
    INNER JOIN HAS_GENRE hg
        ON r.movie_id = hg.movie_id
    INNER JOIN GENRE g
        ON hg.genre_id = g.genre_id
    WHERE g.genre_name = 'Action'
)
ORDER BY u.user_id;


-- Query 3: Find movies without reviews

SELECT
    m.movie_id,
    m.title
FROM MOVIE m
WHERE NOT EXISTS (
    SELECT 1
    FROM REVIEWS r
    WHERE r.movie_id = m.movie_id
)
ORDER BY m.movie_id;


-- Query 4: Find users who rated more than one movie

SELECT
    u.user_id,
    u.username
FROM USER u
WHERE EXISTS (
    SELECT 1
    FROM RATES r
    WHERE r.user_id = u.user_id
    GROUP BY r.user_id
    HAVING COUNT(r.movie_id) > 1
)
ORDER BY u.user_id;


-- Query 5: Find movies with an average rating above all Action ratings

SELECT
    m.title,
    ROUND(AVG(r.rating_value), 2) AS average_rating
FROM MOVIE m
INNER JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
HAVING AVG(r.rating_value) > ALL (
    SELECT r2.rating_value
    FROM RATES r2
    INNER JOIN HAS_GENRE hg
        ON r2.movie_id = hg.movie_id
    INNER JOIN GENRE g
        ON hg.genre_id = g.genre_id
    WHERE g.genre_name = 'Action'
)
ORDER BY average_rating DESC;


-- Query 6: Find movies with an average rating above any Action rating

SELECT
    m.title,
    ROUND(AVG(r.rating_value), 2) AS average_rating
FROM MOVIE m
INNER JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
HAVING AVG(r.rating_value) > ANY (
    SELECT r2.rating_value
    FROM RATES r2
    INNER JOIN HAS_GENRE hg
        ON r2.movie_id = hg.movie_id
    INNER JOIN GENRE g
        ON hg.genre_id = g.genre_id
    WHERE g.genre_name = 'Action'
)
ORDER BY average_rating DESC;
