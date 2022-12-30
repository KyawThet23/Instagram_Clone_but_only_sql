//finding top 5 longest user
SELECT 
    username,
    RANK() OVER(ORDER BY created_at ASC) as Rank_of_loyal_user,
    CONCAT(DATE_FORMAT(FROM_DAYS(DATEDIFF(NOW() , created_at)) , '%Y') + 0, ' years ' ,
    FLOOR((DATEDIFF(NOW() , created_at) % 360) / 30) , ' months ' ,
    (DATEDIFF(NOW() , created_at) % 360) % 30 , ' days' 
    ) AS used_period
FROM users
ORDER BY created_at
LIMIT 10;

//finding most regiister day of week for ad campaing
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;

//To find who has never posted.
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

// find who got most likes.
SELECT
    photo_id as photo,
    COUNT(user_id) as like_count
FROM likes
GROUP BY photo_id
ORDER BY like_count DESC
LIMIT 10;

//find who posted what and get how many likes.
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id;

//to find top 5 most commonly used hash_tags
SELECT
    tag_name,
    COUNT(*) as used_times
FROM photo_tags
INNER JOIN tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY used_times DESC LIMIT 5;

//to find user who has liked on all the post on our IG
SELECT
    username,
    COUNT(*) as num_likes
    FROM likes
    INNER JOIN users
        ON users.id = likes.user_id
    GROUP BY users.id
    HAVING num_likes = (SELECT COUNT(*) FROM photos);
