SELECT 
    StartDateTimeOffset, 
    EndDateTimeOffset,
    CONVERT(datetime, StartDateTimeOffset) AS StartDateTime,
    CONVERT(datetime, EndDateTimeOffset) AS EndDateTime,
    CAST(
        DATEADD(SECOND, 
            DATEDIFF(SECOND, CONVERT(datetime, StartDateTimeOffset), CONVERT(datetime, EndDateTimeOffset)), 
            0
        ) AS TIME
    ) AS Duration_HHMMSS
FROM YourTable;




SELECT 
    StartDateTimeOffset, 
    EndDateTimeOffset,
    DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) AS DurationInSeconds,
    RIGHT('0' + CAST((DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) / 3600) AS VARCHAR), 2) + ':' +
    RIGHT('0' + CAST((DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) % 3600) / 60 AS VARCHAR), 2) + ':' +
    RIGHT('0' + CAST((DATEDIFF(SECOND, StartDateTimeOffset, EndDateTimeOffset) % 60) AS VARCHAR), 2) AS DurationFormatted
FROM YourTable;





--Method 2: Truncate Seconds to the Start of the Minute
--If you only need to truncate (not round) the time to the beginning of the minute:

SELECT 
    YourDateTimeField,
    DATEADD(MINUTE, DATEDIFF(MINUTE, 0, YourDateTimeField), 0) AS TruncatedToMinute
FROM YourTable;
