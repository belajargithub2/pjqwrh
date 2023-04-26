import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_custom_paging/deasy_custom_paging.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';

class OptimusSnbMobileSubmissionScreen
    extends GetWidget<OptimusSubmissionSectionController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DeasyColor.neutral50,
      width: 100.w,
      height: 79.h,
      child: Stack(
        children: [
          _content(),
          _button(),
        ],
      ),
    );
  }

  Widget listItemAsset() {
    return Container(
        color: DeasyColor.neutral000,
        height: 325,
        width: 400,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: DeasyColor.semanticInfo300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: DeasyColor.kpBlue200),
                  ),
                  hintText: ContentConstant.typeToSearch,
                  suffixIcon:
                      Icon(Icons.search, color: DeasyColor.semanticInfo300),
                ),
                controller: controller.searchControllerAsset,
                readOnly: false,
                onTap: () {
                  controller.fetchApiAsset();
                },
                obscureText: false,
                onChanged: (String text) async {
                  controller.onChangeFindAsset(text);
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: RefreshIndicator(
                onRefresh: controller.refreshAsset,
                child: Obx(
                  () => DeasyCustomPaging(
                    isFinish: controller.countAsset.value ==
                        controller.assetDropdownList.length,
                    onLoadMore: controller.loadMore,
                    child: ListView.builder(
                      primary: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(() => InkWell(
                              onTap: () {
                                controller.onTapAsset(
                                    controller.assetDropdownList[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                child: Text(controller
                                    .assetDropdownList[index].assetName!),
                                height: 40.0,
                                alignment: Alignment.centerLeft,
                              ),
                            ));
                      },
                      itemCount: controller.assetDropdownList.length,
                    ),
                    whenEmptyLoad: false,
                    delegate: DefaultLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container()),
          ],
        ));
  }

  Widget _content() {
    return Container(
      color: DeasyColor.neutral000,
      width: 100.w,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        controller: controller.listviewController,
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 15,
          ),
          DeasyTextView(
            text: ContentConstant.orderData,
            fontSize: 18.sp,
            fontColor: DeasyColor.neutral800,
            fontFamily: FontFamily.bold,
          ),
          SizedBox(height: 8),
          DeasyTextView(
            text: ContentConstant.labelOrder,
            maxLines: 2,
            fontSize: 14.sp,
            fontColor: DeasyColor.neutral600,
          ),
          SizedBox(height: 8),
          Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EditTextWidget(
                    controller: controller.phoneNumberController,
                    title: ContentConstant.phoneNumber,
                    hint: ContentConstant.phoneNumberHint,
                    isNumberOnly: true,
                    borderRadius: 8,
                    fontSize: 15.sp,
                    extraFontSize: 13.5.sp,
                    isSelectable: true,
                    validation: (value) =>
                        controller.phoneNumberValidation(value),
                  ),
                  EditTextWidget(
                    controller: controller.productController,
                    title: ContentConstant.selectItem,
                    hint: ContentConstant.selectItem,
                    isNumberOnly: true,
                    borderRadius: 8,
                    isReadOnly: true,
                    fontSize: 15.sp,
                    extraFontSize: 13.5.sp,
                    isSelectable: true,
                    widgetSuffix: Obx(() => controller.listAssetVisible.isTrue
                        ? Icon(
                            Icons.keyboard_arrow_up_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )),
                    validation: (value) =>
                        controller.selectItemValidation(value),
                    onFieldTap: () => controller.onProductTap(),
                  ),
                  Obx(() => controller.listAssetVisible.value
                      ? listItemAsset()
                      : SizedBox()),
                  EditTextWidget(
                    controller: controller.priceController,
                    title: ContentConstant.price,
                    hint: "0",
                    isNumberOnly: true,
                    borderRadius: 8,
                    fontSize: 15.sp,
                    extraFontSize: 13.5.sp,
                    isSelectable: true,
                    onChange: (value) => controller.onChangePriceProduct(value),
                    validation: (value) =>
                        controller.priceGoodValidation(value),
                  ),
                  SizedBox(height: 16),
                ],
              )),
        ],
      ),
    );
  }

  Widget _button() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        width: DeasySizeConfigUtils.screenWidth,
        color: DeasyColor.neutral000,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: DeasyCustomElevatedButton(
            text: "${ContentConstant.seePromoMarketing}",
            textColor: DeasyColor.neutral000,
            borderColor: DeasyColor.kpYellow500,
            primary: DeasyColor.kpYellow500,
            paddingButton: 14,
            onPress: () {
              controller.checkValidation();
            },
          ),
        ),
      ),
    );
  }
}
