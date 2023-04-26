import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class InputCurrentPasswordController extends GetxController {
  final UserRepository userRepository;

  InputCurrentPasswordController({required this.userRepository});

  final isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final RxBool isTextObscuredCurrentPassword = true.obs;
  final RxBool isWrongPassword = false.obs;
  String? email;

  @override
  void onInit() async {
    email = await DeasyPocket().getEmail();
    super.onInit();
  }

  void verifyPassword() async {
    if (formKey.currentState!.validate()) {
      isLoading.toggle();
      userRepository
          .postApiVerifyPassword(
        Get.context,
        email,
        currentPasswordController.text,
      )
          .then((value) {
        isLoading.toggle();
        Get.offAndToNamed(Routes.RESET_PASSWORD,
            arguments: {"currentPassword": currentPasswordController.text});
      }).catchError((onError) {
        isLoading.toggle();
        String errorMessage = onError.toString();
        if (errorMessage.isContainIgnoreCase('bad request')) {
          isWrongPassword.toggle();
        }

        formKey.currentState!.validate();
        isWrongPassword.toggle();
      });
    }
  }

  String? validatePassword(String text) {
    if (text.isEmpty) {
      return "Kata Sandi harus diisi";
    } else if (isWrongPassword.isTrue) {
      return "Kata Sandi salah";
    }
  }
}
