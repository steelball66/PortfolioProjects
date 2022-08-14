create schema covid;
use covid;
select * from coviddata;


ALTER TABLE coviddata
RENAME COLUMN `total deaths` TO total_deaths;

ALTER TABLE coviddata
RENAME COLUMN `total cases` TO total_cases;

ALTER TABLE coviddata
RENAME COLUMN `active cases` TO active_cases;

ALTER TABLE coviddata
RENAME COLUMN `total tests` TO total_tests;

ALTER TABLE coviddata
RENAME COLUMN `total recovered` TO total_recovered;

ALTER TABLE coviddata
RENAME COLUMN `total cases/1` TO total_tests;

/* percent population infected per state*/

select state, total_cases/population*100 as percentpopulationinfected
from coviddata
group by state
order by percentpopulationinfected desc;

/*percent population death per state*/

select state, total_deaths/population*100 as percentpopulationdeath
from coviddata
group by state
order by percentpopulationdeath desc;

/*case to death ratio per state*/

select state, total_deaths/total_cases *100 as case_to_death_Ratio
from coviddata
group by state;

/*test to case ratio per state*/

select state, total_cases/total_tests *100 as test_to_case_ratio
from coviddata
group by state;

/*cases to recovered per state*/

select state, total_recovered/total_cases *100 as recovered_to_case_ratio
from coviddata
group by state;