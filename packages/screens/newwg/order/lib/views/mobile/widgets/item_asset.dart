import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:order/controllers/order_controller.dart';
import 'package:order/data/constants/string_constant.dart';
import 'package:order/views/widgets/asset_pagination.dart';

class ItemAsset extends GetWidget<OrderController> {
  final int? index;

  const ItemAsset({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _content(),
      _footer(),
    ]);
  }

  Widget _content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Obx(() => DeasyTextView(
            text: "${StringConstant.detailProduct}${controller.isMultiAsset.isTrue ? index! + 1 : ""}",
            fontSize: 16,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.bold,
          )),
          const SizedBox(height: 16),
          Obx(() => DeasyTextForm.outlinedTextForm(
            customLabelWidget: DeasyTextView(
              text: StringConstant.selectProduct,
              fontSize: 14.0,
              maxLines: 2,
              fontColor: DeasyColor.neutral800,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.medium,
              letterSpacing: 0.2,
            ),
            readOnly: true,
            onFieldTap: () {
              controller.onTapProduct(index!);
            },
            isDisabled: controller.isDisableDetailProduct.isTrue,
            hintText: StringConstant.selectProductHint,
            prefixIcon: const Icon(
              Icons.search,
              color: DeasyColor.neutral500,
            ),
            controller: controller.listAsset[index!].name,
            customValidation: (String value) => controller.productValidation(value),
          )),
          _listProductByCategory(),
          const SizedBox(height: 16),
          Obx(() => DeasyTextForm.outlinedTextForm(
            customLabelWidget: DeasyTextView(
              text: StringConstant.priceProduct,
              fontSize: 14.0,
              maxLines: 2,
              fontColor: DeasyColor.neutral800,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.medium,
              letterSpacing: 0.2,
            ),
            textInputType: TextInputType.number,
            isNumberOnly: true,
            maxInputLength: controller.maxInputPriceLength,
            hintText: "0",
            onChange: (String value) {
              if (value.isNotEmpty) {
                controller.listAsset[index!].price = int.parse(value);
                value = "Rp. ${value.toString().toDecimalFormat()}";
                controller.listAsset[index!].priceController?.value = TextEditingValue(
                  text: value,
                  selection: TextSelection.collapsed(offset: value.length),
                );
              }
            },
            readOnly: controller.isDisableDetailProduct.isTrue,
            isDisabled: controller.isDisableDetailProduct.isTrue,
            customValidation: (String value) => controller.priceValidation(value, index!),
            controller: controller.listAsset[index!].priceController,
          )),
          const SizedBox(height: 16),
          _buildQtyProduct(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      width: double.infinity,
      height: 16,
      color: DeasyColor.neutral50,
    );
  }

  Widget _buildQtyProduct() {
    return Obx(() => Visibility(
        visible: controller.isMultiAsset.isTrue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: index != 0,
              child: InkWell(
                onTap: () => controller.deleteAsset(index!),
                child: DeasyTextView(
                  text: StringConstant.delete,
                  fontColor: AppConfig.instance.buttonPrimaryColor,
                ),
              ),
            ),
            const Spacer(),
            DeasyTextView(
              text: StringConstant.qtyLabel,
              fontColor: AppConfig.instance.buttonPrimaryColor,
            ),
            const SizedBox(
              width: 8,
            ),
            ClipOval(
              child: Material(
                color: controller.listAsset[index!].qty! < 2
                    ? DeasyColor.neutral200
                    : AppConfig.instance.buttonPrimaryColor,
                child: InkWell(
                  onTap: () => controller.minusQty(index!),
                  child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.remove,
                        size: 15,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: DeasyTextView(
                text: controller.listAsset[index!].qty.toString(),
                fontFamily: FontFamily.medium,
                letterSpacing: 0.2,
                fontColor: DeasyColor.neutral600,
              ),
            ),
            ClipOval(
              child: Material(
                color: AppConfig.instance.buttonPrimaryColor,
                child: InkWell(
                  onTap: () => controller.addQty(index!),
                  child: const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.add,
                        size: 15,
                      )),
                ),
              ),
            ),
          ],
        )));
  }

  Widget _listProductByCategory() {
    return Obx(() => Visibility(
      visible: controller.listAsset[index!].isSearchProduct ?? false,
      child: Container(
          color: DeasyColor.neutral000,
          height: 325,
          width: 400,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: DeasyColor.kpBlue600),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: DeasyColor.kpBlue200),
                    ),
                    hintText: StringConstant.searchProduct,
                    suffixIcon: const Icon(Icons.search, color: DeasyColor.kpBlue600),
                  ),
                  controller: controller.searchController,
                  readOnly: false,
                  obscureText: false,
                  onChanged: (String text) async {
                    controller.onchangeProduct(text);
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Obx(
                      () => OrderPagination(
                    isFinish: controller.countRecord.value == controller.listWhiteGoods.length,
                    onLoadMore: controller.loadMore,
                    whenEmptyLoad: false,
                    delegate: const DefaultLoadMoreDelegate(),
                    textBuilder: DefaultLoadMoreTextBuilder.indonesia,
                    child: ListView.builder(
                      primary: false,
                      itemBuilder: (BuildContext context, int i) {
                        return Obx(() => InkWell(
                          onTap: () {
                            controller.selectProduct(controller.listWhiteGoods[i], index!);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            height: 40.0,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.listWhiteGoods[i].description!),
                          ),
                        ));
                      },
                      itemCount: controller.listWhiteGoods.length,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}
