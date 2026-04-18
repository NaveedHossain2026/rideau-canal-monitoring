WITH AggregatedData AS (
    SELECT
        deviceId AS location,
        System.Timestamp() AS windowEnd,
        CONCAT(deviceId, '-', CAST(System.Timestamp() AS nvarchar(max))) AS id,

        AVG(iceThickness)        AS avgIceThickness,
        MIN(iceThickness)        AS minIceThickness,
        MAX(iceThickness)        AS maxIceThickness,

       AVG(surfaceTemp) AS avgSurfaceTemp,
       MIN(surfaceTemp) AS minSurfaceTemp,
       MAX(surfaceTemp) AS maxSurfaceTemp,

        MAX(snowAccumulation)    AS maxSnowAccumulation,
        AVG(externalTemp) AS avgExternalTemp,
        COUNT(*)                 AS readingCount,

        CASE
            WHEN AVG(iceThickness) >= 30 AND AVG(surfaceTemp) <= -2 THEN 'Safe'
            WHEN AVG(iceThickness) >= 25 AND AVG(surfaceTemp) <= 0  THEN 'Caution'
            ELSE 'Unsafe'
        END AS safetyStatus

    FROM [RideauCanalHub]
    TIMESTAMP BY timestamp
    GROUP BY deviceId, TumblingWindow(minute, 5)
)

SELECT * INTO [SensorAggregations] FROM AggregatedData;
SELECT * INTO [historical-data] FROM AggregatedData;