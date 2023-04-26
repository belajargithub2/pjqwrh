part of '../verification_customer_screen.dart';

class VerificationCustomerWebScreen extends GetWidget<VerificationCustomerController> {
  final Function? onBackToDashboard;
  const VerificationCustomerWebScreen({super.key, this.onBackToDashboard});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Container(
        color: DeasyColor.dmsF8F9FC,
        padding: const EdgeInsets.all(24.0),
        child: Stack(
          children: [
            _content(),
            _dialog(context),
            _loading()
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                color: DeasyColor.neutral000,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _customerData(),
                ),
              ),
            ),
            _space(16, direction: Direction.horizontal),
            Expanded(
              child: Card(
                color: DeasyColor.neutral000,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _additionalData(),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _space(
      double value, {
        Direction direction = Direction.vertical,
      }) {
    return direction == Direction.horizontal
        ? SizedBox(width: value)
        : SizedBox(height: value);
  }

  Widget _customerData() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      child: Obx(() => ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              dt.DeasyTextView(
                text: StringConstant.customerData,
                fontSize: 20,
                fontColor: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
              _space(24),
              ImagePreviewWeb(
                title: StringConstant.customerKtp,
                image: controller.getImageFromUrl(controller.verificationCodeValidateModel.value.data!.customerData!.customerPhoto!.urlPhotoKtp!),
              ),
              _space(40),
              TextVerificationConsumer(
                title: StringConstant.noKtp,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.idNumber ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.name,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalName ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.tTL,
                fontSize: 14.0,
                space: 6.0,
            value: "${controller.verificationCodeValidateModel.value.data?.customerData?.birthPlace ?? ""}, ${controller.verificationCodeValidateModel.value.data?.customerData?.birthDate ?? ""}",
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.address,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalAddress ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.rtRw,
                fontSize: 14.0,
                space: 6.0,
            value: "${controller.verificationCodeValidateModel.value.data?.customerData?.legalRt ?? ""} / ${controller.verificationCodeValidateModel.value.data?.customerData?.legalRw ?? ""}",
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.village,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalKelurahan ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.religion,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.religionDescription ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.maritalStatus,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.maritalStatusDescription ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.work,
                fontSize: 14.0,
                space: 6.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.professionDescription ?? '',
              ),
              _space(6.0),
              TextVerificationConsumer(
                title: StringConstant.citizenship,
                fontSize: 14.0,
                space: 6.0,
                value: controller.verificationCodeValidateModel.value.data?.customerData?.nationalityDescription ?? '',
              ),
            ],
          )),
    );
  }

  Widget _additionalData() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      child: Form(
        key: controller.formKey,
        child: Obx(() => ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                VerificationInfo(
                  icon: Icons.info_outline,
                  text: StringConstant.customerDataInfo,
                ),
                _space(24),
                DeasyTextForm.outlinedTextForm(
                  customLabelWidget: dt.DeasyTextView(
                    text: StringConstant.ensureKtp,
                    fontSize: 14.0,
                    maxLines: 2,
                    fontColor: DeasyColor.neutral800,
                    fontFamily: dt.FontFamily.medium,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                  hintText: StringConstant.selectAnswer,
                  readOnly: true,
              customValidation: (value) => controller.checkIfValueEmpty(value),
                  onFieldTap: () => controller.isOpenEnsureKtp.toggle(),
                  suffixIcon: Obx(
                    () => Icon(
                      controller.isOpenEnsureKtp.isTrue
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: DeasyColor.neutral800,
                    ),
                  ),
                  controller: controller.ensureKtpController,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isOpenEnsureKtp.isTrue,
                    child: ListDropdown(
                      list: [StringConstant.selectSame, StringConstant.selectNotSame],
                      onChanged: (value) {
                        controller.onChangeEnsureKtp(value);
                      },
                    ),
                  ),
                ),
                _space(24),
                dt.DeasyTextView(
                  text: StringConstant.ensureCustomerSelfie,
                  fontSize: 14.0,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
                _space(10),
                ImagePreviewWeb(
                  title: StringConstant.selfieCustomer,
                  image: controller.getImageFromUrl(controller.verificationCodeValidateModel.value.data!.customerData!.customerPhoto!.urlPhotoSelfie!),
                ),
                _space(10),
                DeasyTextForm.outlinedTextForm(
                  hintText: StringConstant.selectAnswer,
                  paddingBottom: 0,
                  readOnly: true,
              customValidation: (value) => controller.checkIfValueEmpty(value),
                  onFieldTap: () => controller.isOpenSelfieConsumer.toggle(),
                  suffixIcon: Obx(
                    () => Icon(
                      controller.isOpenSelfieConsumer.isTrue
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: DeasyColor.neutral800,
                    ),
                  ),
                  controller: controller.selfieConsumerController,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isOpenSelfieConsumer.isTrue,
                    child: ListDropdown(
                      list: [StringConstant.selectSame, StringConstant.selectNotSame],
                      onChanged: (value) {
                        controller.onChangeSelfieConsumer(value);
                      },
                    ),
                  ),
                ),
                _space(24),
                DeasyTextForm.outlinedTextForm(
                  customLabelWidget: dt.DeasyTextView(
                    text: StringConstant.ensureCustomerRecommendation,
                    fontSize: 14.0,
                    maxLines: 2,
                    fontColor: DeasyColor.neutral800,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.2,
                  ),
                  hintText: StringConstant.selectAnswer,
                  readOnly: true,
              customValidation: (value) => controller.checkIfValueEmpty(value),
                  onFieldTap: () =>
                      controller.isOpenRecommendationConsumer.toggle(),
                  suffixIcon: Obx(
                    () => Icon(
                      controller.isOpenRecommendationConsumer.isTrue
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: DeasyColor.neutral800,
                    ),
                  ),
                  controller: controller.recommendationConsumerController,
                ),
                Obx(
                  () => Visibility(
                    visible: controller.isOpenRecommendationConsumer.isTrue,
                    child: ListDropdown(
                      list: [StringConstant.selectYes, StringConstant.selectNo],
                      onChanged: (value) {
                        controller.onChangeRecommendationConsumer(value);
                      },
                    ),
                  ),
                ),
                _space(24),
                _footer(),
              ],
            )),
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                    () => Checkbox(
                  value: controller.isAgree.value,
                  side: BorderSide(width: 2, color:
                      controller.countSubmit.value > 0
                          ? controller.isAgree.value
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
                child: dt.DeasyTextView(
                  text: StringConstant.agreeTermsAndCondition,
                  fontSize: 14.0,
                  maxLines: 2,
                  fontColor: DeasyColor.neutral800,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: SizedBox(
              width: 100.w,
              height: 40,
              child: DeasyPrimaryButton(
                text: StringConstant.buttonConfirmation,
                textStyle: const TextStyle(
                  fontSize: 14.0,
                  color: DeasyColor.neutral000,
                  fontWeight: FontWeight.bold,
                ),
                color: AppConfig.instance.buttonPrimaryColor,
                onPressed: () {
                    controller.submit();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dialog(BuildContext context) {
    return Obx(() {
      if (controller.isShowErrorDialog.isTrue) {
        controller.isShowErrorDialog.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              fontSizeTitle: 24.0,
              fontSizeSubTitle: 14.0,
              title: StringConstant.titleDialogFailed,
              onPressButtonOk: () {
                onBackToDashboard!();
              },
              height: 302,
              width: 560,
              buttonOkText: StringConstant.buttonBack,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              subTitle: StringConstant.subTitleDialogFailed,
              icon: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 36.0),
                child: SvgPicture.asset(
                  IconsConstant.icFailed,
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.fill,
                ),
              ));
        });
      }

      if (controller.isShowSuccessDialog.isTrue) {
        controller.isShowSuccessDialog.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              fontSizeTitle: 24.0,
              fontSizeSubTitle: 14.0,
              title: StringConstant.titleDialogSuccess,
              onPressButtonOk: () {
                Get.back();
                controller.goToDokumenTambahanWeb();
              },
              height: 302,
              width: 560,
              buttonOkText: StringConstant.buttonOk,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              subTitle: StringConstant.subTitleDialogSuccess,
              icon: Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 36.0),
                child: SvgPicture.asset(
                  IconsConstant.icSuccess,
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.fill,
                ),
              ));
        });
      }

      return const SizedBox();
    });
  }

  Widget _loading() {
    return Positioned(
      bottom: 50.h,
      left: 0,
      right: 0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Obx(() {
            if (controller.isLoading.isTrue) {
              return FullScreenSpinner();
            } else {
              return const SizedBox();
            }
          }),
        ),
      ),
    );
  }
}