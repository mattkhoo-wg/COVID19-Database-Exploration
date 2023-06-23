-- Stored procedure that returns countries that have had a 50% increase in cases in the last week
CREATE PROCEDURE FindCountriesWithSignificantCaseIncrease
AS
BEGIN
  SELECT location
  FROM (
    SELECT location, SUM(new_cases) AS total_cases,
           LAG(SUM(new_cases)) OVER (PARTITION BY location ORDER BY MIN(date)) AS prev_week_cases
    FROM Deaths
    WHERE date >= DATEADD(WEEK, -2, GETDATE())
    AND date <= DATEADD(WEEK, -1, GETDATE())
    GROUP BY location
  ) subquery
  WHERE total_cases > 1.5 * prev_week_cases;
END;

-- Stored procedure that returns the number of new cases per month for a given country
CREATE PROCEDURE CountryNewCasesPerMonth
@C_name varchar(45)

AS
BEGIN
    SELECT DATEADD(MONTH, DATEDIFF(MONTH, 0, date), 0) AS month, SUM(new_cases) AS TotalNewCases
    FROM Deaths
    WHERE location = @C_name 
    GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, date), 0)
    ORDER BY month;
END;