import 'package:deasy_config/deasy_config.dart';
import '../../main.dart';
import 'flavor_config_prod.dart';

void main() {
  setFlavor(ProdFlavorConfig());
  mainCommon();
}