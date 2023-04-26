import 'package:deasy_config/deasy_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusRegisterDialog {
  void webDialog(String email) {
    Get.defaultDialog(
      backgroundColor: DeasyColor.neutral000,
      title: "",
      barrierDismissible: false,
      content: Container(
        width: Get.width / 3,
        height: Get.height / 2,
        child: Column(
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(Icons.clear, color: DeasyColor.neutral900),
                  onPressed: () {
                    AnalyticConfig()
                        .sendEvent("Register_Merchant_Verify_Email");
                    //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                    if (flavorConfiguration!.flavorName == "dev") {
                      Get.offAllNamed(
                        OptimusRoutes.EMAIL_VERIFICATION_PAGE,
                        parameters: {
                          "email": email,
                        }
                      );
                    } else {
                      Get.offAllNamed(OptimusRoutes.LOGIN);
                    }
                  },
                ),
                SizedBox(
                  width: 25,
                )
              ],
            ),
            Image.asset(
              ImageConstant.RESOURCES_IMAGE_COMPUTER,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                ContentConstant.verificationMessage,
                style: TextStyle(fontSize: 15, color: DeasyColor.neutral900),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}