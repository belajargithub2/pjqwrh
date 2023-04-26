import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/controllers/optimus_register_merchant_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/repositories/optimus_register_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/views/widgets/optimus_register_dialog.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';

class OptimusRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DynamicLinkConfig>(() => DynamicLinkConfig());
    Get.lazyPut<OptimusRegisterDialog>(() => OptimusRegisterDialog());
    Get.lazyPut<LocationRepository>(() => LocationRepository());
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<DeepLinkRepository>(() => DeepLinkRepository());
    Get.lazyPut<OptimusRegisterRepository>(() => OptimusRegisterRepository());

    Get.lazyPut(() => OptimusRegisterMerchantController());
    Get.lazyPut<LoadingController>(() => LoadingController());
  }
}
