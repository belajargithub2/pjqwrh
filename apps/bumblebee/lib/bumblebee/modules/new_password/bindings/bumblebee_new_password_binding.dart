import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/new_password/controllers/bumblebee_new_password_controller.dart';

class BumblebeeNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepository());
    Get.put(
      BumblebeeNewPasswordController(
        authRepository: Get.find(),
      ),
    );
  }
}
