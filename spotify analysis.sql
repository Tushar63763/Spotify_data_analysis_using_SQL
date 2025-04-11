--Advance SQL Problems solving project--
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

--EDA--
select * 
from spotify
select COUNT(*) 
from spotify
SELECT count (distinct(Artist)) from spotify
select count(distinct album) from spotify;
select distinct (album_type) from spotify;
select max(duration_min) from spotify;
select min(duration_min) from spotify;
select * from spotify where duration_min= 0;
delete from spotify where duration_min=0;
select * from spotify where duration_min= 0;
select COUNT(*) 
from spotify

---Easy level business analytics question--
---1.Retrieve the names of all tracks that have more than 1 billion streams?--
select track from spotify
where stream > 1000000000;
-- Answer=385--

---2.List all albums along with their respective artists.
select distinct album,artist
from spotify
order by 1;

---3.Get the total number of comments for tracks where licensed = TRUE?--
select  sum (comments )
from spotify
where licensed= TRUE
---Answer= 497015695---

---4.Find all tracks that belong to the album type single?---
select track 
from spotify
where spotify.album_type= 'single';
---Answer=4973 songs---

---5.Count the total number of tracks by each artist?---
select count(track) as Total_number_of_tracks,artist
from spotify
group by artist;

---Medium Level Business Questions---

---6.Calculate the average danceability of tracks in each album?---
Select avg (danceability), album
from spotify
group by album
order by 1 desc;

---7.Find the top 5 tracks with the highest energy values?---
select track,energy
from spotify
order by energy desc
limit 5;

---8.List all tracks along with their views and likes where official_video = TRUE?---
select track, views, likes
from spotify
where official_video = TRUE;

---9.For each album, calculate the total views of all associated tracks.?---
select album, sum(views)
from spotify
group by album
order by 2 desc;

---10.Retrieve the track names that have been streamed on Spotify more than YouTube?---
select track
from spotify
where most_played_on= 'Youtube';

---Advanced questions on business---
---11.Find the top 3 most-viewed tracks for each artist using window functions?---
SELECT *
FROM (
  SELECT 
    track,artist, 
    album, 
    views,
    ROW_NUMBER() OVER (PARTITION BY album ORDER BY views DESC) AS top_viewed
  FROM spotify
) ranked
WHERE top_viewed <= 3
-- it would give top 3 of all artists . for artists with 1 or 2 songs it would give ranlk 1 or 2--

---12.Write a query to find tracks where the liveness score is above the average?---
select track,liveness
from spotify
where liveness > (select avg(liveness) from spotify);

---13.Use CTE to calculate the difference between the highest and lowest energy values for tracks in each album?---
WITH cte
AS
(SELECT 
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energery
FROM spotify
GROUP BY 1
)
SELECT 
	album,
	highest_energy - lowest_energery as energy_diff
FROM cte
ORDER BY 2 DESC;

---14.Find tracks where the energy-to-liveness ratio is greater than 1.2?---
SELECT track 
from spotify
where energy/liveness>1.2;
---Answer= 18797 TRACKS----

---15.Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functionS?---
SELECT track,views,
sum(views) OVER ( ORDER BY views DESC)
from spotify;