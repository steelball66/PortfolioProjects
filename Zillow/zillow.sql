use Zillow

select * from zillowComplete

--checking for duplicate rows from API calls
select address
from zillowComplete
group by address
having COUNT(Column_1) > 1

--deleting duplicate rows
with cte as(
select address, ROW_NUMBER() over (partition by address order by address) row_num
from zillowComplete)
delete from cte
where row_num > 1

--adding columns to separate the address by street, city, state, and zip 
alter table zillowComplete
add street varchar(255)

alter table zillowComplete
add city varchar(50)

alter table zillowComplete
add state varchar(50)

alter table zillowComplete
add zip varchar(5)

--setting the street, city, state, and zip columns with the appropriate data
UPDATE zillowComplete
set street = REVERSE(PARSENAME(REPLACE(REVERSE(address), ',', '.'), 1))

UPDATE zillowComplete
set city = REVERSE(PARSENAME(REPLACE(REVERSE(address), ',', '.'), 2))

UPDATE zillowComplete
set city = 'Catalina Foothills' where zip = '85750'

UPDATE zillowComplete
set city = 'Oro Valley' where zip = '85742'

UPDATE zillowComplete
set city = 'South Tucson' where zip = '85713' or zip = '85714'

UPDATE zillowComplete
set state = REVERSE(PARSENAME(REPLACE(REVERSE(address), ',', '.'), 3))

update zillowComplete
set state = left(state, 3)
--had to add an extra update to state column to remove leading space in the column
update zillowComplete
set state = right(state, 2)

UPDATE zillowComplete
set zip = RIGHT(State, 5)


--updating rows that have null zip codes. Manually input this data. Googling Zip Codes
update zillowcomplete
set street = CONCAT(street, '', city) where city = ' Dove Mountain';

update zillowcomplete
set city = 'Marana' where city = ' Dove Mountain';

update zillowcomplete
set zip = '85658' where street like '%Dove Mountain%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Gladden Farm%'

update zillowcomplete
set city = 'Marana' where city like '%Gladden Farm%'

update zillowcomplete
set zip = '85653' where street like '%Gladden Farm%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Saguaro Bloom%'

update zillowcomplete
set city = 'Marana' where city like '%Saguaro Bloom%'

update zillowcomplete
set zip = '85653' where street like '%Saguaro Bloom%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Colina de Anza%'

update zillowcomplete
set city = 'Oro Valley' where zip = '85742'

update zillowcomplete
set city = 'Catalina Foothills' where zip = '85718'

update zillowcomplete
set zip = '85742' where street like '%Colina de Anza%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Meadows at Rancho%' or city like '%Avra Valley Acres%' or city like '%Barnett Village%'

update zillowcomplete
set city = 'Marana' where city like '%Meadows at Rancho%' or city like '%Avra Valley Acres%' or city like '%Barnett Village%'
update zillowcomplete
set zip = '85653' where street like '%Meadows at Rancho%' or street like '%Avra Valley Acres%' or street like '%Barnett Village%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Sonoran Preserve%' or city like '%Tortolita Ridge%' 

update zillowcomplete
set city = 'Marana' where city like '%Sonoran Preserve%' or city like '%Tortolita Ridge%' 

update zillowcomplete
set zip = '85658' where street like '%Sonoran Preserve%' or street like '%Tortolita Ridge%' 

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%The Preserve at Twin Peaks%'

update zillowcomplete
set city = 'Oro Valley' where  city like '%The Preserve at Twin Peaks%'

update zillowcomplete
set zip = '85742' where street like '%The Preserve at Twin Peaks%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Seasons at Red Rock%'

update zillowcomplete
set city = 'Red Rock' where  city like '%Seasons at Red Rock%'

update zillowcomplete
set zip = '85145' where street like '%Seasons at Red Rock%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%SC Ranch%'

update zillowcomplete
set city = 'Marana' where  city like '%SC Ranch%'

update zillowcomplete
set zip = '85653' where street like '%SC Ranch%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Houghton Reserve%'

update zillowcomplete
set city = 'Tucson' where  city like '%Houghton Reserve%'

update zillowcomplete
set zip = '85748' where street like '%Houghton Reserve%'

update zillowcomplete
set street = CONCAT(street, '', city) where city like '%Lazy K%'

update zillowcomplete
set city = 'Tucson' where  city like '%Lazy k%'

update zillowcomplete
set zip = '85743' where street like '%Lazy k%'


--updating city column where city name had a space at the beginning of name
update zillowcomplete
set city = 'Tucson' where city = ' Tucson'

update zillowcomplete
set city = 'Red Rock' where city = ' Red Rock'

update zillowcomplete
set city = 'Marana' where city = ' Marana'

update zillowcomplete
set pricePerSqFt =  round(price / livingarea, 0) 

update zillowcomplete
set lotareaunit = 'sqft' where lotareaunit is null



--dropping columns that will not be used...should have done this in python request(only selecting the columns that would be needed)
ALTER TABLE zillowComplete
DROP COLUMN address;

ALTER TABLE zillowComplete
DROP COLUMN imgsrc;

ALTER TABLE zillowComplete
DROP COLUMN dateSold;

ALTER TABLE zillowComplete
DROP COLUMN listingstatus;

ALTER TABLE zillowComplete
DROP COLUMN listingSubtype;

ALTER TABLE zillowComplete
DROP COLUMN contingentlistingtype;

ALTER TABLE zillowComplete
DROP COLUMN hasimage;

ALTER TABLE zillowComplete
DROP COLUMN newconstructiontype;

ALTER TABLE zillowComplete
DROP COLUMN unit

ALTER TABLE zillowComplete
DROP COLUMN daysonzillow;

ALTER TABLE zillowComplete
DROP COLUMN latitude;

ALTER TABLE zillowComplete
DROP COLUMN longitude;

ALTER TABLE zillowComplete
DROP COLUMN propertytype;

ALTER TABLE zillowComplete
DROP COLUMN zpid;

ALTER TABLE zillowComplete
DROP COLUMN currency;

ALTER TABLE zillowComplete
DROP COLUMN Unnamed_0;

ALTER TABLE zillowComplete
add pricePerSqFt int;

select * from zillowComplete


--average home cost by zip
select zip, AVG(price) as avgPriceByZip
from zillowComplete
group by zip
order by avgPriceByZip desc

--most expensive house by zip
select zip, max(price) as mostExpensive
from zillowcomplete
group by zip 
order by mostExpensive desc

--least expensive house by zip
select zip, min(price) as leastExpensive
from zillowcomplete
group by zip 
order by leastExpensive desc

--average home cost by city
select city, AVG(price) as avgPriceByCity
from zillowComplete
group by city
order by avgPriceByCity desc

--number of lot area types by zip
select zip, lotareaunit, count(lotareaunit) as lotareacount
from zillowcomplete
where lotareaunit is not null
group by zip, lotareaunit
order by zip

select * from tucsonhomeindex

select YEAR, zip, homeindex, LAG(homeindex) over (order by year) as indexPreviousYear
from tucsonhomeindex 
where month(date) = 12 
order by zip, year


alter table tucsonhomeindex
add year smallint

update tucsonhomeindex
set year = year(date)

alter table tucsonhomeindex
alter column zip varchar(5)

select zip, 