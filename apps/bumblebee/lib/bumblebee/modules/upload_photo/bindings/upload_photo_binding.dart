import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_bast_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_camera_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_imei_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_receipt_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_review_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_list_tab_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';

class UploadPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeUploadPhotoRepository());
    Get.lazyPut(() => UploadPhotoCameraController());
    Get.lazyPut(() => UploadPhotoReviewController());
    Get.lazyPut(() => UploadPhotoListTabController());
    Get.lazyPut(() => UploadPhotoBastController());
    Get.lazyPut(() => UploadPhotoReceiptController());
    Get.lazyPut(() => UploadPhotoImeiController());
  }
}
