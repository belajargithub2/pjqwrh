import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kreditplus_deasy_website/optimus/modules/forgot_password/views/widgets/optimus_forgot_password_form_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/controllers/optimus_login_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_email/optimus_login_email_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/login/views/widgets/login_phone/step_1/optimus_login_phone_widget.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusLoginCardWidget extends StatefulWidget {
  @override
  _OptimusLoginCardWidgetState createState() => _OptimusLoginCardWidgetState();
}

class _OptimusLoginCardWidgetState extends State<OptimusLoginCardWidget>
    with AutomaticKeepAliveClientMixin {
  final OptimusLoginController controller = Get.find<OptimusLoginController>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    super.build(context);
    return Container(
      margin: DeasySizeConfigUtils.isMobile
          ? EdgeInsets.symmetric(horizontal: 2)
          : EdgeInsets.symmetric(
              horizontal: DeasySizeConfigUtils.isTab ? 50 : 110),
      height: DeasySizeConfigUtils.screenHeight,
      child: Column(
        mainAxisAlignment: DeasySizeConfigUtils.isMobile
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DeasySizeConfigUtils.isMobile
              ? SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.05,
                )
              : Container(),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                DeasySizeConfigUtils.isMobile ? Container() : Spacer(),
                Expanded(
                    child: Image.asset(ImageConstant.RESOURCES_IMAGE_KP_LOGO))
              ],
            ),
          ),
          Flexible(
              flex: 3,
              child: Obx(() => controller.showForgotPassword.isFalse
                  ? Container(
                      height: DeasySizeConfigUtils.screenHeight! / 1.5,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                        elevation: 0,
                        color: DeasyColor.neutral000,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TabBar(
                                  onTap: (index) {
                                    controller.sendLoginTabEvent(index);
                                  },
                                  unselectedLabelColor: DeasyColor.neutral400,
                                  indicatorColor: DeasyColor.neutral400,
                                  labelColor: DeasyColor.kpBlue500,
                                  controller: controller.tabController,
                                  labelStyle: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: "KBFGDisplayBold"),
                                  tabs: [
                                    Tab(
                                      text: ContentConstant.loginEmailTab,
                                    ),
                                    Tab(text: ContentConstant.loginPhoneTab),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: TabBarView(
                                  physics: NeverScrollableScrollPhysics(),
                                  controller: controller.tabController,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: OptimusLoginEmailWidget(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: OptimusLoginPhoneWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: DeasySizeConfigUtils.screenHeight! / 1.5,
                      child: OptimusForgotPasswordFormWidget())))
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
