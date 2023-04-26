import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/repositories/notification_repository.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/models/optimus_notification_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/widgets/optimus_drawer_item_appbar_open.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:kreditplus_deasy_website/core/model/side_menu/side_menu_model.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_menu_role_repository.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:newwg/config/data_config.dart';

class OptimusDrawerCustomController extends GetxController
    with SingleGetTickerProviderMixin {
  final isOpened = false.obs;
  final isShowLoading = false.obs;
  final isUserVerified = false.obs;
  final isUseSNB = false.obs;
  final isUseNewwg = false.obs;
  final isOpenDropdown = false.obs;
  final role = ''.obs;
  final username = ''.obs;
  final language = 'english'.obs;
  final email = ''.obs;
  final RxList<SideMenuModel> sideMenuList = <SideMenuModel>[].obs;
  late AnimationController animationController;
  late Animation<double> animation;
  final isPlaying = false.obs;
  GlobalKey btnKey = LabeledGlobalKey("button_icon");

  late OverlayEntry overlayEntry;
  Offset? buttonPosition;
  final isMenuOpen = false.obs;
  final isNotif = false.obs;
  final notificationRepository = NotificationRepository();
  final countNotif = 0.obs;
  ScrollController scrollController = ScrollController();
  final RxList<NotificationData> notifList = <NotificationData>[].obs;
  final page = 1.obs;
  final isTapped = false.obs;
  RxDouble bodyHeight = 0.0.obs;
  RxDouble bodyWidth = 0.0.obs;
  final Rx<OptimusMenuRoleRepository> menuRoleRepository =
      OptimusMenuRoleRepository().obs;

  @override
  void onInit() async {
    DeasySizeConfigUtils().init();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 0.0, end: .5).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    DeasyPocket().getName().then((val) {
      username.value = val;
      update();
    });

    isUseSNB.value = await DeasyPocket().getUseSnb();
    isUseNewwg.value = await DeasyPocket().getUseNewwg();
    getMenuByRole();

    DeasyPocket().getRole().then((val) {
      role.value = val;
    });

    fetchNotifList(context: Get.context);

    scrollController.addListener(() {
      loadMoreNotif();
    });

    handleIcon();
    addListener(() {});
    getCountNotif();
    update();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void getCountNotif() {
    countNotif.value = 0;
    notificationRepository.getCountNotif(Get.context).then((value) {
      countNotif.value = value.notificationCountData!.count!;
      update();
    });
  }

  void onTapReadNotif(context, index, requestBody) {
    isTapped.value = true;
    notifList[index].isRead = true;
    isTapped.value = false;
    notificationRepository.patchNotifRead(context, requestBody);
    Future.delayed(const Duration(milliseconds: 500), () {
      getCountNotif();
    });

    if (notifList[index].action == ActionNotification.EDIT_SUBMISSION) {
      goToEditSubmission(notifList[index].prospectId!);
      hiddenDropdownAppBar();
    }
  }

  void fetchNotifList(
      {BuildContext? context, Map<String, dynamic>? requestBody}) {
    notificationRepository
        .fetchNotificationList(context, requestBody)
        .then((value) {
      notifList.addAll(value.data!);
    });
    update();
  }

  void loadMoreNotif() {
    if (scrollController.position.extentAfter <= 0) {
      page.value += 1;
      update();
      var request = Map<String, dynamic>();
      request["limit"] = 10;
      request["page"] = page.value;
      fetchNotifList(context: Get.context, requestBody: request);
      update();
    }
  }

  Future<void> getMenuByRole() async {
    MenuPermission menuPermission = await DeasyPocket()
        .getMenuPermission()
        .then((value) => MenuPermission.fromJson(value));

    RoleData roleData = await DeasyPocket()
        .getRoleDetail()
        .then((value) => RoleData.fromJson(value));

    if (menuPermission != null) {
      bool isRoot = roleData.isRoot ?? false;
      bool sourceApplication = menuPermission.sourceApplication ?? false;
      bool merchantUserManagement = menuPermission.merchantUserManagement ?? false;
      bool ecommerceClientKey = menuPermission.ecommerceClientKey ?? false;
      bool userManagement = menuPermission.userManagement ?? false;
      bool callback = menuPermission.callback ?? false;
      bool roleManagement = menuPermission.roleManagement ?? false;
      bool dealerManagement = menuPermission.dealerManagement ?? false;
      bool subsidiDealer = menuPermission.subsidyDealer ?? false;

      sideMenuList.add(SideMenuModel(
          title: ContentConstant.sideItemDashboard,
          route: Routes.DASHBOARD_WEB,
          icon: IconConstant.RESOURCES_ICON_DASHBOARD_SIDEBAR));

      if (isUseNewwg.value) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.submission,
            route: OptimusRoutes.CONFIRMATION_CUSTOMER_NEWWG,
            icon: IconConstant.RESOURCES_ICON_ADD));
      }

      if (isUseSNB.isTrue) {
        sideMenuList.add(SideMenuModel(
          title: ContentConstant.sideItemSnapAndBuy,
          route: OptimusRoutes.SNAP_AND_BUY_WEB,
          icon: IconConstant.RESOURCES_ICON_SNAP_AND_BUY_SIDEBAR,
        ));
      }

      if (sourceApplication) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemSourceApplication,
            icon: IconConstant.RESOURCES_ICON_SOURCE_APPLICATION_SIDEBAR,
            route: OptimusRoutes.SOURCE_APPLICATION));
      }

      if (ecommerceClientKey) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemEcommerceClientKey,
            route: OptimusRoutes.ECOMMERCE_CLIENT_KEY,
            icon: IconConstant.RESOURCES_ICON_ECOMMERCE_CLIENT_KEY_SIDEBAR));
      }

      if (userManagement) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemUserManagement,
            route: OptimusRoutes.USER_MANAGEMENT,
            icon: IconConstant.RESOURCES_ICON_USER_MANAGEMENT_SIDEBAR));
      }

      if (subsidiDealer) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemSubsidiDealer,
            route: OptimusRoutes.SUBSIDI_DEALER,
            icon: IconConstant.RESOURCES_ICON_ROLE_MANAGEMENT_SIDEBAR));
      }

      if (callback) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemCallbacks,
            route: OptimusRoutes.CALLBACK,
            icon: IconConstant.RESOURCES_ICON_CALLBACK_SIDEBAR));
      }

      if (roleManagement) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemRoleManagement,
            route: OptimusRoutes.ROLE_MANAGEMENT,
            icon: IconConstant.RESOURCES_ICON_ROLE_MANAGEMENT_SIDEBAR));
      }

      if (dealerManagement) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemDealerManagement,
            route: Routes.DEALER_MANAGEMENT,
            icon: IconConstant.RESOURCES_ICON_DEALER_MANAGEMENT_SIDEBAR));
      }

      //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
      if (merchantUserManagement &&
          flavorConfiguration!.flavorName == "dev") {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemMerchantUserManagement,
            route: OptimusRoutes.MERCHANT_USER_MANAGEMENT,
            icon:
                IconConstant.RESOURCES_ICON_MERCHANT_USER_MANAGEMENT_SIDEBAR));
      }

      if (isRoot) {
        sideMenuList.add(SideMenuModel(
            title: ContentConstant.sideItemSettings,
            icon: IconConstant.RESOURCES_ICON_SETTINGS_SIDEBAR,
            route: ContentConstant.emptyString,
            child: [
              SideMenuModel(
                title: ContentConstant.sideSubItemSettingsVersioning,
                route: OptimusRoutes.VERSIONING,
                icon: ContentConstant.emptyString,
              ),
              SideMenuModel(
                title: ContentConstant.sideSubItemSettingsMaintenance,
                route: OptimusRoutes.MAINTENANCE,
                icon: ContentConstant.emptyString,
              ),
              SideMenuModel(
                title: ContentConstant.sideSubItemSettingsAutomail,
                route: OptimusRoutes.AUTOMAIL,
                icon: ContentConstant.emptyString,
              ),
            ]));
      }
    }
  }

  void handleIcon() {
    if (animationController.isDismissed) {
      animationController.forward();
      isOpened.value = true;
      update();
    } else {
      animationController.reverse();
      isOpened.value = false;
      update();
    }
    calculateSizeScreen();
  }

  void onTapMenu(BuildContext context) async {
    if (isMenuOpen.isTrue) {
      overlayEntry.remove();
    } else {
      overlayEntry = overlayEntryBuilder();
      Overlay.of(context)?.insert(overlayEntry);
    }
    isMenuOpen.toggle();
    update();
  }

  OverlayEntry overlayEntryBuilder() {
    return OverlayEntry(
      builder: (_) {
        return Positioned(
          top: 65,
          right: isNotif.isTrue ? 180 : 20,
          width: isNotif.isTrue ? 330 : 200,
          child: OptimusDrawerItemOpen(
              username: username.value,
              role: role.value,
              isNotif: isNotif.value,
              hiddenAppBar: () {
                hiddenDropdownAppBar();
              }),
        );
      },
    );
  }

  void hiddenDropdownAppBar() {
    if (isMenuOpen.isTrue) {
      overlayEntry.remove();
      isMenuOpen.value = false;
      update();
    }
  }

  void calculateSizeScreen() {
    DeasySizeConfigUtils.isMobile
        ? isOpened.isFalse
            ? bodyWidth.value = DeasySizeConfigUtils.screenWidth! - 10
            : bodyWidth.value = DeasySizeConfigUtils.screenWidth! -
                DeasySizeConfigUtils.screenWidth! / 7
        : DeasySizeConfigUtils.isTab
            ? isOpened.isFalse
                ? bodyWidth.value = DeasySizeConfigUtils.screenWidth! -
                    DeasySizeConfigUtils.screenWidth! / 10
                : bodyWidth.value = DeasySizeConfigUtils.screenWidth! -
                    DeasySizeConfigUtils.screenWidth! / 3.5
            : isOpened.isFalse
                ? bodyWidth.value = DeasySizeConfigUtils.screenWidth! -
                    DeasySizeConfigUtils.screenWidth! / 9
                : bodyWidth.value = DeasySizeConfigUtils.screenWidth! -
                    DeasySizeConfigUtils.screenWidth! / 4.8;
  }

  void goToDashboard() {
    hiddenDropdownAppBar();
    Get.back();
    Get.offNamed(Routes.DASHBOARD_WEB);
  }

  void goToEditSubmission(String prospectID) {
    DataConfig.instance.prospectId = prospectID;
    DataConfig.instance.isShowIndicator = false;
    DataConfig.instance.isEditOrder = true;
    Get.toNamed(OptimusRoutes.HUMAN_VERIFICATION_NEWWG);
  }

  void showLoading() {
    isShowLoading.value = true;
  }

  void hideLoading() {
    isShowLoading.value = false;
  }
}
