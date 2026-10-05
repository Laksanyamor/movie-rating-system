# Movie Rating System – Relational Schema

## Overview

The relational schema represents the database structure derived from the Entity Relationship Diagram (ERD).

The database consists of 11 relations. Primary keys (PK) uniquely identify tuples within each relation, while foreign keys (FK) represent relationships between relations.

## Relations

### USER
**USER**(
**user_id**,
username,
email,
password_hash,
role
)

- **Primary Key:** `user_id`
- **Candidate Keys:** `user_id`, `username`, `email`
- `username` and `email` must be unique and non-null.

### MOVIE
**MOVIE**(
**movie_id**,
title,
release_date,
runtime,
description
)

- **Primary Key:** `movie_id`

### GENRE
**GENRE**(
**genre_id**,
genre_name
)

- **Primary Key:** `genre_id`

### ACTOR
**ACTOR**(
**actor_id**,
actor_name
)

- **Primary Key:** `actor_id`

### DIRECTOR
**DIRECTOR**(
**director_id**,
director_name
)

- **Primary Key:** `director_id`

### RATES
**RATES**(
**user_id**,
**movie_id**,
rating_value,
rating_date
)

- **Primary Key:** (`user_id`, `movie_id`)
- **Foreign Keys:** 
  - `user_id` → USER(`user_id`)
  - `movie_id` → MOVIE(`movie_id`)
- A user can rate a particular movie at most once.

### REVIEWS
**REVIEWS**(
**user_id**,
**movie_id**,
review_text,
review_date
)

- **Primary Key:** (`user_id`, `movie_id`)
- **Foreign Keys:**
  - `user_id` → USER(`user_id`)
  - `movie_id` → MOVIE(`movie_id`)
- A user can write at most one review for a particular movie.

### HAS_IN_WATCHLIST
**HAS_IN_WATCHLIST**(
**user_id**,
**movie_id**,
date_added
)

- **Primary Key:** (`user_id`, `movie_id`)
- **Foreign Keys:**
  - `user_id` → USER(`user_id`)
  - `movie_id` → MOVIE(`movie_id`)
- Each user's watchlist is private to that user.

### HAS_GENRE
**HAS_GENRE**(
**movie_id**,
**genre_id**
)

- **Primary Key:** (`movie_id`, `genre_id`)
- **Foreign Keys:**
  - `movie_id` → MOVIE(`movie_id`)
  - `genre_id` → GENRE(`genre_id`)

### HAS_ACTOR
**HAS_ACTOR**(
**movie_id**,
**actor_id**
)

- **Primary Key:** (`movie_id`, `actor_id`)
- **Foreign Keys:**
  - `movie_id` → MOVIE(`movie_id`)
  - `actor_id` → ACTOR(`actor_id`)

### DIRECTED_BY
**DIRECTED_BY**(
**movie_id**,
**director_id**
)

- **Primary Key:** (`movie_id`, `director_id`)
- **Foreign Keys:**
  - `movie_id` → MOVIE(`movie_id`)
  - `director_id` → DIRECTOR(`director_id`)

## Functional Dependencies

The main functional dependencies are:

- `user_id → username, email, password_hash, role`
- `username → user_id, email, password_hash, role`
- `email → user_id, username, password_hash, role`
- `movie_id → title, release_date, runtime, description`
- `genre_id → genre_name`
- `actor_id → actor_name`
- `director_id → director_name`
- (`user_id`, `movie_id`) → `rating_value, rating_date`
- (`user_id`, `movie_id`) → `review_text, review_date`
- (`user_id`, `movie_id`) → `date_added`

The relationship tables `HAS_GENRE`, `HAS_ACTOR`, and `DIRECTED_BY` contain no non-key attributes, so there are no non-trivial functional dependencies within those relations.

## BCNF Justification

A relation is in Boyce-Codd Normal Form (BCNF) if, for every non-trivial functional dependency `X → Y`, `X` is a superkey.

All relations in this schema satisfy BCNF:

- **USER:** `user_id`, `username`, and `email` are candidate keys, so every antecedent is a superkey.
- **MOVIE:** `movie_id` is the antecedent and is the primary key.
- **GENRE:** `genre_id` is the antecedent and is the primary key.
- **ACTOR:** `actor_id` is the antecedent and is the primary key.
- **DIRECTOR:** `director_id` is the antecedent and is the primary key.
- **RATES:** (`user_id`, `movie_id`) is the primary key and determines the rating attributes.
- **REVIEWS:** (`user_id`, `movie_id`) is the primary key and determines the review attributes.
- **HAS_IN_WATCHLIST:** (`user_id`, `movie_id`) is the primary key and determines `date_added`.
- **HAS_GENRE:** contains only its composite key and therefore has no non-trivial functional dependencies.
- **HAS_ACTOR:** contains only its composite key and therefore has no non-trivial functional dependencies.
- **DIRECTED_BY:** contains only its composite key and therefore has no non-trivial functional dependencies.

Therefore, all relations in the Movie Rating System are in **BCNF**.
