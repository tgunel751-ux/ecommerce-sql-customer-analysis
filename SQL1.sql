CREATE TABLE gold_olabilecekler AS 
WITH cte AS(
SELECT membership_type,
      MAX(total_spend) AS max_esik_deger,
      MIN(total_spend) AS  min_esik_deger
FROM e_ticaret_musterileri
GROUP BY membership_type),
cte2 AS(
SELECT e.customer_id,
       c.membership_type,
       e.total_spend,
	   c.max_esik_deger
FROM cte c
JOIN e_ticaret_musterileri e
       ON c.membership_type=e.membership_type
WHERE e.membership_type = 'Silver')
SELECT customer_id
FROM cte2
WHERE total_spend>750;
SELECT *
FROM gold_olabilecekler;


