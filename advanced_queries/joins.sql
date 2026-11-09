-- Query 1: Display movies and their directors

SELECT
    m.movie_id,
    m.title,
    p.person_name AS director_name
FROM MOVIE m
INNER JOIN DIRECTED_BY db
    ON m.movie_id = db.movie_id
INNER JOIN DIRECTOR d
    ON db.person_id = d.person_id
INNER JOIN PERSON p
    ON d.person_id = p.person_id;


-- Query 2: Display movies, genres, and average ratings

SELECT
    m.title,
    g.genre_name,
    AVG(r.rating_value) AS average_rating
FROM MOVIE m
INNER JOIN HAS_GENRE hg
    ON m.movie_id = hg.movie_id
INNER JOIN GENRE g
    ON hg.genre_id = g.genre_id
LEFT JOIN RATES r
    ON m.movie_id = r.movie_id
GROUP BY
    m.movie_id,
    m.title,
    g.genre_id,
    g.genre_name
ORDER BY
    average_rating DESC;


-- Query 3: Find pairs of movies featuring the same actor

SELECT
    p.person_name AS actor_name,
    m1.title AS movie_1,
    m2.title AS movie_2
FROM HAS_ACTOR ha1
INNER JOIN HAS_ACTOR ha2
    ON ha1.person_id = ha2.person_id
    AND ha1.movie_id < ha2.movie_id
INNER JOIN PERSON p
    ON ha1.person_id = p.person_id
INNER JOIN MOVIE m1
    ON ha1.movie_id = m1.movie_id
INNER JOIN MOVIE m2
    ON ha2.movie_id = m2.movie_id
INNER JOIN ACTOR a
    ON ha1.person_id = a.person_id
ORDER BY actor_name;
