abstract class ContentConstant {
  static const MEDIA_ENDPOINT = "/media/reference/20000/";
  static const PACKAGE_NAME = "com.kreditplus.deasy";
  static const DEALER_MANAGEMENT =
      "Dealer Management System (DEASY) adalah portal yang disediakan oleh Kreditplus bagi merchant-merchantnya dengan tujuan memudahkan transaksi pembayaran melalui Kreditplus.";
  static const DEASY_WELCOME = "Selamat Datang di DEASY!";
  static const VERIFICATION_ACCOUNT = "Verifikasi Akun";
  static const IS_DEVELOP = true;
  static const PO = "PO";
  static const EPO = "EPO";
  static const SNB = "SNB";
  static const BUKTI_TERIMA = "Bukti Terima";
  static const BAST = "BAST";
  static const IMEI = "IMEI";
  static const NOMOR_IMEI = "Nomor IMEI";
  static const INVOICE = "Invoice";
  static const CUSTOMER = "Customer";
  static const STATUS_PENGIRIMAN = "Status Pengiriman";
  static const AWB = "AWB";
  static const STATUS_ON_PROGRESS = "On Progress";
  static const STATUS_CANCEL_REQUEST = "Cancel Request";
  static const STATUS_CANCELED = "Canceled";
  static const STATUS_REJECT = "Rejected";
  static const STATUS_APPROVED = "Approved";
  static const STATUS_DISBURSED = "Disbursed";
  static const STATUS_PURCHASE_CONFIRMED = "Purchase Confirmed";
  static const STATUS_BI_CHECKING = "BI Checking";
  static const STATUS_ON_SURVEY = "On Survey";
  static const STATUS_CREDIT_PROCESS = "Credit Process";
  static const STATUS_PAID = "Paid";
  static const STATUS_INCOMING = "Incoming";
  static const TRACKING_STATUS_GOODS_BEING_PACKED = "Barang Dikemas";
  static const TRACKING_STATUS_GOODS_IN_DELIVERY = "Barang Dalam Pengiriman";
  static const TRACKING_STATUS_GOODS_IN_DESTINATION = "Barang Sampai Tujuan";
  static const LOGIN_EMAIL_IS_MUTIPLE = "DSY-01-005";
  static const LOGIN_PHONE_NUMBER_IS_MUTIPLE = "DSY-02-005";
  static const TITLE_LOGOUT = "Keluar dari Deasy";
  static const SUB_TITLE_LOGOUT = "Yakin ingin keluar?";

  static const ROLE_SUPER_ADMIN = "super admin";
  static const ROLE_MERCHANT = "merchant";
  static const ROLE_MERCHANT_EMPLOYEE = "merchant employee";
  static const ROLE_HELPDESK_SUPPORT = "helpdesk support";
  static const ROLE_AGENT = "agent";
  static const PENGAJUAN = "Pengajuan";

  static const DESCENDING = "desc";
  static const ASCENDING = "asc";

  static const ONE = 1;
  static const TWO = 2;
  static const THREE = 3;

  static const INITIAL_LIMIT = 10;
  static const INITIAL_PAGE = 1;
  static const FILTER_DATE_RANGE = 29;

  static const DASHBOARD_DOCUMENT_ACTION_FLAG_NONE = "none";
  static const DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW = "view";
  static const DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD = "upload";

  static String get dealerManagementEditted =>
      'Dealer Management berhasil diubah';

  static String get errorApiDefault =>
      'Maaf, sedang terjadi pemeliharaan pada sistem kami.';

  static String get bastCameraMessage =>
      "Pastikan kembali foto dokumen yang kamu masukkan benar dan semua bagian terlihat.";

  static String get receiptCameraMessage =>
      "Pastikan kembali barang yang diberikan terlihat jelas";

  static String get bastReviewMessage =>
      "Kamu perlu mengambil foto dokumen yang terlihat jelas";

  static String get receiptReviewMessage =>
      "Kamu perlu mengambil foto barang dan orang yang terlihat jelas";

  static String get imeiReviewMessage =>
      "Upload Nomor IMEI dengan mengambil foto Barcode IMEI yang terdapat pada box gedget";

  static String get trackingFlag => "track";

  static String get paidFlag => "payment";

  static String get kmobSpouseSurgateMotherNameTitle => "Nama Ibu Kandung";

  static String get kmobSpouseSurgateMotherNameHint =>
      "Nama Ibu Kandung Pasangan";

  static String get minDp => "Minimum uang muka";

  static String get dpShouldBeSmallerThanProductPrice =>
      "Mohon maaf, harap masukkan nominal uang muka lebih kecil dari harga barang.";

  static String get seeTenor => "Lihat Tenor";

  static String get editTenor => "Edit";

  static String get calculateTenor => "Hitung Tenor";

  static String get serviceUnavailable => "Server Sedang Maintence";

  static String get deleteNotifQuestionMark => 'Hapus ?';

  static String get errorRoleAccess =>
      "Mohon maaf layanan ini tidak tersedia untuk anda silakan login melalui website";

  static String get errorRoleAccessForWeb =>
      "Mohon maaf layanan ini tidak tersedia untuk anda silakan login melalui aplikasi mobile";

  static String get errorValidation => "Periksa data terlebih dahulu";

  static String get hasLogin =>
      "Akun ini sudah login di browser atau perangkat lain, Silakan logout terlebih dahulu sebelum melanjutkan";

  static String get badRequestLogin =>
      "Email yang Anda masukan tidak terdaftar / kata sandi Anda salah";

  static String get badRequestLoginEmailEmpty => "Email tidak boleh kosong";

  static String get emailNotValidOrRegistered =>
      "Email yang Anda masukan tidak terdaftar / Email tidak valid";

  static String get badRequestLoginPasswordEmpty =>
      "Kata Sandi tidak boleh kosong";

  static String get invalidEmailPassword =>
      "Email atau Kata Sandi yang Anda masukkan tidak sesuai";

  static String get badRequestLoginUsingPhoneNumber =>
      "Kode OTP yang Anda masukkan tidak sesuai";

  static String get requestOTPLimitTitle =>
      "Permintaan OTP Melebihi Batas";

  static String get requestOTPLimit =>
      "Mohon maaf. Kode OTP yang anda minta telah lebih dari 3x. Mohon menunggu untuk dapat mengirim ulang Kode OTP";

