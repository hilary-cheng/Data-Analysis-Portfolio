Covid Data Exploration
Select * 
    FROM master..CovidDeaths
order by 3,4

-- Select Data that we are going to be using
Select Location, date, total_cases, new_cases, total_deaths, population
    FROM master..CovidDeaths
order by 1,2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in Hong Kong
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
    FROM master..CovidDeaths
Where Location = 'Hong Kong'
order by 1,2

-- Total Cases vs Population
-- Shows what percentage of population got covid
Select Location, date, population, total_cases, (total_cases/population) * 100 as PercentPopulationInfected
    FROM master..CovidDeaths
Where Location = 'Hong Kong'
order by 1,2

-- Countries with highest infection rate compared to population
Select Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population)) * 100 as PercentPopulationInfected
    FROM master..CovidDeaths
GROUP BY Location, Population
order by PercentPopulationInfected desc

-- Show countries with highest death count per population
Select Location, MAX(cast(Total_deaths as int)) as TotalDeathCount
    FROM master..CovidDeaths
Where continent is not null
GROUP BY Location
order by TotalDeathCount desc

-- Show continent with the highest death count per population
Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
    FROM master..CovidDeaths
Where continent is not null
GROUP BY continent
order by TotalDeathCount desc

-- Global numbers
Select  date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/SUM(new_cases)) * 100 as DeathPercentage
    FROM master..CovidDeaths
WHERE continent is not null
GROUP BY date
order by 1,2

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, (SUM(new_deaths)/SUM(new_cases)) * 100 as DeathPercentage
    FROM master..CovidDeaths
WHERE continent is not null
order by 1,2

-- Joining CovidDeaths data & CovidVaccinations data
Select *
    FROM master..CovidDeaths dea
    JOIN master..CovidVaccinations vac
        ON dea.location = vac.location
        and dea.date = vac.date

-- Total Population vs Vaccinations
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
        SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition By dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
    FROM master..CovidDeaths dea
    JOIN master..CovidVaccinations vac
        ON dea.location = vac.location
        and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3

-- Use CTE (Common Table Expression)
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition By dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
    FROM master..CovidDeaths dea
    JOIN master..CovidVaccinations vac
        ON dea.location = vac.location
        and dea.date = vac.date
WHERE dea.continent is not null
)
Select *, (RollingPeopleVaccinated/population)*100
From PopvsVac

-- Temp Table
Drop Table if exists #PercentePopulationVaccinated
Create Table #PercentePopulationVaccinated
(
    Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    New_Vaccinations numeric,
    RollingPeopleVaccinated numeric
)

Insert into #PercentePopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition By dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
    FROM master..CovidDeaths dea
    JOIN master..CovidVaccinations vac
        ON dea.location = vac.location
        and dea.date = vac.date
WHERE dea.continent is not null

Select *, (RollingPeopleVaccinated/Population)*100
FROM #PercentePopulationVaccinated

-- Creating view to store data for later visualizations
Create VIEW PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition By dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated
    FROM master..CovidDeaths dea
    JOIN master..CovidVaccinations vac
        ON dea.location = vac.location
        and dea.date = vac.date
WHERE dea.continent is not null

Select *
From PercentPopulationVaccinated