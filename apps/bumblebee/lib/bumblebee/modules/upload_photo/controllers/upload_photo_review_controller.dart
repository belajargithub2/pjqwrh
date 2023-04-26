import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class UploadPhotoReviewController extends GetxController {
  final uploadPhotoRepository = Get.find<BumblebeeUploadPhotoRepository>();
  PickedFile? imageFile;
  final isLoading = false.obs;
  dynamic pickImageError;
  final price = ''.obs;
  final date = ''.obs;
  final id = ''.obs;
  final flag = ''.obs;
  final image = ''.obs;
  final reviewMessage = ''.obs;
  String? imagePath;
  String errorMessage = '';
  bool isSuccessUpload = false;
  BuildContext? buildContext;
  bool isBackToCam = false;

  @override
  void onInit() {
    price.value = Get.arguments['price'];
    date.value = Get.arguments['date'];
    id.value = Get.arguments['id'];
    flag.value = Get.arguments['flag'];
    image.value = Get.arguments['image'];
    imagePath = image.value;
    imageFile = PickedFile(imagePath!);
    setReviewMessage(flag.value);
    update();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, String>();
    request["prospect_id"] = id.value;
    return request;
  }

  void setReviewMessage(String parameterFlag) {
    if (parameterFlag.isContainIgnoreCase("bast")) {
      reviewMessage.value = ContentConstant.bastReviewMessage;
    } else if (parameterFlag.isContainIgnoreCase("imei")) {
      reviewMessage.value = ContentConstant.imeiReviewMessage;
    } else {
      reviewMessage.value = ContentConstant.receiptReviewMessage;
    }
  }

  showDialog() {
    Get.defaultDialog(
        barrierDismissible: false,
        backgroundColor: DeasyColor.neutral000,
        title: "",
        content: Container(
            padding: EdgeInsets.symmetric(
                horizontal: DeasySizeConfigUtils.blockHorizontal! * 6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                isSuccessUpload
                    ? SvgPicture.asset(
                        IconConstant.RESOURCES_ICON_SUCCESS_GENERATE)
                    : SvgPicture.asset(
                        IconConstant.RESOURCES_ICON_FAILED_GENERATE),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                DeasyTextView(
                  textAlign: TextAlign.center,
                  text: isSuccessUpload
                      ? ContentConstant.successUploadDocument
                      : ContentConstant.failedUploadDocument,
                  maxLines: 3,
                  fontSize: DeasySizeConfigUtils.blockHorizontal! * 5.35,
                  fontColor: Colors.black,
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
                DeasyTextView(
                    text: isSuccessUpload
                        ? "$flag kamu sudah otomatis terupload di sistem"
                        : errorMessage,
                    fontSize: DeasySizeConfigUtils.blockHorizontal! * 3.9,
                    fontColor: DeasyColor.neutral400,
                    textAlign: TextAlign.center,
                    maxLines: 5),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: DeasyCustomButton(
                      text: isSuccessUpload
                          ? ContentConstant.backToUploadList
                          : ContentConstant.takeImageFromCamera,
                      radius: 8,
                      onPressed: () {
                        if (isSuccessUpload) {
                          Get.back(closeOverlays: true);
                          Get.back(canPop: true, result: true);
                        } else {
                          if (flag.value.toLowerCase().contains("bast")) {
                            AnalyticConfig().sendEventRetry("Bast_Upload");
                          } else if (flag.value
                              .toLowerCase()
                              .contains("imei")) {
                            AnalyticConfig().sendEventRetry("Imei_Upload");
                          } else {
                            AnalyticConfig()
                                .sendEventRetry("Photo_Receipt_Upload");
                          }
                          Get.back();
                          Get.back(canPop: true, result: true);
                        }
                      }),
                ),
                if (!isSuccessUpload)
                  SizedBox(height: DeasySizeConfigUtils.blockVertical * 2),
                if (!isSuccessUpload)
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: double.infinity),
                      child: DeasyPrimaryStrokedButton(
                        text: DialogConstant.cancelUploadDialog,
                        radius: 8,
                        onPressed: () {
                          Get.back();
                        },
                      )),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
              ],
            )));
  }

  showFailedUploadBottomSheet(BuildContext context, String title) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight! / 4,
            margin: EdgeInsets.all(35.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(IconConstant.RESOURCES_ICON_DIALOG_ECOMMERCE),
                SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.03),
                Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: Text(
                      '$title',
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 2),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.03,
                ),
                Text(
                  errorMessage,
                  style: TextStyle(
                      color: DeasyColor.neutral400,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.7),
                ),
                SizedBox(
                  height: DeasySizeConfigUtils.screenHeight! * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                      child: DeasyPrimaryStrokedButton(
                        text: DialogConstant.cancelUploadDialog,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(
                        width: DeasySizeConfigUtils.blockHorizontal! * 1.7),
                    Expanded(
                      child: DeasyPrimaryButton(
                        text: ContentConstant.takeImageFromCamera,
                        onPressed: () {
                          if (flag.value.toLowerCase().contains("bast")) {
                            AnalyticConfig().sendEventRetry("Bast_Upload");
                          } else if (flag.value
                              .toLowerCase()
                              .contains("imei")) {
                            AnalyticConfig().sendEventRetry("Imei_Upload");
                          } else {
                            AnalyticConfig()
                                .sendEventRetry("Photo_Receipt_Upload");
                          }
                          isBackToCam = true;
                          Get.back();
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        }).then((value) {
      if (isBackToCam) Get.back();
    });
  }

  void dismissLoading() {
    isLoading.value = false;
    update();
  }

  void submit(BuildContext context) {
    buildContext = context;
    isLoading.value = true;
    update();
    if (flag.value.isContainIgnoreCase("bast")) {
      uploadPhotoRepository
          .uploadFileBast(context, createRequest(), imageFile, "bast_upload")
          .then((value) {
        dismissLoading();
        if (value.code == 200) {
          AnalyticConfig().sendEventSuccess("Bast_Upload");
          isSuccessUpload = true;
        } else {
          AnalyticConfig().sendEventFailed("Bast_Upload");
          isSuccessUpload = false;
        }

        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          AnalyticConfig().sendEventFailed("Bast_Upload");
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
      }).catchError((onError) {
        AnalyticConfig().sendEventFailed("Bast_Upload");
        dismissLoading();
        isSuccessUpload = false;
        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
      });
    } else if (flag.value.isContainIgnoreCase("imei")) {
      uploadPhotoRepository
          .uploadFileImei(context, createRequest(), imageFile, "imei_upload")
          .then((value) {
        dismissLoading();
        if (value.code == 200) {
          AnalyticConfig().sendEventSuccess("Imei_Upload");
          isSuccessUpload = true;
        } else {
          AnalyticConfig().sendEventFailed("Imei_Upload");
          isSuccessUpload = false;
        }

        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
      }).catchError((onError) {
        AnalyticConfig().sendEventFailed("Imei_Upload");
        dismissLoading();
        isSuccessUpload = false;
        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
      });
    } else {
      uploadPhotoRepository
          .uploadFileReceiptPhoto(
              context, createRequest(), imageFile, "photo_receipt_upload")
          .then((value) {
        dismissLoading();
        if (value.code == 200) {
          AnalyticConfig().sendEventSuccess("Photo_Receipt_Upload");
          isSuccessUpload = true;
        } else {
          AnalyticConfig().sendEventFailed("Photo_Receipt_Upload");
          isSuccessUpload = false;
        }

        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          AnalyticConfig().sendEventFailed("Photo_Receipt_Upload");
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
      }).catchError((onError) {
        errorMessage = onError.toString();
        dismissLoading();
        isSuccessUpload = false;
        if (DeasySizeConfigUtils.isTab && !isSuccessUpload) {
          showFailedUploadBottomSheet(
              Get.context!, ContentConstant.failedUploadDocument);
        } else {
          showDialog();
        }
        AnalyticConfig().sendEventFailed("Photo_Receipt_Upload");
      });
    }
  }
}
