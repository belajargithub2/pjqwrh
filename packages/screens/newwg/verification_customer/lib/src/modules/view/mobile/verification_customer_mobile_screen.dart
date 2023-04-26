part of '../verification_customer_screen.dart';

class VerificationCustomerMobileScreen extends GetWidget<VerificationCustomerController> {
  final Function? onSubmitted;
  const VerificationCustomerMobileScreen({super.key, required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 75.h,
      child: Stack(
        children: [
          _content(),
          _dialog(context),
          _loading()
        ],
      ),
    );
  }

  Widget _content() {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: [
        _customerDataSection(),
        _cardSpacer(),
        _additionalData(),
        _cardSpacer(),
        _footer(),
      ],
    );
  }

  Widget _space(double value) {
    return SizedBox(height: value);
  }

  Widget _cardSpacer() {
    return Container(
      width: double.infinity,
      height: 16,
      color: DeasyColor.neutral100,
    );
  }

  Widget _customerDataSection() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      child: Obx(() => controller.verificationCodeValidateModel.value.data != null
          ? ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          dt.DeasyTextView(
            text: StringConstant.customerData,
            fontSize: 16.0,
            fontColor: DeasyColor.neutral800,
            fontWeight: FontWeight.w700,
            fontFamily: dt.FontFamily.bold,
            letterSpacing: 0.2,
          ),
          _space(16),
          ImagePreviewMobile(
            title: StringConstant.customerKtp,
            image: controller.getImageFromUrl(controller.verificationCodeValidateModel.value.data!.customerData!.customerPhoto!.urlPhotoKtp!),
          ),
          _space(30),
          TextVerificationCustomerMobile(
            title: StringConstant.noKtp,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.idNumber ?? "",
            fontSize: 14.0,
            space: 8.0,
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.name,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalName ?? "",
            fontSize: 14.0,
            space: 8.0,
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.tTL,
            value: "${controller.verificationCodeValidateModel.value.data?.customerData?.birthPlace ?? ""}, ${controller.verificationCodeValidateModel.value.data?.customerData?.birthDate ?? ""}",
            fontSize: 14.0,
            space: 8.0,
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.address,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalAddress ?? "",
            fontSize: 14.0,
            space: 8.0,
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.rtRw,
            fontSize: 14.0,
            space: 8.0,
            value: "${controller.verificationCodeValidateModel.value.data?.customerData?.legalRt ?? ""} / ${controller.verificationCodeValidateModel.value.data?.customerData?.legalRw ?? ""}",
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.village,
            fontSize: 14.0,
            space: 8.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.legalKelurahan ?? "",
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.religion,
            fontSize: 14.0,
            space: 8.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.religionDescription ?? "",
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.maritalStatus,
            fontSize: 14.0,
            space: 8.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.maritalStatusDescription ?? "",
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.work,
            fontSize: 14.0,
            space: 8.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.professionDescription ?? "",
          ),
          _space(12),
          TextVerificationCustomerMobile(
            title: StringConstant.citizenship,
            fontSize: 14.0,
            space: 8.0,
            value: controller.verificationCodeValidateModel.value.data?.customerData?.nationalityDescription ?? "",
          ),
        ],
      )
          : const SizedBox()),
    );
  }

  Widget _additionalData() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      child: Form(
        key: controller.formKey,
        child: Obx(() => controller.verificationCodeValidateModel.value.data != null
            ? ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            VerificationInfo(
              icon: Icons.info_outline,
              text: StringConstant.customerDataInfo,
            ),
            _space(32),
            DeasyTextForm.outlinedTextForm(
              customLabelWidget: dt.DeasyTextView(
                text: StringConstant.ensureKtp,
                fontSize: 14.0,
                maxLines: 2,
                fontColor: DeasyColor.neutral800,
                fontWeight: FontWeight.w500,
                fontFamily: dt.FontFamily.medium,
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
            _space(30),
            dt.DeasyTextView(
              text: StringConstant.ensureCustomerSelfie,
              fontSize: 14.0,
              maxLines: 2,
              fontColor: DeasyColor.neutral800,
              fontWeight: FontWeight.w500,
              fontFamily: dt.FontFamily.medium,
              letterSpacing: 0.2,
            ),
            _space(10),
            ImagePreviewMobile(
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
            _space(30),
            DeasyTextForm.outlinedTextForm(
              customLabelWidget: dt.DeasyTextView(
                text: StringConstant.ensureCustomerRecommendation,
                fontSize: 14.0,
                maxLines: 2,
                fontColor: DeasyColor.neutral800,
                fontWeight: FontWeight.w500,
                fontFamily: dt.FontFamily.medium,
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
            _space(20)
          ],
        )
            : const SizedBox(),
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      color: DeasyColor.neutral000,
      child: Column(
        children: [
          Row(
            children: [
              Obx(() => Checkbox(
                  value: controller.isAgree.value,
                      side: BorderSide(width: 2, color:
                      controller.countSubmit.value > 0
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
            padding: const EdgeInsets.all(16.0),
            child: DeasyPrimaryButton(
              text: StringConstant.buttonConfirmation,
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
    );
  }

  Widget _dialog(BuildContext context) {
    return Obx(() {
      if (controller.isShowErrorDialog.isTrue) {
        controller.isShowErrorDialog.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              title: StringConstant.titleDialogFailed,
              onPressButtonOk: () {
                controller.onBackToDashboard();
              },
              okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
              width: 85.w,
              buttonOkText: StringConstant.buttonBack,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              height: 40.h,
              barrierDismissible: false,
              subTitle: StringConstant.subTitleDialogFailed,
              fontSizeSubTitle: 14,
              icon: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: SvgPicture.asset(
                  IconsConstant.icFailed,
                ),
              ));
        });
      }

      if (controller.isShowSuccessDialog.isTrue) {
        controller.isShowSuccessDialog.toggle();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          DeasyBaseDialogs.getInstance().iconDialog(
              context: context,
              title: StringConstant.titleDialogSuccess,
              onPressButtonOk: () {
                onSubmitted!(controller.verificationCodeValidateModel.value.data!.customerId);
                Get.back();
              },
              okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
              width: 85.w,
              buttonOkText: StringConstant.buttonOk,
              barrierDismissible: false,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              height: 40.h,
              subTitle: StringConstant.subTitleDialogSuccess,
              fontSizeSubTitle: 14,
              icon: Padding(
                padding: const EdgeInsets.only(top: 14),
                child: SvgPicture.asset(
                  IconsConstant.icSuccess,
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