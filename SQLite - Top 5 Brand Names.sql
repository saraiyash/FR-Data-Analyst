WITH 
    earliestmonth 
AS 
(
    SELECT 
        strftime('%m',date)
    FROM 
        FR_time
    ORDER BY date DESC
    LIMIT 1
)

SELECT
    b.name AS "Top 5 Brands Names"
FROM
    (
    SELECT 
        brandId
    FROM
        (
        SELECT 
            brandId, COUNT(brandId) AS pop
        FROM
            FR_scans sc
        INNER JOIN
            (
            SELECT 
                timeId
            FROM 
                FR_time
            WHERE
                strftime('%m',date) IN 
                (
                SELECT 
                    * 
                FROM 
                    earliestmonth
                )
            ) sub
        ON sc.scannedDate = sub.timeId
        GROUP BY brandId
        )
    ORDER BY pop DESC
    LIMIT 5
    ) id
INNER JOIN
    FR_brand b
ON id.brandId = b.brandId
;
