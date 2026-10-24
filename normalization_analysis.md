# Movie Rating System — Normalization Analysis

## 1. Purpose

This document analyzes the functional dependencies, candidate keys, and normal forms of the Movie Rating System database.

The objective is to evaluate the existing relational design using the concepts of functional dependencies, attribute closures, candidate keys, Third Normal Form (3NF), Boyce–Codd Normal Form (BCNF), and Fourth Normal Form (4NF).

The analysis is based on the existing relational schema and SQL implementation. Functional dependencies are derived from the documented business rules and declared key constraints. Any additional assumptions requiring confirmation are identified explicitly.

## 2. USER Relation

### Attributes

USER(user_id, username, email, password_hash, role)

### Functional Dependencies

Assuming usernames and emails are unique and non-null:

- user_id → username, email, password_hash, role
- username → user_id, email, password_hash, role
- email → user_id, username, password_hash, role

### Candidate Keys and Attribute Closures

The attribute closures are:

- user_id+ = {user_id, username, email, password_hash, role}
- username+ = {user_id, username, email, password_hash, role}
- email+ = {user_id, username, email, password_hash, role}

Each attribute determines every attribute in USER. Each is a minimal superkey and therefore a candidate key.

- Primary key: user_id
- Alternate candidate keys: username, email

### Normalization Analysis

Every documented non-trivial functional dependency has a candidate key as its determinant. Therefore, USER satisfies BCNF under the stated assumptions.

The uniqueness and non-null constraints on username and email enforce the alternate candidate keys in the SQL schema.

## 3. MOVIE Relation

### Attributes

MOVIE(movie_id, title, release_date, runtime, description)

### Functional Dependencies

- movie_id → title, release_date, runtime, description

This dependency states that the movie identifier determines the attributes stored for that movie.

### Candidate Keys and Attribute Closures

- movie_id+ = {movie_id, title, release_date, runtime, description}

The closure contains every attribute in MOVIE. Since movie_id is a single attribute, it is a minimal superkey and therefore a candidate key.

- Primary key: movie_id

No additional candidate keys are assumed without a supporting business rule.

### Normalization Analysis

The documented non-trivial functional dependency has movie_id as its determinant, which is a candidate key. Therefore, MOVIE satisfies BCNF under the documented functional dependencies.

## 4. GENRE Relation

### Attributes

GENRE(genre_id, genre_name)

### Functional Dependencies

- genre_id → genre_name

The declared primary key establishes that genre_id determines the genre name.

### Candidate Keys and Attribute Closures

- genre_id+ = {genre_id, genre_name}

The closure contains all attributes in GENRE, so genre_id is a candidate key and the primary key.

### Normalization Analysis

The documented functional dependency has a candidate key as its determinant. Therefore, GENRE satisfies BCNF under the documented dependencies.

A unique constraint on genre_name would be needed to establish genre_name as an additional candidate key. The current schema declares genre_name as NOT NULL but does not declare it UNIQUE.

## 5. ACTOR Relation

### Attributes

ACTOR(actor_id, actor_name)

### Functional Dependencies

- actor_id → actor_name

The actor identifier determines the actor name stored in the relation.

### Candidate Keys and Attribute Closures

- actor_id+ = {actor_id, actor_name}

The closure contains every attribute in ACTOR. Therefore, actor_id is a candidate key and the primary key.

### Normalization Analysis

The documented functional dependency has a candidate key as its determinant. Therefore, ACTOR satisfies BCNF under the documented dependencies.

Actor names are not declared unique, since different actors may share the same name.

## 6. DIRECTOR Relation

### Attributes

DIRECTOR(director_id, director_name)

### Functional Dependencies

- director_id → director_name

The director identifier determines the director name stored in the relation.

### Candidate Keys and Attribute Closures

- director_id+ = {director_id, director_name}

The closure contains every attribute in DIRECTOR. Therefore, director_id is a candidate key and the primary key.

### Normalization Analysis

The documented functional dependency has a candidate key as its determinant. Therefore, DIRECTOR satisfies BCNF under the documented dependencies.

Director names are not declared unique, since different directors may share the same name.

## 7. RATES Relation

### Attributes

RATES(user_id, movie_id, rating_value, rating_date)

### Functional Dependencies

The declared composite primary key and documented business rule imply:

- (user_id, movie_id) → rating_value, rating_date

This represents the rule that a user can rate a particular movie at most once.

### Candidate Keys and Attribute Closures

- {user_id, movie_id}+ = {user_id, movie_id, rating_value, rating_date}

The composite key determines every attribute in RATES.

- Primary key: (user_id, movie_id)

Neither user_id nor movie_id alone determines a rating tuple under the current business rules. Therefore, the composite key is minimal and is a candidate key.

### Normalization Analysis

The documented non-trivial functional dependency has a candidate key as its determinant. Therefore, RATES satisfies BCNF under the stated business rule.

The SQL CHECK constraint restricts rating_value to values between 1 and 5.

## 8. REVIEWS Relation

### Attributes

REVIEWS(user_id, movie_id, review_text, review_date)

### Functional Dependencies

The declared composite primary key and documented business rule imply:

- (user_id, movie_id) → review_text, review_date

This represents the rule that a user can write at most one review for a particular movie.

### Candidate Keys and Attribute Closures

- {user_id, movie_id}+ = {user_id, movie_id, review_text, review_date}

The composite key determines every attribute in REVIEWS.

- Primary key: (user_id, movie_id)

Under the current business rule, neither attribute alone determines a review tuple. The composite key is therefore a candidate key.

### Normalization Analysis

The documented non-trivial functional dependency has a candidate key as its determinant. Therefore, REVIEWS satisfies BCNF under the stated business rule.

If the requirements change to allow multiple reviews by the same user for the same movie, the key and functional dependency would need to be reconsidered.

## 9. HAS_IN_WATCHLIST Relation

### Attributes

HAS_IN_WATCHLIST(user_id, movie_id, date_added)

### Functional Dependencies

The declared composite primary key implies:

- (user_id, movie_id) → date_added

This represents the date on which a movie was added to a particular user's watchlist.

### Candidate Keys and Attribute Closures

- {user_id, movie_id}+ = {user_id, movie_id, date_added}

The composite key determines every attribute in HAS_IN_WATCHLIST.

- Primary key: (user_id, movie_id)

The composite key is minimal under the current rule that a movie can appear only once in a user's watchlist.

### Normalization Analysis

The documented non-trivial functional dependency has a candidate key as its determinant. Therefore, HAS_IN_WATCHLIST satisfies BCNF under the current business rule.

## 10. HAS_GENRE Relation

### Attributes

HAS_GENRE(movie_id, genre_id)

### Functional Dependencies

