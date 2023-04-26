import 'package:additional_documents/additional_documents.dart';
import 'package:get/get.dart';
import 'package:order/order.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/stepper.dart';
import 'package:verification_customer/verification_customer.dart';

class StepperContainerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewWgRepositoryImpl());
    Get.put(StepperContainerController());
    Get.lazyPut(() => AdditionalDocumentsController());
    Get.lazyPut(() => VerificationCustomerController(repository: Get.find<NewWgRepositoryImpl>()));
    Get.lazyPut(() => OrderController(repository: Get.find<NewWgRepositoryImpl>()));
  }
}
