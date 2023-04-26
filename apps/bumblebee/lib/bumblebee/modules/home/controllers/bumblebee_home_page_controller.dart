import 'dart:io';

import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/config/fcm_config.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_container_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/repositories/bumblebee_dashboard_report_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/repositories/bumblebee_notification_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/transaction_status_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';

class BumblebeeHomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final BumblebeeHomeContainerController? homeContainerController;
  BumblebeeHomePageController({this.homeContainerController});

  final name = ''.obs;
  final totalOrder = 0.0.obs;
  RxInt countTransaction = 0.obs;
  final countUpload = 0.obs;
  final applicationByYear = 0.obs;
  final countNotif = 0.obs;
  final supplierId = ''.obs;
  final dashboardReportRepository =
      Get.find<BumblebeeDashboardReportRepository>();
  final listUploadRepository = Get.find<BumblebeeUploadPhotoRepository>();
  final notificationRepository = Get.find<BumblebeeNotificationRepository>();
  final settingRepository = Get.find<SettingsRepository>();
  final roleManagementRepository =
      Get.find<RoleManagementRepository>();
  String? roleId;
  TabController? tabController;
  final minAppVersionFromServer = ''.obs;
  RxString statusText = ''.obs;
  RxString role = "".obs;
  RxBool isMerchantOnline = false.obs;
  RxBool isBlue = false.obs;
  RxBool isLoading = true.obs;
  RxBool isAlreadyShowTutorial = false.obs;
  RxDouble containerHeight = 0.0.obs;
  DateTime timeBackPressed = DateTime.now();

  RxString stringAplikanInfo = "".obs;
  RxString stringIncomeInfo = "".obs;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];

  final _conNav = Get.put(BumblebeeHomeContainerController());

  GlobalKey keyInfo4 = GlobalKey();
  GlobalKey keyInfo1 = GlobalKey();
  GlobalKey keyInfo2 = GlobalKey();
  GlobalKey keyInfo3 = GlobalKey();

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() async {
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    DeasySizeConfigUtils().init(context: Get.context);
    checkAppVersion();
    getCountNotif();
    getLocalData();
    await getRoleId();
    await getRoleDetail();
    await getRole();
    await getCountUploadDoc();
    isLoading(false);
    super.onInit();
  }

  @override
  void onReady() {
    FirebaseConfig.openNotificationOnTerminated();
    super.onReady();
  }

  refreshHome() async {
    isLoading(true);
    await Future.delayed(Duration(milliseconds: 1200));
    DeasySizeConfigUtils().init(context: Get.context);
    checkAppVersion();
    getCountNotif();
    getLocalData();
    await getRoleId();
    await getRoleDetail();
    await getRole();
    await getCountUploadDoc();
    isLoading(false);
  }

  @override
  void dispose() {
    name.close();
    applicationByYear.close();
    supplierId.close();
    super.dispose();
  }

  getLocalData() async {
    await DeasyPocket().getSupplierId().then((value) {
      supplierId.value = value;
    });

    await DeasyPocket().getName().then((value) {
      name.value = value;
    });

    await DeasyPocket().isMerchantOnline().then((value) {
      isMerchantOnline(value);
    });
  }

  getRole() async {
    await DeasyPocket().getRole().then((value) {
      role.value = value;

      setAplicantIncomeText();

      if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
        containerHeight.value = DeasySizeConfigUtils.screenHeight! / 2.27;
      } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
        containerHeight.value = DeasySizeConfigUtils.screenHeight! / 1.36;
      }
    });
  }

  getRoleId() async {
    roleId = await DeasyPocket().getRoleId();
  }

  getRoleDetail() async {
    await roleManagementRepository
        .getDetailRoles(Get.context, {"role_id": roleId}).then((value) async {
      await DeasyPocket()
          .setOfflineAccess(value.data!.dashboardPermission!.offline!);
      await DeasyPocket()
          .setSnbAccess(value.data!.dashboardPermission!.snb!);
      await DeasyPocket()
          .setOnlineAccess(value.data!.dashboardPermission!.online!);
      await DeasyPocket()
          .setPOAccess(value.data!.dashboardPermission!.po!);
      await DeasyPocket()
          .setRequestCancel(value.data!.dashboardPermission!.requestCancel!);
      await DeasyPocket()
          .setInvoiceAccess(value.data!.dashboardPermission!.invoice!);
      await DeasyPocket()
          .setViewBASTAccess(value.data!.dashboardPermission!.viewBast!);
      await DeasyPocket().setViewBuktiTerimaAccess(
          value.data!.dashboardPermission!.viewBuktiTerima!);
      await DeasyPocket()
          .setViewImeiAccess(value.data!.dashboardPermission!.viewImei!);
      await DeasyPocket()
          .setUploadBASTAccess(value.data!.dashboardPermission!.uploadBast!);
      await DeasyPocket().setUploadBuktiTerimaAccess(
          value.data!.dashboardPermission!.uploadBuktiTerima!);
      await DeasyPocket()
          .setUploadImeiAccess(value.data!.dashboardPermission!.uploadImei!);
    });
  }

  void setAplicantIncomeText() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      stringAplikanInfo.value = ContentConstant.dashboardTotalOrder;
      stringIncomeInfo.value = ContentConstant.dashboardTotalDisbursement;
    }
  }

  void setStatusText() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      statusText.value = "Ajukan Konsumen";
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) &&
        countUpload.value == 0) {
      statusText.value = "Tidak ada yang perlu kamu upload";
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      statusText.value =
          "Ada ${countUpload.value} Dokumen yang perlu kamu upload";
    }
  }

  void setIsGrey() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      isBlue(true);
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) &&
        countUpload.value == 0) {
      isBlue(false);
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT) &&
        countUpload.value > 0) {
      isBlue(true);
    }
  }

  refreshData() async {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      await getCountNotif();
      await getCountUploadDoc();
    });
  }

  getCountNotif() async {
    await notificationRepository.getCountNotif(Get.context).then((value) {
      countNotif.value = value.notificationCountData!.count!;
    });
  }

  getCountUploadDoc() async {
    final hasBuktiTerimaAccess =
        await DeasyPocket().getUploadBuktiTerimaAccess();
    final hasBASTAccess = await DeasyPocket().getUploadBASTAccess();
    final hasImeiAccess = await DeasyPocket().getUploadImeiAccess();

    if (isMerchantOnline.isFalse &&
        ((hasBuktiTerimaAccess || hasBASTAccess || hasImeiAccess) &&
            role.value.contains(ContentConstant.ROLE_MERCHANT))) {
      await listUploadRepository
          .fetchAllListUploadPhoto(Get.context)
          .then((val) {
        countUpload.value =
            (hasBuktiTerimaAccess ? val.data!.bast!.length : 0) +
                (hasBASTAccess ? val.data!.buktiTerima!.length : 0) +
                (hasImeiAccess ? val.data!.imei!.length : 0);
      });
    }

    setStatusText();
    setIsGrey();
  }

  Future<bool> exitApp() {
    final different = DateTime.now().difference(timeBackPressed);
    final isExitWarning = different >= Duration(seconds: 2);
    timeBackPressed = DateTime.now();

    if (isExitWarning) {
      final message = "Press back again to exit";
      Get.snackbar("want to exit app ?", message);
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  showTutorial(BuildContext context) async {
    if (isAlreadyShowTutorial.isFalse && role.isNotEmpty) {
      isAlreadyShowTutorial(true);

      await Future.delayed(Duration(milliseconds: 1200));
      if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
        bool tutorialHasPassedAgent =
            await DeasyPocket().tutorialPassedAgent();
        bool isTutorialPassedAgent = !(tutorialHasPassedAgent == null ||
            tutorialHasPassedAgent == false);

        initTargetsAgent();
        if (isTutorialPassedAgent == false) {
          setTutorialCoachMark(context);
        }
      } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
        bool tutorialHasPassedMerchant =
            await DeasyPocket().tutorialPassedMerchant();
        bool isTutorialPassedMerchant = !(tutorialHasPassedMerchant == null ||
            tutorialHasPassedMerchant == false);

        initTargetsMerchant();
        if (isTutorialPassedMerchant == false) {
          setTutorialCoachMark(context);
        }
      }
    }
  }

  void setTutorialCoachMark(BuildContext context) {
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: DeasyColor.neutral800,
      alignSkip: Alignment.bottomLeft,
      skipWidget: skipWidget(),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () async {
        setTutorialPassed();
      },
      onSkip: () async {
        setTutorialPassed();
      },
    )..show(context: context);
  }

  void setTutorialPassed() async {
    final SharedPreferences sharedPreferences = await _prefs;
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      await sharedPreferences.setBool("is_tutorial_passed_agent", true);
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      await sharedPreferences.setBool("is_tutorial_passed_merchant", true);
    }
  }

  void addTargetFocus(String identify, GlobalKey key,
      AlignmentGeometry alignSkip, String text, ContentAlign align,
      {ShapeLightFocus? shape, double? radius}) {
    targets.add(
      TargetFocus(
        identify: identify,
        keyTarget: key,
        alignSkip: alignSkip,
        contents: [
          TargetContent(
            align: align,
            builder: (context, controller) {
              return Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(child: Text(text)),
                        circleArrowIcon()
                      ],
                    ),
                  ));
            },
          ),
        ],
        shape: shape,
        radius: radius,
      ),
    );
  }

  void initTargetsMerchant() {
    targets.clear();

    addTargetFocus("keyBottomNavigation1", keyInfo1, Alignment.bottomRight,
        ContentConstant.tutorialProfile, ContentAlign.bottom);

    addTargetFocus("keyBottomNavigation2", keyInfo2, Alignment.bottomRight,
        ContentConstant.tutorialNotification, ContentAlign.bottom);

    addTargetFocus("Target 0", keyInfo4, Alignment.bottomRight,
        ContentConstant.tutorialIncome, ContentAlign.bottom,
        shape: ShapeLightFocus.RRect, radius: 5);

    addTargetFocus("keyBottomNavigation3", keyInfo3, Alignment.bottomRight,
        ContentConstant.tutorialUpload, ContentAlign.bottom,
        shape: ShapeLightFocus.RRect, radius: 5);

    addTargetFocus("Target 2", _conNav.keyTrans, Alignment.topLeft,
        ContentConstant.tutorialTransactionReport, ContentAlign.top);

    addTargetFocus("Target 1", _conNav.keyFAB, Alignment.topLeft,
        ContentConstant.tutorialOrder, ContentAlign.top);
  }

  void initTargetsAgent() {
    targets.clear();

    addTargetFocus("keyBottomNavigation1", keyInfo1, Alignment.bottomRight,
        ContentConstant.tutorialProfileAgent, ContentAlign.bottom);

    addTargetFocus("keyBottomNavigation2", keyInfo2, Alignment.bottomRight,
        ContentConstant.tutorialNotificationAgent, ContentAlign.bottom);

    addTargetFocus("Target 0", keyInfo4, Alignment.bottomRight,
        ContentConstant.tutorialIncomeAgent, ContentAlign.bottom,
        shape: ShapeLightFocus.RRect, radius: 5);

    addTargetFocus("keyBottomNavigation3", keyInfo3, Alignment.bottomRight,
        ContentConstant.tutorialSubmitOrderAgent, ContentAlign.bottom,
        shape: ShapeLightFocus.RRect, radius: 5);

    addTargetFocus("Target 2", _conNav.keyOrder, Alignment.topLeft,
        ContentConstant.tutorialOrderReport, ContentAlign.top);

    addTargetFocus("Target 1", _conNav.keyDraft, Alignment.topLeft,
        ContentConstant.tutorialDraft, ContentAlign.top);
  }

  Widget circleArrowIcon() {
    return InkWell(
      onTap: () {
        tutorialCoachMark.next();
      },
      child: Container(
          width: DeasySizeConfigUtils.blockVertical * 5,
          height: DeasySizeConfigUtils.blockHorizontal! * 5,
          decoration: BoxDecoration(
              color: DeasyColor.neutral000,
              shape: BoxShape.circle,
              border: Border.all(color: DeasyColor.kpBlue300, width: 1.0)),
          child: Center(
              child: Icon(Icons.arrow_forward_ios_rounded,
                  color: DeasyColor.kpBlue300, size: DeasySizeConfigUtils.blockHorizontal! * 3))),
    );
  }

  Widget skipWidget() {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: DeasyColor.neutral000, borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Lewati",
                style: TextStyle(color: DeasyColor.kpYellow500),
              ),
            ),
          ),
        ],
      ),
    );
  }

  checkAppVersion() async {
    try {
      String platform = Platform.isAndroid ? "android" : "ios";
      SettingsResponse settingsResponse =
          await settingRepository.getAppVersion(Get.context, platform);
      minAppVersionFromServer.value = settingsResponse.data!.appVersion!;
    } catch (e) {
      print(e);
    }
  }

  navigate(bool isSubmit) {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) && isSubmit) {
      navigateToSubmitOrder();
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) && !isSubmit) {
      navigateToAgentFee();
    } else if (role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      navigateToUploadList();
    }
  }

  navigateToSubmitOrder() {
    AnalyticConfig().sendEventAccess("Dashboard_KMOB_Order");
    Get.toNamed(Routes.KMOB_SUBMISSION)!.then((isBackToHome) {
      if (isBackToHome) {
        homeContainerController!
            .selectedFab(BumblebeeHomeContainerController.DASHBOARD_SCREEN);
      } else {
        homeContainerController!
            .selectedFab(BumblebeeHomeContainerController.DRAFT_SCREEN);
      }
    });
  }

  navigateToAgentFee() {
    Get.toNamed(BumblebeeRoutes.AGENT_FEE);
  }

  navigateToUploadList() {
    AnalyticConfig().sendEventAccess("Dashboard_Upload_Document");
    Get.toNamed(Routes.LIST_UPLOAD)!.then((value) => refreshData());
  }

  Widget setStatus(String status) {
    switch (status) {
      case ContentConstant.STATUS_PURCHASE_CONFIRMED:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.purchaseConfirmedIndicatorText,
            labelColor: DeasyColor.kpBlue500,
            iconAsset:
                '${IconConstant.RESOURCES_ICON_PATH}ic_purchase_confirm.svg',
            backgroundColor: DeasyColor.kpBlue50,
          );
        }
      case ContentConstant.STATUS_CANCELED:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.activeCanceledIndicatorText,
            labelColor: DeasyColor.neutral500,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_cancel.svg',
            backgroundColor: DeasyColor.neutral50,
          );
        }
      case ContentConstant.STATUS_REJECT:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.rejectedIndicatorText,
            labelColor: DeasyColor.dmsF46363,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_reject.svg',
            backgroundColor: DeasyColor.dmsFFF1F1,
          );
        }
      case ContentConstant.STATUS_ON_PROGRESS:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.onProgressIndicatorText,
            labelColor: DeasyColor.kpYellow500,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_process.svg',
            backgroundColor: DeasyColor.kpYellow50,
          );
        }
      case ContentConstant.STATUS_APPROVED:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.approvedIndicatorText,
            labelColor: DeasyColor.dms2ED477,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_approve.svg',
            backgroundColor: DeasyColor.dmsEBFFF2,
          );
        }
      case ContentConstant.STATUS_INCOMING:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.incomingIndicatorText,
            labelColor: DeasyColor.sally600,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_new.svg',
            backgroundColor: DeasyColor.sally50,
          );
        }
      case ContentConstant.STATUS_DISBURSED:
        {
          return TransactionStatusWidget(
            labelText: role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)
                ? ContentConstant.disbursedIndicatorTextForAgent
                : ContentConstant.disbursedIndicatorText,
            labelColor: DeasyColor.sally900,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_melted.svg',
            backgroundColor: DeasyColor.sally50,
          );
        }
      case ContentConstant.STATUS_CANCEL_REQUEST:
        {
          return TransactionStatusWidget(
            labelText: ContentConstant.cancelRequestIndicatorText,
            labelColor: DeasyColor.neutral800,
            iconAsset: '${IconConstant.RESOURCES_ICON_PATH}ic_request_cancel.svg',
            backgroundColor: DeasyColor.neutral50,
          );
        }
      default:
        {
          return Text('-');
        }
    }
  }
}
