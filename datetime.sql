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
