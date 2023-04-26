import 'package:additional_documents/additional_documents.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/widgets/pengajuan_menu_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/pengajuan_newwg/widgets/pengajuan_title_widget.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:order/views/order_screen.dart';
import 'package:stepper/stepper.dart';
import 'package:verification_customer/verification_customer.dart';

class StepperNewwgScreen extends GetView<StepperContainerController> {
  StepperNewwgScreen({Key? key}) : super(key: key);

  final drawerController = Get.find<OptimusDrawerCustomController>();

  @override
  Widget build(BuildContext context) {
    controller.konfirmasiKonsumenRoute(OptimusRoutes.CONFIRMATION_CUSTOMER_NEWWG);
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Container(
        color: DeasyColor.dmsF8F9FC,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            menuWidget(),
            titleWidget(),
            Expanded(
              child: SizedBox(
                width: DeasySizeConfigUtils.screenWidth,
                height: DeasySizeConfigUtils.screenHeight! * 0.77,
                child: StepperContainerScreen(
                  screen1: SizedBox(
                    width: DeasySizeConfigUtils.screenWidth,
                    height: DeasySizeConfigUtils.screenHeight! * 0.63,
                    child: VerificationCustomerScreen(
                      onBackToDashboard: () {
                        drawerController.goToDashboard();
                      }
                    ),
                  ),
                  screen2: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 23),
                    child: SizedBox(
                      width: DeasySizeConfigUtils.screenWidth,
                      height: DeasySizeConfigUtils.screenHeight! * 0.50,
                      child: AdditionalDocumentsScreen(
                        customerId: controller.customerId.value,
                      ),
                    ),
                  ),
                  screen3: SizedBox(
                    width: DeasySizeConfigUtils.screenWidth,
                    height: controller.isShowIndicator.value
                        ? DeasySizeConfigUtils.screenHeight! * 0.63
                        : DeasySizeConfigUtils.screenHeight! / 1.28,
                    child: OrderScreen(
                      onBackToDashboard: () {
                        drawerController.goToDashboard();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
