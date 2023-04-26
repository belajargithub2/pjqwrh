import 'package:customer_confirmation/src/constant.dart';
import 'package:customer_confirmation/src/view/widgets/confirmation_dialog.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:get/get.dart';
import 'package:newwg/config/auth_config.dart';
import 'package:newwg/config/data_config.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/stepper.dart';

class CustomerConfirmationController extends GetxController {
  final isLoading = false.obs;
  final isPhoneNumberVerified = false.obs;
  final limitType = LimitType.BLUE.obs;
  final limitTypeColor = DeasyColor.kpBlue800.obs;
  final customerName = "".obs;
  final nextRoute = "".obs;
  final customerId = 0.obs;
  final isVerify = false.obs;
  final isHumanVerify = false.obs;
  final customerLimitData = CutomerCheckLimitTypeData().obs;

  final phoneNumberController = TextEditingController();
  final codeVerificationController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyCodeVerif = GlobalKey<FormState>();

  final repository = Get.find<NewWgRepository>();
  final stepperController = Get.find<StepperContainerController>();
  final documentCheck = true.obs;

  @override
  void onInit() {
    DataConfig.instance.isShowIndicator = true;
    getNewWgConfig();
    super.onInit();
  }

  Future<void> getNewWgConfig() async {
    final dataConfig = await DeasyPocket().getNewWgDataConfig();
    if (dataConfig != null) {
      DataConfig.instance.fromJson(dataConfig);
    }

    final authConfig = await DeasyPocket().getNewWgAuthConfig();
    if (authConfig != null) {
      AuthConfig.instance.fromJson(authConfig);
    }

    final prospectId = await DeasyPocket().getProspectId();
    if (prospectId != null) {
      DataConfig.instance.prospectId = prospectId;
    }
  }

