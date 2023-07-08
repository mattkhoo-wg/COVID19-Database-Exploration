-- Creating view to store data for future visualisations
CREATE VIEW PercentPopulationsVaccinated AS
SELECT
  d.continent,
  d.location,
  d.date,
  d.population,
  v.new_vaccinations,
  SUM(v.new_vaccinations) OVER (
    PARTITION BY d.location
    ORDER BY d.date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS RollingPeopleVaccinated
FROM
  Deaths d
JOIN
  Vaccinations v ON d.location = v.location
  AND d.date = v.date
WHERE
  d.continent IS NOT NULL;