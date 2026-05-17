\# SQL Answers



\## Q1



\### Query

Count transactions by status.



\### Result Summary

The query groups transactions by their status and counts the number of records in each category. The result showed that most transactions were captured, followed by failed and chargeback transactions. This helps understand the overall transaction success and failure distribution.



\---



\## Q2



\### Query

Calculate total captured GMV by merchant.



\### Result Summary

The query calculates merchant-wise GMV using only captured transactions. This ensures that only successful payment value is counted. BETA STORES and ALPHA MART were the leading merchants by captured GMV.



\---



\## Q3



\### Query

Show top 10 merchants by captured GMV.



\### Result Summary

The query ranks merchants by captured GMV in descending order and limits the output to the top 10 merchants. Conditional aggregation was used so that merchants with zero captured GMV are still considered in the ranking.



\---



\## Q4



\### Query

Show daily GMV and successful transaction count.



\### Result Summary

The query aggregates captured GMV and successful transaction count by transaction date. This helps monitor daily payment performance and identify changes in successful transaction volume over time.



\---



\## Q5



\### Query

Find merchants with chargeback ratio above 1%.



\### Result Summary

The query calculates the chargeback ratio for each merchant as chargeback transactions divided by total transactions. Merchants with ratios above 1% are flagged. Eco Home showed the highest chargeback ratio, followed by DELTA TRAVELS, BETA STORES, and ALPHA MART.



\---



\## Q6



\### Query

Find regions with average risk score above 50 and more than 20 transactions.



\### Result Summary

The query groups transactions by gateway region and calculates transaction count and average risk score. Invalid region values such as N/A were excluded from the regional analysis. The final threshold should follow the assignment condition of more than 20 transactions, unless otherwise clarified by the instructor.



\---



\## Q7



\### Query

Find users with 3 or more failed or chargeback transactions on the same day.



\### Result Summary

The query groups failed and chargeback transactions by user and transaction date, then filters for users with at least 3 such transactions on the same day. This helps identify potentially suspicious user-level activity patterns.



\---



\## Q8



\### Query

Show chargeback count, unique affected users, and chargeback amount by merchant.



\### Result Summary

The query summarizes chargeback impact at the merchant level. It calculates total chargeback count, distinct affected users, and total chargeback amount in USD. This helps identify which merchants create the highest chargeback exposure.

