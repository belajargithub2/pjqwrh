import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/repositories/bumblebee_snap_n_buy_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/views/draft_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/bumblebee_home_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/views/bumblebee_transaction_mobile.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BumblebeeHomeContainerController extends GetxController {
  final selectedIndex = 0.obs;
  final isSnb = false.obs;
  final isMerchantOnline = true.obs;
  final keyFAB = GlobalKey();
  final keyTrans = GlobalKey();
  final keyOrder = GlobalKey();
  final keyDraft = GlobalKey();
  final RxList<Widget> isAdminList = <Widget>[].obs;
  final RxList<Widget> isMerchantList = <Widget>[].obs;
  final RxList<Widget> isSnbList = <Widget>[].obs;
  final lastSelected = ''.obs;
  final supplierId = ''.obs;
  final branchId = ''.obs;
  final role = ''.obs;
  final isNewWg = false.obs;
  static const DASHBOARD_SCREEN = 0;
  static const ORDER_SCREEN = 1;
  static const DRAFT_SCREEN = 2;
  MerchantRepository? merchantRepository;
  ECommerceClientKeyRepository? eCommerceClientKeyRepository;
  BumblebeeSnapNBuyRepository? snapNBuyRepository;

  @override
  void onInit() async {
    merchantRepository = MerchantRepository();
    eCommerceClientKeyRepository = ECommerceClientKeyRepository();
    snapNBuyRepository = BumblebeeSnapNBuyRepository();

    await DeasyPocket().getRole().then((value) {
      role.value = value;
    });

    await DeasyPocket().getSupplierId().then((val) {
      supplierId.value = val;
    });

    await DeasyPocket().getBranchId().then((val) {
      branchId.value = val;
    });

    await DeasyPocket().isMerchantOnline().then((val) {
      isMerchantOnline.value = val;
      update();
    });

    await DeasyPocket().getUseNewwg().then((val){
      isNewWg(val);
    });

    super.onInit();
  }

  @override
  void onReady() {
    checkIsSnb();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void selectedFab(int index) {
    selectedIndex.value = index;
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) ||
        role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE)) {
      checkIsSnb();
    }
  }

  Widget selectedWidget(int index) {
    if (index == 0) {
      return BumblebeeHomePage();
    } else if (index == 1) {
      AnalyticConfig().sendEventAccess("Dashboard_Transaction");
      return BumblebeeTransactionMobile();
    } else {
      return DraftScreen();
    }
  }

  void checkIsSnb() async {
    if (!role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      snapNBuyRepository!
          .fetchApiSnapNBuySettings(
              Get.context, supplierId.value, branchId.value)
          .then((value) async {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setBool("is_show_dp", value.data!.isShowDp!);
        value.data!.toSharedPref();
        isSnb.value = value.data!.useSnb!;
      }).catchError((onError) {
        isSnb.value = false;
        update();
      });
    }
  }

  void getEcommerceClientKey(String supplierId) async {
    await eCommerceClientKeyRepository!
        .fetchApClientBySupplierKey(Get.context, null, supplierId)
        .then((value) {
      if (value.data!.key!.length > 0 && isMerchantOnline.isFalse) {
        isSnb.value = true;
      } else {
        isSnb.value = false;
      }
      update();
    }).catchError((onError) {
      isSnb.value = false;
      update();
    });
  }

  navigateToSnbOrNewwg() {
    if(isNewWg.isTrue){
    Get.toNamed(BumblebeeRoutes.CONFIRMATION_CUSTOMER_NEW_WG);
    } else {
      Get.toNamed(BumblebeeRoutes.SNAP_AND_BUY_WEB);
    }
  }
}
