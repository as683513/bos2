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
