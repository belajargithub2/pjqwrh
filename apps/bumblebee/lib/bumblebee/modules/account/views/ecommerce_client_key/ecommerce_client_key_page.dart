import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/ecommerce_client_key_controller.dart';
import 'package:deasy_color/deasy_color.dart';

class EcommerceClientKeyPage extends GetView<EcommerceClientKeyController> {
  @override
  Widget build(BuildContext context) {
    controller.fetchEcommerceBySupplierId(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DeasyColor.neutral000,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'E-commerce Client Key',
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 20,
            ),
            DeasyTextForm.outlinedTextForm(
              isNumberOnly: true,
              labelText: "Nama",
              hintText: "Cth : PT Atung",
              obscure: false,
              controller: controller.nameController,
              readOnly: true,
              textInputType: TextInputType.text,
              actionKeyboard: TextInputAction.next,
              customValidation: (String value) {},
              prefixIcon: null,
              onChange: (string) {},
            ),
            SizedBox(
              height: 20,
            ),
            DeasyTextForm.outlinedTextForm(
              isNumberOnly: true,
              labelText: "Merchant",
              hintText: "Cth : PT TESTES",
              obscure: false,
              readOnly: true,
              controller: controller.merchantNameController,
              textInputType: TextInputType.text,
              actionKeyboard: TextInputAction.next,
              customValidation: (String value) {},
              prefixIcon: null,
              onChange: (string) {},
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Key',
              style: TextStyle(fontFamily: "KBFGDisplayMedium"),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: DeasyColor.neutral400,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: DeasySizeConfigUtils.screenWidth! / 1.4,
                      padding: EdgeInsets.all(4.0),
                      child: TextField(
                        maxLines: 3,
                        readOnly: false,
                        controller: controller.keyController,
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Cth : 110237218312039812",
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        controller.GenerateKey();
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    height: controller.isSuccessGenerate
                                        ? 254
                                        : 324,
                                    width: 328,
                                    margin: EdgeInsets.all(24),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 40.0),
                                        controller.isSuccessGenerate
                                            ? SvgPicture.asset(
                                                'resources/images/icons/ic_success_generate.svg')
                                            : SvgPicture.asset(
                                                'resources/images/icons/ic_failed_generate.svg'),
                                        SizedBox(height: 16.0),
                                        DeasyTextView(
                                          text: controller.isSuccessGenerate
                                              ? "Berhasil"
                                              : "Maaf, Kamu Gagal",
                                          fontSize: 22,
                                          fontColor: Colors.black,
                                        ),
                                        SizedBox(height: 8.0),
                                        DeasyTextView(
                                            text: controller.isSuccessGenerate
                                                ? "Key kamu berhasil di generate"
                                                : "Silahkan coba lagi masukkan key lalu generate kembali.",
                                            fontSize: 16,
                                            fontColor: HexColor("#8B8B8B"),
                                            textAlign: TextAlign.center,
                                            maxLines: 5),
                                        SizedBox(height: 16.0),
                                        ConstrainedBox(
                                          constraints: BoxConstraints.tightFor(
                                              width: double.infinity),
                                          child: DeasyCustomButton(
                                              text: controller.isSuccessGenerate
                                                  ? "Kembali"
                                                  : "Coba Lagi",
                                              radius: 8,
                                              onPressed: () {
                                                if (controller
                                                    .isSuccessGenerate) {
                                                  Navigator.pop(context);
                                                } else {
                                                  controller.GenerateKey();
                                                }
                                              }),
                                        ),
                                        if (!controller.isSuccessGenerate)
                                          SizedBox(height: 16.0),
                                        if (!controller.isSuccessGenerate)
                                          ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                      width: double.infinity),
                                              child: DeasyPrimaryStrokedButton(
                                                text: "Kembali",
                                                radius: 8,
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              )),
                                      ],
                                    ),
                                  ));
                            });
                      },
                      child: Container(
                        height: DeasySizeConfigUtils.screenHeight! / 11,
                        width: DeasySizeConfigUtils.screenWidth! / 6,
                        margin: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: DeasyColor.kpYellow500,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        child: Icon(
                          Icons.replay_outlined,
                          color: DeasyColor.neutral000,
                          size: 40,
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            DeasyTextForm.outlinedTextForm(
              labelText: "CallBack URL Status",
              hintText: "https://",
              obscure: false,
              controller: controller.callbackStatusController,
              textInputType: TextInputType.text,
              actionKeyboard: TextInputAction.next,
              customValidation: (String value) {},
              prefixIcon: null,
              onChange: (string) {},
            ),
            SizedBox(
              height: 20,
            ),
            DeasyTextForm.outlinedTextForm(
              labelText: "CallBack URL Order",
              hintText: "https://",
              obscure: false,
              readOnly: false,
              textInputType: TextInputType.text,
              controller: controller.callbackOrderController,
              actionKeyboard: TextInputAction.next,
              customValidation: (String value) {},
              prefixIcon: null,
              onChange: (string) {},
            ),
            SizedBox(
              height: 20,
            ),
            DeasyCustomButton(
                text: "Submit",
                color: DeasyColor.kpYellow500,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 290,
                              width: 328,
                              margin: EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 40.0),
                                  SvgPicture.asset(
                                      'resources/images/icons/ic_dialog_ecommerce.svg'),
                                  SizedBox(height: 16.0),
                                  DeasyTextView(
                                    text: "Apakah Anda Yakin?",
                                    fontSize: 22,
                                    fontColor: Colors.black,
                                  ),
                                  SizedBox(height: 8.0),
                                  DeasyTextView(
                                      text:
                                          "On the other hand, we denounce with righteous indignation and dislike men who are so beguiled.",
                                      fontSize: 16,
                                      fontColor: HexColor("#8B8B8B"),
                                      textAlign: TextAlign.center,
                                      maxLines: 5),
                                  SizedBox(height: 16.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: DeasyCustomButton(
                                              text: "Ya",
                                              radius: 8,
                                              onPressed: () {
                                                controller
                                                    .updateECommerceClientKey(
                                                        context);
                                                Navigator.pop(context);
                                              })),
                                      SizedBox(width: 16.0),
                                      Expanded(
                                          child: DeasyPrimaryStrokedButton(
                                        text: "No",
                                        radius: 8,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ))
                                    ],
                                  ),
                                ],
                              ),
                            ));
                      });
                }),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                  child: Obx(() => Text(
                        "App version ${controller.appVersion}",
                        style: TextStyle(color: Colors.black),
                      ))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
