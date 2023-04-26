import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/report/daily_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/report/monthly_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/views/report/yearly_page.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/agent_card_row.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/dashboard_card_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/widgets/income_card.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/connection_checker_widget.dart';
import 'package:upgrader/upgrader.dart';

class BumblebeeHomePage extends GetView<BumblebeeHomePageController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.exitApp,
      child: Theme(
          data: ThemeData(dialogBackgroundColor: DeasyColor.neutral000),
          child: Obx(() {
            return UpgradeAlert(
                upgrader: Upgrader(
                  willDisplayUpgrade: (
                      {required display,
                      minAppVersion,
                      installedVersion,
                      appStoreVersion}) {
                    if (display == false) controller.showTutorial(context);
                  },
                  showIgnore: false,
                  showLater: false,
                  shouldPopScope: () => false,
                  dialogStyle: UpgradeDialogStyle.material,
                  minAppVersion: controller.minAppVersionFromServer.value,
                  messages: UpgraderMessages(code: 'id'),
                ),
                child: buildBody());
          })),
    );
  }

  Widget buildBody() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: RefreshIndicator(
        onRefresh: () => controller.refreshHome(),
        child: SafeArea(
          child: ConnectionCheckerWidget(
              onRefresh: () => controller.refreshHome(),
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: DeasyColor.neutral000,
                    leading: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                      ),
                      child: SvgPicture.asset(
                        "${ImageConstant.RESOURCES_IMAGES_PATH}deasy_logo.svg",
                        width: DeasySizeConfigUtils.screenWidth! / 5,
                      ),
                    ),
                    elevation: 2,
                    actions: [
                      IconButton(
                        padding: EdgeInsets.all(16.0),
                        key: controller.keyInfo1,
                        icon: SvgPicture.asset(
                            "${IconConstant.RESOURCES_ICON_PATH}ic_profile.svg",
                            width: DeasySizeConfigUtils.blockVertical * 3.5,
                            height: DeasySizeConfigUtils.blockVertical * 3.5),
                        onPressed: () {
                          Get.toNamed(Routes.ACCOUNT);
                        },
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(BumblebeeRoutes.NOTIFICATION)!
                                .then((value) {
                              controller.getCountNotif();
                            });
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: SvgPicture.asset(
                                  "${IconConstant.RESOURCES_ICON_PATH}ic_notification.svg",
                                  width: DeasySizeConfigUtils.blockVertical * 3.5,
                                  height: DeasySizeConfigUtils.blockVertical * 3.5,
                                  key: controller.keyInfo2,
                                ),
                              ),
                              Obx(() => controller.countNotif.value != 0
                                  ? Positioned(
                                      top: 14,
                                      right: 14,
                                      child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                            controller.countNotif.value
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ))),
                                    )
                                  : SizedBox())
                            ],
                          ))
                    ],
                  ),
                  body: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IncomeCard(),
                          _cardWidget(),
                          TabBar(
                            unselectedLabelColor: DeasyColor.neutral400,
                            indicatorColor: DeasyColor.kpBlue600,
                            labelColor: DeasyColor.kpBlue600,
                            tabs: [
                              Tab(text: "Hari"),
                              Tab(text: "Bulan"),
                              Tab(text: "Tahun"),
                            ],
                            controller: controller.tabController,
                          ),
                          Obx(() => controller.isLoading.isFalse
                              ? Container(
                                  height: controller.containerHeight.value,
                                  child: TabBarView(
                                    physics: NeverScrollableScrollPhysics(),
                                    controller: controller.tabController,
                                    children: [
                                      DailyPage(),
                                      MonthlyPage(),
                                      YearlyPage(),
                                    ],
                                  ))
                              : SizedBox()),
                        ],
                      )))),
        ),
      ),
    );
  }

  _cardWidget() {
    if (controller.role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      return AgentCardRow();
    } else if (controller.isMerchantOnline.isFalse &&
        controller.role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      return DashboardCardWidget(
        prefixIcon: Icon(
          Icons.arrow_circle_up_rounded,
          size: 35,
          color: DeasyColor.neutral000,
        ),
        rightPosition: 10,
        circleWidth: DeasySizeConfigUtils.screenWidth! / 4,
        isBlue: controller.isBlue.value,
        text: controller.statusText.value,
        isSubmit: false,
        showButton: false,
      );
    } else {
      return SizedBox();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
