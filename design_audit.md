# Movie Rating System - Design Audit

## 1. Current Design

The database currently contains 11 relations covering users, movies, genres, actors, directors, ratings, reviews, watchlists, and the relationships between movies and their associated genres, actors, and directors.

## 2. Existing Strengths

- Primary keys identify records and prevent duplicate key values.
- Foreign keys enforce referential integrity between related tables.
- Unique constraints prevent duplicate usernames and email addresses.
- Check constraints restrict user roles, movie runtimes, and rating values.
- Composite primary keys prevent duplicate user–movie ratings, reviews, and watchlist entries.
- Functional dependencies and a BCNF justification are documented in the relational schema.

## 3. Areas for Further Analysis

1. Verify functional dependencies and candidate keys using the project's business rules.
2. Document attribute closures and a minimal basis of functional dependencies.
3. Evaluate the existing BCNF justification and investigate 3NF, lossless decomposition, and dependency preservation where relevant.
4. Investigate whether any independent multivalued attributes create a genuine 4NF violation.
5. Develop SQL tests to demonstrate that integrity constraints work as intended.

## 4. Planned Improvements

The schema will be revised only where the analysis identifies a justified improvement. Any changes will be documented alongside their rationale and supporting evidence.

## 5. Current Status

Initial review completed. Detailed functional dependency analysis and verification of normal forms remain to be completed.
