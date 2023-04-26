import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/delete_account_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/dialogs/dialog_with_two_buttons_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';

class DeleteAccountPage extends GetView<DeleteAccountController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar() as PreferredSizeWidget?,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _title(),
                  _tnc(),
                  _checkbox(),
                  _buttonDeleteAccount()
                ],
              ),
            ),
            _loading()
          ],
        ));
  }

  Widget _loading() {
    return Obx(() => Container(
        width: Get.width,
        child: Visibility(
            visible: controller.isLoading.value,
            child: FullScreenSpinner(showLoadingMessage: false))));
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          ContentConstant.termsDeleteAccount,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _tnc() {
    return Container(
        height: Get.height / 1.75,
        child: controller.obx((state) {
          return RawScrollbar(
            scrollbarOrientation: ScrollbarOrientation.right,
            thickness: 5,
            thumbVisibility: true,
            thumbColor: DeasyColor.neutral400,
            child: SingleChildScrollView(
              child: Html(
                data: state!.data!.body,
                shrinkWrap: true,
                style: {
                  "ol": Style(
                      fontSize: FontSize(14),
                      width: Width(Get.width / 1.5),
                      padding: EdgeInsets.zero)
                },
              ),
            ),
          );
        },
            onLoading: Center(
              child: Text(ContentConstant.onLoading),
            ),
            onError: (e) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () => controller.getTermNConditionText(),
                          icon: Icon(
                            Icons.refresh_rounded,
                            color: DeasyColor.neutral900,
                          )),
                      Text(ContentConstant.failLoad),
                    ],
                  ),
                )));
  }

  Widget _buttonDeleteAccount() {
    return Container(
        width: Get.width,
        height: Get.height * 0.06,
        child: FadeInAnimation(
          delay: 1,
          child: Obx(() => BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: () => controller.isAgree.isTrue
                    ? _showDialogDeleteConfirmation()
                    : null,
                child: Container(
                  decoration: new BoxDecoration(
                      color: controller.isAgree.isTrue
                          ? DeasyColor.kpYellow500
                          : DeasyColor.neutral400,
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0))),
                  width: Get.width / 2,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      ContentConstant.btnDeleteAccount,
                      style: TextStyle(color: DeasyColor.neutral000),
                    ),
                  )),
                ),
              )),
        ));
  }

  Widget _checkbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        children: [
          Obx(
            () => Checkbox(
                activeColor: DeasyColor.kpYellow500,
                value: controller.isAgree.value,
                onChanged: (v) => controller.isCheckToggle(v!)),
          ),
          SizedBox(
            width: Get.width * 0.73,
            child: Text(ContentConstant.tvAgree,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                softWrap: true),
          )
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: DeasyColor.neutral000,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
        onPressed: () => Get.back(),
      ),
      title: Text(ContentConstant.btnDeleteAccount,
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold)),
      elevation: 0,
    );
  }

  void _showDialogDeleteConfirmation() {
    Get.defaultDialog(
      title: ContentConstant.noString,
      backgroundColor: DeasyColor.neutral000,
      content: ContentDialogWithTwoButtonsWidget(
        contentTitle: DialogConstant.dialogConfirmTitle,
        contentSubTitle: DialogConstant.dialogConfirmSubTitle,
        leftButtonText: DialogConstant.dialogBtnDelete,
        leftBtnOnPress: () {
          controller.requestSendEmailConfirmation();
        },
        rightButtonText: DialogConstant.dialogBtnCancel,
        rightBtnOnPress: () => Get.back(),
      ),
    );
  }
}
