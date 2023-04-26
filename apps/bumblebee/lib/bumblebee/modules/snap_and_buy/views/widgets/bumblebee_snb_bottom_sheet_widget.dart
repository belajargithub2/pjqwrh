import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

Widget bumblebeeSnbBottomSheet(
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
    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context!,
        builder: (context) {
          return Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight! / 2,
            margin: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 80,
                  color: DeasyColor.neutral400,
                ),
                Spacer(),
                Image.asset(imagePath!),
                Spacer(),
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: Text(
                      "$title",
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.02,
                ),
                Text(
                  '$subTitle',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: DeasyColor.neutral400, fontSize: 14),
                ),
                Spacer(),
                DeasyPrimaryButton(
                  text: submitText,
                  onPressed: () => onSubmit!(),
                ),
                Visibility(
                    visible: isQrCode,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            width: double.infinity,
                            child: DeasyCustomElevatedButton(
                              text: cancelText,
                              textColor: DeasyColor.kpYellow500,
                              borderColor: DeasyColor.kpYellow500,
                              primary: DeasyColor.neutral000,
                              onPress: () => onCancel!(),
                            ),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        });
  });

  return Container();
}
