
--Method 2: Checking the Data Type via Temporary Table

SELECT 
    CONVERT(datetime, StartDateTimeOffset) AS StartDateTime,
    DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) AS DurationInSeconds
INTO #TempTable
FROM YourTable;

SELECT 
    COLUMN_NAME,
    DATA_TYPE
FROM 
    INFORMATION_SCHEMA.COLUMNS
WHERE 
    TABLE_NAME = 'TempTable';



--Method 3: Using TOP 0
SELECT TOP 0
    CONVERT(datetime, StartDateTimeOffset) AS StartDateTime,
    DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) AS DurationInSeconds
FROM YourTable;