  static String get badRequestChangePassword =>
      "Kata sandi sudah pernah digunakan, silakan masukkan kata sandi yang lain.";

  static String get phoneCantNull => "No HP tidak boleh kosong.";

  static String get phoneValidation =>
      "Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka.";

  static String get subTitlePhoneNumberNotFound =>
      "Saat ini No. HP customer belum terdaftar.\nSilakan periksa kembali.";

  static String get isValidPhone => "Format No HP salah.";

  static String get invalidLoginPhoneNumber =>
      "Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka";

  static String get invalidLoginEmail =>
      "Email yang Anda masukan tidak terdaftar / Email tidak valid";

  static String get titlePhoneNumberNotFound => "No. HP Tidak Ditemukan";

  static String get cantEmptyPhoneNumber =>
      "Nomor Handphone tidak boleh kosong";

  static String get cantEmptyOtp => "OTP tidak boleh kosong";

  static String get subTitlePromoNotfound =>
      "Silakan lakukan verifikasi akun Kreditmu kamu\nmelalui aplikasi Kreditplus Mobile";

  static String get titlePromoNotfound => "Mohon Maaf, Promo Tidak Tersedia";

  static String get titleNeedVerification => "Mohon maaf,";

  static String get titleInsufficientLimit => "Limit tidak cukup";

  static String get subtitleInsufficientLimit =>
      "Limit yang kamu miliki tidak cukup, silakan ajukan barang sesuai dengan limit yang kamu miliki.";

  static String get subTitleNeedVerification =>
      "silakan minta konsumen untuk melakukan\nverifikasi akun kreditmu melalui aplikasi kreditplus mobile";

  static String get titleQrCodeRunOut => "Waktu scan QR Code telah berakhir.";

  static String get subTitleQrCodeRunOut => "Silakan buat pengajuan ulang";

  static String get correctValue => "Periksa Data kembali";

  static String get emptyProduct => "Kamu belum memilih barang.";

  static String get emptyPromo => "Promo harus dipilih";

  static String get errorPasswordFinansia =>
      "Kata Sandi tidak boleh mengandung Finansia";

  static String get errorPasswordCantBeEmpty => "Kata Sandi tidak boleh kosong";

  static String get errorNeedToFillForm => "Mohon isi semua form";

  static String get errorValidationNewPassword =>
      "Kata sandi Anda setidaknya minimal 6 karakter, tidak mengandung kata 'finansia', satu simbol (!@#^&*), satu huruf besar, satu huruf kecil dan satu angka";

  static String get minimumGoodPrice => "Minimal Harga Barang Rp. 1.500.000";

  static String get priceCantNull => "Harga Barang tidak boleh kosong.";

  static String get correctPriceGood =>
      "Mohon maaf, total pengajuan kamu diluar ketentuan. ";

  static String get paymentCantNull => "Pembayaran Awal tidak boleh kosong.";

  static String get dpNull => "Silahkan Pilih Kode Program Terlebih Dahulu.";

  static String get priceNull => "Silahkan isi Harga Barang terlebih dahulu";

  static String get dpCantBeMoreThanPrice =>
      "Mohon maaf, harap masukan pembayaran dimuka lebih kecil dari harga barang";

  static String get correctDpGood =>
      "DP tidak boleh lebih besar dari Nilai Pembiayaan";

  static String get labelOrder =>
      "Data Pesanan ini menunjukan produk yang akan customer ajukan cicilannya. Isi semua fieldnya ya.";

  static String get tutorialProfile =>
      'Kamu bisa mengelola profil akunmu di sini';

  static String get tutorialProfileAgent => 'Kelola profil akunmu di sini';

  static String get tutorialNotification =>
      'Kamu bisa melihat notifikasi di sini';

  static String get tutorialNotificationAgent => 'Lihat notifikasimu di sini';

  static String get tutorialUpload =>
      'Kamu dapat melihat daftar dokumen yang perlu kamu upload di sini';

  static String get tutorialSubmitOrderAgent =>
      'Buat formulir pengajuanmu di sini';

  static String get tutorialIncome =>
      'Kamu dapat melihat jumlah pendapatan kamu di sini';

  static String get tutorialIncomeAgent => 'Lihat performa kerjamu di sini';

  static String get tutorialTransactionReport =>
      'Kamu dapat melihat laporan transaksi kamu di sini';

  static String get tutorialOrderReport =>
      'Lihat daftar pengajuan kamu di sini';

  static String get tutorialOrder =>
      'Kamu dapat membuat data pesanan konsumen kamu di sini';

  static String get tutorialDraft =>
      'Lihat daftar formulir pengajuan yang belum kamu selesaikan di sini';

  static String get passwordChangedSuccess =>
      'Kata Sandi Anda telah berhasil diubah.';

  static String get locationNotFound => 'Lokasi tidak ditemukan';

  static String get needLocationFeature => 'Mohon Ijinkan Akses Lokasi anda';

  static String get needLocationPermission =>
      'Mohon izinkan akses lokasi untuk melanjutkan';

  static String get needLocationPermissionInSetting =>
      'Deasy memerlukan akses lokasi anda untuk pengajuan aplikasi via fitur Snap and Buy, data lokasi anda dibutuhkan untuk menghindari potensi pelanggaran pada aplikasi kami\n\nUntuk mengaktifkan lokasi, silahkan menuju ke menu setting > privacy > location > deasy, dan aktifkan lokasi anda';

  static String get seePromoMarketing => 'Lihat Promo Marketing';

  static String get typeToSearch => 'Ketik untuk mencari...';

  static String get usageInformationLimit => 'Informasi Penggunaan Limit';

  static String get makeSurePromoMarketing =>
      'Pastikan semua informasi yang tertampil dibawah ini sudah sesuai dengan pilihanmu';

  static String get howToUse => 'Cara Penggunaan:';

  static String get howToUse1 =>
      '1. Buka aplikasi Kreditplus Mobile di ponsel kamu';

  static String get howToUse3 =>
      '3. Arahkan ponsel kamu ke layar ini untuk mengambil kode barcode';

  static String get profQrCode =>
      'QR Code ini sebagai bukti tanda jadi barang yang customer ajukan cicilannya.';

