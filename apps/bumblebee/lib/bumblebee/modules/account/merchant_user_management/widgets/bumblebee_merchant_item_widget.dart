import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_timer/deasy_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/widgets/bumblebee_merchant_user_management_dialog.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeMerchantItemWidget extends GetView<BumblebeeMerchantUserManagementController> {
  final bool isVerified;
  final String name;
  final String email;
  final String phone;
  final int index;
  final String userId;
  final String updatedAt;
  final Duration? duration;

  BumblebeeMerchantItemWidget(
    {
      required this.isVerified,
      required this.name,
      required this.email,
      required this.phone,
      required this.index,
      required this.userId,
      required this.updatedAt,
      this.duration
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DeasyColor.neutral000,
      margin: EdgeInsets.only(bottom: 1.17.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.52.h, vertical: 0.6.h),
            child: Row(
              children: [
                Expanded(
                  child: DeasyTextView(
                    text: name,
                    overflow: TextOverflow.ellipsis,
                    fontFamily: FontFamily.bold,
                    fontSize: 2.05.h,
                  )
                ),
                SizedBox(width: 3.52.h),
                _verificationStatusWidget(isVerified, duration),
                PopupMenuButton<String>(
                  elevation: 0,
                  color: DeasyColor.neutral000,
                  icon: Icon(Icons.more_vert, color: DeasyColor.neutral900),
                  onSelected: (String val) {},
                  position: PopupMenuPosition.under,
                  offset: Offset(0, -0.8.h),
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        padding: EdgeInsets.zero,
                        height: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                              color: DeasyColor.neutral200,
                            )
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!isVerified) _menuWidget(false),
                              if (!isVerified) Divider(
                                height: 0,
                                thickness: 1,
                              ),
                              _menuWidget(true),
                            ],
                          )
                        ),
                      )
                    ];
                  }
                )
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.52.h, vertical: 1.47.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DeasyTextView(
                  text: email,
                  fontColor: DeasyColor.neutral400,
                  fontSize: 1.76.h,
                ),
                SizedBox(height: 0.6.h),
                DeasyTextView(
                  text: phone,
                  fontColor: DeasyColor.neutral400,
                  fontSize: 1.76.h,
                ),
                SizedBox(height: 1.47.h),
                Divider(
                  height: 0,
                  thickness: 1.5,
                ),
                SizedBox(height: 1.47.h),
                DeasyTextView(
                  text: "Terakhir diperbarui $updatedAt",
                  fontColor: DeasyColor.neutral400,
                  fontSize: 1.47.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _verificationStatusWidget(bool isVerified, Duration? duration) {
    return Container(
      decoration: BoxDecoration(
        color: isVerified
          ? DeasyColor.kpBlue50
          : DeasyColor.semanticWarning100,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.47.h, vertical: 0.44.h),
        child: isVerified
          ? _verifiedStatusWidget()
          : _waitingForVerificationStatusWidget(duration),
      ),
    );
  }

  _verifiedStatusWidget() {
    return DeasyTextView(
      text: ContentConstant.verified,
      fontColor: DeasyColor.kpBlue600,
      fontFamily: FontFamily.medium,
      fontSize: 1.76.h,
    );
  }

  _waitingForVerificationStatusWidget(Duration? duration) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          duration == null
            ? Icons.info_outline_rounded
            : Icons.access_time_outlined,
          color: DeasyColor.semanticWarning300,
          size: 1.76.h,
        ),
        SizedBox(width: 0.6.h),
        duration == null
          ? DeasyTextView(
              text: ContentConstant.waitingForVerification,
              fontColor: DeasyColor.semanticWarning300,
              fontFamily: FontFamily.medium,
              fontSize: 1.76.h,
            )
          : DeasyMinutesTimerWidget(
              duration: duration,
              fontColor: DeasyColor.semanticWarning300,
              fontFamily: FontFamily.medium,
              fontSize: 1.76.h,
              endTimerText: ContentConstant.waitingForVerification,
              onEnd: () {
                controller.isActiveTimer[index] = false;
              },
            )
      ],
    );
  }

  _menuWidget(bool isDelete) {
    return Container(
      color: isDelete
        ? DeasyColor.neutral000
        : duration == Duration.zero || duration == null || controller.isActiveTimer[index] == false
          ? DeasyColor.neutral000
          : DeasyColor.neutral100,
      width: double.infinity,
      child: InkWell(
        onTap: () async {
          if (isDelete) {
            Get.back();
            deleteUserDialog(() async {
              await controller.deleteUser(userId).then((value) async {
                if (controller.isShowSuccessDeleteDialog) {
                  await controller.reloadUserList();
                  successDeleteDialog();
                }
              });
            });
          } else if (duration == Duration.zero || duration == null || controller.isActiveTimer[index] == false) {
            Get.back();
            await controller.resendEmail(email).then((value) async {
              if (controller.isShowSuccessResendDialog) {
                await controller.reloadUserList();
                successResendEmailDialog(email);
              }
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.35.h, vertical: 1.17.h),
          child: DeasyTextView(
            text: isDelete
              ? DialogConstant.dialogBtnDelete
              : ContentConstant.resendEmail,
            fontColor: isDelete
              ? DeasyColor.dmsF46363
              : duration == Duration.zero || duration == null || controller.isActiveTimer[index] == false
                ? DeasyColor.neutral900
                : DeasyColor.neutral400,
            fontFamily: FontFamily.medium,
            fontSize: 2.05.h,
          ),
        ),
      ),
    );
  }
}