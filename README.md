# 📊 Analisis Data Penjualan - Kimia Farma

## File
**analisis_kimia_farma.sql**

## Deskripsi
File SQL ini digunakan untuk membuat tabel `kf_analisis` dalam schema `kimia_farma`. Tabel ini berfungsi sebagai hasil analisis gabungan dari data transaksi, produk, dan cabang Kimia Farma, dengan tambahan perhitungan metrik penting seperti laba kotor dan laba bersih.

## Tujuan Analisis
- Menggabungkan data dari tabel:
  - `kf_final_transaction` (data transaksi)
  - `kf_product` (data produk)
  - `kf_kantor_cabang` (data cabang)
- Menghitung:
  - **Persentase gross laba** berdasarkan harga produk.
  - **Nett sales** (harga setelah diskon).
  - **Nett profit** (laba bersih berdasarkan nett sales dan margin harga).
- Menampilkan data yang sudah dibersihkan dan siap dianalisis, terurut berdasarkan tanggal transaksi.

## Logika Perhitungan

### Persentase Gross Laba
| Harga Produk (Rp)       | Persentase Laba |
|-------------------------|------------------|
| ≤ 50.000                | 10%              |
| 50.001 - 100.000        | 15%              |
| 100.001 - 300.000       | 20%              |
| 300.001 - 500.000       | 25%              |
| > 500.000               | 30%              |

### Formula
- **Nett Sales** = `price * (1 - discount_percentage / 100)`
- **Nett Profit** = `nett_sales * persentase_gross_laba`

## Kolom Output
- `transaction_id`
- `date`
- `branch_id`
- `branch_name`
- `kota`
- `provinsi`
- `rating_cabang`
- `customer_name`
- `product_id`
- `product_name`
- `actual_price`
- `discount_percentage`
- `persentase_gross_laba` (dalam persen, dibulatkan 2 desimal)
- `nett_sales` (dibulatkan 2 desimal)
- `nett_profit` (dibulatkan 2 desimal)
- `rating_transaksi`

## Cara Penggunaan
1. Pastikan schema `kimia_farma` dan tabel:
   - `kf_final_transaction`
   - `kf_product`
   - `kf_kantor_cabang`
   sudah tersedia di database.
2. Jalankan file `analisis_kimia_farma.sql` di editor SQL (misalnya: BigQuery Console, DBeaver, atau SQL Workbench).
3. Tabel `kf_analisis` akan otomatis dibuat/replace.

## NOTES
- Query ini menggunakan teknik `Common Table Expression (CTE)` untuk meningkatkan keterbacaan dan modularitas kode.
- Cocok untuk digunakan dalam analisis penjualan, performa cabang, dan pengambilan keputusan bisnis.

---

📝 Dibuat oleh: _Zahira Salsabila Khairunnisa_  
📅 Tanggal: 29 Maret 2025
