import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/controllers/optimus_callback_detail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/views/widgets/optimus_callback_transaction_info.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/widgets/decoration.dart';
import 'package:kreditplus_deasy_website/core/widgets/divider.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:pretty_json/pretty_json.dart';

class OptimusCallbackDetailWeb
    extends GetView<OptimusCallbackDetailController> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnnotatedRegion<SystemUiOverlayStyle>(
          value: baseSystemUiOverlayStyle(),
          child: OptimusDrawerCustom(
              body: Stack(
            children: [
              Container(
                width: double.infinity,
                color: DeasyColor.neutral50,
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                child: SingleChildScrollView(
                  primary: false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _menuWidget(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                          SizedBox(width: 20),
                          DeasyTextView(
                              text: ContentConstant.callbackDetail,
                              fontSize: 20,
                              fontFamily: FontFamily.bold),
                        ],
                      ),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              DeasyTextView(
                                  text: ContentConstant.callbackType,
                                  fontSize: 20,
                                  fontFamily: FontFamily.bold),
                              SizedBox(height: 12.0),
                              controller.callbackDetailDataList.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return HorizontalDivider();
                                      },
                                      itemCount: controller
                                          .callbackDetailDataList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return OptimusCallbackTransactionInfo(
                                          callbackDetailData: controller
                                              .callbackDetailDataList[index],
                                          index: index,
                                          requestPayloadJson: prettyJson(
                                              controller
                                                  .callbackDetailDataList[index]
                                                  .requestPayload!
                                                  .toJson()),
                                          responsePayloadJson: prettyJson(
                                              controller
                                                  .callbackDetailDataList[index]
                                                  .responsePayload!
                                                  .toJson()),
                                        );
                                      })
                                  : Container(
                                      height:
                                          DeasySizeConfigUtils.screenHeight! /
                                              2,
                                      child: Center(
                                          child: DeasyTextView(
                                              text: ContentConstant
                                                  .dataNotFound))),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: controller.isLoading.value,
                  child: FullScreenSpinner())
            ],
          ))),
    );
  }

  Widget _menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.callbacks,
      menuNameThree: ContentConstant.callbackDetail,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: () {
        _drawerController.handleIcon();
        Get.back();
      },
    );
  }
}
