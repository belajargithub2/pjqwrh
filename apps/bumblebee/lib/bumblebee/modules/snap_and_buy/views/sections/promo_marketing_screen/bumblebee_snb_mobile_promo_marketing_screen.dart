import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_circular_checkbox/deasy_circular_checkbox.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/models/bumblebee_list_promo_marketing_response.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/controllers/bumblebee_promo_marketing_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_ringkasan_belanja_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/widgets/bumblebee_snb_skema_pembayaran_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/text_field.dart';
import 'package:select_dialog/select_dialog.dart';

class BumblebeeSnbMobilePromoMarketingScreen
    extends GetWidget<BumblebeePromoMarketingController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DeasyColor.neutral50,
      width: 100.w,
      height: 79.h,
      child: Stack(
        children: [
          Form(
            key: controller.formKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                _cardPromoMarketing(),
                SizedBox(
                  height: 20,
                ),
                _cardInformasiPenggunaanLimit(),
                Container(
                  height: DeasySizeConfigUtils.screenHeight! / 10.0,
                  color: DeasyColor.neutral50,
                ),
              ],
            ),
          ),
          Obx(() => _submit()),
        ],
      ),
    );
  }

  Widget _submit() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: DeasySizeConfigUtils.screenWidth,
        color: DeasyColor.neutral000,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DeasyCustomElevatedButton(
            text: "Submit",
            textColor: DeasyColor.neutral000,
            borderColor: controller.btnSubmitIsValid.isTrue
                ? DeasyColor.kpYellow500
                : DeasyColor.neutral400,
            primary: controller.btnSubmitIsValid.isTrue
                ? DeasyColor.kpYellow500
                : DeasyColor.neutral400,
            paddingButton: 12,
            onPress: () {
              controller.submit();
            },
          ),
        ),
      ),
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
          SizedBox(height: 12.0),
          DeasyTextView(
              text: ContentConstant.promoMarketing,
              fontColor: DeasyColor.neutral900,
              fontSize: 18.sp,
              fontFamily: FontFamily.bold),
          SizedBox(height: 8.0),
          DeasyTextView(
              text: ContentConstant.labelOrder,
              fontColor: DeasyColor.neutral400,
              maxLines: 2,
              fontSize: 14.sp,
              fontFamily: FontFamily.medium),
          SizedBox(height: 10),
          EditTextWidget(
            controller: controller.promoController,
            title: ContentConstant.specialOffer,
            hint: ContentConstant.selectPromo,
            borderRadius: 8,
            isReadOnly: true,
            fontSize: 15.sp,
            extraFontSize: 13.5.sp,
            isSelectable: true,
            onFieldTap: () {
              SelectDialog.showModal<Program>(
                Get.context!,
                items: controller.bumblebeeSnapAndBuyBaseController
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
            widgetSuffix: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 34,
              color: DeasyColor.neutral400,
            ),
            validation: (value) => controller.selectPromoValidation(value),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Obx(() => Visibility(
                      visible: controller.isShowTextFieldDp.value,
                      child: EditTextWidget(
                        controller: controller.dpController,
                        title: ContentConstant.dpLabel,
                        isSelectable: true,
                        hint: '0',
                        fontSize: 15.sp,
                        extraFontSize: 13.5.sp,
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
                  flex: 1,
                  child: Obx(() => Visibility(
                        visible: controller.isShowButtonTenor.value,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: 8.0,
                              top: controller.isShowTextFieldDp.value ? 0 : 8),
                          child: DeasyCustomElevatedButton(
                            text: controller.btnTenorIsEdit.value
                                ? ContentConstant.editTenor
                                : ContentConstant.calculateTenor,
                            textColor: controller.dpIsValid.value
                                ? DeasyColor.kpYellow500
                                : DeasyColor.neutral400,
                            borderColor: controller.dpIsValid.value
                                ? DeasyColor.kpYellow500
                                : DeasyColor.neutral400,
                            primary: DeasyColor.neutral000,
                            radius: 8,
                            paddingButton:
                                controller.btnTenorIsEdit.value ? 15 : 9,
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
                  fontSize: 15.sp,
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
                        return InkWell(
                          onTap: () {
                            controller.onTapTenor(i);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 6.0, right: 6.0, top: 12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Obx(() => DeasyCircularCheckBox(
                                          size: 20,
                                          isEnable: true,
                                          isChecked:
                                              controller.indexTenor.value == i,
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
                                        fontSize:
                                            DeasySizeConfigUtils.blockVertical *
                                                1.7,
                                        fontFamily: FontFamily.medium),
                                    Spacer(),
                                    DeasyTextView(
                                        text:
                                            "Rp. ${controller.listTenor[i].installmentAmount.toString().toDecimalFormat()}",
                                        fontColor: DeasyColor.neutral400,
                                        fontSize:
                                            DeasySizeConfigUtils.blockVertical *
                                                1.7,
                                        fontFamily: FontFamily.medium)
                                  ],
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ))),
          Obx(() => Visibility(
                visible: controller.isShowErrorTenor.value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 23, bottom: 10),
                  child: DeasyTextView(
                      text: ContentConstant.tenorCantEmpty,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.4,
                      fontColor: DeasyColor.dmsF46363,
                      fontFamily: FontFamily.medium),
                ),
              )),
        ],
      ),
    );
  }

  Widget _cardInformasiPenggunaanLimit() {
    return Obx(() => Visibility(
          visible: controller.isShowShoppingSummaryMobile.value,
          child: Container(
            color: DeasyColor.neutral000,
            width: DeasySizeConfigUtils.screenWidth,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(height: 15.0),
                Obx(() => DeasyTextView(
                    text:
                        "${controller.bumblebeeSnapAndBuyBaseController.prospectId.value}",
                    fontSize: 16.sp,
                    fontColor: DeasyColor.kpBlue600,
                    fontFamily: FontFamily.medium)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Divider(),
                ),
                DeasyTextView(
                    text: ContentConstant.usageInformationLimit,
                    fontSize: 17.sp,
                    fontFamily: FontFamily.medium),
                SizedBox(height: 8.0),
                DeasyTextView(
                    text: ContentConstant.makeSurePromoMarketing,
                    fontColor: DeasyColor.neutral400,
                    maxLines: 3,
                    fontSize: 14.5.sp,
                    fontFamily: FontFamily.medium),
                SizedBox(height: 30),
                Obx(() => bumblebeeRingkasanBelanjaWidget(
                      controller.bumblebeeSubmissionSectionController.assetModel
                          .value,
                      controller.bumblebeeSubmissionSectionController,
                      controller.tenorModel.value,
                      controller.bumblebeeSnapAndBuyBaseController,
                      controller.inputDp.value,
                    )),
                SizedBox(height: 30),
                Obx(() => controller.tenorModel.value.tenor == null
                    ? SizedBox()
                    : bumblebeeRingkasanSkemaPembayaranWidget(
                        controller.tenorModel.value)),
                SizedBox(height: 10.0),
              ],
            ),
          ),
        ));
  }
}
