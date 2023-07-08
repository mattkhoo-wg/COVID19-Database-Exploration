-- Retrieve countires with the highest number of vaccinations
SELECT location, MAX(total_vaccinations) AS max_vaccinations
FROM Vaccinations
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY max_vaccinations DESC;

-- Calculating percentage increase in vaccinations for United States
SELECT date, location, new_vaccinations,
       (new_vaccinations - LAG(new_vaccinations) OVER (PARTITION BY location ORDER BY date)) / LAG(new_vaccinations) OVER (PARTITION BY location ORDER BY date) * 100 AS percentage_increase
FROM Vaccinations
WHERE location = 'United States'
ORDER BY date;

-- Retrieve the top 5 countries with the highest percentage of population fully vaccinated:
SELECT TOP 5 V.location, (max(V.total_vaccinations) / MAX(D.population)) * 100 AS percentage_fully_vaccinated
FROM Vaccinations V
JOIN Deaths D on V.location = D.location
    AND V.date = D.date
GROUP BY V.location
ORDER BY percentage_fully_vaccinated DESC;

-- Get the rolling count of vaccinations in each location
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RollingPeopleVaccinated
FROM Deaths d
JOIN Vaccinations v on d.location = v.location 
    AND d.date = v.date
WHERE d.continent IS NOT NULL
ORDER BY d.location, d.date

-- From the rolling count compare the countries vaccination percentages using a CTE
WITH PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RollingPeopleVaccinated
FROM Deaths d
JOIN Vaccinations v on d.location = v.location 
    AND d.date = v.date
WHERE d.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/population)*100 as VaccinationPercentage
FROM PopvsVac

