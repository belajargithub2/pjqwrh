import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart' as text;
import 'package:deasy_text_form/deasy_text_form.dart' as textForm;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class AgentFeeScreen extends GetView<AgentFeeController> {
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DeasyColor.neutral50,
        body: Stack(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildLine(),
                _buildResponsiveBody(),
              ],
            ),
            _buildBottomButton(),
            _buildLoading(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return FadeInAnimation(
      delay: 1,
      child: Container(
        color: DeasyColor.neutral000,
        padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
        child: Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DeasyColor.neutral800,
              ),
              onPressed: () => Get.back(),
            ),
            text.DeasyTextView(
              text: ContentConstant.agentFeeLabel,
              fontSize: 16,
              fontColor: DeasyColor.neutral800,
              fontFamily: text.FontFamily.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLine() {
    return FadeInAnimation(
      delay: 2,
      child: Divider(
        height: 3.0,
      ),
    );
  }

  Widget _buildResponsiveBody() {
    return FadeInAnimation(
      delay: 2,
      child: Container(
        color: DeasyColor.neutral000,
        child: DeasyResponsive(
          builder: (context, orientation, screenType) {
            return _buildContent(context);
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            textForm.DeasyTextForm.outlinedTextForm(
              hintText: ContentConstant.agentFeeSelectStartDate,
              labelText: ContentConstant.agentFeeStartDateLabel,
              labelSize: 14,
              readOnly: true,
              labelFontFamily: textForm.FontFamilyTextForm.medium,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  IconConstant.RESOURCES_ICON_CALENDAR,
                ),
              ),
              customValidation: (value) {
                return controller.validationStartDate(value, ContentConstant.agentFeeStartDateCantBeEmpty);
              },
              onFieldTap: () =>
                  showDatePickerDialog(context: context, isStartDate: true),
              controller: startDateController,
            ),
            SizedBox(
              height: 24.0,
            ),
            textForm.DeasyTextForm.outlinedTextForm(
              hintText: ContentConstant.agentFeeSelectEndDate,
              labelText: ContentConstant.agentFeeEndDateLabel,
              labelSize: 14,
              readOnly: true,
              onFieldTap: () =>
                  showDatePickerDialog(context: context, isStartDate: false),
              labelFontFamily: textForm.FontFamilyTextForm.medium,
              customValidation: (value) {
                return controller.validationEndDate(value,
                    messageIfEmpty: ContentConstant.agentFeeEndDateCantBeEmpty,
                    messageEndDateBeforeStartDate: ContentConstant.agentFeeEndDateBeforeStartDate);
                },
              suffixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  IconConstant.RESOURCES_ICON_CALENDAR,
                ),
              ),
              controller: endDateController,
            ),
            SizedBox(
              height: 24.0,
            ),
            _buildNoteLabel(),
            SizedBox(
              height: 12.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: FadeInAnimation(
        delay: 3,
        child: Container(
          color: DeasyColor.neutral000,
          padding: EdgeInsets.all(12.0),
          child: DeasyCustomElevatedButton(
            primary: DeasyColor.kpYellow500,
            borderColor: DeasyColor.kpYellow500,
            onPress: () {
              if (formKey.currentState!.validate()) {
                controller.fetchAgentFee().whenComplete(()
                  => controller.agentFeeState == AgentFeeState.ERROR
                      ? null
                      : controller.listAgentFee.isEmpty
                        ? _showDialog()
                        : _directToAgentFeeDetailScreen());
              }
            },
            fontSize: 16.0,
            text: ContentConstant.agentFeeShowAgentFee,
            textColor: DeasyColor.neutral000,
          ),
        ),
      ),
    );
  }

  Widget _buildNoteLabel() {
    return SideInAnimation(
      delay: 3,
      child: Container(
        color: DeasyColor.sally50,
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: DeasyColor.kpBlue600,
              size: 12.0,
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: text.DeasyTextView(
                text: ContentConstant.agentFeeNoteLabel,
                fontSize: 13,
                fontFamily: text.FontFamily.medium,
                maxLines: 3,
                fontColor: DeasyColor.kpBlue600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDatePickerDialog({
    required bool isStartDate,
    required BuildContext context
  }) async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: DeasyColor.kpBlue600,
              onPrimary: DeasyColor.neutral000,
              surface: DeasyColor.neutral000,
              onSurface: DeasyColor.neutral800,
            ),
            dialogBackgroundColor: DeasyColor.neutral000,
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) {
      return;
    }

    String dateFormat2 = DateFormat(DateConstant.dateFormat2).format(pickedDate);
    String dateFormat5 = DateFormat(DateConstant.dateFormat5).format(pickedDate);

    if (isStartDate) {
      startDateController.text = dateFormat2;
      controller.startDate.value = dateFormat5;
    } else {
      endDateController.text = dateFormat2;
      controller.endDate.value = dateFormat5;
    }
  }

  void _directToAgentFeeDetailScreen() {
    Get.toNamed(BumblebeeRoutes.AGENT_FEE_DETAIL,
        arguments: controller.agentFeeDataForDetailPage()
    );
  }

  void _showDialog() {
    DeasyBaseDialogs.getInstance().iconDialog(
        context: Get.context!,
        title: ContentConstant.agentFeeListEmptyTitle,
        subTitle: ContentConstant.agentFeeListEmptySubTitle,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        height: 260,
        onPressButtonOk: () {
          Get.back();
        },
        buttonOkText: DialogConstant.agentFeeDialogOkTextButton,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(IconConstant.RESOURCES_ICON_FAILED_PATH),
        ));
  }

  Widget _buildLoading() {
    return Obx(() => Visibility(
        visible: controller.agentFeeState.value == AgentFeeState.LOADING,
        child: FullScreenSpinner()));
  }
}
