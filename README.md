# Travel Wisata Lokal

Aplikasi **Travel Wisata Lokal** adalah aplikasi mobile berbasis **Flutter** yang digunakan untuk mencatat, mengelola, dan memvisualisasikan data destinasi wisata lokal. Aplikasi ini mendukung penyimpanan data secara lokal menggunakan **SQLite (sqflite)** serta integrasi **Google Maps** untuk menampilkan lokasi destinasi.

Proyek ini dibuat untuk memenuhi tugas **Remedial Akhir Semester Ganjil 2025/2026** mata kuliah **Mobile Programming**.

## 🎯 Tujuan Aplikasi
* Memudahkan pengguna dalam mencatat dan mengelola data destinasi wisata.
* Menyediakan visualisasi lokasi destinasi menggunakan Google Maps.
* Menjadi media pembelajaran implementasi Flutter, SQLite, dan Map API.

## 🚀 Fitur Utama
* **Tambah Destinasi**: Input nama, deskripsi, alamat, jam buka/tutup, dan koordinat lokasi.
* **Lihat Daftar Destinasi**: Menampilkan seluruh data destinasi dari database SQLite.
* **Edit & Hapus Destinasi**: Mengelola data melalui menu konteks.
* **Google Maps Integration**: Menampilkan marker lokasi setiap destinasi.
* **Validasi Form**: Mencegah penyimpanan data jika field penting kosong.
* **Notifikasi**: SnackBar/Dialog saat proses simpan, ubah, dan hapus berhasil/gagal.
* **Penyimpanan Lokal**: Data tetap tersimpan meskipun aplikasi ditutup.

## 📦 Daftar Package (Dependencies)
Aplikasi ini menggunakan beberapa package Flutter berikut:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.3.0
  path_provider: ^2.1.2
  google_maps_flutter: ^2.5.0
```

**Penjelasan:**

* `sqflite` → Menyimpan data destinasi dalam database SQLite.
* `path_provider` → Menentukan lokasi penyimpanan database.
* `google_maps_flutter` → Menampilkan peta dan marker lokasi destinasi.

---

##  Skema Database

### Tabel: `destinations`

| Kolom       | Tipe Data                   | Keterangan             |
| ----------- | --------------------------- | ---------------------- |
| id          | INTEGER (PK, AUTOINCREMENT) | Primary key            |
| name        | TEXT NOT NULL               | Nama destinasi         |
| description | TEXT                        | Deskripsi singkat      |
| address     | TEXT                        | Alamat                 |
| open_time   | TEXT                        | Jam buka               |
| close_time  | TEXT                        | Jam tutup              |
| latitude    | REAL NOT NULL               | Koordinat lintang      |
| longitude   | REAL NOT NULL               | Koordinat bujur        |
| image_path  | TEXT                        | Path gambar (opsional) |
| created_at  | TEXT                        | Waktu input data       |

**Query Pembuatan Tabel:**

```sql
CREATE TABLE destinations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  description TEXT,
  address TEXT,
  open_time TEXT,
  close_time TEXT,
  latitude REAL NOT NULL,
  longitude REAL NOT NULL,
  image_path TEXT,
  created_at TEXT
);
```

---

##  Alur CRUD (Create, Read, Update, Delete)

* **Create** → Data destinasi disimpan ke SQLite melalui `insertDestination()`
* **Read** → Data diambil dengan `getDestinations()` dan ditampilkan dalam ListView
* **Update** → Data diperbarui melalui `updateDestination()`
* **Delete** → Data dihapus menggunakan `deleteDestination(id)`

Data akan tetap ada meskipun aplikasi ditutup karena disimpan secara persisten di SQLite.

---

##  Cara Menjalankan Proyek

1. **Clone repository**

```bash
git clone https://github.com/username/travel-wisata-lokal.git
cd travel-wisata-lokal
```

2. **Install dependency**

```bash
flutter pub get
```

3. **Jalankan aplikasi**

```bash
flutter run
```

---

##  Cara Build Aplikasi

### Build APK

```bash
flutter build apk --release
```

File hasil build:

```
build/app/outputs/flutter-apk/app-release.apk
```

### Build App Bundle (AAB)

```bash
flutter build appbundle
```

File hasil build:

```
build/app/outputs/bundle/release/app-release.aab
```

---

## 🖼️ Screenshots Aplikasi

| Home Page                 | Form Destinasi            | Google Maps              |
| ------------------------- | ------------------------- | ------------------------ |
| ![](screenshots/home.png) | ![](screenshots/form.png) | ![](screenshots/map.png) |

> *Catatan: Tambahkan folder `/screenshots` di repository dan masukkan gambar hasil tangkapan layar aplikasi.*

---

### Evidence Kontribusi (Commit Log)

Setiap anggota berkontribusi melalui commit GitHub yang dapat dilihat pada menu **Commits** di repository.

Contoh commit:

```
feat: add destination CRUD using sqflite
feat: integrate google maps with markers
fix: validation form and snackbar feedback
docs: update README and screenshots
```

Riwayat commit dapat diakses melalui:

```
https://github.com/username/travel-wisata-lokal/commits/main
```

---

## 📑 Artefak Pengumpulan Tugas

Sesuai ketentuan dosen, berikut dokumen yang dikumpulkan:

screenshoot apk
c. Dokumentasi dan Pengumpulan
  ![WhatsApp Image 2026-01-09 at 15 04 52](https://github.com/user-attachments/assets/6e09aa0a-89e1-4c11-93ba-5a858e38c6d3)
  ![WhatsApp Image 2026-01-09 at 15 04 24](https://github.com/user-attachments/assets/da7635ed-8b7b-4b68-a422-c0a3a86b5faf)
<img width="540" height="1204" alt="image" src="https://github.com/user-attachments/assets/5ce5d09d-daaa-4133-a5e4-eff0e8b9646a" />
<img width="540" height="1204" alt="image" src="https://github.com/user-attachments/assets/cf4ee319-ebd1-4c4e-aa88-a3b117579e43" />
<img width="540" height="1204" alt="image" src="https://github.com/user-attachments/assets/a720260d-c194-44b5-9164-5a50c5222d1c" />

*  **Link File APK "https://drive.google.com/file/d/1iwSzSlxTU4EQrdVrnZBFBTD75TVAkjJy/view?usp=sharing" **
*  **Link Video Presentasi YouTube "https://youtu.be/TXMZqK2eh5U"**

---

## 🏁 Penutup

Aplikasi **Travel Wisata Lokal** dikembangkan dengan arsitektur terstruktur, penyimpanan data lokal menggunakan SQLite, serta integrasi Google Maps untuk visualisasi lokasi. Proyek ini diharapkan dapat menjadi bukti pemahaman konsep Mobile Programming serta memenuhi kriteria penilaian remedial akhir semester.

