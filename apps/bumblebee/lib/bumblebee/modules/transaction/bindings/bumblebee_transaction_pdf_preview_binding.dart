import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_pdf_preview_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';

class BumblebeeTransactionPdfPreviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BumblebeeTransactionRepository>(
        () => BumblebeeTransactionRepository());
    Get.lazyPut(
      () => BumblebeeTransactionPdfPreviewController(
        transactionRepository: Get.find(),
      ),
    );
  }
}
