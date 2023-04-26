import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_logout/deasy_logout.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/qr_refferal_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/no_internet_checker_controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountController extends GetxController {
  final qrRefferalController = Get.find<QrRefferalController>();
  final userRepository = Get.find<UserRepository>();
  final noInternetController = Get.find<NoInternetCheckerController>();

  final merchantIdController = TextEditingController();
  final merchantPhoneController = TextEditingController();
  final merchantNameController = TextEditingController();
  final agentNameController = TextEditingController();
  final agentKtpController = TextEditingController();
  final agentPhoneNumberController = TextEditingController();

  final supplierOrAgentID = ''.obs;
  final isOnline = false.obs;
  final role = ''.obs;
  final userId = ''.obs;
  final versionApp = ''.obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void onInit() async {
    getVersion();
    await DeasyPocket().getUserId().then((value) {
      userId.value = value;
    });
    await DeasyPocket().isMerchantOnline().then((value) {
      if (value != null) isOnline.value = value;
    });
    await DeasyPocket().getRole().then((value) {
      role.value = value;
    });
    fetchUserById(Get.context, userId.value);
    await DeasyPocket().getSupplierIdOrAgentId().then((value) {
      supplierOrAgentID.value = value;
    });

    super.onInit();
  }

  void logout() {
    DeasyLogout().logout();
  }

  @override
  void dispose() {
    merchantIdController.clear();
    merchantNameController.clear();
    super.dispose();
  }

  void onTapQrRefferal() {
    qrRefferalController.onShowBottomSheet();
  }

  void fetchUserById(BuildContext? context, userId) async {
    await userRepository.getUserById(context, userId).then((value) {
      if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
        agentNameController.text = value.data!.agent!.name!;
        agentKtpController.text = value.data!.agent!.nik!;
        agentPhoneNumberController.text = value.data!.phoneNumber!;
      } else {
        merchantNameController.text = value.data!.supplier!.supplierName!;
        merchantIdController.text = value.data!.supplier!.supplierId!;
        merchantPhoneController.text = value.data!.phoneNumber!;
      }
    });
  }

  Future refreshProfilePageWhenInternetConnected() async {
    noInternetController.isLoading.toggle();
    await Future.delayed(Duration(milliseconds: 1200));
    fetchUserById(Get.context, userId.value);
    noInternetController.isLoading.toggle();
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    fetchUserById(Get.context, userId.value);
    refreshController.loadComplete();
  }

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionApp.value = packageInfo.version;
  }

  get goToDeleteAccountScreen => Get.toNamed(BumblebeeRoutes.DELETE_ACCOUNT);

  get goToMerchantUserManagementScreen => Get.toNamed(BumblebeeRoutes.MERCHANT_USER_MANAGEMENT);
}
