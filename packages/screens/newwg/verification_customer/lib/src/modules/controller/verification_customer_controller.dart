import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/stepper.dart';
import 'package:verification_customer/src/modules/constans/strings.dart';
import 'package:verification_customer/src/modules/data/mappers/verification_code_validation_response_to_model_mapper.dart';
import 'package:verification_customer/src/modules/data/models/verification_code_validate_model.dart';

class VerificationCustomerController extends GetxController {
  final NewWgRepositoryImpl? repository;

  VerificationCustomerController({this.repository});

  final stepperController = Get.find<StepperContainerController>();

  final formKey = GlobalKey<FormState>();
  final ensureKtpController = TextEditingController();
  final selfieConsumerController = TextEditingController();
  final recommendationConsumerController = TextEditingController();
  final verificationCodeValidateModel = VerificationCodeValidateModel().obs;
  final isOpenEnsureKtp = false.obs;
  final isOpenSelfieConsumer = false.obs;
  final isOpenRecommendationConsumer = false.obs;
  final isAgree = false.obs;
  final countSubmit = 0.obs;
  final isShowSuccessDialog = false.obs;
  final isShowErrorDialog = false.obs;
  final isSameKtp = false.obs;
  final isSameSelfie = false.obs;
  final isCustomerRecommended = false.obs;
  final isLoading = false.obs;
  final isValid = StringConstant.selectSame.obs;
  final result = 'REJECT'.obs;

  @override
  void onReady() {
    getFromPreviousScreen();
    super.onReady();
  }

  void onChangeEnsureKtp(value) {
    isOpenEnsureKtp.toggle();
    ensureKtpController.text = value;

    if (value == isValid.value) {
      isSameKtp.value = true;
    } else {
      isSameKtp.value = false;
    }
  }

  void onChangeSelfieConsumer(value) {
    isOpenSelfieConsumer.toggle();
    selfieConsumerController.text = value;

    if (value == isValid.value) {
      isSameSelfie.value = true;
    } else {
      isSameSelfie.value = false;
    }
  }

  void onChangeRecommendationConsumer(value) {
    isOpenRecommendationConsumer.toggle();
    recommendationConsumerController.text = value;

    if (value == StringConstant.selectYes) {
      isCustomerRecommended.value = true;
    } else {
      isCustomerRecommended.value = false;
    }
  }

  String? checkIfValueEmpty(value) {
    if (value.isEmpty) {
      return 'Mohon konfirmasi jawaban';
    }

    return null;
  }

  void submit() async {
    countSubmit.value++;
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (isAgree.isFalse) {
      return;
    }

    isLoading.value = true;
    await repository!
        .submitHumanVerification(
          Get.context!,
          verificationCodeValidateModel.value.data!.customerId!,
          isSameKtp.value,
          isSameSelfie.value,
          isCustomerRecommended.value,
          isAgree.value,
        ).then((value) {
          if (value.data?.result != result.value) {
            isShowSuccessDialog.toggle();
          } else {
            isShowErrorDialog.toggle();
          }
        }).catchError((error) {
            isShowErrorDialog.toggle();
        }).whenComplete(() => isLoading.value = false);
  }

  void goToDokumenTambahanWeb() {
    stepperController.customerId(verificationCodeValidateModel.value.data!.customerId);
    stepperController.goToDokumenTambahan();
  }

  void getFromPreviousScreen() {
    final argument = Get.arguments;
    if (argument != null) {
      final VerificationCodeValidateResponse data = argument["data"];
      verificationCodeValidateModel.value = data.toModel();
    } else {
      stepperController.goToKonfirmasiKonsumen();
    }
  }

  Future<Uint8List> getImageFromUrl(String url) async {
    final response =
        await repository!.getImageCustomer(Get.context!, url, true);
    return response!;
  }

  void onBackToDashboard() {
    if (stepperController.isLibrary.value) {
      SystemNavigator.pop(animated: true);
    } else {
      Get.back();
      Get.back();
    }
  }
}
