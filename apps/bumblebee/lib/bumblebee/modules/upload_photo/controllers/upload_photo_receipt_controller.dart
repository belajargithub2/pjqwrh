import 'package:deasy_helper/deasy_helper.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/documents_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:get/get.dart';

class UploadPhotoReceiptController extends GetxController {
  final RxList<ReceiptModel> listReceipt = <ReceiptModel>[].obs;
  final uploadPhotoRepository = Get.find<BumblebeeUploadPhotoRepository>();
  final homePageController = Get.find<BumblebeeHomePageController>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchReceipt();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void fetchReceipt() async {
    isLoading(true);
    listReceipt.clear();
    await uploadPhotoRepository
        .fetchListReceiptPhoto(
            Get.context, createRequest(), "photo_receipt_list")
        .then((value) {
      value.data!.buktiTerima!.forEach((element) {
        String _price =
            element.otr != null ? element.otr.toString().toRupiah() : "-";
        listReceipt.add(ReceiptModel(
            name: ContentConstant.documentReceipt,
            date: DateFormat(DateConstant.dateFormat4).format(element.orderDate!),
            id: element.prospectId,
            price: _price));
      });
      isLoading(false);
    });
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, String>();
    request["document_type"] = ContentConstant.documentReceipt;
    return request;
  }

  void navigateToCamera(int index) {
    Get.toNamed(Routes.UPLOAD_PHOTO_CAMERA, arguments: {
      "price": listReceipt[index].price,
      "id": listReceipt[index].id,
      "date": listReceipt[index].date,
      "flag": ContentConstant.documentReceipt,
      "is_empty_cust_receipt": false
    })!
        .then((value) {
      fetchReceipt();
      homePageController.refreshData();
    });
  }
}
