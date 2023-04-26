import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_switch/deasy_switch.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_maintenance_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/menu_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class OptimusMaintenanceScreenWeb
    extends GetView<OptimusMaintenanceController> {
  final OptimusDrawerCustomController _drawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return OptimusDrawerCustom(
      body: Obx(
        () => controller.isLoading.isTrue
            ? FullScreenSpinner()
            : MaintenanceWidget(),
      ),
    );
  }

  Widget MaintenanceWidget() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 40),
      color: DeasyColor.neutral100,
      child: ListView(
        children: [
          _menuWidget(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DeasyTextView(
                    text: ContentConstant.maintenance,
                    fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                    fontFamily: FontFamily.bold),
                controller.isEdit.isFalse
                    ? DeasyCustomActionButton(
                        text: ButtonConstant.edit,
                        width: 96,
                        height: 35,
                        bgColor: DeasyColor.kpYellow500,
                        onPressed: () {
                          controller.isEdit.toggle();
                        })
                    : SizedBox(),
              ],
            ),
          ),
          Card(
            color: DeasyColor.neutral000,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ..._merchantWidget(),
                  SizedBox(height: 16),
                  Divider(
                    color: DeasyColor.neutral100,
                  ),
                  SizedBox(height: 16),
                  ..._agentWidget(),
                  SizedBox(height: 16),
                  Divider(
                    color: DeasyColor.neutral100,
                  ),
                  _actionWidget(),
                ],
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
      menuNameThree: MenuConstant.maintenance,
      onTapMenuOne: () {
        _drawerController.handleIcon();
        Get.back();
        Get.offNamed(Routes.DASHBOARD_WEB);
      },
      onTapMenuTwo: null,
    );
  }

  List<Widget> _merchantWidget() {
    return [
      DeasyTextView(
        text: ContentConstant.merchantLabel,
        fontColor: DeasyColor.kpBlue600,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: DeasyTextView(
              text: ContentConstant.snapNbuyModulLabel,
            ),
          ),
          DeasySwitch(
            transitionType: TextTransitionTypes.FADE,
            rounded: true,
            isClickable: controller.isEdit.isTrue,
            duration: Duration(milliseconds: 500),
            forceWidth: true,
            value: controller.snbModul.value,
            onChanged: (val) {
              controller.snbModul.value = val;
            },
            onText: "",
            offText: "",
            offBkColor: DeasyColor.neutral400,
            onBkColor: DeasyColor.dms2ED477,
            offThumbColor: DeasyColor.neutral000,
            onThumbColor: DeasyColor.neutral000,
            thumbSize: 17.0,
          ),
          SizedBox(width: 16),
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: _labelStatus(controller.snbModul.isTrue),
          ),
        ],
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: DeasyTextView(
              text: ContentConstant.allModulLabel,
            ),
          ),
          DeasySwitch(
            transitionType: TextTransitionTypes.FADE,
            rounded: true,
            isClickable: controller.isEdit.isTrue,
            duration: Duration(milliseconds: 500),
            forceWidth: true,
            value: controller.allModulMerchant.value,
            onChanged: (val) {
              controller.allModulMerchant.value = val;
            },
            onText: "",
            offText: "",
            offBkColor: DeasyColor.neutral400,
            onBkColor: DeasyColor.dms2ED477,
            offThumbColor: DeasyColor.neutral000,
            onThumbColor: DeasyColor.neutral000,
            thumbSize: 17.0,
          ),
          SizedBox(width: 16),
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: _labelStatus(controller.allModulMerchant.isTrue),
          ),
        ],
      ),
    ];
  }

  List<Widget> _agentWidget() {
    return [
      DeasyTextView(
        text: ContentConstant.agentLabel,
        fontColor: DeasyColor.kpBlue600,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: DeasyTextView(
              text: ContentConstant.orderFormModullabel,
            ),
          ),
          DeasySwitch(
            transitionType: TextTransitionTypes.FADE,
            rounded: true,
            isClickable: controller.isEdit.isTrue,
            duration: Duration(milliseconds: 500),
            forceWidth: true,
            value: controller.orderFromModul.value,
            onChanged: (val) {
              controller.orderFromModul.value = val;
            },
            onText: "",
            offText: "",
            offBkColor: DeasyColor.neutral400,
            onBkColor: DeasyColor.dms2ED477,
            offThumbColor: DeasyColor.neutral000,
            onThumbColor: DeasyColor.neutral000,
            thumbSize: 17.0,
          ),
          SizedBox(width: 16),
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: _labelStatus(controller.orderFromModul.isTrue),
          ),
        ],
      ),
      SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: DeasyTextView(
              text: ContentConstant.allModulLabel,
            ),
          ),
          DeasySwitch(
            transitionType: TextTransitionTypes.FADE,
            rounded: true,
            isClickable: controller.isEdit.isTrue,
            duration: Duration(milliseconds: 500),
            forceWidth: true,
            value: controller.allModulAgent.value,
            onChanged: (val) {
              controller.allModulAgent.value = val;
            },
            onText: "",
            offText: "",
            offBkColor: DeasyColor.neutral400,
            onBkColor: DeasyColor.dms2ED477,
            offThumbColor: DeasyColor.neutral000,
            onThumbColor: DeasyColor.neutral000,
            thumbSize: 17.0,
          ),
          SizedBox(width: 16),
          Container(
            alignment: Alignment.centerRight,
            width: 70,
            child: _labelStatus(controller.allModulAgent.isTrue),
          ),
        ],
      ),
    ];
  }

  Widget _labelStatus(bool modulActive) {
    return DeasyTextView(
      fontWeight: FontWeight.w500,
      fontColor: !controller.isEdit.isTrue
          ? DeasyColor.neutral400
          : modulActive
              ? DeasyColor.dms2ED477
              : DeasyColor.neutral400,
      text: modulActive
          ? ContentConstant.activeLabel
          : ContentConstant.inactiveLabel,
    );
  }

  Widget _actionWidget() {
    return controller.isEdit.isTrue
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DeasyCustomActionButton(
                onPressed: () {
                  controller.getMaintenance();
                },
                text: ButtonConstant.cancel,
                textColor: DeasyColor.kpYellow500,
                bgColor: DeasyColor.neutral000,
              ),
              SizedBox(width: 16),
              DeasyCustomActionButton(
                onPressed: () {
                  controller.dialogConfirm();
                },
                text: ButtonConstant.save,
              ),
            ],
          )
        : SizedBox();
  }
}
