part of '../order_screen.dart';

class OrderWebScreen extends GetWidget<OrderController> {
  final Function? onBackToDashboard;
  const OrderWebScreen({super.key, this.onBackToDashboard});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        color: DeasyColor.dmsF8F9FC,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Stack(
          children: [
            _content(),
            _loading(),
            _dialog(context),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return ListView(physics: const BouncingScrollPhysics(), children: [
      _dataOrder(),
      const SizedBox(height: 16),
      _detailProduct(),
      _additionalCard(),
      const SizedBox(height: 16),
      _footer(),
    ]);
  }

  Widget _dataOrder() {
    return Form(
      key: controller.formKeyProductType,
      child: Container(
        decoration: BoxDecoration(
          color: DeasyColor.neutral000,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 16.0),
            DeasyTextView(
              text: StringConstant.submissionData,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.bold,
            ),
            const SizedBox(
              height: 4,
            ),
            DeasyTextView(
              text: StringConstant.selectProductLabel,
              fontSize: 14,
              letterSpacing: 0.2,
              fontColor: DeasyColor.neutral600,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.medium,
            ),
            const SizedBox(
              height: 24,
            ),
            DeasyTextForm.outlinedTextForm(
              customLabelWidget: DeasyTextView(
                text: StringConstant.productType,
                fontSize: 14.0,
                maxLines: 2,
                fontColor: DeasyColor.neutral800,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.medium,
                letterSpacing: 0.2,
              ),
              hintText: StringConstant.selectProductType,
              readOnly: true,
              onFieldTap: () => controller.isOpenProductType.toggle(),
              customValidation: (String value) =>
                  controller.productTypeValidation(value),
              suffixIcon: Obx(
                () => controller.isOpenProductType.value
                    ? const Icon(
                        Icons.keyboard_arrow_up,
                        color: DeasyColor.neutral800,
                      )
                    : const Icon(
                        Icons.keyboard_arrow_down,
                        color: DeasyColor.neutral800,
                      ),
              ),
              controller: controller.productTypeController,
            ),
            Obx(
              () => controller.isOpenProductType.value
                  ? _productType()
                  : const SizedBox(),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: DeasyColor.kpBlue600,
                    size: 12,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DeasyTextView(
                      text: StringConstant.productTypeLabel,
                      fontSize: 12.0,
                      maxLines: 3,
                      fontColor: DeasyColor.kpBlue600,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _productType() {
    return Card(
      color: DeasyColor.neutral000,
      child: Container(
        decoration: BoxDecoration(
          color: DeasyColor.neutral000,
          borderRadius: BorderRadius.circular(5),
        ),
        child: controller.getGroupCategoryModel.value.data != null
            ? ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.getGroupCategoryModel.value.data?.length,
                itemBuilder: (context, index) {
                  final data = controller.getGroupCategoryModel.value.data![index];
                  return InkWell(
                    onTap: () {
                      controller.onTapProductType(data);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DeasyTextView(
                            text: data.name,
                            fontSize: 14.0,
                            maxLines: 2,
                            fontColor: DeasyColor.neutral800,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.medium,
                            letterSpacing: 0.2,
                          ),
                          DeasyTextView(
                            text: data.notes,
                            fontSize: 14.0,
                            maxLines: 2,
                            fontColor: DeasyColor.neutral400,
                            fontWeight: FontWeight.w500,
                            fontFamily: FontFamily.medium,
                            letterSpacing: 0.2,
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _detailProduct() {
    return Form(
      key: controller.formKey,
      child: Container(
        color: DeasyColor.neutral000,
        child: Obx(() => controller.listAsset.isEmpty ? const SizedBox() : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.listAsset.length,
                itemBuilder: (context, index) {
                  return ItemAssetWeb(
                    index: index,
                  );
                })),
      ),
    );
  }

  Widget _additionalCard() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        children: [
          Obx(
            () => Checkbox(
              value: controller.isAgree.value,
              activeColor: DeasyColor.kpYellow500,
              side: BorderSide(width: 2, color:
              controller.countSubmit.value > 0
                      ? controller.isAgree.isTrue
                          ? DeasyColor.neutral500
                          : DeasyColor.semanticDanger500
                      : DeasyColor.neutral500),
              onChanged: (value) {
                controller.isAgree.value = value!;
              },
            ),
          ),
          const SizedBox(
            width: 9.0,
          ),
          Expanded(
            child: DeasyTextView(
              text: StringConstant.isAgree,
              fontSize: 12.0,
              maxLines: 2,
              fontColor: DeasyColor.neutral500,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Row(
        children: [
          const Spacer(),
          Obx(() => Visibility(
                visible: controller.isMultiAsset.isTrue,
                child: InkWell(
                  onTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.addNewAsset();
                    }
                  },
                  child: Container(
                    decoration: DottedDecoration(
                      shape: Shape.box,
                      color: DeasyColor.kpYellow500,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    width: 240.0,
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DeasyTextView(
                          text: StringConstant.addOtherProduct,
                          fontColor: DeasyColor.kpYellow500,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: FontFamily.medium,
                        ),
                        const SizedBox(
                          width: 7.33,
                        ),
                        const Icon(
                          Icons.add,
                          size: 16,
                          color: DeasyColor.kpYellow500,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          const SizedBox(
            width: 16.0,
          ),
          SizedBox(
              width: 240.0,
              height: 40.0,
              child: DeasyCustomButton(text: StringConstant.submit, onPressed: () {
                    controller.submit();
                  })),
        ],
      ),
    );
  }

  Widget _loading() {
    return Obx(() => controller.isLoading.isTrue
        ? FullScreenSpinner()
        : const SizedBox());
  }

  Widget _dialog(BuildContext context) {
    return Obx(() {
      if (controller.isSuccessOrder.isTrue) {
        controller.isSuccessOrder.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              barrierDismissible: false,
              title: StringConstant.dialogSuccessTitle,
              fontSizeTitle: 20.0,
              fontSizeSubTitle: 14.0,
              onPressButtonOk: () {
                onBackToDashboard!();
              },
              buttonOkText: StringConstant.buttonOkText,
              width: 560,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              height: 280,
              subTitle: StringConstant.dialogSuccessSubTitle,
              icon: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SvgPicture.asset(
                  ImageConstant.icSuccess,
                  width: 64,
                  height: 63,
                ),
              ));
        });
      }
      return const SizedBox();
    });
  }
}
