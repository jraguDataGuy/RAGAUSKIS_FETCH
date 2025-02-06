## Data Quality Issues

**Users Table**

* No duplicate IDs found.
* Significant number of null values:
    * Birthdates: 3,675 (out of 100,000 unique IDs)
    * States: 4,812
    * Language: 30,508
    * Gender: 5,892
* Some birthdates imply users aged 125+.

**Products Table**

* Four columns named "Category" with intersecting parameters.  Need more information on category meaning and hierarchy.
* Null values:
    * Category 1: 111 (out of 845,552 data points)
    * Category 2: 1,424
    * Category 3: 60,566
    * Category 4: 778,093
    * Manufacturer: 226,474
    * Brand: 226,472
    * Barcode: 4,025

**Transactions Table**

* Null values:
    * Barcode: 5,762 (out of 50,000 rows)
* `Final_Sale` data stored as a string, requiring cleanup for analysis.


## Top 5 Brands by Receipts Scanned (Users 21+)

| BRAND | RECEIPT_SCANS |
|---|---|
| COCA-COLA | 527 |
| GREAT VALUE | 384 |
| PEPSI | 361 |
| EQUATE | 341 |
| LAY'S | 324 |

**Data Issues:**

* 3,765 users without birthdates.
* 226,472 brands untagged.
* Null values for barcodes in Transactions and Products.
* Birthdates imply users up to 125 years old (not eliminated from data).


## Top 5 Brands by Sales (Account Age 6+ Months)

| BRAND | TOTAL_SALES |
|---|---|
| COCA-COLA | $3,948.93 |
| PEPSI | $3,265.61 |
| EQUATE | $2,800.12 |
| FRITO-LAY | $2,111.83 |
| GREAT VALUE | $1,944.56 |

**Data Issues:**

* Sales data converted from string to integer (blanks and nulls eliminated).
* Null values for barcodes in Transactions and Products.


## Fetch Growth Year Over Year

| YEAR | USER_TOTAL | RUNNING_TOTAL | PRIOR_YEAR_RUNNING_TOTAL | YOY_CHANGE |
|---|---|---|---|---|
| 2014 | 30 | 30 |  |  |
| 2015 | 51 | 81 | 30 | 170 |
| 2016 | 70 | 151 | 81 | 86.42 |
| 2017 | 644 | 795 | 151 | 426.49 |
| 2018 | 2168 | 2963 | 795 | 272.70 |
| 2019 | 7093 | 10056 | 2963 | 239.39 |
| 2020 | 16883 | 26939 | 10056 | 167.89 |
| 2021 | 19159 | 46098 | 26939 | 71.12 |
| 2022 | 26807 | 72905 | 46098 | 58.15 |
| 2023 | 15464 | 88369 | 72905 | 21.21 |
| 2024 | 11631 | 100000 | 88369 | 13.16 |

## Internal Communication on Results

Subject: Customer Insights Update - Brand & Growth Analysis

Good afternoon,

I wanted to update you on some questions I was tasked with investigating to better understand our customers in certain segments and age brackets.

Our 21+ users scan large volumes of top brands:

| BRAND | RECEIPT_SCANS |
|---|---|
| COCA-COLA | 527 |
| GREAT VALUE | 384 |
| PEPSI | 361 |
| EQUATE | 341 |
| LAY'S | 324 |

Coca-Cola dominates this age bracket, highlighting them as a potential partner to target for additional growth.

For users with accounts older than 6 months, we see total sales trending toward Coca-Cola, with significant overlap of brands in our receipt scans/21+ cohort:

| BRAND | TOTAL_SALES |
|---|---|
| COCA-COLA | $3,948.93 |
| PEPSI | $3,265.61 |
| EQUATE | $2,800.12 |
| FRITO-LAY | $2,111.83 |
| GREAT VALUE | $1,944.56 |

We have grown our user base by 13% in 2024. Given the volume of receipts and sales of Coke products, there is an opportunity to target Coca-Cola as a partner for increasing awareness of Fetch.

I want to caveat that I will need additional details to solidify findings in the future:

* **Category Assignments:** We need clarity on the Category assignments in our product data. We currently have 4 columns of data here, with increasing nulls in each additional category. There may be an opportunity for consolidation to improve targeted product insights.
* **Missing Brand Data:** 26.7% of our product data does not have a brand assignment. This skews our brand-related results. We will need to ensure we are capturing that information for analysis going forward.
* **Data Type Consistency:** Some numerical values are stored as strings. I will discuss with our data engineers a more efficient data storage/ETL process to simplify data validation/transformation needs on the analytics team.

Let me know if you have any additional questions.

Sincerely,

Jeff Ragauskis


