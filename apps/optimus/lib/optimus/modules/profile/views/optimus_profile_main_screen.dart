import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/profile/controllers/optimus_profile_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusProfileMainScreen extends GetView<OptimusProfileController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            color: DeasyColor.neutral50,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 32),
            child: Card(
              color: DeasyColor.neutral000,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Container(
                margin: EdgeInsets.all(24),
                child: Obx(
                  () => Column(
                    children: [
                      DeasySizeConfigUtils.isMobile
                          ? Row(
                              children: [
                                _customIconButton(
                                  ContentConstant.profileKey,
                                  Icons.person,
                                ),
                                SizedBox(width: 10),
                                _customIconButton(
                                  ContentConstant.changePasswordKey,
                                  Icons.password,
                                ),
                                SizedBox(width: 10),
                                controller.showQrRefferal.value
                                    ? _customIconButton(
                                        ContentConstant.qrRefferalKey,
                                        Icons.qr_code,
                                      )
                                    : SizedBox(),
                              ],
                            )
                          : Row(
                              children: [
                                _textButtonTab(ContentConstant.profileKey),
                                const SizedBox(width: 10),
                                _textButtonTab(
                                    ContentConstant.changePasswordKey),
                                const SizedBox(width: 10),
                                controller.showQrRefferal.value
                                    ? _textButtonTab(
                                        ContentConstant.qrRefferalKey)
                                    : SizedBox(),
                              ],
                            ),
                      controller.activeScreens.value,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _textButtonTab(String key) {
    return Container(
      child: DeasyCustomButton(
        text: key,
        color: controller.activeTab.value == key
            ? DeasyColor.kpYellow500
            : DeasyColor.neutral000,
        colorText: controller.activeTab.value == key
            ? DeasyColor.neutral000
            : DeasyColor.neutral900,
        onPressed: () {
          controller.setActiveTab(key);
          if (key == ContentConstant.qrRefferalKey)
            controller.webQrRefferalController.onShowQrRefferalTab();
        },
      ),
    );
  }

  Widget _customIconButton(String key, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: controller.activeTab.value == key
            ? DeasyColor.kpYellow500
            : DeasyColor.neutral000,
        border: Border.all(
          color: DeasyColor.kpYellow500,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        onPressed: () {
          controller.setActiveTab(key);
          if (key == ContentConstant.qrRefferalKey)
            controller.webQrRefferalController.onShowQrRefferalTab();
        },
        icon: Icon(icon),
        color: controller.activeTab.value == key
            ? DeasyColor.neutral000
            : DeasyColor.kpYellow500,
      ),
    );
  }
}
