import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_upload_document_kmob.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';

class BumblebeeKMOBReviewImageController extends GetxController {
  final BumblebeeKMOBUploadDocumentSubmissionController? kmobUploadDocumentSubmissionController;
  final BumblebeeKMOBSubmissionRepository? kmobSubmissionRepository;
  final BumblebeeKMOBSubmissionController? kmobSubmissionController;

  BumblebeeKMOBReviewImageController({
    this.kmobUploadDocumentSubmissionController,
    this.kmobSubmissionRepository,
    this.kmobSubmissionController
  });

  final imagePath = ''.obs;
  final imageUrl = ''.obs;
  final photoStnkKeyFile = 'photo_stnk'.obs;
  final photoKkKeyFile = 'photo_kk'.obs;
  final photoKtpKeyFile = 'photo_ktp'.obs;
  final documentType = 'photo_ktp'.obs;
  final scaleCamera = 0.0.obs;
  final ratioCamera = 0.0.obs;
  final imageFromCamera = false.obs;
  final isSuccessUpload = false.obs;

  @override
  void onInit() {
    imageFromCamera.value = Get.arguments['imageFromCamera'] ?? false;
    imagePath.value = Get.arguments['imagePath'] ?? '';
    scaleCamera.value = Get.arguments['scaleCamera'] ?? 0.0;
    ratioCamera.value = Get.arguments['ratioCamera'] ?? 0.0;
    super.onInit();
  }

  Map<String, dynamic> getRequestBranch(String documentType) {
    RequestUplaodDocumentKmob requestUplaodDocumentKmob =
        RequestUplaodDocumentKmob()
          ..documentType = documentType
          ..prospectId = kmobSubmissionController!.prospectId.value;
    return requestUplaodDocumentKmob.toJson();
  }

  void uploadImage(BuildContext? context) {
    keyUploadImageEnum _keyUploadImageEnum = kmobUploadDocumentSubmissionController!.imageKey!;
    String documentType = kmobUploadDocumentSubmissionController!.documentType.value;

    if (identical(_keyUploadImageEnum.name, keyUploadImageEnum.KTP.name)) {
      uploadKtp(context, fileKey: photoKtpKeyFile.value, documentType: documentType);
    } else if (identical(_keyUploadImageEnum.name, keyUploadImageEnum.STNK.name)) {
      uploadStnk(context, fileKey: photoStnkKeyFile.value, documentType: documentType);
    } else if (identical(_keyUploadImageEnum.name, keyUploadImageEnum.KARTU_KELUARGA.name)) {
      uploadKk(context, fileKey: photoKkKeyFile.value, documentType: documentType);
    } else {
      uploadKtp(context, fileKey: photoKtpKeyFile.value, documentType: documentType);
    }
  }

  Future<void> uploadStnk(BuildContext? context, {required String fileKey, required String documentType}) async {
    await kmobSubmissionRepository!.uploadStnk(context, photoStnkKeyFile.value, imagePath.value,
        getRequestBranch(documentType))
        .then((value) {
          isSuccessUpload.value = true;
          imageUrl.value = value.data!.mediaUrl!;
        });
  }

  Future<void> uploadKk(BuildContext? context, {required String fileKey, required String documentType}) async {
    await kmobSubmissionRepository!
        .uploadKk(context, photoKkKeyFile.value, imagePath.value, getRequestBranch(documentType))
        .then((value) {
          isSuccessUpload.value = true;
          imageUrl.value = value.data!.mediaUrl!;
        });
  }

  Future<void> uploadKtp(BuildContext? context, {required String fileKey, required String documentType}) async {
    await kmobSubmissionRepository!
        .uploadKtp(context, photoKtpKeyFile.value, imagePath.value, getRequestBranch(documentType))
        .then((value) {
          isSuccessUpload.value = true;
          imageUrl.value = value.data!.mediaUrl!;
        });
  }

  void successUpload(BuildContext context) {
    Navigator.pop(context, {
      "imagePath": imagePath.value,
      "imageUrl": imageUrl.value,
      "typeName": kmobUploadDocumentSubmissionController!.typeName.value
    });
  }
}
