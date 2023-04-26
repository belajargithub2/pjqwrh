import 'package:customer_confirmation/src/controller/customer_confirmation_controller.dart';
import 'package:get/get.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/controller/stepper_container_controller.dart';

class CustomerConfirmationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewWgRepository>(
      () => NewWgRepositoryImpl(),
    );
    Get.lazyPut<CustomerConfirmationController>(
      () => CustomerConfirmationController(),
    );
    Get.lazyPut<StepperContainerController>(
      () => StepperContainerController(),
    );
  }
}
