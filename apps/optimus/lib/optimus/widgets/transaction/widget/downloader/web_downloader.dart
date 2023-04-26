import 'dart:html';

import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/downloader/transaction_download_interface.dart';

class WebDownloader implements TransactionDownloader {
  void downloadFile(List<int>? blobBytes, String fileName) {
    var blob = Blob([blobBytes], 'excel', 'native');

    AnchorElement(
      href: Url.createObjectUrlFromBlob(blob).toString(),
    )
      ..setAttribute("download", fileName)
      ..click();
  }
}

TransactionDownloader getDownloader() => WebDownloader();
