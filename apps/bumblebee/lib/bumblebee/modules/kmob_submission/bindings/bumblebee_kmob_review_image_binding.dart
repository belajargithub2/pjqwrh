import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_review_image_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';

class BumblebeeKMOBReviewImageBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeKMOBUploadDocumentSubmissionController());
    Get.lazyPut(() => BumblebeeKMOBSubmissionRepository());
    Get.lazyPut(() => BumblebeeKMOBSubmissionController());

    Get.lazyPut(() => BumblebeeKMOBReviewImageController(
        kmobUploadDocumentSubmissionController: Get.find<BumblebeeKMOBUploadDocumentSubmissionController>(),
        kmobSubmissionRepository: Get.find<BumblebeeKMOBSubmissionRepository>(),
        kmobSubmissionController: Get.find<BumblebeeKMOBSubmissionController>(),
    ));
  }
}
