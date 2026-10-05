CREATE DATABASE IF NOT EXISTS movie_rating_system;
USE movie_rating_system;

CREATE TABLE USER (
    user_id INT AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'user',

    PRIMARY KEY (user_id),
    CHECK (role IN ('user', 'admin'))
);

CREATE TABLE MOVIE (
    movie_id INT AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_date DATE,
    runtime INT,
    description TEXT,

    PRIMARY KEY (movie_id),
    CHECK (runtime IS NULL OR runtime > 0)
);

CREATE TABLE GENRE (
    genre_id INT AUTO_INCREMENT,
    genre_name VARCHAR(100) NOT NULL UNIQUE,

    PRIMARY KEY (genre_id)
);

CREATE TABLE ACTOR (
    actor_id INT AUTO_INCREMENT,
    actor_name VARCHAR(255) NOT NULL,

    PRIMARY KEY (actor_id)
);

CREATE TABLE DIRECTOR (
    director_id INT AUTO_INCREMENT,
    director_name VARCHAR(255) NOT NULL,

    PRIMARY KEY (director_id)
);

CREATE TABLE RATES (
    user_id INT,
    movie_id INT,
    rating_value INT NOT NULL,
    rating_date DATE NOT NULL,

    PRIMARY KEY (user_id, movie_id),

    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),

    CHECK (rating_value BETWEEN 1 AND 5)
);

CREATE TABLE REVIEWS (
    user_id INT,
    movie_id INT,
    review_text TEXT NOT NULL,
    review_date DATE NOT NULL,

    PRIMARY KEY (user_id, movie_id),

    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id)
);

CREATE TABLE HAS_IN_WATCHLIST (
    user_id INT,
    movie_id INT,
    date_added DATE NOT NULL,

    PRIMARY KEY (user_id, movie_id),

    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id)
);

CREATE TABLE HAS_GENRE (
    movie_id INT,
    genre_id INT,

    PRIMARY KEY (movie_id, genre_id),

    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
    FOREIGN KEY (genre_id) REFERENCES GENRE(genre_id)
);

CREATE TABLE HAS_ACTOR (
    movie_id INT,
    actor_id INT,

    PRIMARY KEY (movie_id, actor_id),

    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
    FOREIGN KEY (actor_id) REFERENCES ACTOR(actor_id)
);

CREATE TABLE DIRECTED_BY (
    movie_id INT,
    director_id INT,

    PRIMARY KEY (movie_id, director_id),

    FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id),
    FOREIGN KEY (director_id) REFERENCES DIRECTOR(director_id)
);
