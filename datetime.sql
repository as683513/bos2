SELECT 
    StartDateTimeOffset, 
    EndDateTimeOffset,
    CONVERT(datetime, StartDateTimeOffset) AS StartDateTime,
    CONVERT(datetime, EndDateTimeOffset) AS EndDateTime,
    CONVERT(varchar(8), 
        DATEADD(SECOND, 
            DATEDIFF(SECOND, CONVERT(datetime, StartDateTimeOffset), CONVERT(datetime, EndDateTimeOffset)), 
            0
        ),
        108
    ) AS Duration_HHMMSS
FROM YourTable;
