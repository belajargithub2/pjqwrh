abstract class ValidationConstant {
  static String get nameMustBeCharacterWith1To50Words =>
      'Merupakan Karakter berjumlah 1-50 huruf';

  static String get nameValidation => 'Nama Tidak Valid';

  static String get emailNotValid => 'Email Tidak Valid';

  static String get badRequestLoginPasswordEmpty =>
      "Kata Sandi tidak boleh kosong";

  static String get phoneValidation =>
      "Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka.";

  static String get rtCantBeEmpty => 'RT tidak boleh kosong';

  static String get rtCantless2 => 'RT minimal berisi 2 angka';

  static String get rtCantExceed3 => 'RT maksimal berisi 3 angka';

  static String get rwCantBeEmpty => 'RW tidak boleh kosong';

  static String get rwCantless2 => 'RW minimal berisi 2 angka';

  static String get rwCantExceed3 => 'RW maksimal berisi 3 angka';

  static String get phoneNumberNotValid =>
      'Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka';

  static String get ktpMustBe16Digit =>
      'Nomor KTP merupakan karakter angka dan terdiri dari 16 karakter';

  static String get invalidLoginPhoneNumber =>
      "Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka";

  static String get invalidLoginEmail =>
      "Email yang Anda masukan tidak terdaftar / Email tidak valid";

  static String get cantEmptyPhoneNumber =>
      "Nomor Handphone tidak boleh kosong";

  static String get cantEmptyOtp => "OTP tidak boleh kosong";

  static String get subTitlePromoNotfound =>
      "Silakan lakukan verifikasi akun Kreditmu kamu\nmelalui aplikasi Kreditplus Mobile";

  static String get correctValue => "Periksa Data kembali";

  static String get emptyProduct => "Kamu belum memilih barang.";

  static String get emptyPromo => "Promo harus dipilih";

  static String get errorPasswordFinansia =>
      "Kata Sandi tidak boleh mengandung Finansia";

  static String get isValidPhone => "Format No HP salah.";
}
