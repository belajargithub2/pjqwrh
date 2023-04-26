import 'languages.dart';

class LanguageIndonesia extends Languages {
  @override
  String get onBoardingTitle1 => "Kemudahan dalam kelola pesanan";

  @override
  String get onBoardingTitle2 => "Dapatkan semuanya dalam genggaman";

  @override
  String get onBoardingTitle3 => "Jelajahi lebih yang ada di Deasy";

  @override
  String get onBoardingSubtitle1 =>
      "Berfungsi sebagai aplikasi terpusat untuk semua saluran masuk Kreditplus, di mana pengguna dapat melihat semua pesanan dan detailnya.";

  @override
  String get onBoardingSubtitle2 =>
      "Dapatkan semua laporan hanya dengan download E-PO (Purchase Order) dan E-Invoice, juga upload File BAST (Berita Acara Serah Terima)";

  @override
  String get onBoardingSubtitle3 =>
      "Sebagai admin super, buat pengguna baru, juga tetapkan peran dan fitur untuk masing-masing pengguna berdasarkan kebutuhannya.";

  @override
  String get loginDescription =>
      "Sistem manajemen dealer bertujuan untuk memfasilitasi transaksi pembayaran melalui Kreditplus.";

  @override
  String get loginForgotPassword => "Lupa Kata Sandi?";

  @override
  String get loginSubmit => "Masuk";

  @override
  String get loginUsername => "No Handphone / Email";

  @override
  String get loginEmail => "Email";

  @override 
  String get loginPassword => "Kata Sandi";

  @override
  String get enterEmail => "Masukkan Email";

  @override
  String get enterPassword => "Masukkan Kata Sandi";

  @override
  String get loginWelcome => "Selamat datang";

  @override
  String get loginEmailNotFound => "Email / no hp kamu belum terdaftar";

  @override
  String get loginFillAllField => "Harap isi semua field";

  @override
  String get loginInvalidEmail => "Kata sandi salah atau email yang anda masukkan tidak terdaftar.";

  @override
  String get loginInvalidPassword => "Password yang kamu masukan salah";

  @override
  String get noInternet => "Tidak ada koneksi internet";

  @override
  String get error500 => "Terjadi kesalahan pada server";

  @override
  String get homeNoBAST => "Belum ada bast yang harus di upload untuk saat ini.";

  @override
  String get homeNoTransaction => "Kamu saat ini belum ada transaksi, coba di lain hari ya.";

  @override
  String get homeTodayTransaction => "Transaksi Hari ini";

  @override
  String get homeWelcome => "Selamat pagi, ";
}
