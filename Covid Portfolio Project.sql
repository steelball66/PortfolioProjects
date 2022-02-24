select * from PortfolioProject..CovidDeaths
order by 3,4;

--select * 
--from PortfolioProject..CovidVaccinations
--order by 3,4;

--Select Data that we are going to be using

select location, date, total_cases, new_cases, total_deaths, population
from PortfolioProject..CovidDeaths
order by 1,2;

-- Total cases vs Total Deaths (Death Rate)

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
from PortfolioProject..CovidDeaths
where location =  'United states'
order by 1,2;

--Total cases vs population (Infection Rate)

select location, date, population, total_cases, (total_cases/population)*100 as InfectedPopulationPercent
from PortfolioProject..CovidDeaths
where location =  'United states'
order by 1,2;


--Countries with highest infection rate vs population

select location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as InfectedPopulationPercent
from PortfolioProject..CovidDeaths
group by location, population
order by 4 desc;

--Countries with highest death count 

select location, max(cast(total_deaths as bigint)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by location
order by TotalDeathCount desc;

--Continents with highest death count

select continent, max(cast(total_deaths as bigint)) as TotalDeathCount
from PortfolioProject..CovidDeaths
where continent is not null
group by continent
order by TotalDeathCount desc;

--Global Numbers

select sum(new_cases) as total_cases, sum(cast(new_deaths as bigint)) as total_deaths, sum(cast(new_deaths as bigint))/sum(new_cases)*100 as DeathPercentage
from PortfolioProject..CovidDeaths
where continent is not null
order by 1,2;

--total population vs vaccinations

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3

--use CTE

with PopVsVac  (continent, location, date, population, New_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	)
select *, (rollingPeopleVaccinated/population)*100 
from PopVsVac

-- create view for visualiZation

create view PercentPoplulationVaccinated as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as bigint)) over (partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths dea
join PortfolioProject..CovidVaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3
