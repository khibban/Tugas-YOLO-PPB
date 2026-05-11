# Tugas-YOLO-PPB

Aplikasi **YOLO Object Detection** berbasis Flutter. Aplikasi ini dibuat sebagai pemenuhan Tugas Mata Kuliah **Pemrograman Perangkat Bergerak (PPB)** untuk implementasi Artificial Intelligence (AI) di perangkat seluler.

Aplikasi ini menggunakan model **YOLO11n** (You Only Look Once versi 11 Nano) yang telah dikonversi ke format **TensorFlow Lite (.tflite)** agar dapat berjalan secara lokal dan ringan di perangkat Android tanpa memerlukan koneksi internet.

## Fitur Utama

- **Deteksi Gambar Statis**: Memilih gambar dari galeri perangkat dan mendeteksi objek yang ada di dalamnya beserta tingkat kepercayaannya (*confidence score*).
- **Deteksi Real-time (Live Camera)**: Menggunakan kamera perangkat untuk mendeteksi dan melacak objek secara langsung (*real-time tracking*) dengan *bounding box* yang di-render di atas *camera preview*.
- **Hardware Acceleration**: Mendukung pemrosesan GPU dan Neural Networks API (NNAPI) Android untuk performa deteksi yang mulus dan optimal.

## Teknologi yang Digunakan

- **Framework**: Flutter (Dart)
- **Machine Learning**: TensorFlow Lite (`yolo11n.tflite`)
- **Plugin**: `ultralytics_yolo` (Untuk menjembatani TFLite C++ API dengan Flutter)
- **Kamera**: Integrasi kamera native via YOLOView

## Instalasi dan Cara Menjalankan

1. **Clone Repository**
   ```bash
   git clone https://github.com/khibban/Tugas-YOLO-PPB.git
   cd Tugas-YOLO-PPB
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan Aplikasi**
   Pastikan emulator atau perangkat Android fisik sudah terhubung.
   ```bash
   flutter run
   ```

> **Catatan**: Aplikasi ini membutuhkan izin akses Kamera untuk fitur *Live Detection* dan izin akses Galeri/Penyimpanan untuk fitur *Static Image Detection*.

## Tentang Model ML

Model yang dipaketkan ke dalam aplikasi ini adalah `yolo11n.tflite`. Model ini diekspor langsung dari *checkpoint* PyTorch resmi Ultralytics. Pemilihan model "Nano" ditujukan untuk menyeimbangkan antara kecepatan inferensi (*inference speed*) dan akurasi, sangat cocok untuk arsitektur CPU dan GPU *mobile*.

## Screenshot Penggunaaan Aplikasi

<img width="630" height="1400" alt="image" src="https://github.com/user-attachments/assets/5d9642e6-c3cc-4db1-98fd-e30ef2e2f26d" />

<img width="630" height="1400" alt="image" src="https://github.com/user-attachments/assets/ed17ae54-d29f-454f-aa8c-7a809d1c8c89" />

<img width="630" height="1400" alt="image" src="https://github.com/user-attachments/assets/dd607e77-f746-4c60-b0f3-9aea80f9f443" />

<img width="630" height="1400" alt="image" src="https://github.com/user-attachments/assets/d2db6ec7-4f24-4df0-83be-6211c569dbfd" />



