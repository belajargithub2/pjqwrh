import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_consumen_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_upload_document_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_local_repository.dart';

class BumblebeeKMOBSubmissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BumblebeeKMOBSubmissionRepository());
    Get.lazyPut(() => BumblebeeDraftRepository());
    Get.lazyPut(() => BumblebeeLocalRepository());

    Get.lazyPut(() => BumblebeeKMOBSubmissionController(
        kmobSubmissionRepository: Get.find<BumblebeeKMOBSubmissionRepository>(),
        localRepository: Get.find<BumblebeeLocalRepository>(),
        draftRepository: Get.find<BumblebeeDraftRepository>(),));

    Get.lazyPut(() => BumblebeeKMOBConsumerDataSubmissionController(
        kmobSubmissionRepository: Get.find<BumblebeeKMOBSubmissionRepository>(),
        draftRepository: Get.find<BumblebeeDraftRepository>(),
        kmobSubmissionController: Get.find<BumblebeeKMOBSubmissionController>()));

    Get.lazyPut(() => BumblebeeKMOBAssetDataSubmissionController(
        bumblebeeKmobSubmissionRepository: Get.find<BumblebeeKMOBSubmissionRepository>(),
        bumblebeeDraftRepository: Get.find<BumblebeeDraftRepository>(),
        bumblebeeKmobSubmissionController: Get.find<BumblebeeKMOBSubmissionController>()));

    Get.lazyPut(() => BumblebeeKMOBUploadDocumentSubmissionController(
        kmobSubmissionRepository: Get.find<BumblebeeKMOBSubmissionRepository>(),
        kmobConsumerDataSubmissionController: Get.find<BumblebeeKMOBConsumerDataSubmissionController>(),
        kmobSubmissionController: Get.find<BumblebeeKMOBSubmissionController>(),
        kmobAssetDataSubmissionController: Get.find<BumblebeeKMOBAssetDataSubmissionController>(),
        draftRepository: Get.find<BumblebeeDraftRepository>()));
  }
}
