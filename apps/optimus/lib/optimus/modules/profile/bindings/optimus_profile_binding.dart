import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_profile_change_password_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_profile_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_web_qr_refferal_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/repositories/optimus_identifier_transaksi_repository.dart';
import 'package:deasy_repository/deasy_repository.dart';

class OptimusProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OptimusProfileController());
    Get.lazyPut(() => OptimusProfileChangePasswordController());
    Get.lazyPut(() => OptimusWebQrRefferalController());
    Get.lazyPut(() => OptimusIdentifierTransaksiRepository());
    Get.lazyPut(() => UserRepository());
  }
}
