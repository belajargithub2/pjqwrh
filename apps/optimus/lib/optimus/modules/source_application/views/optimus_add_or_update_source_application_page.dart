import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/controllers/optimus_add_or_update_source_application_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/hover.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';

class OptimusAddOrUpdateSourceApplicationPage
    extends GetView<OptimusAddOrUpdateSourceApplicationController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return OptimusDrawerCustom(
      body: Container(
        color: DeasyColor.neutral100,
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MenuWidget(),
                      Row(
                        children: [
                          GestureDetector(
                              child:
                                  Icon(Icons.arrow_back, color: Colors.black),
                              onTap: () async {
                                var dismissed = DeasySnackBarUtil.isDismissedFlushBar();
                                if (dismissed) {
                                  Get.back();
                                } else {
                                  await DeasySnackBarUtil.dismissFlushBar();
                                  Get.back();
                                }
                              }),
                          SizedBox(
                            width: 8,
                          ),
                          Obx(() => DeasyTextView(
                              text: controller.isEdit.value
                                  ? "Edit Source Application"
                                  : "Tambah Source Application",
                              fontSize: 20,
                              fontFamily: FontFamily.bold)),
                        ],
                      ),
                      SizedBox(height: 40),
                      Form(
                        key: controller.formKey,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                            margin: EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DeasyTextForm.outlinedTextForm(
                                  labelText: "Source Application",
                                  hintText: "Source Application",
                                  obscure: false,
                                  readOnly: false,
                                  controller:
                                      controller.sourceAppTextController,
                                  textInputType: TextInputType.text,
                                  actionKeyboard: TextInputAction.next,
                                  functionValidate: commonValidation,
                                  parametersValidate:
                                      "Source Application harus diisi",
                                  prefixIcon: null,
                                ),
                                SizedBox(height: 25),
                                DeasyTextForm.outlinedTextForm(
                                  labelText: "Callback URL Status",
                                  hintText: "Callback URL Status",
                                  obscure: false,
                                  readOnly: false,
                                  controller: controller
                                      .callbackUrlStatusTextController,
                                  textInputType: TextInputType.text,
                                  actionKeyboard: TextInputAction.next,
                                  customValidation: (v) =>
                                      controller.urlValidator(v),
                                  prefixIcon: null,
                                ),
                                SizedBox(height: 25),
                                DeasyTextForm.outlinedTextForm(
                                  labelText: "Callback URL Order",
                                  hintText: "Callback URL Order",
                                  obscure: false,
                                  readOnly: false,
                                  controller:
                                      controller.callbackUrlOrderTextController,
                                  textInputType: TextInputType.text,
                                  actionKeyboard: TextInputAction.next,
                                  customValidation: (v) =>
                                      controller.urlValidator(v),
                                  prefixIcon: null,
                                ),
                                SizedBox(height: 25),
                                Row(
                                  children: [
                                    Spacer(),
                                    DeasyPrimaryButton(
                                        text: "Submit",
                                        width: 154,
                                        onPressed: () {
                                          controller.submit();
                                        })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget MenuWidget() {
    double size = DeasySizeConfigUtils.blockVertical * 1.6;
    double sizeOnHover = DeasySizeConfigUtils.blockVertical * 1.7;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OnHover(
            builder: (isHovered) {
              return InkWell(
                onTap: () {
                  _drawerController.handleIcon();
                  Get.back();
                  Get.offNamed(Routes.DASHBOARD_WEB);
                },
                child: Text(
                  'Dashboard',
                  style: TextStyle(
                      color: DeasyColor.neutral800,
                      fontSize: isHovered ? sizeOnHover : size),
                ),
              );
            },
          ),
          SizedBox(
            width: 4,
          ),
          OnHover(
            builder: (isHovered) {
              return InkWell(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  '> Source Application',
                  style: TextStyle(
                      color: DeasyColor.neutral800,
                      fontSize: isHovered ? sizeOnHover : size),
                ),
              );
            },
          ),
          SizedBox(
            width: 4,
          ),
          OnHover(
            builder: (isHovered) {
              return InkWell(
                onTap: () {},
                child: Obx(() => Text(
                      controller.isEdit.isTrue
                          ? "> Edit Source Application"
                          : "> Tambah Source Application",
                      style: TextStyle(
                          color: DeasyColor.semanticInfo300,
                          fontSize: isHovered ? sizeOnHover : size),
                    )),
              );
            },
          ),
        ],
      ),
    );
  }
}
