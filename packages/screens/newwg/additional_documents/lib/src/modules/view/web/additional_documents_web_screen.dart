part of '../additional_documents_screen.dart';

class AdditionalDocumentsWebScreen
    extends GetWidget<AdditionalDocumentsController> {
  const AdditionalDocumentsWebScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DeasyColor.dmsF8F9FC,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _customerPhotoSection(),
      ),
    );
  }

  Widget _customerPhotoSection() {
    return Container(
      color: DeasyColor.neutral000,
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          dt.DeasyTextView(
            text: StringConstant.additionalDocs,
            fontSize: 20.0,
            fontColor: DeasyColor.neutral800,
            // todo: NEWWG-209 change based on App Config (ihsan)
            fontWeight: FontWeight.w700,
            fontFamily: dt.FontFamily.bold,
            letterSpacing: 0.2,
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => controller.ktpUrl.isNotEmpty
                      ? ImagePreview(
                          title: StringConstant.customerPhotoKtp,
                          image: controller
                              .getImageFromUrl(controller.ktpUrl.value),
                          onTap: () => _handleAction(
                            StringConstant.reviewCustomerKtp,
                            StringConstant.ensureKtp,
                            photoTypes.ktp,
                          ),
                        )
                      : FramePreviewMobile(
                          description: StringConstant.customerPhotoKtp,
                          errorMessage: StringConstant.ktpRequired,
                          isError: controller.isKtpFilled.isFalse,
                          borderColor: controller.isKtpFilled.isFalse
                              ? DeasyColor.dmsF64E60
                              : DeasyColor.neutral300,
                          onTap: () => _handleAction(
                            StringConstant.reviewCustomerKtp,
                            StringConstant.ensureKtp,
                            photoTypes.ktp,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 24.0),
              Expanded(
                child: Obx(
                  () => controller.selfieUrl.isNotEmpty
                      ? ImagePreview(
                          title: StringConstant.customerPhotoSelfie,
                          image: controller
                              .getImageFromUrl(controller.selfieUrl.value),
                          onTap: () => _handleAction(
                            StringConstant.reviewCustomerSelfie,
                            StringConstant.ensureKtp,
                            photoTypes.selfieWithOfficer,
                          ),
                        )
                      : FramePreviewMobile(
                          description: StringConstant.customerPhotoSelfie,
                          errorMessage: StringConstant.selfieRequired,
                          isError: controller.isSelfieFilled.isFalse,
                          borderColor: controller.isSelfieFilled.isFalse
                              ? DeasyColor.dmsF64E60
                              : DeasyColor.neutral300,
                          onTap: () => _handleAction(
                            StringConstant.reviewCustomerSelfie,
                            StringConstant.ensureSelfie,
                            photoTypes.selfieWithOfficer,
                          ),
                        ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          _footer(),
        ],
      ),
    );
  }

  Widget _footer() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DeasyCustomActionButton(
            text: StringConstant.buttonConfirmation,
            bgColor: AppConfig.instance.buttonPrimaryColor,
            padding: 10,
            borderRadius: 6,
            onPressed: () {
              controller.submit();
            },
          ),
        ],
      ),
    );
  }

  Widget _cameraWidget() {
    return controller.isLoading.isTrue
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              dt.DeasyTextView(
                text: StringConstant.takePhoto,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(height: 24.0),
              CameraPreview(controller.cameraController.value!),
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
        ? const Center(child: CircularProgressIndicator())
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
                height: 40.h,
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  const SizedBox(width: 24),
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
              const SizedBox(height: 40.0),
            ],
          );
  }

  void _handleAction(String title, String subTitle, photoTypes type) {
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
        width: 40.w,
        height: 70.h,
        barrierDismissible: controller.previewImagePath.isEmpty,
        content: Obx(
          () => controller.previewImagePath.isEmpty &&
                  controller.cameraInitialized.isTrue
              ? _cameraWidget()
              : _dialogPreview(
                  title: title,
                  subTitle: subTitle,
                ),
        ),
      );
    }
  }
}
