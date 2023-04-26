import 'package:deasy_config/deasy_config.dart';
import '../../main.dart';
import 'flavor_config_staging.dart';

void main() {
  setFlavor(StagingFlavorConfig());
  mainCommon();
}
