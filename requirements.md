# Movie Rating System — Requirements

## 1. System Features

### 1.1 Movie Information and Ratings
- The system stores information about movies.
- Users can view a movie's average rating.
- Users can view the individual ratings and reviews associated with a movie.
- Users can submit a rating and optionally write a review for a movie.
- Users can update or remove their own ratings/reviews.

### 1.2 User Accounts
- Each user has an account containing their personal information.
- Users can view and manage their own ratings and reviews.
- Users can maintain a private watchlist of movies.
- Each user can add or remove movies from their watchlist.
- A user's watchlist is accessible only to that user.

### 1.3 Movie Search
- Users can search for movies using movie metadata.
- Movie metadata may include:
  - Title
  - Release year/date
  - Genre
  - Director
  - Cast/actors
  - Language

### 1.4 Administration
- Administrators can add, remove, and update movie information.

## 2. Data Requirements

### Users
- User identification
- User account/personal information
- User role

### Movies
- Movie identification
- Title
- Release information
- Runtime/description
- Relevant metadata

### Movie Metadata
- Genres
- Directors
- Actors/cast
- Languages

### Ratings
- User who submitted the rating
- Movie being rated
- Rating value
- Date/time of rating

### Reviews
- User who submitted the review
- Movie being reviewed
- Review content
- Date/time of review

### Watchlists
- User who owns the watchlist entry
- Movie added to the watchlist
- Date added

## 3. Business Rules and Assumptions

1. A user can rate a movie at most once. They can later update their rating.
2. A user can write at most one review for a movie. They can later edit or delete it.
3. A rating may exist without a review.
4. A user can have multiple movies in their watchlist.
5. A movie can appear in the watchlists of many users.
6. A movie can have multiple genres, actors, etc., and each genre/actor can be associated with multiple movies.
7. A user's watchlist is private and can only be accessed by its owner.
8. Administrators can manage movie data.
