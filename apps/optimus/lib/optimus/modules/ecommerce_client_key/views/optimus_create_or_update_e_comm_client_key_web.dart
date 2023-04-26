import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/controllers/optimus_create_or_update_ecommerce_client_key_web_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/hover.dart';
import 'package:kreditplus_deasy_website/core/widgets/base_widget.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusCreateOrUpdateECommerceClientKeyWeb
    extends GetView<OptimusCreateOUpdateEcommerceClientKeyWebController> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
        parentRoute: OptimusRoutes.ECOMMERCE_CLIENT_KEY,
        scaffoldKey: scaffoldKey,
        body: BaseWidget(
          child: Container(
            color: DeasyColor.neutral100,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, top: 10),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _menuWidget(),
                        Row(
                          children: [
                            Obx(() => Visibility(
                                  visible:
                                      controller.flag.value == 0 ? false : true,
                                  child: GestureDetector(
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.black),
                                      onTap: () {
                                        Get.back();
                                      }),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Obx(() => DeasyTextView(
                                text: controller.isEdit.isTrue
                                    ? MenuConstant.editEcommerceClientKey
                                    : MenuConstant.addEcommerceClientKey,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2.5,
                                fontFamily: FontFamily.bold)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Form(
                          key: controller.formKey,
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Container(
                              margin: EdgeInsets.all(24),
                              child: Column(
                                children: [
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: "Nama User",
                                    hintText: "Cth : Atung",
                                    obscure: false,
                                    readOnly: false,
                                    controller: controller.nameController,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate: "Nama User harus diisi",
                                    prefixIcon: null,
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: "Nama Merchant",
                                    hintText: "Cari berdasarkan nama merchant",
                                    obscure: false,
                                    controller: controller.merchantController,
                                    readOnly: true,
                                    onFieldTap: () {
                                      controller.merchantListDialog();
                                    },
                                    textInputType: TextInputType.number,
                                    actionKeyboard: TextInputAction.next,
                                    functionValidate: commonValidation,
                                    parametersValidate:
                                        "Nama Merchant harus diisi",
                                    prefixIcon: null,
                                  ),
                                  SizedBox(height: 25),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        flex: 13,
                                        child: DeasyTextForm.outlinedTextForm(
                                          labelText: "Key",
                                          paddingBottom: 8,
                                          hintText:
                                              "Klik generate untuk mendapatkan Key",
                                          obscure: false,
                                          controller:
                                              controller.keyTextController,
                                          readOnly: true,
                                          textInputType: TextInputType.text,
                                          actionKeyboard: TextInputAction.next,
                                          functionValidate: commonValidation,
                                          parametersValidate: "Key harus diisi",
                                          prefixIcon: null,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: OnHover(builder: (isHovered) {
                                          return DeasyPrimaryStrokedButton(
                                              text: "Generate",
                                              onPressed: () {
                                                controller.keyTextController
                                                        .text =
                                                    DeasyStringHelper
                                                        .getRandomString(
                                                            length: 32);
                                              });
                                        }),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: "Callback URL Status",
                                    hintText: "Cth : https//...",
                                    obscure: false,
                                    readOnly: false,
                                    controller:
                                        controller.callbackStatusTextController,
                                    textInputType: TextInputType.text,
                                    actionKeyboard: TextInputAction.next,
                                    customValidation: (v) =>
                                        controller.urlValidator(v),
                                    prefixIcon: null,
                                  ),
                                  SizedBox(height: 25),
                                  DeasyTextForm.outlinedTextForm(
                                    labelText: "Callback URL Order",
                                    hintText: "Cth : https//...",
                                    obscure: false,
                                    readOnly: false,
                                    controller:
                                        controller.callbackOrderTextController,
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
                                      OnHover(builder: (isHovered) {
                                        return DeasyCustomElevatedButton(
                                            textColor: DeasyColor.neutral900,
                                            borderColor: DeasyColor.neutral400,
                                            primary: DeasyColor.neutral000,
                                            paddingButton: 15,
                                            text: "Cancel",
                                            onPress: () {
                                              Get.back();
                                            });
                                      }),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      OnHover(builder: (isHovered) {
                                        return DeasyCustomElevatedButton(
                                            textColor: DeasyColor.neutral000,
                                            borderColor: DeasyColor.kpYellow500,
                                            primary: DeasyColor.kpYellow500,
                                            paddingButton: 15,
                                            text: "Submit",
                                            onPress: () {
                                              controller.submit();
                                            });
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget _menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.ecommerceClientKey,
      menuNameThree: controller.isEdit.isTrue
          ? MenuConstant.editEcommerceClientKey
          : MenuConstant.addEcommerceClientKey,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: () {
        _drawerController.handleIcon();
        Get.offNamed(OptimusRoutes.ECOMMERCE_CLIENT_KEY);
      },
    );
  }
}
