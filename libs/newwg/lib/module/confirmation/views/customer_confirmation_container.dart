import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg/module/confirmation/constants/strings.dart';
import 'package:newwg/routes/app_pages.dart';

class CustomerConfirmationContainer
    extends GetView<CustomerConfirmationController> {
  const CustomerConfirmationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(context);
    return Scaffold(body: DeasyResponsive(
      builder: ((context, orientation, screenType) {
        return SafeArea(
          child: Column(
            children: [
              _appBar(),
              const Expanded(child: CustomerConfirmationScreen()),
            ],
          ),
        );
      }),
    ));
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: AppConfig.instance.appBarColor,
      leading: IconButton(
        onPressed: () => SystemNavigator.pop(animated: true),
        icon: Icon(
          Icons.arrow_back_ios,
          size: 3.vmax,
          color: DeasyColor.neutral800,
        ),
      ),
      title: DeasyTextView(
        text: StringConstant.titleConsumenSubmission,
        fontSize: 16,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    controller.nextRoute.value = Routes.HUMAN_VERIFICATION_NEW_WG;
  }
}
