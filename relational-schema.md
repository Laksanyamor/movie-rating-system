# Movie Rating System – Relational Schema

## Overview

The relational schema represents the database structure derived from the Entity Relationship Diagram (ERD).

The database consists of 12 relations. Primary keys (PK) uniquely identify tuples within each relation, while foreign keys (FK) represent relationships between relations. `ACTOR` and `DIRECTOR` are subtype relations of `PERSON`.

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
- A movie may exist before its genre, actor, or director information is entered.

### GENRE
**GENRE**(
**genre_id**,
genre_name
)

- **Primary Key:** `genre_id`
- `genre_name` is unique.

### PERSON
**PERSON**(
**person_id**,
person_name
)

- **Primary Key:** `person_id`
- `person_id` identifies a person independently of their name.

### ACTOR
**ACTOR**(
**person_id**
)

- **Primary Key:** `person_id`
- **Foreign Key:** `person_id` → PERSON(`person_id`)
- `ACTOR` is a subset of `PERSON`. A person may be an actor, a director, or both.

### DIRECTOR
**DIRECTOR**(
**person_id**
)

- **Primary Key:** `person_id`
- **Foreign Key:** `person_id` → PERSON(`person_id`)
- `DIRECTOR` is a subset of `PERSON`. A person may be an actor, a director, or both.

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
**person_id**
)

- **Primary Key:** (`movie_id`, `person_id`)
- **Foreign Keys:**
  - `movie_id` → MOVIE(`movie_id`)
  - `person_id` → ACTOR(`person_id`)

### DIRECTED_BY
**DIRECTED_BY**(
**movie_id**,
**person_id**
)

- **Primary Key:** (`movie_id`, `person_id`)
- **Foreign Keys:**
  - `movie_id` → MOVIE(`movie_id`)
  - `person_id` → DIRECTOR(`person_id`)

## Functional Dependencies

The main functional dependencies are:

- `user_id → username, email, password_hash, role`
- `username → user_id, email, password_hash, role`
- `email → user_id, username, password_hash, role`
- `movie_id → title, release_date, runtime, description`
- `genre_id → genre_name`
- `person_id → person_name`
- (`user_id`, `movie_id`) → `rating_value, rating_date`
- (`user_id`, `movie_id`) → `review_text, review_date`
- (`user_id`, `movie_id`) → `date_added`

The `ACTOR` and `DIRECTOR` relations contain only `person_id`, their primary and foreign key, so they have no non-trivial functional dependencies. The relationship tables `HAS_GENRE`, `HAS_ACTOR`, and `DIRECTED_BY` contain no non-key attributes, so there are no non-trivial functional dependencies within those relations.

## BCNF Justification

A relation is in Boyce-Codd Normal Form (BCNF) if, for every non-trivial functional dependency `X → Y`, `X` is a superkey.

All relations in this schema satisfy BCNF, based on the functional dependencies listed above:

- **USER:** `user_id`, `username`, and `email` are candidate keys, so every determinant is a superkey.
- **MOVIE:** `movie_id` is the primary key and determines the remaining attributes.
- **GENRE:** `genre_id` is the primary key and determines `genre_name`.
- **PERSON:** `person_id` is the primary key and determines `person_name`.
- **ACTOR:** contains only its primary/foreign key and therefore has no non-trivial functional dependencies.
- **DIRECTOR:** contains only its primary/foreign key and therefore has no non-trivial functional dependencies.
- **RATES:** (`user_id`, `movie_id`) is the primary key and determines the rating attributes.
- **REVIEWS:** (`user_id`, `movie_id`) is the primary key and determines the review attributes.
- **HAS_IN_WATCHLIST:** (`user_id`, `movie_id`) is the primary key and determines `date_added`.
- **HAS_GENRE:** contains only its composite key and therefore has no non-trivial functional dependencies.
- **HAS_ACTOR:** contains only its composite key and therefore has no non-trivial functional dependencies.
- **DIRECTED_BY:** contains only its composite key and therefore has no non-trivial functional dependencies.

Therefore, based on the stated functional dependencies, all relations in the Movie Rating System are in **BCNF**.
