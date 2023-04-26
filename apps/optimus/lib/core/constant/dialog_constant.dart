abstract class DialogConstant {
  static String get tWaitingToResendEmail => 'Email verifikasi telah terkirim';

  static String get stWaitingToResendEmail =>
      'Terdapat waktu tunggu jika kamu melakukan kirim ulang email verifikasi. Lama waktu tunggu dapat dilihat di kolom Status.';

  //Login
  static String get requestOTPLimitTitle =>
      "Permintaan Kode OTP Anda Melebihi Batas";
  static const String tryAgainIn15Menutes =
      'Silakan coba kembali setelah 15 menit';

  static String get successAddMerchantEmployee =>
      'Merchant Employee Berhasil Ditambahkan';

  static String get bodyAddMerchantEmployee1 =>
      "Silakan periksa kotak masuk email:";

  static String get bodyAddMerchantEmployee2 =>
      "untuk melanjutkan proses verifikasi akun";

  static String get asktoCheckEmail1 => "Silakan periksa kotak masuk email:";

  static String get asktoCheckEmail2 =>
      "untuk melanjutkan proses verifikasi akun";

  static String get dialogConfirmDeleteTitle => 'Hapus Akun?';

  static String get confirmDeleteUser =>
      'Apa kamu yakin untuk menghapus akun ini?';

  static String get successDelete => 'Berhasil Dihapus';

  static String get resendEmail => 'Kirim ulang email verifikasi?';

  static String get resendEmailSubTitle =>  'Hanya tersedia 4 kali kesempatan untuk mengirim ulang email verifikasi.';


  static String get titlePhoneNumberNotFound => "No. HP Tidak Ditemukan";


  static String get subTitlePhoneNumberNotFound =>
      "Saat ini No. HP customer belum terdaftar.\nSilakan periksa kembali.";

  static String get titleInsufficientLimit => "Limit tidak cukup";

  static String get subtitleInsufficientLimit =>
      "Limit yang kamu miliki tidak cukup, silakan ajukan barang sesuai dengan limit yang kamu miliki.";

  static String get titlePromoNotfound => "Mohon Maaf, Promo Tidak Tersedia";

  static String get subTitlePromoNotfound =>
      "Silakan lakukan verifikasi akun Kreditmu kamu\nmelalui aplikasi Kreditplus Mobile";

  static String get titleNeedVerification => "Mohon maaf,";

  static String get subTitleNeedVerification =>
      "silakan minta konsumen untuk melakukan\nverifikasi akun kreditmu melalui aplikasi kreditplus mobile";



  static String get titleQrCodeRunOut => "Waktu scan QR Code telah berakhir.";

  static String get subTitleQrCodeRunOut => "Silakan buat pengajuan ulang";

  static String get paymentDetailDialogTitle => 'Detail Pembayaran ke Merchant';

  static String get uploadImeiDialogSubtitle =>
      "Upload Nomor IMEI dengan mengambil foto Barcode IMEI yang terdapat pada box gadget";

  static String get uploadReceiptDialogSubtitle =>
      "Pastikan foto yang anda unggah mengambil foto barang dan orang yang terlihat jelas";

  static String get uploadBastDialogSubtitle =>
      "Pastikan Dokumen yang anda unggah sudah tepat dan dapat dibaca dengan jelas";

  static String get trackingDetailDialogTitle => 'Detail Status Pengiriman';

  static String get cancelUploadDialog => "Batalkan";

  static String get titleDialogExpiredSnb => 'Kesempatan Scan\nTelah Habis';

  static String get subTitleDialogExpiredSnb =>
      'Silahkan melakukan\npengajuan ulang';

  static String get snbDialogFormPesananButton => "Kembali";

  static String get accountNotVerified => "Kamu belum memverifikasi akun";

}
