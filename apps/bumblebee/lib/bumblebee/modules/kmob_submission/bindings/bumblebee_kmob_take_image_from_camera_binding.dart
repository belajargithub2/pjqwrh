import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_take_image_from_camera_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';

class BumblebeeKMOBTakeImageFromCameraBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeKMOBUploadDocumentSubmissionController());
    Get.lazyPut(() => BumblebeeKMOBTakeImageFromCameraController(
      kmobUploadDocumentSubmissionController: Get.find<BumblebeeKMOBUploadDocumentSubmissionController>(),
    ));
  }
}