  static String get verifyChangePassword =>
      'Mohon verifikasi diri kamu untuk melanjutkan proses ganti kata sandi';

  static String get insertEmailForgotPassword =>
      'Masukkan email untuk mengatur kata sandi baru';

  static String get errorValidationResponseMessage => 'error validation';

  static String get emailNotRegisteredResponseMessage =>
      'email tidak terdaftar';

  static String get emailNotRegisteredValidationMessage =>
      'Email anda tidak terdaftar. Mohon diperiksa kembali.';

  static String get backToProfile => 'Kembali ke Halaman Profile';

  static String get successUpdatePassword => 'Kata Sandi berhasil diperbarui';

  static String get errorValidationKMOBSubmission =>
      'Pastikan Data sudah terisi lengkap dan benar sebelum melanjutkan ke tahap berikutnya';

  static String get urlCantBeNull => 'URL harus diisi';

  static String get branchCantBeNull => 'Cabang tidak boleh kosong';

  static String get brandCantBeNull => 'Brand Kendaraan tidak boleh kosong';

  static String get supplierIdCantBeNull => 'Supplier ID tidak boleh kosong';

  static String get supplierIdSuggestion =>
      'Supplier ID dapat berisi huruf dan angka';

  static String get nameCantBeNull => 'Nama tidak boleh kosong';

  static String get msgNameMaxLength => 'Merupakan karakter berjumlah 1 - 50 huruf';

  static String get ktpCantBeNull => 'Nomor KTP tidak boleh kosong';

  static String get dateOfBirthCantBeNull => 'Tanggal Lahir tidak boleh kosong';

  static String get placeOfBirthCantBeNull => 'Tempat Lahir tidak boleh kosong';

  static String get genderCantBeNull => 'Jenis Kelamin tidak boleh kosong';

  static String get userNameCantBeNull => 'Nama User tidak boleh kosong';

  static String get userNameCantContainSpecialChar =>
      'Nama tidak boleh menggunakan spesial karakter';

  static String get motherNameCantBeNull =>
      'Nama Ibu Kandung tidak boleh kosong';

  static String get phoneNumberCantBeNull => 'Nomor Telepon tidak boleh kosong';

  static String get maritalStatusCantBeNull =>
      'Status Perkawinan tidak boleh kosong';

  static String get maritalStatusTitle => 'Pilih Status Perkawinan';

  static String get partnerNameCantBeNull => 'Nama Pasangan tidak boleh kosong';

  static String get vehicleModelCantBeNull =>
      'Model Kendaraan tidak boleh kosong';

  static String get vehicleTypeCantBeNull =>
      'Tipe Kendaraan tidak boleh kosong';

  static String get disbursedAmountCantBeNull =>
      'Nilai Pencairan tidak boleh kosong';

  static String get licenseAreaCantBeNull => 'Plat tidak boleh kosong';

  static String get licenseNumberCantBeNull =>
      'Nomor Kendaraan tidak boleh kosong';

  static String get licenseCodeCantBeNull => "Kode tidak boleh kosong";

  static String get extraTextCode =>
      "Merupakan rangkaian huruf akhir pada plat kendaraan";

  static String get extraLicenseNumber =>
      "Merupakan angka tengah pada plat kendaraan";

  static String get licenseYearCantBeNull =>
      "Tahun Kendaraan tidak boleh kosong";

  static String get licenseNumberMustBe4Digit =>
      "Data merupakan karakter angka dan tidak boleh lebih dari 4 karakter";

  static String get licenseAreaMustBe2Digit =>
      "Data merupakan karakter alfabet dan tidak boleh lebih dari 2 karakter";

  static String get licenseCodeMustBe3Digit =>
      "Data merupakan karakter alfabet dan tidak boleh lebih dari 3 karakter";

  static String get licenseStatusCantBeNull =>
      "Status Kepemilikan BPKB tidak boleh kosong";

  static String get makeSureThePhotoMustBeClear =>
      "Pastikan foto dokumen dapat terbaca dan\nterlihat jelas";

  static String get cameraPemission => "Mohon izinkan akses untuk kamera";

  static String get cameraAccessNotAllowed =>
      "Deasy belum mendapat izin mengakses kamera.\nSilahkan periksa pengaturan perangkat dan browser Anda.";

  static String get tryAgain => "Coba Lagi";

  static String get phoneNumberNotValid =>
      'Format Nomor Handphone harus diawali dengan 08, terdiri dari 9-14 angka';

  static String get ktpMustBe16Digit =>
      'Nomor KTP merupakan karakter angka dan terdiri dari 16 karakter';

  static String get nameSectionOneSnbMobile => 'Form Data\nPesanan';

  static String get nameSectionTwoSnbMobile => 'Promo\nMarketing';

  static String get nameSectionThreeSnbMobile => 'Pindai\nQR Code';

  static String get nameSectionOneSnbTab => 'Form Data\nPesanan';

  static String get nameSectionTwoSnbTab => 'Promo\nMarketing';

  static String get nameSectionThreeSnbTab => 'Pindai\nQR Code';

  static String get nameSectionOneSnbWeb => 'Form Data Pesanan';

  static String get nameSectionTwoSnbWeb => 'Promo Marketing';

  static String get nameSectionThreeSnbWeb => 'Pindai QR Code';

  static String get nameSectionOneKMOBSubmissionMobile => 'Form Data\nKonsumen';

  static String get nameSectionTwoKMOBSubmissionMobile => 'Form Data\nAset';

  static String get nameSectionThreeKMOBSubmissionMobile => 'Upload\nDokumen';

  static String get nameSectionOneKMOBSubmissionTab => 'Form Data\nPesanan';

  static String get nameSectionTwoKMOBSubmissionTab => 'Form Data\nAset';

  static String get nameSectionThreeKMOBSubmissionTab => 'Upload\nDokumen';

  static String get nameSectionOneKMOBSubmissionWeb => 'Form Data Konsumen';

  static String get nameSectionTwoKMOBSubmissionWeb => 'Form Data Aset';

  static String get nameSectionThreeKMOBSubmissionWeb => 'Upload Dokumen';

  static String get incomingIndicatorText => 'Baru';

  static String get biCheckingIndicatorText => 'BI Checking';

  static String get surveyIndicatorText => 'Survei';

