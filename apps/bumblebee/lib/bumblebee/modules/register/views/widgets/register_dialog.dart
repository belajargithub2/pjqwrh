import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';

class RegisterDialog {
  void mobileDefaultDialog({String? email}) {
    Get.defaultDialog(
      title: "",
      backgroundColor: DeasyColor.neutral000,
      content: Container(
        width: DeasySizeConfigUtils.screenWidth! / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageConstant.RESOURCES_IMAGE_CHECKLIST,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              ContentConstant.linkSent,
              style: TextStyle(
                  color: DeasyColor.neutral900,
                  fontSize: DeasySizeConfigUtils.blockVertical * 2.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Text(ContentConstant.registerSuccessMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: DeasyColor.neutral400,
                    fontSize: DeasySizeConfigUtils.blockVertical * 1.7)),
            SizedBox(
              height: 15,
            ),
            BouncingWidget(
              duration: Duration(milliseconds: 100),
              scaleFactor: 1.5,
              onPressed: () async {
                await AnalyticConfig()
                    .sendEvent("Register_Merchant_Verify_Email");
                //TODO: remove flavorConfiguration!.flavorName == "dev" checking after new wg release
                if (email != null &&
                    flavorConfiguration!.flavorName == "dev") {
                  Get.offAllNamed(
                    BumblebeeRoutes.EMAIL_VERIFICATION_PAGE,
                    arguments: {
                      "email": email,
                    }
                  );
                } else {
                  Get.offAllNamed(BumblebeeRoutes.LOGIN);
                }
              },
              child: Container(
                decoration: new BoxDecoration(
                    color: DeasyColor.kpYellow500,
                    borderRadius: new BorderRadius.all(Radius.circular(10.0))),
                width: DeasySizeConfigUtils.screenWidth! / 2,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    ContentConstant.uderstand,
                    style: TextStyle(color: DeasyColor.neutral000),
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
