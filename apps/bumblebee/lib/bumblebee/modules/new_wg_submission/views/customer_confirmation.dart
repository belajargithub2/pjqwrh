import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';

class CustomerConfirmation extends GetView<CustomerConfirmationController> {
  const CustomerConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(context);
    return Scaffold(body: DeasyResponsive(
      builder: ((context, orientation, screenType) {
        return SafeArea(
          child: Column(
            children: [
              _appBar(),
              Expanded(child: CustomerConfirmationScreen()),
            ],
          ),
        );
      }),
    ));
  }

  Widget _appBar() {
    return Container(
      width: 100.w,
      color: DeasyColor.neutral000,
      height: 7.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 3.vmax,
                    color: DeasyColor.neutral800,
                  ),
                ),
                DeasyTextView(
                  text: 'Pengajuan Konsumen',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    controller.nextRoute.value = BumblebeeRoutes.HUMAN_VERIFICATION_NEW_WG;
  }
}
