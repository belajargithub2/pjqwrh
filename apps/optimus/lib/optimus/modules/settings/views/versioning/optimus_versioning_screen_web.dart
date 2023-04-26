import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_versioning_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusVersioningScreenWeb extends GetView<OptimusVersioningController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Obx(
        () => controller.isLoading.isTrue
            ? FullScreenSpinner()
            : VersioningWidget(),
      ),
    );
  }

  Widget VersioningWidget() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: DeasyColor.neutral100,
      child: ListView(
        children: [
          _menuWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: DeasyTextView(
                text: MenuConstant.versioning,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                fontFamily: FontFamily.bold),
          ),
          Card(
            color: DeasyColor.neutral000,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...osVersion(
                      ContentConstant.iosVersionTitle,
                      controller.iosTextC,
                      controller.iosBtnActive,
                      'iOS',
                    ),
                    SizedBox(height: 16),
                    ...osVersion(
                      ContentConstant.androidVersionTitle,
                      controller.androidTextC,
                      controller.androidBtnActive,
                      'Android',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuWidget() {
    return MenuWidgets.threeMenu(
      menuNameOne: MenuConstant.dashboardLabel,
      menuNameTwo: MenuConstant.setting,
      menuNameThree: MenuConstant.versioning,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: null,
    );
  }

  List<Widget> osVersion(String title, Rx textC, RxBool btnActive, String os) {
    return [
      DeasyTextView(
        text: title,
        fontFamily: FontFamily.medium,
        fontSize: 14,
      ),
      Row(
        children: [
          Expanded(
            child: DeasyTextForm.outlinedTextForm(
              obscure: false,
              readOnly: false,
              controller: textC.value,
              textInputType: TextInputType.number,
              actionKeyboard: TextInputAction.next,
              prefixIcon: null,
              prefixText: 'V.',
              onChange: (String v) {
                btnActive.value = !v.isBlank!;
              },
            ),
          ),
          SizedBox(width: 8),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: DeasyPrimaryButton(
              text: ContentConstant.generate,
              color: btnActive.isTrue
                  ? DeasyColor.kpYellow500
                  : DeasyColor.neutral200,
              borderColor: btnActive.isTrue
                  ? DeasyColor.kpYellow500
                  : DeasyColor.neutral200,
              width: 170,
              onPressed: () {
                if (btnActive.isTrue) {
                  controller.dialogConfirm(os, textC.value.text);
                }
              },
            ),
          ),
        ],
      ),
    ];
  }
}
