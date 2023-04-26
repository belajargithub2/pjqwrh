import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_circular_checkbox/deasy_circular_checkbox.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/models/optimus_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:select_dialog/select_dialog.dart';

class OptimusSnbTabPromoMarketingScreen
    extends GetWidget<OptimusPromoMarketingController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DeasyColor.neutral000.withOpacity(0.1),
      width: 100.w,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(left: 16, right: 16),
      height: 66.h,
      child: ListView(
        children: [
          _formPromoMarketing(),
          _submit(),
        ],
      ),
    );
  }

  Widget _formPromoMarketing() {
    return Form(
      key: controller.formKey,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _cardPromoMarketing(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget _submit() {
    return Row(
      children: [
        Spacer(),
        Container(
          width: 15.w,
          color: DeasyColor.neutral000,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Obx(() => DeasyCustomElevatedButton(
                  text: "Submit",
                  textColor: DeasyColor.neutral000,
                  borderColor: controller.btnSubmitIsValid.value
                      ? DeasyColor.kpYellow500
                      : DeasyColor.neutral400,
                  primary: controller.btnSubmitIsValid.value
                      ? DeasyColor.kpYellow500
                      : DeasyColor.neutral400,
                  radius: 4,
                  paddingButton: 12,
                  onPress: () {
                    controller.submit();
                  },
                )),
          ),
        ),
      ],
    );
  }

  Widget _cardPromoMarketing() {
    return Container(
      color: DeasyColor.neutral000,
      width: DeasySizeConfigUtils.screenWidth,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    controller.submissionSectionController
                        .goToSubmissionSection();
                  },
                  iconSize: 30,
                  icon: Icon(
                    Icons.arrow_back,
                    color: DeasyColor.neutral900,
                  )),
              DeasyTextView(
                text: ContentConstant.promoMarketing,
                fontSize: 14.sp,
                fontColor: DeasyColor.neutral800,
                fontFamily: FontFamily.bold,
                isSelectable: true,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          DeasyTextView(
            text: ContentConstant.labelOrder,
            maxLines: 2,
            isSelectable: true,
            fontSize: 11.sp,
            fontColor: DeasyColor.neutral600,
          ),
          SizedBox(height: 15),
          EditTextWidget(
            controller: controller.promoController,
            title: ContentConstant.specialOffer,
            hint: ContentConstant.selectPromo,
            isNumberOnly: true,
            borderRadius: 4,
            isSelectable: true,
            widgetSuffix: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 34,
              color: DeasyColor.neutral400,
            ),
            validation: (value) => controller.selectPromoValidation(value),
            onChange: (value) => controller.onChangePromo(value),
            onFieldTap: () {
              SelectDialog.showModal<Program>(
                Get.context!,
                items: controller.snapAndBuyWebController
                    .listPromoMarketingResponse.value.data!.programs,
                backgroundColor: DeasyColor.neutral000,
                label: ContentConstant.searchProgramName,
                titleStyle: TextStyle(color: DeasyColor.neutral900),
                searchBoxDecoration: InputDecoration(
                  hintText: '...',
                  disabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DeasyColor.neutral600, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DeasyColor.neutral600, width: 0.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DeasyColor.neutral600, width: 0.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: DeasyColor.neutral600, width: 0.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                onFind: (String filter) => controller.filterListPromo(filter),
                itemBuilder:
                    (BuildContext context, Program item, bool isSelected) {
                  return Container(
                    child: ListTile(
                      selected: isSelected,
                      title: Text(item.programName!),
                    ),
                  );
                },
                onChange: (Program result) {
                  controller.onChangePromo(result);
                },
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Obx(() => Visibility(
                      visible: controller.isShowTextFieldDp.value,
                      child: EditTextWidget(
                        controller: controller.dpController,
                        title: ContentConstant.dpLabel,
                        isSelectable: true,
                        hint: '0',
                        isReadOnly:
                            controller.btnTenorIsEdit.value ? true : false,
                        isNumberOnly: true,
                        borderRadius: 4,
                        extraTextColor: controller.extraTextDpIsRedColor.isFalse
                            ? DeasyColor.kpBlue600
                            : DeasyColor.dmsF46363,
                        extraText: controller.extraTextDp.value,
                        onChange: (value) =>
                            controller.onChangePriceProduct(value.toString()),
                      ),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Obx(() => Visibility(
                        visible: controller.isShowButtonTenor.value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 4.0,
                              top: controller.isShowTextFieldDp.value ? 0 : 8),
                          child: DeasyCustomElevatedButton(
                            text: controller.btnTenorIsEdit.value
                                ? ContentConstant.editTenor
                                : ContentConstant.seeTenor,
                            textColor: controller.dpIsValid.value
                                ? DeasyColor.kpYellow500
                                : DeasyColor.neutral400,
                            borderColor: controller.dpIsValid.value
                                ? DeasyColor.kpYellow500
                                : DeasyColor.neutral400,
                            primary: DeasyColor.neutral000,
                            radius: 4,
                            fontSize: 11.sp,
                            paddingButton: 12,
                            onPress: () {
                              controller.submitTenor();
                            },
                          ),
                        ),
                      ))),
            ],
          ),
          Obx(() => Visibility(
              visible: controller.listTenor.length > 0,
              child: DeasyTextView(
                  text: ContentConstant.selectTenor,
                  fontColor: DeasyColor.neutral900,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  isSelectable: true,
                  fontSize: 11.sp,
                  fontFamily: FontFamily.bold))),
          Obx(() => Visibility(
              visible: controller.listTenor.length > 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Obx(() => ListView.builder(
                      itemCount: controller.listTenor.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return SideInAnimation(
                          child: InkWell(
                            onTap: () {
                              controller.onTapTenor(i);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 6.0, right: 6.0, top: 6.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => DeasyCircularCheckBox(
                                        animationDuration: Duration(milliseconds: 150),
                                        size: 20,
                                        isEnable: true,
                                        isChecked:
                                            controller.indexTenor.value ==
                                                i,
                                        onTap: (value) {
                                          controller.onTapTenor(i);
                                        },
                                      )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      DeasyTextView(
                                          text:
                                              "Cicilan ${controller.listTenor[i].tenor} bulan",
                                          fontColor: DeasyColor.neutral400,
                                          isSelectable: true,
                                          fontSize: 11.sp,
                                          fontFamily: FontFamily.medium),
                                      Spacer(),
                                      DeasyTextView(
                                          text:
                                              "Rp. ${controller.listTenor[i].installmentAmount.toString().toDecimalFormat()}",
                                          fontColor: DeasyColor.neutral400,
                                          isSelectable: true,
                                          fontSize: 11.sp,
                                          fontFamily: FontFamily.medium)
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Divider(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )),
              ))),
          Obx(() => Visibility(
                visible: controller.isShowErrorTenor.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 10),
                  child: DeasyTextView(
                      text: ContentConstant.tenorCantEmpty,
                      fontSize: 10.sp,
                      isSelectable: true,
                      fontColor: DeasyColor.dmsF46363,
                      fontFamily: FontFamily.medium),
                ),
              )),
        ],
      ),
    );
  }
}
