import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/widgets/pengajuan_menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/widgets/pengajuan_title_widget.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class KonfirmasiKonsumenNewwgScreen
    extends GetView<CustomerConfirmationController> {
  KonfirmasiKonsumenNewwgScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _navigateToNextScreen(context);
    return OptimusDrawerCustom(
      body: Obx(
        () => Scaffold(
          backgroundColor: DeasyColor.dmsF8F9FC,
          body: controller.isLoading.isTrue
              ? FullScreenSpinner()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menuWidget(),
                    titleWidget(),
                    CustomerConfirmationScreen(),
                  ],
                ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context) {
    controller.nextRoute.value = OptimusRoutes.HUMAN_VERIFICATION_NEWWG;
  }
}
