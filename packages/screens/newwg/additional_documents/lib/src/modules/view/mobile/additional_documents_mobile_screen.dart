part of '../additional_documents_screen.dart';

class AdditionalDocumentsMobileScreen
    extends GetWidget<AdditionalDocumentsController> {
  const AdditionalDocumentsMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _customerPhotoSection(),
        _space(16),
        _footer(),
      ],
    );
  }

  Widget _space(double value) {
    return SizedBox(height: value);
  }

  Widget _customerPhotoSection() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.fromLTRB(15.0, 10, 15.0, 0),
      child: Obx(
        () => ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            dt.DeasyTextView(
              text: StringConstant.additionalDocs,
              fontSize: 16.0,
              fontColor: AppConfig.instance.formTitleColor,
              fontWeight: FontWeight.w700,
              fontFamily: dt.FontFamily.bold,
              letterSpacing: 0.2,
            ),
            _space(16),
            controller.ktpUrl.isNotEmpty
                ? ImagePreview(
                    title: StringConstant.customerPhotoKtp,
                    image: controller.getImageFromUrl(controller.ktpUrl.value),
                    onTap: () => _handleAction(
                        StringConstant.takePhotoKtp, photoTypes.ktp),
                  )
                : FramePreviewMobile(
                    description: StringConstant.customerPhotoKtp,
                    errorMessage: StringConstant.ktpRequired,
                    isError: controller.isKtpFilled.isFalse,
                    borderColor: controller.isKtpFilled.isFalse
                        ? DeasyColor.dmsF64E60
                        : DeasyColor.neutral300,
                    onTap: () => _handleAction(
                        StringConstant.takePhotoKtp, photoTypes.ktp),
                  ),
            _space(16),
            controller.selfieUrl.isNotEmpty
                ? ImagePreview(
                    title: StringConstant.customerPhotoSelfie,
                    image:
                        controller.getImageFromUrl(controller.selfieUrl.value),
                    onTap: () => _handleAction(StringConstant.takePhotoKtp,
                        photoTypes.selfieWithOfficer),
                  )
                : FramePreviewMobile(
                    description: StringConstant.customerPhotoSelfie,
                    errorMessage: StringConstant.selfieRequired,
                    isError: controller.isSelfieFilled.isFalse,
                    borderColor: controller.isSelfieFilled.isFalse
                        ? DeasyColor.dmsF64E60
                        : DeasyColor.neutral300,
                    onTap: () => _handleAction(StringConstant.takePhotoKtp,
                        photoTypes.selfieWithOfficer),
                  ),
            _space(16),
          ],
        ),
      ),
    );
  }

  Widget _footer() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.all(16.0),
      child: DeasyPrimaryButton(
        text: StringConstant.buttonConfirmation,
        radius: 8.0,
        padding: const EdgeInsets.all(8.0),
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
    );
  }

  Widget _uploadDialog() {
    return controller.isLoading.isTrue ? FullScreenSpinner() : _cameraWidget();
  }

  Widget _cameraWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        dt.DeasyTextView(
          text: StringConstant.takePhoto,
          fontSize: 20.0,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 24.0),
        SizedBox(
          height: 335.0,
          child: CameraPreview(controller.cameraController.value!),
        ),
        const SizedBox(height: 24.0),
        Material(
          color: AppConfig.instance.buttonPrimaryColor,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: () => controller.takePicture(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  dt.DeasyTextView(
                    text: StringConstant.photo,
                    textAlign: TextAlign.center,
                    fontColor: DeasyColor.neutral000,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(width: 6),
                  const Icon(
                    Icons.camera_alt,
                    color: DeasyColor.neutral000,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _dialogPreview({required String title, required String subTitle}) {
    return controller.isLoading.isTrue
        ? FullScreenSpinner()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              dt.DeasyTextView(
                text: title,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 24.0),
              dt.DeasyTextView(
                text: subTitle,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontColor: DeasyColor.neutral400,
              ),
              const SizedBox(height: 40.0),
              Image.memory(
                controller.imageBytes.value!,
                fit: BoxFit.cover,
                height: 335.0,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DeasyCustomActionButton(
                    text: StringConstant.rePhoto,
                    onPressed: () {
                      controller.activateCamera();
                    },
                    textColor: AppConfig.instance.buttonPrimaryColor,
                    bgColor: DeasyColor.neutral000,
                    borderColor: AppConfig.instance.buttonPrimaryColor,
                  ),
                  DeasyCustomActionButton(
                    text: StringConstant.upload,
                    onPressed: () {
                      controller.uploadPhoto();
                    },
                    bgColor: AppConfig.instance.buttonPrimaryColor,
                    borderColor: AppConfig.instance.buttonPrimaryColor,
                  ),
                ],
              ),
            ],
          );
  }

  void _handleAction(String title, photoTypes type) {
    if (!kIsWeb) {
      var args = {
        "mobile_phone": controller.phoneNumber.value,
        "type_id": type
      };
      Get.toNamed(
        NewWgAdditionalDocumentsRoutes.NEWWG_ADD_DOCS_TAKE_PHOTO,
        arguments: args,
      );
    } else {
      controller.activateCamera();
      controller.selectType(type);
      DeasyBaseDialogs.getInstance().customContentDialog(
        context: Get.context!,
        width: 100.w,
        height: 70.h,
        barrierDismissible: controller.previewImagePath.isEmpty,
        content: Obx(
          () => controller.previewImagePath.isEmpty &&
                  controller.cameraInitialized.isTrue
              ? _uploadDialog()
              : _dialogPreview(
                  title: StringConstant.reviewCustomerKtp,
                  subTitle: StringConstant.ensureKtp,
                ),
        ),
      );
    }
  }
}