  static String get creditProcessIndicatorText => 'Proses Kredit';

  static String get approvedIndicatorText => 'Disetujui';

  static String get rejectedIndicatorText => 'Ditolak';

  static String get disbursedIndicatorText => 'Terbayar';

  static String get disbursedIndicatorTextForAgent => 'Go-Live';

  static String get onProgressIndicatorText => 'Dalam Proses';

  static String get cancelRequestIndicatorText => 'Permintaan\nPembatalan';

  static String get purchaseConfirmedIndicatorText =>
      'Pembayaran\nDikonfirmasi';

  static String get activeCanceledIndicatorText => 'Dibatalkan';

  static String get inactiveCanceledIndicatorText => 'Terbatalkan';

  static String get orderStatusOnProgress => 'on progress';

  static String get orderStatusApproved => 'approved';

  static String get orderStatusRejected => 'rejected';

  static String get orderStatusCanceled => 'canceled';

  static String get orderStatusCancelRequest => 'cancel request';

  static String get orderStatusPurchaseConfirmed => 'purchase confirmed';

  static String get orderStatusPaid => 'paid';

  static String get orderStatusDisbursed => 'disbursed';

  static String get orderStatusIncoming => 'incoming';

  static String get orderStatusBIChecking => 'bi checking';

  static String get successUpload => "Berhasil Upload\nDokumen";

  static String get backToUploadList => "Kembali ke List Upload";

  static String get failedUploadDocument => "Maaf, Upload kamu gagal !";

  static String get successUploadDocument => "Yeiy, Upload kamu berhasil !";

  static String get addImage => "Tambahkan Foto";

  static String get takeImageFromCamera => "Ambil Foto";

  static String get photo => "Foto";

  static String get continueUpload => "Lanjut";

  static String get fromGallery => "Dari Galeri";

  static String get upload => "Upload File Lainnya";

  static String get documentReceipt => "Bukti Terima";

  static String get documentBast => "BAST";

  static String get documentImei => "IMEI";

  static String get uploadHere => "Upload Disini";

  static String get uploadButton => "Upload";

  static String get retakePhoto => "Foto Ulang";

  static String get reuploadPhoto => "Upload Ulang";

  static String get failedUpload => "Gagal Upload";

  static String get refillForm => "Isi Application Form Lagi";

  static String get reupload => "Upload Ulang";

  static String get dropFileHere => "Upload atau taruh file disini";

  static String get reuploadWarning =>
      "Foto tidak dapat diubah setelah ter-upload";

  static String get makeSureImage =>
      "Pastikan foto yang anda upload sudah tepat";

  static String get successOrder => "Pengajuan Konsumen\nBerhasil Terkirim";

  static String get uploadPhotoConfirmation => "Upload foto ini?";

  static String get successOrderDetail =>
      "Anda dapat melihat status\npengajuan pada menu Order";

  static String get backToHome => "Kembali ke Home";

  static String get readSubmission => "Lihat Pengajuan";

  static String get submitAgent => "Ajukan";

  static String get submitConsumer => "Ajukan Konsumen";

  static String get otherReason => 'Alasan Lain';

  static String get titleDraft => 'Ingin Menyimpan Data\nke Draft?';

  static String get detailDraft =>
      'Anda dapat melihat dan\nmelanjutkan pengisian data ini\npada menu Draft';

  static String get successSaveToDraft => 'Berhasil Menyimpan\nData ke Draft';

  static String get continueToOrder => 'Lanjut Pengisian Data';

  static String get seeDraft => 'Lihat Draft';

  static String get phoneNumberUnRegister => 'Nomor Handphone tidak terdaftar';

  static String get draftIsEmpty => 'Draft kamu masih kosong';

  static String get vehicleRegistrationNameCantBeNull =>
      'Nama pada STNK tidak boleh kosong';

  static String get dashboard => 'Dashboard';

  static String get dashboardTableHeaderTextOrder => 'Order';

  static String get dashboardTableHeaderTextApplication => 'Aplikasi';

  static String get dashboardTableHeaderTextDisbursement => 'Nilai Pencairan';

  static String get dashboardTableHeaderTextIncome => 'Pendapatan';

  static String get dashboardDailyAplicant => "Aplikan Hari ini";

  static String get dashboardDailyIncome => "Pendapatan Hari ini";

  static String get dashboardMonthlyAplicant => "Aplikan Bulan ini";

  static String get dashboardMonthlyIncome => "Pendapatan Bulan ini";

  static String get dashboardYearlyAplicant => "Aplikan Tahun ini";

  static String get dashboardYearlyIncome => "Pendapatan Tahun ini";

  static String get dashboardTotalOrder => "Total Order";

  static String get dashboardTotalDisbursement => "Total Pencairan";

  static String get sqanQRCode => 'Pindai QR Code';

  static String get expiredQrCode => 'Berlaku selama';

  static String get tryAgainCreateQrCode => 'Ulangi';

  static String get phoneNumberRegisteredOnKreditmu =>
      'No Hp yang Terdaftar di Akun Kreditmu';

  static String get backToDashBoard => 'Kembali ke Dashboard';

  static String get reOrderSnb => 'Ajukan Kembali';

  static String get dpLabel => 'Uang Muka';

  static String get dpLabelMobile => 'Down Payment';

  static String get orderData => 'Data Pesanan';

  static String get hintPhoneNumber => 'Cth: 08111111111';

  static String get price => 'Harga Barang';

  static String get selectItem => 'Pilih Barang';

  static String get phoneNumber => 'No Handphone';

  static String get registerAgentPhoneNumber => 'Nomor Handphone';

  static String get phoneNumberHint => 'Contoh: 08111111111';

  static String get optional => '(opsional)';

  static String get previewQrCode => 'Perbesar QR Code';

  static String get scanQrCode => 'Pindai QR Code';

  static String get promoMarketing => 'Promo Marketing';

  static String get specialOffer => 'Penawaran Special Untukmu';

  static String get selectPromo => 'Silakan pilih promo yang diinginkan';

  static String get tenorCantEmpty => 'Tenor harus dipilih';

  static String get selectTenor => 'Pilih Tenor';

  static String get searchProgramName => 'Cari Nama Program';

  static String get shoppingSummary => 'Ringkasan Belanja';

