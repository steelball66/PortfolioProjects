USE PMIYouTube

select * from PMI_youtube_api
order by title

select *
from PMI_youtube_api
order by published 

alter table pmi_youtube_api
alter column published datetime

alter table pmi_youtube_api
add monthName varchar(50)

alter table pmi_youtube_api
add liveshow varchar(50)

update PMI_youtube_api
set liveshow = case
					when title like '%The Pat Mcafee Show |%' OR title like '%Mcafee & Hawk%' or title like '%PMS 2.0 Ep%' or title like '%Ep.%' OR title like '%Draft Spectacular%' and durationSecs >3000 then 'Yes'
					else 'No' end

alter table pmi_youtube_api
add percentLiked float

update PMI_youtube_api
set percentLiked = round(cast((likecount) as float) / cast((viewcount) AS float),4) * 100

select * from PMI_youtube_api
where title like '%The Pat Mcafee Show |%' OR title like '%Mcafee & Hawk Sports Talk%' or title like '%PMS 2.0 Ep%'
order by published

update PMI_youtube_api
set monthName = DATENAME(MONTH, published ) 

--monthly views since channel started
select YEAR(published) as Year, monthname, SUM(viewcount) as totalMonthlyViews
from PMI_youtube_api
group by monthName, year(published)
order by year(published), monthname


--# of views per title
select title, viewcount 
from PMI_youtube_api

--comparing the duration of each video to viewCount
select durationsecs, viewcount
from PMI_youtube_api

--comparing the duration of each video to viewCount not counting liveshow(durationSecs greater than 10000)
select durationsecs, viewcount
from PMI_youtube_api
where durationSecs <= 10000

--comparing number of likes to number of views
select viewCount, likeCount
from PMI_youtube_api

--comparing view counts by days of the week
select sum(viewcount), dayofweek
from PMI_youtube_api
group by DayOfWeek
order by DayOfWeek

--comparing live show view and like counts over time by published date
select title,published,likecount, viewcount, liveshow
from PMI_youtube_api
where liveshow = 'Yes'	
	union
select title,published,likecount, viewcount, liveshow
from PMI_youtube_api
where liveshow = 'No'

select title,published,likecount, viewcount, liveshow, percentLiked
from PMI_youtube_api
where liveshow = 'Yes'	
	union
select title,published,likecount, viewcount, liveshow, percentLiked
from PMI_youtube_api
where liveshow = 'No'

select * from PMI_youtube_api
where liveshow = 'yes'
order by published


select * from PMI_youtube_api
where published > '05-01-2019' and published < '01-31-2020'
order by durationSecs desc

select title,likecount, viewcount, liveshow, round(cast((likecount) as float) / cast((viewcount) AS float),4) * 100 as percentLiked
from PMI_youtube_api
order by percentLiked desc

select max(percentliked) as percentLikedMax, min(percentliked) as percentLikedMin
from (select  round(cast((likecount) as float) / cast((viewcount) AS float),4) * 100 as percentLiked from PMI_youtube_api) sub