  void initLimitTypeColor(LimitType type) {
    if (type == LimitType.BLUE) {
      limitTypeColor(DeasyColor.kpBlue800);
    }
    if (type == LimitType.GOLD) {
      limitTypeColor(DeasyColor.kpYellow400);
    }
    if (type == LimitType.PLATINUM) {
      limitTypeColor(DeasyColor.dms900);
    }
    limitType(type);
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty || value.isBlank!) {
      return Constanta.phoneNumberCannotEmpty;
    } else if (!value.isIdPhoneNumber()) {
      return Constanta.phoneNumberNotValid;
    }
    return null;
  }

  String? codeVerificationValidator(String value) {
    if (value.isEmpty || value.isBlank! || value == "") {
      DeasySnackBarUtil.showFlushBarError(
        Get.context!,
        Constanta.codeVerificationCannotEmpty,
      );
      return '';
    }
    return null;
  }

  void userLimitValidation(CutomerCheckLimitTypeResponse customerLimit) {
    final limitStatus = customerLimit.data?.limitStatus;
    final verificationLimitStatus = customerLimit.data?.verificationLimitStatus;
    final verifyData = customerLimit.data!.verificationSchema?.verifyData?.dataVerification;
    final idForgery = customerLimit.data!.verificationSchema?.idForgery?.idForgeryVerification;
    final liveness = customerLimit.data!.verificationSchema?.liveness?.livenessVerification;
    final faceCompare = customerLimit.data!.verificationSchema?.faceCompare?.faceVerification;
    isHumanVerify.value = customerLimit.data!.verificationSchema?.human?.humanVerification ?? false;
    customerLimitData.value = customerLimit.data!;

    if (customerLimit.data!.customerId == 0) {
      isLoading(false);
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, Constanta.phoneNumberNotRegistered);
      return;
    }

    if (limitStatus != LimitStatus.ACTIVE) {
      isLoading(false);
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, Constanta.limitStatusIsNotActiveWording);
      return;
    }

    if (verificationLimitStatus == VerificationLimitStatus.RENEWAL ||
        verificationLimitStatus == VerificationLimitStatus.RE_VERIFY) {
      isLoading(false);
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, Constanta.limitStatusIsNotActiveWording);
      return;
    }

    if (verificationLimitStatus == VerificationLimitStatus.VERIFY) {
      isLoading(false);
      isVerify(true);
      checkConfirmationDialogPlatform(customerLimit);
      return;
    }

    if (verificationLimitStatus == VerificationLimitStatus.NOT_VERIFY) {
      isLoading(false);
      isVerify(false);
      if (verifyData == true &&
          idForgery == true &&
          liveness == true &&
          faceCompare == true) {
        checkConfirmationDialogPlatform(customerLimit);
      } else {
        isLoading(false);
        DeasySnackBarUtil.showFlushBarError(
            Get.context!, Constanta.limitNotActivated);
      }
    }
  }

  void checkConfirmationDialogPlatform(
      CutomerCheckLimitTypeResponse customerLimit) async {
    if (DeasySizeConfigUtils.isDesktopOrWeb) {
      ConfirmationDialog().webDialog();
      isLoading(false);
    }
    if (DeasySizeConfigUtils.isMobile) {
      ConfirmationDialog().mobileDialog();
      isLoading(false);
    }
  }

  void submitPhoneNumber() async {
    if (formKey.currentState!.validate()) {
      isLoading(true);
      await repository
          .checkCustomerLimitType(Get.context!, phoneNumberController.text)
          .then((value) async {
        DataConfig.instance.prospectId = await generateProspectId();
        userLimitValidation(value);

        customerId.value = value.data!.customerId!;
        customerName.value = value.data!.fullName!;
        initLimitTypeColor(value.data!.limitCategory!);

        documentCheck(value.data?.documentAdditionalCheck);
      }).catchError((onError) {
        isLoading(false);
      });
    }
  }

  void submitCodeVerification() async {
    if (formKeyCodeVerif.currentState!.validate()) {
      isLoading(true);
      await repository
          .verificationCodeValidate(
        Get.context!,
        codeVerificationController.text,
        phoneNumberController.text,
      )
          .then((value) {
        Get.offNamed(
          nextRoute.value,
          arguments: {
            "data": value,
            "verif_code": codeVerificationController.text,
            "phone_number": phoneNumberController.text,
            "customer_id": customerId.value,
            "customer_name": customerName.value,
            "limit_type": limitType.value.name,
          },
        );
      }).catchError((onError) {
        isLoading(false);
      });
      isLoading(false);
    }
  }

  void checkNavigation() {
    final humanRequired = customerLimitData.value.verificationSchema!.human!.required ?? true;
    final humanHumanVerification = customerLimitData.value.verificationSchema!.human!.humanVerification ?? false;

    if (humanRequired && !humanHumanVerification) {
      isPhoneNumberVerified(true);
      return;
    }

    if (documentCheck.isFalse) {
      goToAdditionalDocument();
      return;
    }

    gotoPesanan();
  }

  void goToAdditionalDocument() {
    Get.offNamed(nextRoute.value, arguments: {
      "phone_number": phoneNumberController.text,
      "customer_id": customerId.value,
      "customer_name": customerName.value,
      "limit_type": limitType.value.name,
      "document_check": documentCheck.value,
    },);
  }

  void gotoPesanan() {
    DataConfig.instance.isShowIndicator = false;

    Get.offNamed(nextRoute.value, arguments: {
      "phone_number": phoneNumberController.text,
      "customer_id": customerId.value,
      "customer_name": customerName.value,
      "limit_type": limitType.value.name,
      if (documentCheck.isTrue) "document_check": documentCheck.value,
    },);
    return;
  }

  Future<String> generateProspectId() async {
    try {
      final prospectId = await repository.generateProspectId(
        Get.context!,
        AuthConfig.instance.prefix,
        AuthConfig.instance.uniqueId,
      );

      DeasyPocket().setProspectId(prospectId.data!.orderId!);

      return prospectId.data!.orderId!;
    } catch (e) {
      return "";
    }
  }
}