  static String get nameOfGoods => 'Nama Barang';

  static String get totalShopping => 'Total Belanja';

  static String get registerButtonText => 'Daftar';

  static String get registerAgent => 'Daftar Agent';

  static String get registerMerchant => 'Registrasi Merchant';

  static String get pleaseVerifyEmail => 'Silakan Verifikasi Email Anda';

  static String get checkEmailInbox =>
      'Periksa kotak masuk email Anda. Kami telah mengirimkan tautan verifikasi untuk mengatur kata sandi ke ';

  static String get hasReceiveEmail => 'Belum menerima email verifikasi?';

  static String get successSendVerificationEmail => 'Email verifikasi berhasil dikirim';

  static const String errorEmailNotVerified = 'Anda belum melakukan verifikasi email.';

  static String get loginEmailTab => 'Login Email';

  static String get loginPhoneTab => 'Login No. Hp';

  static String get login => 'Login';

  static String get phoneTextFieldLabel => 'No Hp';

  static String get sendOtp => 'Kirim OTP';

  static String get otpCode => 'Kode OTP';

  static String get isGetOtp => 'Belum mendapat kode OTP?';

  static String get resendOtp => 'Kirim Ulang OTP';

  //flag
  static String get flagAccountDeleted => 'deleted';

  //delete_account
  static String get tvAgree =>
      'Saya telah membaca dan menyetujui syarat & ketentuan Hapus Akun';

  static String get eCommerceClientKeyLabel => 'E-Commerce Client Key';

  static String get btnDeleteAccount => 'Hapus Akun';

  static String get termsDeleteAccount => 'Syarat & Ketentuan\nHapus Akun';

  static String get onLoading => 'Sedang Memuat...';

  static String get failLoad => 'Gagal Memuat!';

  static String get noString => '';

  static String get keyGetWordsDeleteAccount => 'tc_delete_account';

  static String get errorPasswordNotSame =>
      'Kata Sandi yang Anda masukkan tidak sama. Mohon periksa kembali.';

  static String get errorPasswordAlreadyUsed =>
      'Anda tidak bisa mengganti Kata Sandi ini, karena sudah pernah memakainya. Silakan coba Kata Sandi lain.';

  static String get errorPasswordAlreadyUsedResponse =>
      'password sudah pernah digunakan';

  static String get errorIncorrectPasswordResponse => 'incorrect password';

  static String get errorBadRequestResponse => 'bad request';

  static String get userManagementLabel => 'User Management';

  static String get subsidiDealerLabel => 'Subsidi Dealer';

  static String get userManagementAddUser => 'Tambah User Management';

  static String get userManagementEditUser => 'Edit User Management';

  static String get userManagementSuccessUpdateUser => 'User Berhasil Diubah';

  static String get userManagementSuccessAddUser => 'User Berhasil Dibuat';

  static String get userManagementBackLabel => 'Kembali ke User Management';

  static String get userManagementSearchByMerchantName =>
      'Cari berdasarkan nama merchant';

  static String get roleCantBeEmpty => 'Role harus dipilih';

  static String get merchantCantBeEmpty => 'Merchant harus dipilih';

  static String get nikHint => 'Cth : 1234567890123456';

  static String get nikLabel => 'NIK';

  static String get phoneNumberCantBeEmpty => 'No Handphone tidak boleh kosong';

  static String get emailHint => 'Cth : nama@email.com';

  static String get emailLabel => 'Email';

  static String get passwordLabel => 'Kata Sandi';

  static String get searchByProvince => "Cari berdasarkan nama provinsi";

  static String get emailCantBeEmpty => 'Email tidak boleh kosong';

  static String get rtCantBeEmpty => 'RT tidak boleh kosong';

  static String get rtCantless2 => 'RT minimal berisi 2 angka';

  static String get rtCantExceed3 => 'RT maksimal berisi 3 angka';

  static String get rwCantBeEmpty => 'RW tidak boleh kosong';

  static String get rwCantless2 => 'RW minimal berisi 2 angka';

  static String get rwCantExceed3 => 'RW maksimal berisi 3 angka';

  static String get lineOfBusinessLabel => 'Line of Business';

  static String get lineOfBusinessHint => 'Pilih Line of Business';

  static String get deaLobType => 'dea';

  static String get electronicLobName => 'elektronik';

  static String get lineOfBusinessCantBeNull =>
      'Line of Business tidak boleh kosong';

  static String get saveChangesLabel => 'Simpan Perubahan';

  static String get addUserLabel => 'Tambah User';

  static String get dashboardLabel => 'Dashboard';

  static String get roleManagementLabel => 'Role Management';

  static String get selectRole => 'Pilih Role';

  static String get transaction => 'Transaksi';

  static String get download => 'Unduh';

  static String get receipt => 'Bukti Terima';

  static String get downloadTransaction => 'Download Transaksi';

  static String get reportMessage =>
      'Dengan ini kamu akan otomatis mengetahui laporan.';

  static String get selectStatus => 'Pilih Status';

  static String get date => 'Tanggal';

  static String get failedReportDownload =>
      'Gagal unduh laporan, silahkan coba beberapa saat lagi.';

  static String get documentNotFound => 'Dokumen tidak ditemukan';

  static String get provinsiNotFound => 'Provinsi tidak ditemukan';

  static String get kotaNotFound => 'Kota/Kabupaten tidak ditemukan';

  static String get kecamatanNotFound => 'Kecamatan tidak ditemukan';

  static String get kelurahanNotFound => 'Kelurahan tidak ditemukan';

  static String get internalServerError => 'Terjadi kesalahan pada server';

  static String get sourceApplication => 'Source Application';

  static String get eformSourceApp => 'eform';

  static String get snbSourceApp => 'snb';

  static String get addApplication => 'Tambah Aplikasi';

  static String get search => 'Search';

  static String get dateCreated => 'Tanggal Dibuat';

  static String get dateUpdated => 'Tanggal Diperbaharui';

  static String get textCopied => 'Text berhasil di copy';

  static String get showZeroEntry => 'Menampilkan 0 dari 0 entri';

  static String get dataNotFound => 'Data tidak ditemukan';

  static String get merchantName => 'Nama Merchant';

  static String get ecommerceClientKey => 'E-Commerce Client Key';

  static String get addEcommerceClientKey => 'Tambah E-Commerce Client Key';

