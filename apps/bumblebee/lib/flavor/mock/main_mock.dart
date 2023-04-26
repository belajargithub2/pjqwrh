import 'package:deasy_config/deasy_config.dart';
import '../../main.dart';
import 'flavor_config_mock.dart';

void main() {
  setFlavor(MockFlavorConfig());
  mainCommon();
}