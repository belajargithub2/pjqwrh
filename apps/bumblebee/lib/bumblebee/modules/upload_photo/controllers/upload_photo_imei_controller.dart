import 'package:deasy_helper/deasy_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/models/documents_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/repositories/bumblebee_upload_photo_repository.dart';
import 'package:kreditplus_deasy_mobile/core/routes/app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:get/get.dart';

class UploadPhotoImeiController extends GetxController {
  final RxList<ImeiModel> listImei = <ImeiModel>[].obs;
  final uploadPhotoRepository = Get.find<BumblebeeUploadPhotoRepository>();
  final homePageController = Get.find<BumblebeeHomePageController>();
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchImei();
    super.onInit();
  }

  void fetchImei() async {
    isLoading(true);
    listImei.clear();
    await uploadPhotoRepository
        .fetchListImei(Get.context, createRequest(), "IMEI_list")
        .then((value) {
      value.data!.imei!.forEach(
        (element) {
          String _price =
              element.otr != null ? element.otr.toString().toRupiah() : "-";
          listImei.add(
            new ImeiModel(
              name: ContentConstant.documentImei,
              date:
                  DateFormat(DateConstant.dateFormat4).format(element.orderDate!),
              id: element.prospectId,
              price: _price,
            ),
          );
        },
      );
      isLoading(false);
    });
  }

  Map<String, dynamic> createRequest() {
    var request = Map<String, String>();
    request["document_type"] = ContentConstant.documentImei;
    return request;
  }

  void navigateToCamera(int index) {
    Get.toNamed(Routes.UPLOAD_PHOTO_CAMERA, arguments: {
      "price": listImei[index].price,
      "id": listImei[index].id,
      "date": listImei[index].date,
      "flag": ContentConstant.documentImei,
      "is_empty_cust_receipt": false,
      "has_imei": true,
    })!
        .then((value) {
      fetchImei();
      homePageController.refreshData();
    });
  }

  void onTapTakeFromGallery(int index) async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      Get.toNamed(Routes.UPLOAD_PHOTO_REVIEW, arguments: {
        "price": listImei[index].price,
        "id": listImei[index].id,
        "date": listImei[index].date,
        "image": image.path,
        "flag": ContentConstant.documentImei
      })!
          .then((value) {
        fetchImei();
        homePageController.refreshData();
      });
    }
  }
}
