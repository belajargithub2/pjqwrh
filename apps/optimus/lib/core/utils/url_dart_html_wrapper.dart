import 'package:universal_html/html.dart';

class UrlDartHtmlWrapper {
  String createObjectUrlFromBlob(Blob? blob) {
    return Url.createObjectUrlFromBlob(blob!);
  }
}
