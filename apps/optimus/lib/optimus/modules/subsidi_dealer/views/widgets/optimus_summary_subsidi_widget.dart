import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusSummarySubsidiWidget
    extends GetView<OptimusSubsidiDealerController> {
  @override
  Widget build(BuildContext context) {
    final cardWidth = 248.0;
    final cardHeigth = 130.0;
    return Container(
      width: DeasySizeConfigUtils.screenWidth! * 0.8,
      height: cardHeigth,
      child: Obx(
        () => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.listSummarySubsidiLabel.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11),
              child: itemSummarySubsidi(
                cardWidth,
                cardHeigth,
                controller.listSummarySubsidiLabel[index],
                controller.listSummarySubsidiAmount[index],
              ),
            );
          },
        ),
      ),
    );
  }

  Container itemSummarySubsidi(
    double cardWidth,
    double cardHeight,
    String label,
    String amount,
  ) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        color: DeasyColor.neutral000,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeasyTextView(
                text: label,
                fontColor: DeasyColor.kpBlue600,
                fontSize: 16,
                fontFamily: FontFamily.medium,
              ),
              SizedBox(height: 17),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: cardWidth * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeasyTextView(
                          text: amount,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        SizedBox(height: 8),
                        DeasyTextView(
                          text: ContentConstant.rupiah,
                          fontSize: 14,
                          fontColor: DeasyColor.neutral400,
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeasyTextView(
                        text: controller.summarySubsidi.value.aprovedCount
                            .toString(),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      SizedBox(height: 8),
                      DeasyTextView(
                        text: ContentConstant.approve,
                        fontSize: 14,
                        fontColor: DeasyColor.neutral400,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
