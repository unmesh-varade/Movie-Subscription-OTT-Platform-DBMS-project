DROP DATABASE IF EXISTS ott_platform;
CREATE DATABASE ott_platform;
USE ott_platform;

SET default_storage_engine=INNODB;

-- Users
CREATE TABLE Users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE,
  phone VARCHAR(20),
  city VARCHAR(80),
  created_on DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Movies
CREATE TABLE Movies (
  movie_id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  release_year SMALLINT,
  duration_min INT,
  language VARCHAR(50),
  created_on DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Genres
CREATE TABLE Genres (
  genre_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) UNIQUE
) ENGINE=InnoDB;

-- Movie_Genres (many-to-many)
CREATE TABLE Movie_Genres (
  movie_id INT,
  genre_id INT,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES Genres(genre_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Subscriptions
CREATE TABLE Subscriptions (
  subscription_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  plan_name VARCHAR(50),
  monthly_price DECIMAL(8,2),
  start_date DATE,
  end_date DATE,
  status VARCHAR(20) DEFAULT 'Active',
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Watch_History
CREATE TABLE Watch_History (
  watch_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  movie_id INT,
  watched_on DATETIME DEFAULT CURRENT_TIMESTAMP,
  watch_duration_min INT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Ratings
CREATE TABLE Ratings (
  rating_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  movie_id INT,
  rating TINYINT NOT NULL,
  review TEXT,
  rated_on DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE (user_id, movie_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES Movies(movie_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Payments
CREATE TABLE Payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  subscription_id INT,
  amount DECIMAL(10,2),
  paid_on DATETIME DEFAULT CURRENT_TIMESTAMP,
  method VARCHAR(30),
  status VARCHAR(30) DEFAULT 'Completed',
  FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id) ON DELETE CASCADE
) ENGINE=InnoDB;
