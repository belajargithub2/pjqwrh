import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_mobile_controller.dart';

class BumblebeeTransactionMobileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeTransactionMobileController());
  }
}
