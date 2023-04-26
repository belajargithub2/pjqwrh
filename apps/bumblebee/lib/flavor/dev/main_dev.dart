import 'package:deasy_config/deasy_config.dart';

import '../../main.dart';
import 'flavor_config_dev.dart';

void main() {
  setFlavor(DevFlavorConfig());
  mainCommon();
}