  static String get editEcommerceClientKey => 'Edit E-Commerce Client Key';

  static String get ecommerceEditSucces =>
      'E-Commerce Key telah berhasil diubah.';

  static String get ecommerceAddSucces =>
      'E-Commerce Key telah berhasil ditambahkan.';

  static String get addData => 'Tambah Data';

  static String get dealerManagementLabel => 'Dealer Management';

  static String get editDealerManagementLabel => 'Edit Dealer Management';

  static String get dealerDetail => 'Detail Dealer';

  static String get selectBranch => 'Pilih Branch';

  static String get selectCro => 'Pilih CRO';

  static String get selectChannel => 'Pilih Channel';

  static String get selectSourceApp => 'Pilih Source Application';

  static String get selectMethodConfirm => 'Pilih Metode Konfirmasi';

  static String get dealerId => 'Dealer ID';

  static String get dealerGroup => 'Dealer Group';

  static String get dealerName => 'Dealer Name';

  static String get dealerAddress => 'Alamat Dealer';

  static String get branch => 'Branch';

  static String get croName => 'CRO Name';

  static String get email => 'Email';

  static String get channel => 'Channel';

  static String get confirmMethod => 'Metode Konfirmasi';

  static String get userManagement => 'User Management';

  static String get supplierId => 'Supplier ID';

  static String get supplierName => 'Supplier Name';

  static String get userName => 'User Name';

  static String get role => 'Role';

  static String get created => 'Created';

  static String get apply => 'Apply';

  static String get clear => 'clear';

  static String get status => 'Status';

  static String get action => 'Aksi';

  static String get active => 'Aktif';

  static String get nonActive => 'Tidak Aktif';

  static String get orderStatus => 'Order Status';

  static String get prospectId => 'Prospect ID';

  static String get success => 'Sukses';

  static String get failed => 'Gagal';

  static String get callbacks => 'Callbacks';

  static String get callbackDetail => 'Detail Callback';

  static String get callbackType => 'Callback Type';

  static String get successMessage => 'Success resend callback';

  static String get failedMessage => 'Failed resend callback';

  static String get close => 'Tutup';

  static String get dealerIdHint => 'Cth : 01212121021';

  static String get merchantNameHint => 'Cth : PT TESTES';

  static String get merchantAddress => 'Alamat Merchant';

  static String get merchantAddressHint => 'Jl. Jendral Sudirman';

  static String get callCenterMessage =>
      'Silahkan menghubungi 1500565 untuk melakukan perubahan data, Terima kasih!';

  static String get nameValidation => 'Nama Tidak Valid';

  static String get versioning => 'Versioning';

  static String get iosVersionTitle => 'Mobile iOS Version';

  static String get androidVersionTitle => 'Mobile Android Version';

  static String get generate => 'Generate';

  static String get edit => 'Edit';

  static String get save => 'Simpan';

  static String get cancel => 'Batal';

  static String get back => 'Kembali';

  static String get successGenerateTitle => 'Berhasil Generate Versi Terbaru';

  static String get manageAccount => 'Kelola Akun';

  static String get notification => 'Notifikasi';

  static String get emptyNotif => 'Wah, notifikasi anda masih kosong';

  static String get exit => 'Keluar';

  static String get setting => 'Settings';

  static String get maintenance => 'Maintenance';

  static String get merchantLabel => 'Merchant';

  static String get snapNbuyModulLabel => 'Snap N Buy Modul';

  static String get allModulLabel => 'All Modul';

  static String get agentLabel => 'Agent';

  static String get orderFormModullabel => 'Order Form Modul';

  static String get activeLabel => 'Aktif';

  static String get inactiveLabel => 'Non Aktif';

  static String get changeSuccess => 'Perubahan Berhasil Tersimpan';

  static String get notFoundTitle => 'Oops!';

  static String get notFoundSubTitle =>
      'Halaman ini sedang tidak tersedia untuk saat ini.\nSilahkan kembali ke dashboard dan coba beberapa saat lagi';

  static String get notFoundMessage => '(error code: 404)';

  static String get searchLicenseArea => 'Cari kode area...';

  static String get orderId => 'Order ID';

  static String get noAwb => 'Nomor AWB';

  static String get logisticName => 'Nama Logistik';

  static String get deliveryTime => 'Waktu Kirim';

  static String get arrivedTime => 'Waktu Diterima';

  static String get receiverName => 'Nama Penerima';

  static String get shippingAddress => 'Alamat Penerima';

  static String get receiverMobilePhone => 'No. HP Penerima';

  static String get agreementNo => 'No Perjanjian Kredit';

  static String get paymentDate => 'Tanggal Pembayaran';

  static String get nominal => 'Nominal';

  static String get trackingStatus => 'Status Pengiriman';

  static String get cancelOrderDetailButtonText => 'Batalkan Order';

  static String get orderDate => 'Tanggal Pengajuan';

  static String get emptyDataBottomSheetText => 'Maaf data belum tersedia';

  static String get detail => 'Detail';

  static String get consumerName => 'Nama Konsumen';

  static String get marketingProgram => 'Program Marketing';

  static String get agentFee => 'Agent Fee';

  static String get viewReports => 'Lihat Laporan';

  static String get assetData => 'Data Asset';

  static String get vehicleBrand => 'Brand Kendaraan';

  static String get vehicleModel => 'Model Kendaraan';

  static String get vehicleType => 'Tipe Kendaraan';

  static String get uploadImeiWording => 'Yuk, segera upload Imei kamu';

  static String get uploadImeiLabel => 'Upload IMEI';

  static String get takeImageImeiFromLabel =>
      'Ambil foto barcode IMEI yang\nterdapat pada Box Gadget';

  static String get takeImageBuktiTerimaLabel =>
      'Kamu perlu mengambil foto konsumen\nyang sedang menerima barang\npesanannya secara jelas';

  static String get imeiNotFound => 'Foto IMEI Tidak Ditemukan';

  static String get name => 'Nama';

  static String get agentName => 'Nama Agent';

  static String get noKtp => 'Nomor KTP';

  static String get inputNoKtp => 'Masukkan Nomor KTP';

  static String get noKtpLength => 'Nomor KTP harus berisi 16 angka';

