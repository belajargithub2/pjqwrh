import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';

Widget bumblebeeShowDialogSnb(
    {Function? onSubmit,
    Function? onCancel,
    String? imagePath,
    String? title,
    String? subTitle,
    String submitText = "Kembali",
    String cancelText = "",
    BuildContext? context,
    bool isQrCode = false}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
        context: context!,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  width: 560,
                  height: 472,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Image.asset(
                        imagePath!,
                        width: 283.33,
                        height: 212.0,
                        fit: BoxFit.cover,
                      ),
                      Spacer(),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "$title",
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Text(
                        '$subTitle',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: DeasyColor.neutral400, fontSize: 16),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: isQrCode ? 230 : 500,
                              child: DeasyCustomElevatedButton(
                                text: submitText,
                                textColor: DeasyColor.neutral000,
                                radius: 6,
                                borderColor: DeasyColor.neutral000,
                                primary: DeasyColor.kpYellow500,
                                onPress: () => onSubmit!(),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isQrCode,
                            child: Container(
                              width: 230,
                              child: DeasyCustomElevatedButton(
                                text: cancelText,
                                textColor: DeasyColor.kpYellow500,
                                radius: 6,
                                borderColor: DeasyColor.kpYellow500,
                                primary: DeasyColor.neutral000,
                                onPress: () => onCancel!(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                );
              }));
        });
  });
  return SizedBox();
}

Widget dialogScanIsExpired(
    {Function? onReorderSnb, Function? onBackToDashboard}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Get.defaultDialog(
      title: "",
      barrierDismissible: false,
      backgroundColor: DeasyColor.neutral000,
      content: WillPopScope(
        onWillPop: () async => false,
        child: Column(
          children: [
            SvgPicture.asset(
              IconConstant.RESOURCES_ICON_ERROR,
            ),
            SizedBox(
              height: 30,
            ),
            DeasyTextView(
              text: DialogConstant.titleDialogExpiredSnb,
              fontSize: 18.sp,
              maxLines: 2,
              fontFamily: FontFamily.medium,
              textAlign: TextAlign.center,
              fontColor: DeasyColor.neutral900,
            ),
            SizedBox(
              height: 14,
            ),
            DeasyTextView(
              text: DialogConstant.subTitleDialogExpiredSnb,
              fontSize: 14,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontColor: DeasyColor.neutral900.withOpacity(0.4),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: double.infinity,
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.reOrderSnb,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  paddingButton: 12,
                  onPress: () => onReorderSnb!(),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Container(
                width: double.infinity,
                child: DeasyCustomElevatedButton(
                  text: ContentConstant.backToDashBoard,
                  paddingButton: 12,
                  textColor: DeasyColor.kpYellow500,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.neutral000,
                  onPress: () => onBackToDashboard!(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  });
  return SizedBox();
}
