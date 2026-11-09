-- Query 1: Count movie appearances for each actor

SELECT
    p.person_name AS actor_name,
    COUNT(DISTINCT ha.movie_id) AS movies_appeared_in
FROM ACTOR a
INNER JOIN PERSON p
    ON a.person_id = p.person_id
INNER JOIN HAS_ACTOR ha
    ON a.person_id = ha.person_id
GROUP BY
    a.person_id,
    p.person_name
HAVING COUNT(DISTINCT ha.movie_id) > 1
ORDER BY movies_appeared_in DESC;


-- Query 2: Calculate average ratings and rating counts for each movie

SELECT
    m.movie_id,
    m.title,
    COUNT(r.user_id) AS total_ratings,
    ROUND(AVG(r.rating_value), 2) AS average_rating
FROM MOVIE m
LEFT JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
ORDER BY
    average_rating DESC;


-- Query 3: Find movies with at least three ratings

SELECT
    m.title,
    COUNT(r.user_id) AS total_ratings,
    ROUND(AVG(r.rating_value), 2) AS average_rating
FROM MOVIE m
INNER JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title
HAVING COUNT(r.user_id) >= 3
ORDER BY total_ratings DESC;


-- Query 4: Count movies in each genre

SELECT
    g.genre_name,
    COUNT(DISTINCT hg.movie_id) AS total_movies
FROM GENRE g
INNER JOIN HAS_GENRE hg
    ON g.genre_id = hg.genre_id
GROUP BY
    g.genre_id,
    g.genre_name
ORDER BY total_movies DESC;
