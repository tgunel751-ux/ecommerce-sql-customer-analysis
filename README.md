# ecommerce-sql-customer-analysis
# 🛒 E-Commerce Customer Segmentation & Analysis Project (SQL)

Bu proje, e-ticaret platformu müşteri verilerini kullanarak müşteri segmentasyonu yapmak, üyelik tiplerine ve demografik özelliklere (cinsiyet, şehir) göre davranışları analiz etmek, potansiyel "Gold" üyeleri tespit edip raporlamak amacıyla geliştirilmiş bir SQL çalışmasıdır.

---

## 📌 Proje Akışı & Senaryo (Project Workflow)
1. **Müşteri Analizi (`SQL1.sql`):** Mevcut üyelik tiplerine göre toplam harcama eşik değerleri CTE (Common Table Expressions) yardımıyla hesaplanmıştır. Silver üyeler arasından belirli bir harcama sınırını (`> 750`) geçen müşteriler filtrelenerek potansiyel Gold adaylar tablosu (`gold_olabilecekler`) oluşturulmuştur.
2. **Üyelik ve Süre Analizi (`SQL2.sql`):** Üyelik tiplerine göre son alışverişten bu yana geçen gün sürelerinin maksimum, minimum ve ortalama değerleri analiz edilmiş; potansiyel adaylar arasından belirli bir gün kriterini sağlayanlar listelenmiştir.
3. **Tablo Yönetimi ve Şehir Bazlı Raporlama (`SQL3.sql`):** Yeni Gold üyeler için dinamik bir tablo (`new_gold_customers1`) oluşturulmuş, yeni veriler buraya `INSERT` edilmiştir. Ardından bu müşteri grubunun şehir bazında ortalama ürün alma adetleri ve müşteri sayıları analiz edilmiştir.
4. **Demografik Analiz (`SQL4.sql`):** Müşterilerin cinsiyet kırılımına göre kişi sayıları, toplam harcamaları ve ortalama harcama tutarları hesaplanarak en çok harcama yapan demografik grup tespit edilmiştir.

---

## 🛠️ Kullanılan Teknolojiler & Konular (Technologies & Concepts)
- **RDBMS:** PostgreSQL / SQL
- **SQL Konseptleri:** 
  - `CREATE TABLE AS (CTAS)` & `INSERT INTO`
  - `WITH (CTE - Common Table Expressions)`
  - `JOIN` İşlemleri (`INNER JOIN`)
  - Agregat Fonksiyonlar (`SUM`, `AVG`, `MAX`, `MIN`, `COUNT`, `ROUND`)
  - Gruplama ve Sıralama (`GROUP BY`, `ORDER BY`)

---

## 🔍 Öne Çıkan SQL Sorgularından Örnekler (Key Queries)

### 1. Potansiyel Gold Üyelerin Tespiti (CTE Kullanımı)
```sql
CREATE TABLE gold_olabilecekler AS 
WITH cte AS(
    SELECT membership_type,
          MAX(total_spend) AS max_esik_deger,
          MIN(total_spend) AS min_esik_deger
    FROM e_ticaret_musterileri
    GROUP BY membership_type
),
cte2 AS(
    SELECT e.customer_id,
           c.membership_type,
           e.total_spend,
	       c.max_esik_deger
    FROM cte c
    JOIN e_ticaret_musterileri e ON c.membership_type = e.membership_type
    WHERE e.membership_type = 'Silver'
)
2. Cinsiyete Göre Müşteri ve Harcama Analizi
SELECT gender,
       COUNT(customer_id) AS kisi_sayisi,
	   SUM(total_spend) AS toplam_harcama,
	   AVG(total_spend) AS ortalama_harcama
FROM e_ticaret_musterileri
GROUP BY gender
ORDER BY SUM(total_spend) DESC;
3. Şehir Bazlı Yeni Gold Üye Dağılımı ve Ortalama Ürün Analizi
SELECT city,
       ROUND(AVG(items_purchased), 2) AS average_item,
	   COUNT(*) AS numCustom
FROM e_ticaret_musterileri e
JOIN new_gold_customers1 n ON e.customer_id = n.customer_id
GROUP BY city
ORDER BY numCustom DESC;
Projeyi Çalıştırma (How to Run)
Bu depoyu klonlayın:
git clone [https://github.com/kullanici-adiniz/ecommerce-sql-customer-analysis.git](https://github.com/kullanici-adiniz/ecommerce-sql-customer-analysis.git)
SELECT customer_id
FROM cte2
WHERE total_spend > 750;
