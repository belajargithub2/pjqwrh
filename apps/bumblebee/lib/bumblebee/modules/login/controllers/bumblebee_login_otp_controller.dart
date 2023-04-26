import 'dart:async';

import 'package:kreditplus_deasy_mobile/bumblebee/modules/login/controllers/bumblebee_login_phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BumblebeeLoginOTPController extends GetxController
    with SingleGetTickerProviderMixin {
  final BumblebeeLoginPhoneController? phoneNumberController;

  BumblebeeLoginOTPController({
    this.phoneNumberController,
  });

  final fieldOne = TextEditingController();
  final fieldTwo = TextEditingController();
  final fieldThree = TextEditingController();
  final fieldFour = TextEditingController();
  final fieldFive = TextEditingController();
  final fieldSix = TextEditingController();
  final focusNodeOne = FocusNode();
  final focusNodeTwo = FocusNode();
  final focusNodeThree = FocusNode();
  final focusNodeFour = FocusNode();
  final focusNodeFive = FocusNode();
  final focusNodeSix = FocusNode();
  final phoneNumber = ''.obs;
  final dashedPhoneNumber = ''.obs;
  final RxList<String> otpArray = <String>['', '', '', '', '', ''].obs;
  final retryAt = 0.obs;
  final second = 60.obs;
  final interval = const Duration(seconds: 1);
  final timerMaxSeconds = 80.obs;
  final currentSeconds = 0.obs;
  late Timer otpTimer;
  final canRequestOTP = false.obs;
  final otpType = "sms".obs;

  @override
  void onInit() {
    addFocusNodeListener(fieldOne, focusNodeOne);
    addFocusNodeListener(fieldTwo, focusNodeTwo);
    addFocusNodeListener(fieldThree, focusNodeThree);
    addFocusNodeListener(fieldFour, focusNodeFour);
    addFocusNodeListener(fieldFive, focusNodeFive);
    addFocusNodeListener(fieldSix, focusNodeSix);
    getArguments();
    setPhoneNumberText();
    setTimeOut();
    super.onInit();
  }

  void addFocusNodeListener(TextEditingController fieldController, FocusNode focusNode) {
    focusNode.addListener(() {
      if (fieldController.text.isNotEmpty && focusNode.hasFocus) {
        fieldController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: fieldController.text.length
        );
      }
    });
  }

  void resendOTP({Function? onFailed}) async {
    phoneNumberController!.isLoading(true);
    if (canRequestOTP.isTrue) {
      await phoneNumberController!.requestOTP(false)
          .then((v) => retryAt(v))
          .onError((e, _) => onFailed!("$e"));
      currentSeconds.value = 0;
      setTimeOut();
    }
    phoneNumberController!.isLoading(false);
  }

  void getArguments() {
    phoneNumber.value = Get.arguments['phone'];
    retryAt.value = Get.arguments['retry_at'] ?? 0;
    otpType.value = Get.arguments['type'] ?? "sms";
  }

  void setPhoneNumberText() {
    dashedPhoneNumber.value = phoneNumber.value.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)}-");

    if (dashedPhoneNumber.value.lastIndexOf('-') == dashedPhoneNumber.value.length - 1) {
      dashedPhoneNumber.value = dashedPhoneNumber.value.substring(0, dashedPhoneNumber.value.length - 1);
    }
  }

  void setTimeOut() {
    final currentDate = DateTime.now();
    var date = DateTime.fromMillisecondsSinceEpoch(retryAt.value * 1000);
    second.value = date.difference(currentDate).inSeconds;
    timerMaxSeconds.value = second.value;
    startTimeout();
  }

  void startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      otpTimer = timer;
      currentSeconds.value = otpTimer.tick;
      if (otpTimer.tick >= timerMaxSeconds.value) {
        timer.cancel();
      }

      if ((timerMaxSeconds.value - currentSeconds.value) == 0) {
        canRequestOTP(true);
      }
    });
    canRequestOTP(false);
  }

  void setOTPText(String value, int index, BuildContext context) {
    if (value.length == 1) {
      otpArray[index] = value;
      if (index != 5) {
        FocusScope.of(context).nextFocus();
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      if(index > 0) {FocusScope.of(context).previousFocus();}
      otpArray[index] = '';
    }

    checkOTPText();
  }

  void checkOTPText() {
    int _countEmpty = 0;
    otpArray.forEach((element) {
      if (element.isEmpty) {
        _countEmpty++;
      }
    });

    if (_countEmpty == 0) {
      phoneNumberController!.otpController.text = otpArray.join();
      phoneNumberController!.submit();
    }
  }
}