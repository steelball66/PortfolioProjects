use drugs

select *
from drugspending
where Mftr_Name ='aegerion pharma'




--top 10 drugs by medicaid spending 2016-2019 (summing the years totals) 
select top 10 brnd_name, gnrc_name,SUM(tot_spndng_2016 + Tot_Spndng_2017 + tot_spndng_2018 + tot_spndng_2019) as totalSpending2016To2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name, gnrc_name
order by totalSpending2016To2019 desc


--top 10 drugs with the most claims and medicaid's spending from 2016-2019 (summing the years totals)
select top 10 brnd_name, SUM(Tot_Clms_2016 + Tot_Clms_2017 + Tot_Clms_2018 + Tot_Clms_2019) as totalClaims2016To2019, SUM(tot_spndng_2016 + Tot_Spndng_2017 + tot_spndng_2018 + tot_spndng_2019) as totalSpending2016To2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name
order by totalClaims2016To2019 desc

--top 10 drugs with the highest average medicaid spending per claim from 2016-2019
select top 10 brnd_name, sum(avg_spnd_per_clm_2016 + avg_spnd_per_clm_2017 + avg_spnd_per_clm_2018 + Avg_Spnd_Per_Clm_2019) / 4 as avg_spnd_per_claim_2016to2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name
order by avg_spnd_per_claim_2016to2019 desc

--top 10 manufacturers with medicaid's highest total spening 2016-2019
select top 10 Mftr_Name , SUM(tot_spndng_2016 + Tot_Spndng_2017 + tot_spndng_2018 + tot_spndng_2019) as totalSpending2016To2019
from drugspending
where Mftr_Name != 'overall'
group by Mftr_Name
order by totalSpending2016To2019 desc

--top 10 manufacturers with highest avg spending per claim 
select top 10 Mftr_Name, gnrc_name, sum(avg_spnd_per_clm_2016 + avg_spnd_per_clm_2017 + avg_spnd_per_clm_2018 + Avg_Spnd_Per_Clm_2019)/COUNT(mftr_name) / 4 as avg_spnd_per_claim_2016to2019
from drugspending
where Mftr_Name != 'overall'
group by Mftr_Name, Gnrc_Name
order by avg_spnd_per_claim_2016to2019 desc

--top 10 manufacturers with the most claims and medicaid total spending
select top 10 Mftr_Name, SUM(Tot_Clms_2016 + Tot_Clms_2017 + Tot_Clms_2018 + Tot_Clms_2019) as totalClaims2016To2019, SUM(tot_spndng_2016 + Tot_Spndng_2017 + tot_spndng_2018 + tot_spndng_2019) as totalSpending2016To2019
from drugspending
where Mftr_Name != 'overall'
group by Mftr_Name
order by totalClaims2016To2019 desc

select count(distinct gnrc_name) as NumberOfDrugs, SUM(tot_clms_2019) as TotalClaims, sum(Tot_Spndng_2019 ) as TotalSpending, AVG(Avg_Spnd_Per_Clm_2019) as AvgClaim
from drugspending
where Mftr_Name = 'overall'


select *
from drugspending
where Mftr_Name like '%pfizer%'
order by Brnd_Name

select count(distinct gnrc_name) as NumberOfDrugs, SUM(tot_clms_2019) as TotalClaims, sum(Tot_Spndng_2019 ) as TotalSpending, round(AVG(Avg_Spnd_Per_Clm_2019),2) as AvgClaim
from drugspending

select top 10 brnd_name, SUM(Tot_Clms_2019) as totalClaims2019, SUM(tot_spndng_2019) as totalSpending2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name
order by totalClaims2019 desc

select top 20 brnd_name, SUM(Tot_Clms_2019) as totalClaims2019, SUM(tot_spndng_2019) as totalSpending2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name
order by totalClaims2019 desc

select top 10 brnd_name, SUM(Tot_Clms_2016 + Tot_Clms_2017 + Tot_Clms_2018 + Tot_Clms_2019) as totalClaims2016To2019, SUM(tot_spndng_2016 + Tot_Spndng_2017 + tot_spndng_2018 + tot_spndng_2019) as totalSpending2016To2019
from drugspending
where Mftr_Name = 'overall'
group by Brnd_Name
order by totalClaims2016To2019 desc

--top 10 manufacturers with medicaids highest total spening 2016-2019
select top 10 Mftr_Name , SUM(Tot_Clms_2019) as totalClaims2019, SUM( tot_spndng_2019) as totalSpending2019
from drugspending
where Mftr_Name != 'overall'
group by Mftr_Name
order by totalSpending2019 desc


select top 10 Mftr_Name, SUM(Tot_Clms_2019) as totalClaims2019, SUM(tot_spndng_2019) as totalSpending2019
from drugspending
where Mftr_Name != 'overall'
group by Mftr_Name
order by totalClaims2019 desc

select top 10 brnd_name, Tot_Spndng_2019, Tot_Spndng_2018, Tot_Spndng_2019 - Tot_Spndng_2018 as YearIncrease  
from drugspending
group by Brnd_Name, Tot_Spndng_2019, Tot_Spndng_2018
order by YearIncrease desc



select SUM(tot_spndng_2019) 
from drugspending
where Mftr_Name = 'overall'

select SUM(tot_spndng_2019) 
from drugspending
where Mftr_Name != 'overall'

