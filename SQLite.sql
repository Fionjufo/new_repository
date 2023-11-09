-- (A)
-- Create dimension table dim_user
CREATE TABLE dim_user AS
SELECT DISTINCT user_id, user_name, country
FROM raw_users;

-- Create dimension table dim_post
CREATE TABLE dim_post AS
SELECT DISTINCT post_id, post_text, post_date, user_id
FROM raw_posts;

-- Create dimension table dim_date
CREATE TABLE dim_date AS
SELECT DISTINCT post_date
FROM raw_posts;

-- (B)
-- Populate dim_user from raw_users
INSERT INTO dim_user (user_id, user_name, country,)
SELECT DISTINCT user_id, user_name, country
FROM raw_users;

-- Populate dim_post from raw_posts
INSERT INTO dim_post (post_id, post_text, post_date, user_id)
SELECT DISTINCT post_id, post_text, post_date, user_id
FROM raw_posts;

-- Populate dim_date from raw_posts
INSERT INTO dim_date (post_date)
SELECT DISTINCT post_date
FROM raw_posts;

-- (C) dan (D)
-- Create fact table fact_post_performance and populate data
CREATE TABLE fact_post_performance AS
SELECT dp.post_id, dp.post_date, COUNT(rl.like_id) AS like_count
FROM dim_post dp
LEFT JOIN raw_likes rl ON dp.post_id = rl.post_id
GROUP BY dp.post_id, dp.post_date;

-- (E) dan (F)
-- Create fact table fact_daily_posts and populate data
CREATE TABLE fact_daily_posts AS
SELECT dp.post_date, du.user_id, COUNT(dp.post_id) AS post_count
FROM dim_post dp
JOIN dim_user du ON dp.user_id = du.user_id
GROUP BY dp.post_date, du.user_id;