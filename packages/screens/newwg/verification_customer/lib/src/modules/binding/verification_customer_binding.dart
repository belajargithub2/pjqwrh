import 'package:get/get.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:verification_customer/src/modules/controller/verification_customer_controller.dart';

class VerificationCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewWgRepositoryImpl>(() => NewWgRepositoryImpl());

    Get.lazyPut<VerificationCustomerController>(() =>
        VerificationCustomerController(repository: Get.find<NewWgRepositoryImpl>()));
  }

}
