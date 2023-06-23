-- Death Rate
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathRate
FROM Deaths
WHERE location like '%states%'
ORDER BY 1, 2;

-- Infection Rate
SELECT location, date, total_cases, population, (total_cases/population)*100 as PercentagePopulationInfected
FROM Deaths
WHERE location like '%states%'
ORDER BY 1, 2;

-- Coutries ordered by infection Rate, highest to lowest
SELECT location, population, MAX(total_cases) as HighestTotalCases, (MAX(total_cases)/population)*100 as MaxPercentagePopulationInfected
FROM Deaths
GROUP BY location, population
ORDER BY MaxPercentagePopulationInfected DESC;

-- Coutries ordered by Death Rate, highest to lowest
SELECT location, MAX(total_deaths) as TotalDeaths
FROM Deaths
WHERE continent IS NOT NULL -- will include continents if not added.
GROUP BY location
ORDER BY TotalDeaths DESC;

-- Examining continents
SELECT location, MAX(total_Deaths) as TotalDeathsContinent
FROM Deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeathsContinent DESC;

-- Global numbers by date
SELECT date, SUM(new_cases) as TotalNewCases, SUM(new_deaths) as TotalNewDeaths, SUM(new_deaths)/SUM(new_cases) * 100 as DeathRatePerDay
FROM Deaths
WHERE continent IS NOT NULL
GROUP BY date;

-- Death Percentage for whole world
SELECT location,  MAX(total_cases) as TotalGlobalCases, MAX(total_deaths) as TotalGlobalDeaths, MAX(total_deaths)/MAX(total_cases) * 100 as DeathRate
FROM Deaths
WHERE location = 'world'
GROUP BY location;