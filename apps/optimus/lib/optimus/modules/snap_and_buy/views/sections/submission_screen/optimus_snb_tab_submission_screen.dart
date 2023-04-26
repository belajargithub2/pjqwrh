import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_custom_paging/deasy_custom_paging.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/controllers/optimus_submission_controller.dart';

class OptimusSnbTabSubmissionScreen
    extends GetWidget<OptimusSubmissionSectionController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 65.h,
      padding: EdgeInsets.only(left: 16, right: 16),
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ListView(
        controller: controller.listviewController,
        shrinkWrap: true,
        children: [
          _labelWidget(),
          _formWidget(),
        ],
      ),
    );
  }

  listItemAsset() {
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
                  hintText: '${ContentConstant.typeToSearch}',
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

  Widget _formWidget() {
    return Obx(() => Form(
        key: controller.formKey,
        autovalidateMode: controller.autoValidate.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditTextWidget(
              controller: controller.phoneNumberController,
              title: ContentConstant.phoneNumberRegisteredOnKreditmu,
              hint: ContentConstant.hintPhoneNumber,
              isNumberOnly: true,
              borderRadius: 4,
              isSelectable: true,
              validation: (value) => controller.phoneNumberValidation(value),
            ),
            EditTextWidget(
              controller: controller.productController,
              title: ContentConstant.selectItem,
              hint: ContentConstant.selectItem,
              borderRadius: 4,
              isReadOnly: true,
              isSelectable: true,
              onFieldTap: () => controller.onProductTap(),
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
              validation: (value) => controller.selectItemValidation(value),
              onChange: (value) =>
                  controller.onChangePriceProduct(value.toString()),
            ),
            SizedBox(height: 16),
            Obx(() => controller.listAssetVisible.value
                ? listItemAsset()
                : SizedBox()),
            EditTextWidget(
              controller: controller.priceController,
              title: ContentConstant.price,
              hint: '0',
              isSelectable: true,
              isNumberOnly: true,
              borderRadius: 4,
              validation: (value) => controller.priceGoodValidation(value),
              onChange: (value) =>
                  controller.onChangePriceProduct(value.toString()),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Spacer(),
                DeasyCustomElevatedButton(
                  text: ContentConstant.seePromoMarketing,
                  textColor: DeasyColor.neutral000,
                  borderColor: DeasyColor.kpYellow500,
                  primary: DeasyColor.kpYellow500,
                  radius: 4,
                  fontSize: 12.sp,
                  paddingButton: 12,
                  onPress: () {
                    controller.checkValidation();
                  },
                ),
              ],
            ),
          ],
        )));
  }

  Widget _labelWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeasyTextView(
          text: ContentConstant.orderData,
          fontSize: 14.sp,
          fontColor: DeasyColor.neutral800,
          fontFamily: FontFamily.bold,
          isSelectable: true,
        ),
        SizedBox(height: 8),
        DeasyTextView(
          text: ContentConstant.labelOrder,
          maxLines: 2,
          isSelectable: true,
          fontSize: 11.sp,
          fontColor: DeasyColor.neutral600,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          height: 1,
          width: double.infinity,
          color: DeasyColor.kpBlue200,
        ),
      ],
    );
  }
}
