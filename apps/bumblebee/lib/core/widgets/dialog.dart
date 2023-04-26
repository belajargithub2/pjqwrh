import 'dart:ui';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';

class DialogUtil {
  static Dialog baseDialog(
      {BuildContext? context,
      String? titleText,
      String? descriptionText,
      String? confirmText,
      String? cancelText,
      Function? onCancel,
      Function? onConfirm}) {
    return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: 254,
          width: 328,
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 29),
              DeasyTextView(
                  text: titleText, fontSize: 24, fontFamily: FontFamily.bold),
              SizedBox(height: 16),
              DeasyTextView(text: descriptionText, maxLines: 3),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  DeasyPrimaryStrokedButton(
                      width: 100,
                      text: cancelText,
                      radius: 8,
                      onPressed: () {
                        onCancel!();
                      }),
                  SizedBox(width: 16),
                  DeasyPrimaryButton(
                      width: 100,
                      text: confirmText,
                      radius: 8,
                      onPressed: () {
                        onConfirm!();
                      })
                ],
              )
            ],
          ),
        ));
  }

  static Dialog expiredSessionDialog(
      {BuildContext? context, Function? onButtonPress}) {
    return Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: 254,
          width: 328,
          margin: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.logout,
                color: Colors.red,
                size: 30,
              ),
              SizedBox(height: 29),
              DeasyTextView(
                  text: "Sesi Habis",
                  fontSize: 24,
                  fontFamily: FontFamily.bold),
              SizedBox(height: 16),
              DeasyTextView(
                  text: "Sesi anda telah habis, harap melakukan login ulang.",
                  maxLines: 2),
              Spacer(),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: double.infinity),
                child: DeasyCustomButton(
                    text: "Login",
                    radius: 8,
                    onPressed: () {
                      onButtonPress!();
                    }),
              ),
            ],
          ),
        ));
  }

  static Widget expiredSessionDialogBlur(
      {BuildContext? context, Function? onButtonPress}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
          backgroundColor: Colors.white,
          child: Container(
            height: 254,
            width: 328,
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                  size: 30,
                ),
                SizedBox(height: 29),
                DeasyTextView(
                    text: "Sesi Habis",
                    fontSize: 24,
                    fontFamily: FontFamily.bold),
                SizedBox(height: 16),
                DeasyTextView(
                    text: "Sesi anda telah habis, harap melakukan login ulang.",
                    maxLines: 2),
                Spacer(),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: DeasyCustomButton(
                      text: "Login",
                      radius: 8,
                      onPressed: () {
                        onButtonPress!();
                      }),
                ),
              ],
            ),
          )),
    );
  }

  static Dialog deleteUserManagementDialog(
      {BuildContext? context,
      Function? onConfirmPress,
      Function? onCancelPress,
      String? name,
      String? id}) {
    return Dialog(
      child: Container(
        width: 391,
        height: 312,
        decoration: BoxDecoration(
          color: DeasyColor.neutral000,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
                "${IconConstant.RESOURCES_ICON_PATH}ic_warning.svg"),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Text(
                                'Hapus data ',
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            WidgetSpan(
                              child: Text(
                                '$name ?',
                                style: TextStyle(
                                    fontSize: 20, color: DeasyColor.kpBlue600),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          WidgetSpan(
                              child: Text(
                            'Dengan ini data ',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          )),
                          WidgetSpan(
                              child: Text(
                            '$name',
                            style: TextStyle(
                                fontSize: 14, color: DeasyColor.kpBlue600),
                            textAlign: TextAlign.center,
                          )),
                          WidgetSpan(
                              child: Text(
                            ' akan terhapus. ',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ))
                        ]),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: DeasyColor.kpYellow500,
                              side: BorderSide(
                                  width: 1, color: DeasyColor.kpYellow500),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: onConfirmPress as void Function()?,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Hapus",
                                style: TextStyle(color: DeasyColor.neutral000),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: DeasyColor.neutral000,
                              side: BorderSide(
                                  width: 1, color: DeasyColor.kpYellow500),
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: onCancelPress as void Function()?,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "Batalkan",
                                style: TextStyle(color: DeasyColor.kpYellow500),
                              ),
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static Widget dialogImeiCamera(
      {BuildContext? context, Function? onButtonPress}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
              ),
              DeasyTextView(
                  text: ContentConstant.uploadImeiLabel,
                  fontSize: 24,
                  fontFamily: FontFamily.medium),
              SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                ImageConstant.RESOURCES_IMAGE_IMEI_INSTRUCTOR_IMAGE,
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DeasyTextView(
                        text: ContentConstant.takeImageImeiFromLabel,
                        fontSize: 17.sp,
                        fontColor: DeasyColor.kpBlue600,
                        fontFamily: FontFamily.medium,
                        textAlign: TextAlign.center,
                        maxLines: 3),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: double.infinity),
                        child: DeasyCustomButton(
                            text: DialogConstant.dialogBtnOke,
                            radius: 8,
                            onPressed: () {
                              onButtonPress!();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  static Widget dialogBuktiTerimaCamera(
      {BuildContext? context, Function? onButtonPress}) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
              ),
              DeasyTextView(
                  text: ContentConstant.BUKTI_TERIMA,
                  fontSize: 24,
                  fontFamily: FontFamily.medium),
              SizedBox(
                height: 40,
              ),
              SvgPicture.asset(
                ImageConstant.RESOURCES_IMAGE_BUKTI_TERIMA_INSTRUCTOR_IMAGE,
              ),
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    DeasyTextView(
                        text: ContentConstant.takeImageBuktiTerimaLabel,
                        fontSize: 17.sp,
                        fontColor: DeasyColor.kpBlue600,
                        fontFamily: FontFamily.medium,
                        textAlign: TextAlign.center,
                        maxLines: 4),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: double.infinity),
                        child: DeasyCustomButton(
                            text: DialogConstant.dialogBtnOke,
                            radius: 8,
                            onPressed: () {
                              onButtonPress!();
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
