library deasy_service;
import 'package:flutter/foundation.dart';

abstract class IAppService {
  bool getkIsWeb();
}

class DeasyService implements IAppService {
  bool getkIsWeb() {
    return kIsWeb;
  }
}
