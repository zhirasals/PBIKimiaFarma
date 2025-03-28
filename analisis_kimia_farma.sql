
-- analisis_kimia_farma.sql

-- 1. Membuat tabel analisis dengan kolom yang diminta
CREATE OR REPLACE TABLE kimia_farma.kf_analisis AS

-- 2. Menggabungkan data dari 3 tabel utama
WITH transaksi_bersih AS (
  SELECT 
    t.transaction_id,
    t.date,
    t.branch_id,
    kc.branch_name,
    kc.kota,
    kc.provinsi,
    kc.rating AS rating_cabang,
    t.customer_name,
    t.product_id,
    p.product_name,
    p.price AS actual_price,
    t.discount_percentage,
    
    -- 3. Menghitung persentase laba berdasarkan harga
    CASE
      WHEN p.price <= 50000 THEN 0.10
      WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
      WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
      WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
      WHEN p.price > 500000 THEN 0.30
    END AS persentase_gross_laba,
    
    -- 4. Menghitung nett_sales (harga setelah diskon)
    (p.price * (1 - t.discount_percentage/100)) AS nett_sales,
    
    -- 5. Menghitung nett_profit (laba bersih)
    (p.price * (1 - t.discount_percentage/100) * 
     CASE
       WHEN p.price <= 50000 THEN 0.10
       WHEN p.price > 50000 AND p.price <= 100000 THEN 0.15
       WHEN p.price > 100000 AND p.price <= 300000 THEN 0.20
       WHEN p.price > 300000 AND p.price <= 500000 THEN 0.25
       WHEN p.price > 500000 THEN 0.30
     END) AS nett_profit,
    
    t.rating AS rating_transaksi
  FROM 
    kimia_farma.kf_final_transaction t
  JOIN 
    kimia_farma.kf_product p ON t.product_id = p.product_id
  JOIN 
    kimia_farma.kf_kantor_cabang kc ON t.branch_id = kc.branch_id
)

-- 6. Menampilkan hasil akhir
SELECT 
  transaction_id,
  date,
  branch_id,
  branch_name,
  kota,
  provinsi,
  rating_cabang,
  customer_name,
  product_id,
  product_name,
  actual_price,
  discount_percentage,
  ROUND(persentase_gross_laba * 100, 2) AS persentase_gross_laba,
  ROUND(nett_sales, 2) AS nett_sales,
  ROUND(nett_profit, 2) AS nett_profit,
  rating_transaksi
FROM 
  transaksi_bersih
ORDER BY 
  date;
