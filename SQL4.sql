SELECT gender,
       COUNT(customer_id) AS kisi_sayisi,
	   SUM(total_spend)AS toplam_harcama,
	   AVG(total_spend)ASortlaam_harcama
FROM e_ticaret_musterileri
GROUP BY gender
ORDER BY SUM(total_spend) DESC;