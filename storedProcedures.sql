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

-- Stored procudre for bulk insert from blob storage
CREATE PROCEDURE BulkInsertFromBlob
    @FilePath NVARCHAR(255),
    @TableName NVARCHAR(255)
AS
BEGIN
  SET NOCOUNT ON;

  BULK INSERT @TableName FROM @FilePath
  WITH (
      DATA_SOURCE = 'covidData_blob',
      DATAFILETYPE = 'char',
      FIRSTROW = 2, -- Skip the header row if necessary
      FIELDTERMINATOR = ',', -- Specify the CSV field delimiter
      ROWTERMINATOR = '\n', -- Specify the row delimiter
      BATCHSIZE=10000, -- reduce network traffic
      TABLOCK -- minimize log records
  );
END;

-- Stored procedure for bulk insert from CSV file
CREATE PROCEDURE BulkInsertFromCSV
    @FilePath NVARCHAR(255),
    @TableName NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    -- Define the format file path
    DECLARE @FormatFilePath NVARCHAR(255);
    SET @FormatFilePath = REPLACE(@FilePath, '.csv', '.fmt');
  
    -- Create a format file for the CSV data
    EXEC xp_cmdshell 'bcp ' + @TableName + ' format nul -f ' + @FormatFilePath + ' -n -x';

    -- Bulk insert the data from the CSV file
    DECLARE @BulkInsertQuery NVARCHAR(MAX);
    SET @BulkInsertQuery = 'BULK INSERT ' + @TableName + ' FROM ''' + @FilePath + ''' '
        + 'WITH (FORMATFILE = ''' + @FormatFilePath + ''', FIRSTROW = 2, FIELDTERMINATOR = '','', ROWTERMINATOR = ''\n'')';
    EXEC sp_executesql @BulkInsertQuery;
END;