  static String get emailFinansiaHint => 'Contoh: finansia@email.com';

  static String get agentType => 'Jenis Agent';

  static String get carAgent => 'Agent Mobil';

  static String get sampleName => 'Cth : nama';

  static String get searchRole => 'Cari Role';

  static String get searchHint => 'Cari...';

  static String get sideItemDashboard => 'Dashboard';

  static String get sideItemSnapAndBuy => 'Snap And Buy';

  static String get sideItemSourceApplication => 'Source Application';

  static String get sideItemEcommerceClientKey => 'E-Commerce Client Key';

  static String get sideItemUserManagement => 'User Management';

  static String get sideItemSubsidiDealer => 'Subsidi Dealer';

  static String get sideItemCallbacks => 'Callbacks';

  static String get sideItemRoleManagement => 'Role Management';

  static String get sideItemDealerManagement => 'Dealer Management';

  static String get sideItemSettings => 'Settings';

  static String get sideSubItemSettingsVersioning => ' Versioning';

  static String get sideSubItemSettingsMaintenance => ' Maintenance';

  static String get emptyString => '';

  static String get forgotPassword => 'Lupa Kata Sandi';

  static String get emailInput => 'Masukkan Email';

  static String get emailVerification => 'Verifikasi Email';

  static String get emailNotValid => 'Email Tidak Valid';

  static String get urlNotValid => 'Url Tidak Valid';

  static String get successSent => 'Berhasil Dikirim';

  static String get understand => 'Oke, Saya Mengerti';

  static String get messageEmailVerify =>
      'Verifikasi email untuk pergantian Kata Sandi sudah kami kirimkan. Silakan lihat email kamu untuk lanjut mengatur kata sandi';

  static String get strong => 'Kuat';

  static String get weak => 'Lemah';

  static String get passwordRequired => 'Kata Sandi harus diisi';

  static String get passwordNotMatch => 'Kata Sandi baru tidak cocok';

  static String get passwordConfirmRequired =>
      'Konfirmasi Kata Sandi harus diisi';

  static String get newPasswordNotMatch => 'Kata Sandi baru tidak cocok';

  static String get passwordNotAllowed => 'Kata Sandi tidak sesuai ketentuan';

  //register resources
  static String get linkSent => 'Tautan Berhasil Terkirim';

  static String get registerSuccessMessage =>
      'Silakan periksa & klik tautan di email yang Anda daftarkan untuk melakukan pengaturan kata sandi baru dan menyelesaikan proses pendaftaran';

  static String get uderstand => 'Oke, Saya Mengerti';

  static String get verificationMessage =>
      'Silakan check email Anda untuk melanjutkan\nmemverifikasi pendaftaran Anda.';

  // Mobile Identifier Transaksi resources

  static const RESOURCES_ICON_QR_REFFERAL =
      "resources/images/icons/ic_qr_refferal.svg";

  static const RESOURCES_DUMMY_QR = "resources/images/qr_dummy.png";

  static String get qrRefferalTitle => 'QR Refferal';

  static String get qrRefferalSuccess => 'QR Refferal berhasil digunakan';

  static String get merchantUserManagement => 'Merchant User Management';

  static String get maxMerchantInfo =>
      'Maksimal Merchant Employee yang dapat ditambahkan adalah 3 employee';

  static String get verified => 'Terverifikasi';

  static String get waitingForVerification => 'Menunggu Verifikasi';

  static String get emptyMerchantEmployee => 'Kamu belum menambahkan Merchant Employee';

  static String get resendEmail => 'Kirim Ulang Email';

  static String get confirmDeleteUser => 'Apa kamu yakin untuk menghapus akun ini?';

  static String get successDelete => 'Berhasil Dihapus';
  
  static String get successSendEmail => 'Email Berhasil Dikirim';

  static String get addMerchantEmployee => 'Tambah Merchant Employee';

  static String get merchantUserNameHint => 'Nama Merchant User';

  static String get successAddMerchantEmployee => 'Merchant Employee Berhasil Ditambahkan';

  static String get qrBackToProfile => 'Kembali ke Profil';

  static String get qrHowToUse => 'Cara Penggunaan';

  static String get qrNumberOne =>
      'Buka aplikasi Kredit Plus Mobile di ponsel kamu';

  static String get qrNumberTwo =>
      'Isi form pengajuan limit di aplikasi Kredit Plus Mobile';

  static String get qrNumberthree =>
      'Pilih “Iya” pada bagian “Apakah kamu sedang berada di toko rekanan kami?”';

  static String get qrNumberFive =>
      'Arahkan ponsel kamu ke layar ini untuk mengambil QR Code';

  static String get qrTekanIcon => 'Tekan icon ';

  static String get qrUntukScan => ' untuk melakukan scan QR Code';

  static String get qrMuatUlang => 'Muat Ulang';

  // WEB Identifier Transaksi resources
  static String webQrHowToUse1 =
      '1. Buka aplikasi Kreditplus Mobile di ponsel kamu';
  static String webQrHowToUse2 =
      '2. Isi form pengajuan limit di aplikasi Kredit Plus Mobile';
  static String webQrHowToUse3 =
      '3. Pilih “Iya” pada bagian “Apakah kamu sedang berada di toko rekanan kami?”';
  static String webQrHowToUse5 =
      '5. Arahkan ponsel kamu ke layar ini untuk mengambil QR Code';

  //Profile resources
  static const String profileKey = 'Profile';
  static const String changePasswordKey = 'Ganti Kata Sandi';
  static const String qrRefferalKey = 'QR Refferal';

  static String get toLoginMenu => 'Ke Menu Login';

  static String get inputEmailForChangePassword =>
      'Masukkan email untuk melakukan perubahan Kata Sandi.';

  static String get verifChangePasswordMessage =>
      'Silahkan check email Anda untuk melanjutkan\nperubahaan Kata Sandi.';

  //Subsidi Dealer resources
  static const String hargaProdukOtr = 'Harga Produk OTR';
  static const String hargaNtf = 'Harga NTF';
  static const String hargaTotalOtr = 'Harga Total OTR';
  static const String subsidiAmount = 'Subsidi Amount';
  static const String rupiah = 'Rupiah';
  static const String approve = 'Approve';
  static const String searchByOrderid = 'Cari Order ID';
  static const String tanggalTransaksi = 'Tanggal Transaksi';
  static const String namaProduk = 'Nama Produk';

