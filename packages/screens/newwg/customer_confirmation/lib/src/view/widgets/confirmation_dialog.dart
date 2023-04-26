import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:customer_confirmation/src/constant.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';

class ConfirmationDialog {
  final controller = Get.find<CustomerConfirmationController>();

  webDialog() {
    DeasyBaseDialogs.getInstance().customContentDialog(
      context: Get.context!,
      width: 450,
      height: 185,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            DeasyTextView(
              text: Constanta.titleKonfirmasiKonsumen,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DeasyTextView(
                      text: Constanta.namaKonsumen,
                      fontColor: DeasyColor.neutral400,
                      fontSize: 14,
                    ),
                    DeasyTextView(
                      text: Constanta.labelPhoneNumber,
                      fontColor: DeasyColor.neutral400,
                      fontSize: 14,
                    ),
                    DeasyTextView(
                      text: Constanta.tipeLimit,
                      fontColor: DeasyColor.neutral400,
                      fontSize: 14,
                    ),
                  ],
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DeasyTextView(
                        text: controller.customerName.value,
                        fontColor: DeasyColor.kpBlue900,
                        fontSize: 14,
                      ),
                      DeasyTextView(
                        text: controller.phoneNumberController.text,
                        fontColor: DeasyColor.neutral900,
                        fontSize: 14,
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: controller.limitTypeColor.value,
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: DeasyTextView(
                          text: controller.limitType.value.name,
                          fontColor: DeasyColor.neutral000,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: DeasyPrimaryButton(
                    text: Constanta.konfirmasi,
                    color: AppConfig.instance.buttonPrimaryColor,
                    onPressed: () {
                      Get.back();
                      controller.checkNavigation();
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  flex: 1,
                  child: DeasyPrimaryButton(
                    text: Constanta.kembali,
                    textStyle: TextStyle(
                      color: AppConfig.instance.buttonPrimaryColor,
                    ),
                    color: DeasyColor.neutral000,
                    borderColor: AppConfig.instance.buttonPrimaryColor,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  mobileDialog() {
    DeasyBaseDialogs.getInstance().customContentDialog(
      context: Get.context!,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DeasyTextView(
                text: Constanta.titleKonfirmasiKonsumen,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DeasyTextView(
                        text: Constanta.namaKonsumen,
                        fontColor: DeasyColor.neutral400,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
                      DeasyTextView(
                        text: Constanta.labelPhoneNumber,
                        fontColor: DeasyColor.neutral400,
                        fontSize: 14,
                      ),
                      const SizedBox(height: 8),
                      DeasyTextView(
                        text: Constanta.tipeLimit,
                        fontColor: DeasyColor.neutral400,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DeasyTextView(
                            text: controller.customerName.value,
                            fontColor: DeasyColor.kpBlue900,
                            maxLines: 3,
                            textAlign: TextAlign.end,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 8),
                          DeasyTextView(
                            text: controller.phoneNumberController.text,
                            fontColor: DeasyColor.neutral900,
                            maxLines: 2,
                            textAlign: TextAlign.end,
                            fontSize: 14,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: controller.limitTypeColor.value,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            child: DeasyTextView(
                              text: controller.limitType.value.name,
                              fontColor: DeasyColor.neutral000,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: DeasyPrimaryButton(
                      text: Constanta.konfirmasi,
                      color: AppConfig.instance.buttonPrimaryColor,
                      onPressed: () {
                        Get.back();
                        controller.checkNavigation();
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    flex: 1,
                    child: DeasyPrimaryButton(
                      text: Constanta.kembali,
                      textStyle: TextStyle(
                        color: AppConfig.instance.buttonPrimaryColor,
                      ),
                      color: DeasyColor.neutral000,
                      borderColor: AppConfig.instance.buttonPrimaryColor,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
