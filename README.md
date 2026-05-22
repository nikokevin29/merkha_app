# Merkha App

<p align="center">
  <strong>Social Commerce Mobile Application</strong><br/>
  PT. Merkha Teknologi Indonesia
</p>

---

Aplikasi mobile social commerce yang menggabungkan e-commerce dan jejaring sosial dalam satu platform. Pengguna dapat menemukan produk, berbelanja, berinteraksi dengan merchant, serta berbagi konten melalui feed komunitas.

> Dikembangkan sebagai **tugas magang** di [PT. Merkha Teknologi Indonesia](https://merkha.com) sekaligus **proyek skripsi** di Universitas Atma Jaya Yogyakarta.

---

## Fitur Utama

### Belanja (E-Commerce)
| Fitur | Deskripsi |
|-------|-----------|
| Browsing produk | Jelajahi produk berdasarkan kategori dan rekomendasi |
| Pencarian | Cari produk dengan filter |
| Detail produk | Galeri foto, deskripsi, ulasan, dan info merchant |
| Keranjang | Penyimpanan lokal via SQLite (tetap tersimpan offline) |
| Checkout | Pilih alamat, terapkan voucher, lanjut ke pembayaran |
| Pembayaran | Multiple metode pembayaran via wallet |
| Riwayat pesanan | Pantau status pesanan aktif dan selesai |
| Wishlist | Simpan produk favorit |
| Ulasan | Beri rating dan komentar pada produk dan merchant |
| Voucher | Kode diskon saat checkout |

### Sosial (Social Feed)
| Fitur | Deskripsi |
|-------|-----------|
| Feed | Infinite scroll feed dengan konten merchant dan pengguna |
| Like & Komentar | Interaksi pada setiap postingan |
| Buat postingan | Upload konten dengan foto |
| Follow | Ikuti merchant dan pengguna |
| Chat | Pesan langsung ke merchant (real-time via Firestore) |
| Laporan | Laporkan konten tidak pantas |

### Merchant
| Fitur | Deskripsi |
|-------|-----------|
| Profil merchant | Info toko, jam operasional, rating, dan produk |
| Feed merchant | Konten khusus per merchant |
| Produk terlaris | Tampilan best seller per merchant |
| Chat | Komunikasi langsung dengan pembeli |

### Akun
- Registrasi multi-langkah (6 tahap)
- Login / reset password
- Edit profil dan foto
- Kelola alamat pengiriman
- Preferensi dan minat pengguna

---

## Tech Stack

| Layer | Teknologi |
|-------|-----------|
| Framework | Flutter (iOS & Android) |
| Language | Dart ≥2.7.0 |
| State Management | BLoC + Cubit (31+ cubit) |
| Navigation | GetX |
| REST API | HTTP + Bearer token auth |
| Real-time chat | Cloud Firestore |
| Push notification | Firebase Cloud Messaging |
| Storage | Firebase Storage |
| Analytics | Firebase Analytics |
| DB Lokal | SQLite (sqflite) — keranjang belanja |
| Lokasi | Geolocator + Geocoder |
| Gambar | Image Picker + Image Cropper |

---

## Arsitektur

```
lib/
├── bloc/           # FeedBloc
├── cubit/          # 31+ Cubit (User, Product, Feed, Order, Merchant, Social, ...)
├── models/         # 27 model data (User, Product, Order, Feed, Merchant, ...)
├── services/       # 16 service (UserService, ProductService, OrderService, ...)
├── view/
│   ├── pages/      # Semua screen (~60+ halaman)
│   └── widgets/    # Komponen reusable
└── shared/         # Konstanta, tema, utilitas, local storage
```

**Pola:** Clean Architecture — Presentation → Cubit/BLoC → Service → API/Firebase

---

## Alur Aplikasi

```
SplashScreen
    ↓
Sign In / Sign Up (6 langkah)
    ↓
Main Navigation (5 tab)
├── Home      — browse kategori & produk unggulan
├── Feed      — feed sosial komunitas
├── Cart      — keranjang belanja
├── Wishlist  — produk tersimpan
└── Profile   — akun & pengaturan
```

---

## Menjalankan Project

### Prasyarat

- Flutter SDK ≥2.7.0
- Dart SDK
- Firebase project dengan Firestore, Storage, FCM, dan Analytics aktif
- Backend REST API Merkha (internal — diperlukan akses)

### Setup

```bash
git clone https://github.com/nikokevin29/merkha_app.git
cd merkha_app

flutter pub get
```

Konfigurasi Firebase:
- Tambahkan `google-services.json` ke `android/app/`
- Tambahkan `GoogleService-Info.plist` ke `ios/Runner/`

```bash
flutter run
```

> **Catatan:** Aplikasi membutuhkan koneksi ke backend REST API Merkha. Tanpa akses endpoint internal, fitur e-commerce dan sosial tidak akan berfungsi penuh.

---

## Konteks Pengembangan

Proyek ini dikembangkan selama **program magang** di PT. Merkha Teknologi Indonesia dan sekaligus menjadi **proyek skripsi** di Universitas Atma Jaya Yogyakarta.

**Topik penelitian:** Implementasi arsitektur BLoC pada aplikasi social commerce berbasis Flutter dengan integrasi Firebase dan REST API.

---

*Dikembangkan dengan Flutter · Firebase · BLoC*  
*PT. Merkha Teknologi Indonesia · Universitas Atma Jaya Yogyakarta*
