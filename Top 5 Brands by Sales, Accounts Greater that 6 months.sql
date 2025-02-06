-- Isolated accounts that have existed 6+ months
WITH ACCOUNT_AGE AS (
  SELECT
  ID AS USER_ID
  ,DATE_DIFF(CURRENT_DATE(), DATE(CREATED_DATE), MONTH) AS ACCOUNT_AGE
  FROM `fetch.user`
  WHERE DATE_DIFF(CURRENT_DATE(), DATE(CREATED_DATE), MONTH) >= 6
  AND CREATED_DATE IS NOT NULL
  ORDER BY ACCOUNT_AGE DESC
)

--THIS WAS ADDED TO CORRECT STRING VALUES IN THE SALES CATEGORY

,CLEAN_SALES AS (
  SELECT
  USER_ID
  ,BARCODE
   , COALESCE(
        SAFE_CAST(
            TRIM( 
                NULLIF( 
                    REPLACE(
                        REGEXP_REPLACE(  
                            FINAL_SALE,
                            r'^[^0-9.-]|[^0-9.eE-]', 
                            ''
                        ),
                        ',', '.'
                    )
                , '')
            ) AS FLOAT64),
        0.0  
    ) AS FINAL_SALE
FROM `fetch.transaction`
)

SELECT
FP.BRAND AS BRAND
,SUM(CS.FINAL_SALE) AS TOTAL_SALES
FROM CLEAN_SALES AS CS
LEFT JOIN ACCOUNT_AGE AS A
  ON A.USER_ID = CS.USER_ID
LEFT JOIN `fetch.products` AS FP
  ON FP.BARCODE = CS.BARCODE
WHERE BRAND IS NOT NULL
AND FINAL_SALE IS NOT NULL
GROUP BY BRAND
ORDER BY TOTAL_SALES DESC
LIMIT 5