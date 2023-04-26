import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/repositories/optimus_subsidi_dealer_repository.dart';

class OptimusSubsidiDealerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OptimusSubsidiDealerRepository>(() => OptimusSubsidiDealerRepository());

    Get.lazyPut<OptimusDrawerCustomController>(() => OptimusDrawerCustomController());

    Get.lazyPut<OptimusSubsidiDealerController>(
      () => OptimusSubsidiDealerController(
        subsidiDealerRepo: Get.find(),
      ),
    );
    Get.lazyPut<OptimusSubsidiDealerTableController>(
      () => OptimusSubsidiDealerTableController(
        subsidiDealerRepository: Get.find(),
      ),
    );
  }
}
