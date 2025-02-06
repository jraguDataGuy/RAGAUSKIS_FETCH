WITH COUNT_BY_YEAR AS
(SELECT
   EXTRACT(YEAR FROM DATE_TRUNC((CREATED_DATE),YEAR))AS YEAR
  --,EXTRACT(MONTH FROM DATE_TRUNC((CREATED_DATE),MONTH)) AS MONTH
  ,COUNT(DISTINCT ID) AS USER_TOTAL
  FROM `fetch.user`
  GROUP BY YEAR
  ORDER BY YEAR 
)

,YEARLYTOTALS AS (
   SELECT
        YEAR,
        USER_TOTAL,
        SUM(USER_TOTAL) OVER (ORDER BY YEAR) AS RUNNING_TOTAL 
    FROM
        COUNT_BY_YEAR
)

SELECT
    YEAR
    ,USER_TOTAL
    ,RUNNING_TOTAL
    , LAG(RUNNING_TOTAL, 1) OVER (ORDER BY YEAR) AS PRIOR_YEAR_RUNNING_TOTAL
    ,SAFE_DIVIDE((RUNNING_TOTAL - LAG(RUNNING_TOTAL, 1) OVER (ORDER BY YEAR)) * 100.0, LAG(RUNNING_TOTAL, 1) OVER (ORDER BY YEAR)) AS YOY_CHANGE
    
FROM
    YEARLYTOTALS
ORDER BY YEAR