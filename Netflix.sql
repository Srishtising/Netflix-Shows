select * from Netflix..credits;
select * from Netflix..titles;

---- What were the top 10 movies according to IMDB score?
select title, imdb_score ,type
from Netflix..titles
where type='MOVIE'
order by imdb_score desc
OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY;

-- What were the top 10 shows according to IMDB score?
select title, imdb_score ,type
from Netflix..titles
where type='SHOW'
order by imdb_score desc
OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY;

-- What were the bottom 10 movies according to IMDB score? 
select title, imdb_score ,type
from Netflix..titles
where type='MOVIE'
order by imdb_score
OFFSET 0 ROWS  
    FETCH NEXT 10 ROWS ONLY;

-- What were the average IMDB and TMDB scores for shows and movies? 
 select type, 
   round(avg(imdb_score),2) imdb_average,
   round(avg(tmdb_score),2) tmdb_average
 from Netflix..titles
 group by type


 ---- Count of movies and shows in each decade
 select 
 CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade,
 count(*) as total_release
 from Netflix..titles
 group by CONCAT(FLOOR(release_year / 10) * 10, 's')
 order by CONCAT(FLOOR(release_year / 10) * 10, 's')


-- What were the average IMDB and TMDB scores for each production country?
select distinct production_countries,
round(avg(imdb_score),2)  imdb_avg,
round(avg(tmdb_score),2) tmdb_avg
from Netflix..titles
group by production_countries

-- What were the average IMDB and TMDB scores for each age certification for shows and movies?
select age_certification,
round(avg(imdb_score),2)  imdb_avg,
round(avg(tmdb_score),2) tmdb_avg
from Netflix..titles
where age_certification<>'null'
group by age_certification
order by imdb_avg;

-- What were the 5 most common age certifications for movies?
select  age_certification , count(1)
from Netflix..titles
where type='MOVIE' and age_certification <>' null'
group by age_certification
order by count(1) desc
OFFSET 0 ROWS  
    FETCH NEXT 5 ROWS ONLY;

-- Who were the top 20 actors that appeared the most in movies/shows? 
select 
    name,count(1) as total_appearence
from Netflix..credits
where role='ACTOR'
group by name
order by count(1) desc
OFFSET 0 ROWS  
    FETCH NEXT 20 ROWS ONLY;

-- Who were the top 20 directors that directed the most movies/shows? 
select 
    name,count(1) as total_appearence
from Netflix..credits
where role='DIRECTOR'
group by name
order by count(1) desc
OFFSET 0 ROWS  
    FETCH NEXT 20 ROWS ONLY;

-- Calculating the average runtime of movies and TV shows separately
select type, round(avg(runtime),2) avg_runtime
from Netflix..titles
group by type

-- Finding the titles and  directors of movies released on or after 2010
select distinct nt.title,nc.role, nt.release_year
    from Netflix..titles as nt 
join 
    Netflix..credits as nc on nt.id=nc.id
where nt.release_year>='2010' and nc.role='Director'

-- Which shows on Netflix have the most seasons?
select title, sum(seasons) as total_season from Netflix..titles
where type='SHOW' 
group by title
order by sum(seasons) desc
OFFSET 0 ROWS  
    FETCH NEXT 20 ROWS ONLY;











































