import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/controllers/account_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/connection_checker_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountPage extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    RefreshConfiguration.of(context);
    return SmartRefresher(
      controller: controller.refreshController,
      onRefresh: controller.onRefresh,
      onLoading: controller.onLoading,
      child: Scaffold(
        appBar: _appBar() as PreferredSizeWidget?,
        body: _body(),
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
      title: Text('Profile',
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold)),
      elevation: 2,
    );
  }

  Widget _body() {
    return Obx(
      () => Container(
        color: DeasyColor.neutral50,
        width: Get.width,
        height: Get.height,
        child: Stack(
          children: [
            ConnectionCheckerWidget(
              onRefresh: () =>
                  controller.refreshProfilePageWhenInternetConnected(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  controller.role.value
                          .isContainIgnoreCase(ContentConstant.ROLE_AGENT)
                      ? _agentWidget()
                      : _merchantWidget(),
                  SizedBox(height: 24),
                  controller.role.value.isContainIgnoreCase(
                              ContentConstant.ROLE_AGENT) ||
                          controller.isOnline.isTrue
                      ? SizedBox()
                      : _qrRefferal(),
                  //TODO: remove flavorConfiguration!.flavorName == "dev" checking after release 03 April
                  if (controller.role.value.isEqualIgnoreCase(
                    ContentConstant.ROLE_MERCHANT) &&
                    flavorConfiguration!.flavorName == "dev") _merchantUserManagement(),
                  SizedBox(height: 24),
                  _footer(),
                  _versionApp(),
                ],
              ),
            ),
            controller.qrRefferalController.isLoading.isTrue
                ? FullScreenSpinner()
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Container _qrRefferal() {
    return Container(
      color: DeasyColor.neutral000,
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () {
          controller.onTapQrRefferal();
        },
        child: Container(
          width: DeasySizeConfigUtils.screenWidth,
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                '${ImageConstant.RESOURCES_ICON_QR_REFFERAL}',
                height: 20,
                width: 20,
                color: DeasyColor.kpYellow500,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                ContentConstant.qrRefferalTitle,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: DeasyColor.neutral900,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _merchantUserManagement() {
    return Container(
      color: DeasyColor.neutral000,
      padding: EdgeInsets.all(15),
      child: InkWell(
        onTap: () => controller.goToMerchantUserManagementScreen,
        child: Container(
          width: DeasySizeConfigUtils.screenWidth,
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          child: Row(
            children: [
              SvgPicture.asset(
                '${IconConstant.RESOURCES_ICON_PROFILE}',
                height: 20,
                width: 20,
                color: DeasyColor.kpYellow500,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                ContentConstant.merchantUserManagement,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: DeasyColor.neutral900,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _merchantWidget() {
    return Container(
      color: DeasyColor.neutral000,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 20,
          ),
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: "Merchant ID",
            hintText: "Cth : 01212121021",
            obscure: false,
            isDisabled: true,
            readOnly: true,
            controller: controller.merchantIdController,
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
            labelText: "Nama Merchant Terdaftar",
            hintText: "Cth : PT TESTES",
            obscure: false,
            isDisabled: true,
            controller: controller.merchantNameController,
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
            labelText: "No Handphone Terdaftar",
            controller: controller.merchantPhoneController,
            hintText: "",
            isDisabled: true,
            obscure: false,
            readOnly: true,
            prefixIcon: null,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _agentWidget() {
    return Container(
      color: DeasyColor.neutral000,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 20,
          ),
          DeasyTextForm.outlinedTextForm(
            isNumberOnly: true,
            labelText: "Nama",
            hintText: "-",
            obscure: false,
            isDisabled: true,
            readOnly: true,
            controller: controller.agentNameController,
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
            labelText: "Nomor KTP",
            hintText: "-",
            obscure: false,
            readOnly: true,
            isDisabled: true,
            controller: controller.agentKtpController,
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
            labelText: "Nomor Handphone",
            controller: controller.agentPhoneNumberController,
            hintText: "",
            isDisabled: true,
            obscure: false,
            readOnly: true,
            prefixIcon: null,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _showDialogLogout() {
    Get.defaultDialog(
      title: "",
      backgroundColor: DeasyColor.neutral000,
      content: Column(
        children: [
          SvgPicture.asset(
            IconConstant.RESOURCES_ICON_WARNING_PATH,
          ),
          SizedBox(
            height: 30,
          ),
          DeasyTextView(
            text: ContentConstant.TITLE_LOGOUT,
            fontSize: 20,
            fontColor: DeasyColor.neutral900,
          ),
          SizedBox(
            height: 5,
          ),
          DeasyTextView(
            text: ContentConstant.SUB_TITLE_LOGOUT,
            fontSize: 14,
            fontColor: DeasyColor.neutral900.withOpacity(0.4),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: DeasyCustomElevatedButton(
                  text: " Keluar ",
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  paddingButton: 12,
                  onPress: () {
                    controller.logout();
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: DeasyCustomElevatedButton(
                  text: "Batalkan",
                  paddingButton: 12,
                  textColor: DeasyColor.kpYellow500,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.neutral000,
                  onPress: () {
                    Get.back();
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      color: DeasyColor.neutral000,
      padding: EdgeInsets.all(15),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.RESET_CURRENT_PASSWORD);
            },
            child: Container(
              width: DeasySizeConfigUtils.screenWidth,
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.lock,
                    color: DeasyColor.kpYellow500,
                    size: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Ganti Kata Sandi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: DeasyColor.neutral900,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: DeasyColor.neutral900.withOpacity(0.4),
            indent: 10,
            endIndent: 10,
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: controller.isOnline.isTrue,
            child: Column(children: [
              InkWell(
                onTap: () {
                  Get.toNamed(BumblebeeRoutes.ECOMMERCE_CLIENT_KEY_MOBILE);
                },
                child: Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        IconConstant.RESOURCES_ICON_ECOMMERCE_CLIENT_KEY,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        ContentConstant.eCommerceClientKeyLabel,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: DeasyColor.neutral900,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: DeasyColor.neutral900.withOpacity(0.4),
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(
                height: 15,
              ),
            ]),
          ),
          _deleteAccountButton(),
          _logoutButton(),
        ],
      ),
    );
  }

  Widget _logoutButton() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            _showDialogLogout();
          },
          child: Container(
            width: DeasySizeConfigUtils.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: Row(
              children: [
                SvgPicture.asset(
                  '${IconConstant.RESOURCES_ICON_LOGOUT_PATH}',
                  height: 20,
                  width: 20,
                  color: DeasyColor.kpYellow500,
                ),
                Divider(),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Keluar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: DeasyColor.neutral900,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          color: DeasyColor.neutral900.withOpacity(0.4),
        ),
      ],
    );
  }

  Widget _deleteAccountButton() {
    return Container(
      child: Column(children: [
        InkWell(
          onTap: () => controller.goToDeleteAccountScreen,
          child: Container(
            width: DeasySizeConfigUtils.screenWidth,
            padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.warning,
                  color: DeasyColor.kpYellow500,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Hapus Akun',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: DeasyColor.neutral900,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
        Divider(
          indent: 10,
          endIndent: 10,
          color: DeasyColor.neutral900.withOpacity(0.4),
        ),
      ]),
    );
  }

  Widget _versionApp() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Center(
            child: DeasyTextView(
                  text: 'V ${controller.versionApp.value}',
                  fontSize: 12,
                  fontColor: DeasyColor.neutral900,
                )));
  }
}
