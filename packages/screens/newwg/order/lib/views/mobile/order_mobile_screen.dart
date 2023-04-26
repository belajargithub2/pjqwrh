part of '../order_screen.dart';

class OrderMobileScreen extends GetWidget<OrderController> {
  const OrderMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.keyboardListener(context);
    return Container(
      color: DeasyColor.neutral50,
      width: 100.w,
      height: controller.stepper.isShowIndicator.value ? 75.h : 87.h,
      child: Stack(
        children: [
          ListView(
            shrinkWrap: true,
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            children: [
              _content(),
            ],
          ),
          _buildBottomButton(),
          _loading(),
          _successDialog(context),
        ],
      ),
    );
  }

  Widget _content() {
    return Column(
      children: [
        _buildOrderForm(),
        _spaceBetween(
          height: 16,
          color: DeasyColor.neutral50,
        ),
        _buildDetailOrder(),
        _buildAddAsset(),
        Obx(() => _spaceBetween(
          height: controller.isKeyboardShow.isTrue ? controller.estimatedAdditionalScrollingHeight : 150,
          color: DeasyColor.neutral50,
        ),),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        color: DeasyColor.neutral000,
        width: 100.w,
        height: 100,
        child: Column(
          children: [
            _spaceBetween(height: 4),
            Expanded(
              child: Row(
                children: [
                  Obx(
                        () => Checkbox(
                      value: controller.isAgree.value,
                      side: BorderSide(
                          width: 2,
                          color: controller.countSubmit.value > 0
                              ? controller.isAgree.isTrue
                              ? DeasyColor.neutral500
                              : DeasyColor.semanticDanger500
                              : DeasyColor.neutral500),
                      activeColor: AppConfig.instance.buttonPrimaryColor,
                      onChanged: (value) {
                        controller.isAgree.value = value!;
                      },
                    ),
                  ),
                  Expanded(
                    child: DeasyTextView(
                      text: StringConstant.isAgree,
                      fontSize: 14.0,
                      maxLines: 2,
                      fontColor: DeasyColor.neutral800,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DeasyPrimaryButton(
                text: StringConstant.submit,
                textStyle: TextStyle(
                  fontSize: 18.0,
                  color: AppConfig.instance.buttonTextPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                color: AppConfig.instance.buttonPrimaryColor,
                onPressed: () {
                  controller.submit();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderForm() {
    return Form(
      key: controller.formKeyProductType,
      child: Container(
        color: DeasyColor.neutral000,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _spaceBetween(height: 16.0),
            DeasyTextView(
              text: StringConstant.submissionData,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.bold,
              fontColor: AppConfig.instance.formTitleColor,
            ),
            const SizedBox(
              height: 4,
            ),
            DeasyTextView(
              text: StringConstant.selectProductLabel,
              fontSize: 12,
              letterSpacing: 0.2,
              fontColor: DeasyColor.neutral600,
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.medium,
            ),
            const SizedBox(
              height: 16,
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
              customValidation: (String value) =>
                  controller.productTypeValidation(value),
              onFieldTap: () => controller.isOpenProductType.toggle(),
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
                  ? _buildProductTypeList()
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
            _spaceBetween(),
          ],
        ),
      ),
    );
  }

  Widget _spaceBetween({
    final double height = 8,
    final double width = 8,
    final Color color = DeasyColor.neutral000,
  }) {
    if (height > 0) {
      return Container(
        width: 200,
        height: height,
        color: color,
      );
    }

    return SizedBox(
      width: width,
    );
  }

  Widget _buildDetailOrder() {
    return Form(
      key: controller.formKey,
      child: Container(
        color: DeasyColor.neutral000,
        child: Obx(
                () => buildMultiAsset(isMultiAsset: controller.isMultiAsset.value)),
      ),
    );
  }

  Widget _buildProductTypeList() {
    return Card(
      color: DeasyColor.neutral000,
      child: Container(
        decoration: BoxDecoration(
          color: DeasyColor.neutral000,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
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
        ),
      ),
    );
  }

  Widget buildMultiAsset({required bool isMultiAsset}) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.listAsset.length,
        itemBuilder: (context, index) {
          return Focus(
            onFocusChange: (_){
              controller.keyboardListener(context);
            },
            child: ItemAsset(
              index: index,
            ),
          );
        });
  }

  Widget _buildAddAsset() {
    return Obx(
          () => Visibility(
        visible: controller.isMultiAsset.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Container(
            decoration: DottedDecoration(
              shape: Shape.box,
              color: AppConfig.instance.buttonPrimaryColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.addNewAsset();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DeasyTextView(
                      text: StringConstant.addOtherProduct,
                      fontColor: AppConfig.instance.buttonPrimaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: FontFamily.medium,
                    ),
                    const SizedBox(
                      width: 7.33,
                    ),
                    Icon(
                      Icons.add,
                      size: 16,
                      color: AppConfig.instance.buttonPrimaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return Obx(
          () => Visibility(
        visible: controller.isLoading.value,
        child: AbsorbPointer(
          absorbing: true,
          child: FullScreenSpinner(),
        ),
      ),
    );
  }

  Widget _successDialog(BuildContext context) {
    return Obx(() {
      if (controller.isSuccessOrder.isTrue) {
        controller.isSuccessOrder.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              barrierDismissible: false,
              buttonOkText: StringConstant.buttonOkText,
              title: StringConstant.dialogSuccessTitle,
              onPressButtonOk: () {
                controller.onBackToDashboard();
              },
              width: 85.w,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              height: 40.h,
              maxlineSubtitle: 6,
              subTitle: StringConstant.dialogSuccessSubTitle,
              fontSizeSubTitle: 14,
              okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
              icon: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: SvgPicture.asset(
                  ImageConstant.icSuccess,
                ),
              ));
        });
      }
      return const SizedBox();
    });
  }
}
