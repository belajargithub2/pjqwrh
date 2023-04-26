import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:kreditplus_deasy_website/optimus/modules/new_password/controllers/optimus_new_password_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:deasy_animation/deasy_animation.dart';

class OptimusNewPasswordCard extends GetView<OptimusNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Container(
      margin: kIsWeb && DeasySizeConfigUtils.isMobile
          ? EdgeInsets.only(left: 2, right: 2)
          : EdgeInsets.only(left: 70, right: 70),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: kIsWeb && DeasySizeConfigUtils.isMobile
                ? MainAxisAlignment.start
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kIsWeb && DeasySizeConfigUtils.isMobile
                  ? SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.07,
                    )
                  : SizedBox(
                      height: DeasySizeConfigUtils.screenHeight! * 0.07,
                    ),
              Row(
                children: [
                  kIsWeb && DeasySizeConfigUtils.isMobile
                      ? Container()
                      : Spacer(),
                  Expanded(child: Image.asset('resources/images/kp_logo.png')),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Atur Kata Sandi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: DeasySizeConfigUtils.blockVertical * 3,
                      color: DeasyColor.semanticInfo300,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Visibility(
                visible: false,
                child: DeasyTextForm.outlinedTextForm(
                  isNoSpaceOnly: true,
                  labelText: "Email",
                  hintText: "",
                  controller: controller.emailController,
                  readOnly: false,
                  obscure: false,
                  textInputType: TextInputType.text,
                  actionKeyboard: TextInputAction.next,
                  customValidation: (String value) {
                    if (value.isEmpty) {
                      return "email tidak boleh kosong";
                    }
                  },
                  prefixIcon: null,
                  onChange: (val) {},
                ),
              ),
              SizedBox(height: 10),
              FadeInAnimation(
                delay: 1,
                child: Obx(() => DeasyTextForm.outlinedTextForm(
                      isNoSpaceOnly: true,
                      labelText: "Kata Sandi Baru",
                      hintText: "",
                      controller: controller.passwordController,
                      readOnly: false,
                      obscure: controller.isTextObscuredNewPassword.value,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      suffixIcon: Obx(() => GestureDetector(
                            child: Icon(
                                controller.isTextObscuredNewPassword.isFalse
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                                size: 20.0),
                            onTap: () {
                              controller.isTextObscuredNewPassword.value =
                                  !controller.isTextObscuredNewPassword.value;
                              controller.update();
                            },
                          )),
                      customValidation: (String value) {
                        return controller.validate(value, false);
                      },
                      prefixIcon: null,
                      onChange: (val) {},
                    )),
              ),
              SizedBox(height: 10),
              FadeInAnimation(
                delay: 2,
                child: Obx(() => DeasyTextForm.outlinedTextForm(
                      labelText: "Masukkan Kembali Kata Sandi Baru",
                      hintText: "",
                      obscure:
                          controller.isTextObscuredConfirmPassword.value,
                      controller: controller.newPasswordController,
                      readOnly: false,
                      textInputType: TextInputType.text,
                      actionKeyboard: TextInputAction.next,
                      suffixIcon: Obx(() => GestureDetector(
                            child: Icon(
                                controller.isTextObscuredConfirmPassword.isFalse
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                                size: 20.0),
                            onTap: () {
                              controller.isTextObscuredConfirmPassword.value =
                                  !controller
                                      .isTextObscuredConfirmPassword.value;
                              controller.update();
                            },
                          )),
                      customValidation: (String value) {
                        return controller.validate(value, true);
                      },
                      prefixIcon: null,
                      onChange: (val) {},
                    )),
              ),
              SizedBox(
                height: DeasySizeConfigUtils.screenHeight! * 0.05,
              ),
              Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  child: DeasyCustomButton(
                      text: 'Submit',
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        controller.submit();
                      })),
              SizedBox(height: 10),
              ketentuanWidget(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  ketentuanWidget({int number = 1, int content = 20}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ketentuan : ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Container(child: Text('1. '))),
            Expanded(
                flex: content,
                child: Container(
                    child: Text('Kata Sandi tidak mengandung kata "Finansia'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Container(child: Text('2.'))),
            Expanded(
                flex: content,
                child: Container(
                    child: Text(
                        'Kata Sandi minimal terdiri dari 6 karakter yang memuat komponen simbol, huruf besar, huruf kecil dan angka.'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Container(child: Text('3.'))),
            Expanded(
                flex: content,
                child: Container(
                    child: Text(
                        'Kata Sandi baru sebaiknya menggunakan Kata Sandi yang belum dipakai sebelumnya. Meskipun demikian, Kata Sandi baru masih dapat menggunakan password yang pernah dipergunakan sebelumnya, dengan contoh sebagai\nberikut :'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number + 1, child: Container(child: Text(''))),
            Expanded(
                flex: content,
                child: Container(child: Text('1 Januari 2021 : Pass01!'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number + 1, child: Container(child: Text(''))),
            Expanded(
                flex: content,
                child: Container(child: Text('1 April 2021 : Pass02!'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number + 1, child: Container(child: Text(''))),
            Expanded(
                flex: content,
                child: Container(child: Text('1 Juli 2021 : Pass01!'))),
          ],
        ),
        SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: number, child: Container(child: Text(''))),
            Expanded(
                flex: content,
                child: Container(
                    child: Text(
                        '(Kata Sandi bulan Januari 2021 dapat digunakan kembali pada bulan Juli 2021)'))),
          ],
        ),
      ],
    );
  }
}