  static const String checkPhoneNumber =
      'Mohon maaf, Harap masukkan No HP yang valid antara 9 hingga 14 digit angka.';

  //dashboard cancel order
  static const String cancelOrderLabel =
      'Apakah anda yakin ingin melakukan cancel order ';
  static const String requestCancelOrder = 'Permintaan Pembatalan Order';
  static const String reasonCancelOrder = 'Alasan Pembatalan Order';
  static const String selectReasonCancelOrder = 'Pilih Alasan Cancel Order';
  static const String findReasonCancelOrder = 'Cari Alasan Cancel Order';
  static const String reasonCantBeEmpty = 'Alasan Cancel tidak boleh kosong';
  static const String cancelRequestCancelOrder = 'Batalkan';
  static const String sendRequestCancelOrder = 'Ajukan Pembatalan';
  static const String emptyReasonCancelOrder = 'Tidak ada data';

  static const String appsTotal = 'Total Aplikasi';
  static const String application = 'Aplikasi';
  static const String merchantNotFound = 'Merchant tidak ditemukan';

  //splashscreen
  static const String callOurHotline = 'Hubungi hotline kami di 1500605';
  static const String registeredAndSupervisedBy = 'Terdaftar dan\nDiawasi oleh';

  static const String select = 'Pilih';
  static const String urgent = 'PENTING!';
  static const String selectOtp = 'Pilih Metode\nPengiriman Kode OTP';
  static const String otpViaCall = 'Kirim melalui Panggilan';
  static const String otpViaSms = 'Kirim melalui SMS';
  static const String errorPhoneNotRegister = 'Nomor Handphone tidak terdaftar';
  static const String errorRequestLimit =
      'Permintaan otp melebihi batas. silakan coba kembali setelah 15 menit';
  static const String yourPhoneNotRegister =
      'Nomor handphone yang Anda masukkan tidak terdaftar. Mohon periksa kembali';
  static const String otpVerificationTitle = 'Verifikasi Kode OTP';
  static const String otpVerificationSubTitle = 'Kami akan melakukan panggilan ke nomor kamu. Panggilan ini tidak perlu dijawab';
  static const String callMe = 'Hubungi Saya';
  static const String phoneMistaken = 'Nomor handphone keliru?';
  static const String notReceivingOtp = 'Tidak menerima kode OTP?';
  static const String reLogin = 'Login Ulang';
  static const String loginPhoneTitle = 'Masuk dengan nomor\nhandphone terdaftar';
  static const String loginPhoneSubtitle = 'Untuk masuk ke akun Anda, kami akan mengirimkan kode OTP ke nomor tersebut';
  static const String loginPhoneHint = 'Contoh: 08123456****';

  // Agent Fee
  static const String agentFeeLabel = 'Agent Fee';
  static const String agentFeeSelectStartDate = 'Pilih tanggal awal';
  static const String agentFeeStartDateLabel = 'Tanggal Awal';
  static const String agentFeeStartDateCantBeEmpty = 'Tanggal Awal tidak boleh kosong';
  static const String agentFeeSelectEndDate = 'Pilih tanggal Akhir';
  static const String agentFeeEndDateLabel = 'Tanggal Akhir';
  static const String agentFeeEndDateCantBeEmpty = 'Tanggal Akhir tidak boleh kosong';
  static const String agentFeeEndDateBeforeStartDate = 'Tanggal Akhir merupakan waktu sesudah Tanggal Awal';
  static const String agentFeeShowAgentFee = 'Tampilkan Agent Fee';
  static const String agentFeeNoteLabel = 'Maksimal Rentang periode mutasi yang dapat dipilih adalah 30 hari dalam 3 Bulan ke belakang.';

  //agent detail fee
  static const String agentFeeDetailDownloadDocument = 'Unduh Dokumen';
  static const String agentFeeDetailDisbursement = 'Pencairan';
  static const String agentFeeDetailConsumerName = 'Nama Konsumen';
  static const String agentFeeDisbursement = 'DISBURSEMENT';
  static const String agentFeeMonthlyIncentive = 'MONTHLY_INCENTIVE';
  static const String agentFeeLoyalty = 'LOYALTY';
  static const String agentFeeDetailAsset = 'Asset';
  static const String agentFeeListEmptyTitle = 'Tidak ada Transaksi';
  static const String agentFeeListEmptySubTitle = 'Tidak ada transaksi pada periode yang Kamu pilih. Silakan pilih periode lainnya.';
  static const String agentFeeDetailDisbursementDate = 'Tanggal Pencairan';
  static const String agentFeeDetailDisbursementValue = 'Nilai Pencairan';
  static const String agentFeeDetailTotalAgentFee = 'Total Agent Fee';
  static const String agentFeeDetailMonthlyIntencive = 'Insentif Bulanan';
  static const String agentFeeDetailDescription = 'Deskripsi';
  static const String agentFeeDetailLoyalty = 'Loyalty';
  static const String agentFeeDetailRincianAgentFee = 'Rincian Agent Fee';

  static const String agentFeeDetailDownloadButtonOk = 'Unduh';
  static const String agentFeeDetailDownloadButtonCancel = 'Kembali';
  static const String agentFeeDetailHeaderCardItem = 'Detail';
  static const String agentFeeDetailButtonBottomSheet = 'Kembali';
  static const String agentFeeDetailTaxSheet = 'Pajak';

  static String get cancelActivation => 'Batalkan Proses Aktivasi?';
  static String get exitSubmission => 'Keluar dari Proses Pengajuan Konsumen?';
  static String get ensureExitSubmission => 'Jika kamu keluar dari tahap ini, maka proses pengajuan limit konsumen akan dibatalkan';
  static String get goHomeWithLimit => 'Kamu akan diarahkan ke Home, namun limit konsumen sudah diaktifkan.';
  static String get canceling => 'Batalkan';
  static String get continueProcess => 'Lanjutkan Proses';

  static String get titleLimitCategory => 'Snap and Buy Tidak tersedia untuk konsumen dengan tipe limit blue';
  static String get subTitleLimitCategory => 'Saat ini, Snap and Buy hanya tersedia untuk konsumen dengan tipe limit gold dan platinum';
}
