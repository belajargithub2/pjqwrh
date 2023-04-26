import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/downloader/transaction_download_interface.dart';

class MobileDownloader implements TransactionDownloader {

  void downloadFile(List<int> blobBytes, String fileName) {

  }

}

TransactionDownloader getDownloader() => MobileDownloader();