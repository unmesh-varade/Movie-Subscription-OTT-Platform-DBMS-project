USE ott_platform;

-- Q1: List all users alphabetically
SELECT user_id, name, email, city, created_on 
FROM Users 
ORDER BY name;

-- Q2: Movies with their genres
SELECT m.movie_id, m.title, m.release_year, 
       GROUP_CONCAT(g.name SEPARATOR ', ') AS genres
FROM Movies m
JOIN Movie_Genres mg ON m.movie_id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.genre_id
GROUP BY m.movie_id;

-- Q3: Active subscriptions with remaining days
SELECT s.subscription_id, u.name, s.plan_name, s.end_date,
       DATEDIFF(s.end_date, CURDATE()) AS days_left
FROM Subscriptions s 
JOIN Users u ON s.user_id = u.user_id
WHERE s.status='Active';

-- Q4: Total revenue from payments
SELECT SUM(amount) AS total_revenue
FROM Payments;

-- Q5: Most-watched movie by watch sessions
SELECT m.movie_id, m.title, COUNT(w.watch_id) AS watch_sessions
FROM Movies m
LEFT JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.movie_id
ORDER BY watch_sessions DESC
LIMIT 1;

-- Q6: Top 3 movies by total minutes watched
SELECT m.movie_id, m.title, SUM(w.watch_duration_min) AS total_minutes
FROM Movies m
LEFT JOIN Watch_History w ON m.movie_id = w.movie_id
GROUP BY m.movie_id
ORDER BY total_minutes DESC
LIMIT 3;

-- Q7: Most popular genre by watch count
SELECT g.genre_id, g.name, COUNT(w.watch_id) AS watch_count
FROM Genres g
JOIN Movie_Genres mg ON g.genre_id = mg.genre_id
JOIN Watch_History w ON mg.movie_id = w.movie_id
GROUP BY g.genre_id
ORDER BY watch_count DESC
LIMIT 1;

-- Q8: Top 3 users by variety of movies watched
SELECT u.user_id, u.name,
       COUNT(DISTINCT w.movie_id) AS unique_movies_watched
FROM Users u
JOIN Watch_History w ON u.user_id = w.user_id
GROUP BY u.user_id
ORDER BY unique_movies_watched DESC
LIMIT 3;

-- Q9: Average rating and rating count per movie
SELECT m.movie_id, m.title, 
       COALESCE(AVG(r.rating),0) AS avg_rating,
       COUNT(r.rating_id) AS rating_count
FROM Movies m
LEFT JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.movie_id
ORDER BY avg_rating DESC;

-- Q10: Total watch time per user
SELECT u.user_id, u.name, 
       COALESCE(SUM(w.watch_duration_min),0) AS total_watch_minutes
FROM Users u
LEFT JOIN Watch_History w ON u.user_id = w.user_id
GROUP BY u.user_id
ORDER BY total_watch_minutes DESC;

-- Q11: Movies released in the last 5 years
SELECT movie_id, title, release_year
FROM Movies
WHERE release_year >= (YEAR(CURDATE()) - 5);

-- Q12: Revenue and subscriber count per plan
SELECT s.plan_name,
       COALESCE(SUM(p.amount),0) AS plan_revenue,
       COUNT(DISTINCT s.user_id) AS subscribers
FROM Subscriptions s
LEFT JOIN Payments p ON s.subscription_id = p.subscription_id
GROUP BY s.plan_name;

-- Q13: Users who gave 5-star ratings
SELECT u.user_id, u.name, m.title, r.rating
FROM Ratings r
JOIN Users u ON r.user_id = u.user_id
JOIN Movies m ON r.movie_id = m.movie_id
WHERE r.rating = 5;

-- Q14: Whether user 1 has rated each movie
SELECT m.movie_id, m.title,
  CASE 
    WHEN EXISTS (
      SELECT 1 FROM Ratings r 
      WHERE r.movie_id = m.movie_id AND r.user_id = 1
    )
    THEN 'Rated'
    ELSE 'Not Rated'
  END AS user1_rating_status
FROM Movies m;

-- Q15: Average watch duration per genre
SELECT g.name AS genre,
       AVG(w.watch_duration_min) AS avg_watch_minutes
FROM Genres g
JOIN Movie_Genres mg ON g.genre_id = mg.genre_id
JOIN Watch_History w ON mg.movie_id = w.movie_id
GROUP BY g.genre_id
ORDER BY avg_watch_minutes DESC;

-- Q16: Full user profile (user 1) with subscription details
SELECT u.user_id, u.name, u.email, u.city,
       s.plan_name, s.start_date, s.end_date, s.status
FROM Users u
LEFT JOIN Subscriptions s ON u.user_id = s.user_id
WHERE u.user_id = 1;

-- Q17: Last 10 watched movies for user 1
SELECT m.movie_id, m.title, w.watched_on
FROM Watch_History w
JOIN Movies m ON w.movie_id = m.movie_id
WHERE w.user_id = 1
ORDER BY w.watched_on DESC
LIMIT 10;

-- Q18: Movies with no ratings
SELECT m.movie_id, m.title
FROM Movies m
LEFT JOIN Ratings r ON m.movie_id = r.movie_id
WHERE r.rating_id IS NULL;
