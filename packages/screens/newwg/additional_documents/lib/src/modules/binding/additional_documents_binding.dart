import 'package:additional_documents/src/modules/controller/preview_photo_controller.dart';
import 'package:additional_documents/src/modules/controller/take_photo_controller.dart';
import 'package:get/get.dart';
import 'package:additional_documents/src/modules/controller/additional_documents_controller.dart';
import 'package:newwg_repository/newwg_repository.dart';

class AdditionalDocumentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewWgRepositoryImpl>(() => NewWgRepositoryImpl());
    Get.lazyPut<AdditionalDocumentsController>(
        () => AdditionalDocumentsController());
    Get.lazyPut<TakePhotoController>(() => TakePhotoController());
    Get.lazyPut<PreviewPhotoController>(() => PreviewPhotoController());
  }
}
