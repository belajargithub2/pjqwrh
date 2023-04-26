import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_cancel_transaction_controller.dart';

class BumblebeeCancelTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeCancelTransactionController());
  }
}
