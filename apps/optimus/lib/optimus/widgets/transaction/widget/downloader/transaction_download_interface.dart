import 'transaction_stub.dart'
    if (dart.library.html) 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/downloader/web_downloader.dart';

/// Class abstract ini diimplementasi pada class mobile/web downloader.
/// reason : fungsi/feature download memerlukan dart:html agar dapat berjalan,
/// sedangkan dart:html tidak akan bisa dipanggil jika kita meng-compile
/// mobile apps.
///
/// Class ini berfungsi agar dart:html tidak dipanggil saat kita men-compile
/// aplikasi android/ios.
abstract class TransactionDownloader {
  void downloadFile(List<int>? blobBytes, String fileName) {}

  factory TransactionDownloader() => getDownloader();
}
