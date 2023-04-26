import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_detail_transaction_controller.dart';

class BumblebeeDetailTransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BumblebeeDetailTransactionController());
  }
}
