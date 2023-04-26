import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/controllers/bumblebee_register_merchant_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/views/widgets/register_dialog.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/register/controllers/bumblebee_register_agent_controller.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/loading/loading_controller.dart';

class BumblebeeRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<RegisterDialog>(() => RegisterDialog());
    Get.lazyPut<LocationRepository>(() => LocationRepository());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<MerchantRepository>(() => MerchantRepository());

    Get.lazyPut(() => BumblebeeRegisterMerchantController());

    Get.lazyPut<BumblebeeRegisterAgentController>(
      () => BumblebeeRegisterAgentController(
        userRepository: Get.find<UserRepository>(),
      ),
    );

    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}
