import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/downloader/transaction_stub.dart'
    if (dart.library.io) 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/downloader/mobile_downloader.dart';

/// Class abstract ini diimplementasi pada class mobile/web downloader.
/// reason : fungsi/feature download memerlukan dart:html agar dapat berjalan,
/// sedangkan dart:html tidak akan bisa dipanggil jika kita meng-compile
/// mobile apps.
///
/// Class ini berfungsi agar dart:html tidak dipanggil saat kita men-compile
/// aplikasi android/ios.
abstract class TransactionDownloader {
  void downloadFile(List<int> blobBytes, String fileName) {}

  factory TransactionDownloader() => getDownloader();
}
