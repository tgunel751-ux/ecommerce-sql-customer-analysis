CREATE TABLE new_gold_customers1 AS(
 SELECT customer_id,days_since_last_purchase
 FROM e_ticaret_musterileri
 WHERE membership_type='Gold'
);
INSERT INTO new_gold_customers1(customer_id,days_since_last_purchase)
SELECT g.customer_id, 
       e.days_since_last_purchase
FROM gold_olabilecekler g
JOIN e_ticaret_musterileri e
    ON e.customer_id=g.customer_id
WHERE e.days_since_last_purchase <=12;
SELECT * FROM new_gold_customers1;
--DROP TABLE new_gold_customerss;
SELECT city,
       ROUND(AVG(items_purchased),2) AS average_item,
	   COUNT(*) AS numCustom
FROM e_ticaret_musterileri e
JOIN new_gold_customers1 n
     ON e.customer_id=n.customer_id
GROUP BY city
ORDER  BY numCustom DESC;

