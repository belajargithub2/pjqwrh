import 'package:additional_documents/additional_documents.dart';
import 'package:additional_documents/src/modules/constans/enums.dart';
import 'package:additional_documents/src/modules/constans/icons.dart';
import 'package:additional_documents/src/modules/constans/strings.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:newwg_repository/newwg_repository.dart';
import 'package:stepper/stepper.dart';

class PreviewPhotoController extends GetxController {
  final isLoading = false.obs;
  final title = "".obs;
  final info = "".obs;
  final imageUrl = Rxn<Uint8List>();
  final imagePath = "".obs;
  final docsController = Get.find<AdditionalDocumentsController>();
  final repository = Get.find<NewWgRepositoryImpl>();
  final isSuccessUpload = false.obs;
  final photoUrl = "".obs;
  photoTypes photoType = photoTypes.ktp;
  final stepperController = Get.find<StepperContainerController>();

  void init() {
    Map<String, dynamic> args = Get.arguments;
    imageUrl.value = args['image_url'];
    imagePath.value = args['image_path'];
    photoType = args['type_id'];
    setTitle();
    setInfo();
  }

  setTitle() {
    if (photoType == photoTypes.ktp) {
      title(StringConstant.reviewCustomerKtp);
    } else {
      title(StringConstant.reviewCustomerSelfie);
    }
  }

  setInfo() {
    if (photoType == photoTypes.ktp) {
      info(StringConstant.ensureKtp);
    } else {
      info(StringConstant.ensureSelfie);
    }
  }

  Future<void> uploadPhoto() async {
    isLoading(true);
    repository
        .uploadAdditionalDocuments(
            Get.context!, stepperController.phoneNumber.value, photoType.name, imagePath.value)
        .then((res) {
      if (res.code == 200) {
        photoUrl("${res.data?.mediaUrl}");
        isSuccessUpload(true);
      }
    }).catchError((e) {
      isSuccessUpload(false);
    }).whenComplete(() {
      _showDialogStatusUpload();
      isLoading(false);
    });
  }

  _showDialogStatusUpload() {
    DeasyBaseDialogs.getInstance().iconDialog(
      context: Get.context!,
      barrierDismissible: false,
      title: isSuccessUpload.isTrue
          ? StringConstant.titleDialogSuccess
          : StringConstant.titleDialogFailed,
      subTitle: isSuccessUpload.isTrue
          ? StringConstant.subTitleDialogSuccess
          : StringConstant.subTitleDialogFailed,
      fontSizeTitle: 20.0,
      fontSizeSubTitle: 14.0,
      icon: SvgPicture.asset(
        isSuccessUpload.isTrue
            ? IconsConstant.icSuccess
            : IconsConstant.icFailed,
      ),
      okPrimaryButtonColor: AppConfig.instance.buttonPrimaryColor,
      buttonOkText: isSuccessUpload.isTrue
          ? StringConstant.buttonOk
          : StringConstant.buttonBack,
      onPressButtonOk: () {
        if (isSuccessUpload.isTrue) {
          docsController.callbackFromPreview(photoType, photoUrl.value);
          Get.back();
          Get.back();
        }
        Get.back();
      },
    );
  }
}
