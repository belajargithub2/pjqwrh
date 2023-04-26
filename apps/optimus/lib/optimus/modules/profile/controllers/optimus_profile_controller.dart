import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_web_qr_refferal_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/views/optimus_profile_new_password_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/views/optimus_profile_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/views/optimus_web_qr_refferal_screen.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class OptimusProfileController extends GetxController {
  final userRepository = Get.find<UserRepository>();
  final webQrRefferalController = Get.find<OptimusWebQrRefferalController>();

  final merchantIdController = TextEditingController();
  final merchantPhoneController = TextEditingController();
  final merchantNameController = TextEditingController();
  final merchantAddressController = TextEditingController();

  final activeTab = 'Profile'.obs;
  final userId = ''.obs;
  final isMerchantOnline = false.obs;
  final role = ''.obs;
  final showQrRefferal = true.obs;
  final activeScreens = Rx<StatelessWidget>(OptimusProfileScreen());

  @override
  void onInit() async {
    await DeasyPocket().getUserId().then((value) {
      userId.value = value;
    });

    await DeasyPocket().isMerchantOnline().then((value) {
      if (value != null) isMerchantOnline.value = value;
    });
    await DeasyPocket().getRole().then((value) {
      role.value = value;
    });

    isQrRefferalShowed();

    super.onInit();
  }

  @override
  void onReady() {
    fetchUserById(Get.context, userId.value);
    super.onReady();
  }

  void setActiveTab(String value) {
    activeTab(value);
    switch (value) {
      case ContentConstant.profileKey:
        activeScreens(OptimusProfileScreen());
        break;
      case ContentConstant.changePasswordKey:
        activeScreens(OptimusProfileNewPasswordScreen());
        break;
      case ContentConstant.qrRefferalKey:
        activeScreens(OptimusWebQrRefferalScreen());
        break;
      default:
    }
  }

  void isQrRefferalShowed() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) ||
        isMerchantOnline.isTrue) {
      showQrRefferal(false);
    }
  }

  void fetchUserById(BuildContext? context, userId) async {
    try {
      await userRepository.getUserById(context, userId).then((value) {
        merchantNameController.text = value.data!.supplier!.supplierName!;
        merchantIdController.text = value.data!.supplier!.supplierId!;
        merchantPhoneController.text = value.data!.phoneNumber!;
      });
    } catch (e) {
      print(e);
    }
  }
}
