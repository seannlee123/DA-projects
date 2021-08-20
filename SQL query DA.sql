SELECT * FROM [Portfolio projects]..CovidDeaths
order by 3,4

--*
SELECT * FROM [Portfolio projects]..CovidVaccinations
--*

SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM [Portfolio projects]..CovidDeaths
order by 1,2 --this will order table by location and date as first and second
--stopped at 16:57 https://www.youtube.com/watch?v=qfyynHBFOsM&t=468s



--calculate to find total cases vs total deaths
--find total cases and deaths
-- what is percentage of who had covid death percentage
--total death/total cases multiplied by 100 and alias(column name) as DeathPercentage

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio projects]..CovidDeaths
Where continent is not null
order by 1,2 

--find total cases and death @21:11
--Chance of death percentage upon attracting covid
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio projects]..CovidDeaths
where location like'%state%'
and continent is not null 
order by 1,2 

--total cases vs population
	--% of population contracting covid
	--PPI PercentPopulationInfected
SELECT location, date,population, total_cases, (total_cases/population)*100 as PPI
FROM [Portfolio projects]..CovidDeaths
where location like'%state%' --to specify visualization
order by 1,2 

--highest infection rate vs population
--HPPI HighestPercentPopulationInfected
SELECT location,population, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as HPPI
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is not null
group by location,population
order by HPPI desc --use desc to find highest to low

--date included
SELECT location,population,date, MAX(total_cases) as HighestInfectionCount, Max(total_cases/population)*100 as HPPI
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is not null
group by location,population,date
order by HPPI desc --use desc to find highest to low

--show countries with highest death per population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is not null
group by location
order by TotalDeathCount desc 


-- CONTINENTS SECTION---
--do by continent
--missing canada information
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is not null
group by continent
order by TotalDeathCount desc 


-- CONTINENTS SECTION--
-- location to specify directly 
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null --taking out not null will include countries
group by location
order by TotalDeathCount desc 

--total new_deaths continued without world total, euro union, international

SELECT location, sum(cast(new_deaths as int)) as NewDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null
and location not in ('world', 'European Union', 'International')--taking out not null will include countries
group by location
order by NewDeathCount desc 

--special------------------------------------
SELECT location, sum(cast(new_deaths as int)) as NewDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null
and location not in ('world', 'European Union', 'International')--taking out not null will include countries
group by location
order by NewDeathCount desc 

SELECT location, sum(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null
and location not in ('world', 'European Union', 'International')--taking out not null will include countries
group by location
order by TotalDeathCount desc 

---------------------------------------------------------
SELECT location, sum(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null
and location not in  ('Europe', 'North America', 'South America', 'Asia', 'Africa','Oceania')--taking out not null will include countries
group by location
order by TotalDeathCount desc 

-- total death test

SELECT location, sum(cast(new_deaths as int)) + sum(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null
and location not in ('world', 'European Union', 'International')--taking out not null will include countries
group by location
order by TotalDeathCount desc 


SELECT location, sum(cast(total_deaths as int)) as TotalDeathCount
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%' --to specify visualization
Where continent is  null --taking out not null will include countries
group by location
order by TotalDeathCount desc 

-- GLOBAL numbers--
--we are doing by date as it will look out all the world
--sum(cast(new_deaths as int)) need to cast because it is a float 
-- with date
SELECT  date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths , sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage--, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%'
where continent is not null 
group by date
order by 1,2 



--total of everything overall based on new cases and total cases
--without date
SELECT sum(new_cases) as total_cases, 
sum(cast(new_deaths as int)) as total_deaths , 
sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage--, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM [Portfolio projects]..CovidDeaths
--where location like'%state%'
where continent is not null 
--group by date
order by 1,2 

-- new table covid 
--52:17
select * from [Portfolio projects]..CovidDeaths
select * from [Portfolio projects]..CovidVaccinations
--joining tables
SELECT * 
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date

----Total populaiton vs vaccination
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations	--pick columns 
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null --need to specify continent
	order by 1,2,3

--test to remove nulls out of new vaccinations 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations	--pick columns 
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null --need to specify continent
	and new_vaccinations is not null
	order by 2,3

-- test to specify by location 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations 	--pick columns 
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.location like '%state%'
	and new_vaccinations is not null
	order by 1,2,3  
-- continued but adding 

--percentage of population vaccianted
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, dea.date) as RollingVacCount--partition function to reset count of location when changes
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null --need to specify continent
	order by 2,3

--using CTE common table expression
With PopvsVac (Continent, location, date, population, new_vaccinations, RollingVacCount) 
AS
(

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingVacCount 
--partition function to reset count of location when changes
FROM [Portfolio projects]..CovidDeaths dea
Join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
)
select *, (RollingVacCount/Population)*100 as VacPercentage from PopvsVac
--order by 2,3

--tmp tables test

Drop Table if exists #PopVacPercent --add this for temp tables for multiple testing
Create Table #PopVacPercent
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
RollingVacCount numeric
)
Insert into #PopVacPercent
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (Partition by dea.location order by dea.location, dea.date) as RollingVacCount 
--partition function to reset count of location when changes
FROM [Portfolio projects]..CovidDeaths dea
Join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null

select *, (RollingVacCount/Population)*100 as VacPercentage from #PopVacPercent

--creating views to store data visualization
--run first--
 Create View PercentagePopulationVac as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int,vac.new_vaccinations)) OVER (partition by dea.location order by dea.location, dea.date) as RollingVacCount--partition function to reset count of location when changes
FROM [Portfolio projects]..CovidDeaths dea
join [Portfolio projects]..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null --need to specify continent
	--order by 2,3
--- run first--
Select * from PercentagePopulationVac