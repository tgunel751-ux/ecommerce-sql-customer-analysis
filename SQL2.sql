Select * from e_ticaret_musterileri;
SELECT MAX(days_since_last_purchase) AS max,
MIN(days_since_last_purchase) AS min,
ROUND(AVG(days_since_last_purchase),2)AS average,
membership_type
FROM e_ticaret_musterileri 
GROUP BY membership_type;
SELECT g.customer_id AS gold_uyelige_gecenler,
       e.days_since_last_purchase
FROM gold_olabilecekler g
JOIN e_ticaret_musterileri e
    ON e.customer_id=g.customer_id
WHERE e.days_since_last_purchase <=12;

