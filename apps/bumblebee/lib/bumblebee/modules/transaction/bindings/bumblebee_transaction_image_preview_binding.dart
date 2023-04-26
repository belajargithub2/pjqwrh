import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_image_preview_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';

class BumblebeeTransactionImagePreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeTransactionRepository());
    Get.lazyPut(
      () => BumblebeeTransactionImagePreviewController(
        transactionRepository: Get.find(),
      ),
    );
  }
}
