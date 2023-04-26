import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_ringkasan_belanja_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/widgets/optimus_snb_skema_pembayaran_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusUsageLimitCard extends GetWidget<OptimusPromoMarketingController> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        return Container(
          color: DeasyColor.neutral000,
          width: DeasySizeConfigUtils.screenWidth,
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 15.0),
              DeasyTextView(
                  text: ContentConstant.usageInformationLimit,
                  fontSize: 2.2.h,
                  isSelectable: true,
                  fontFamily: FontFamily.bold),
              SizedBox(height: 8.0),
              DeasyTextView(
                text: ContentConstant.makeSurePromoMarketing,
                maxLines: 2,
                fontSize: 1.76.h,
                isSelectable: true,
                fontColor: DeasyColor.neutral600,
              ),
              SizedBox(height: 20),
              Card(
                color: DeasyColor.kpBlue50,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ringkasanBelanjaWebWidget(
                        controller.submissionSectionController.assetModel.value,
                        controller.submissionSectionController,
                        controller.snapAndBuyWebController.prospectId.value,
                        controller.tenorModel.value,
                        controller.snapAndBuyWebController,
                        controller.inputDp.value,
                      ),
                      SizedBox(height: 30),
                      Obx(() => controller.tenorModel.value.tenor == null
                          ? SizedBox()
                          : optimusRingkasanSkemaPembayaranWidget(
                              controller.tenorModel.value)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        );
      }
    );
  }
}
