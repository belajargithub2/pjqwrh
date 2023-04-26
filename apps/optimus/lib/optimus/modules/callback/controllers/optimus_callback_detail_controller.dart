import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/models/callback_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/repositories/optimus_callback_repository.dart';

class OptimusCallbackDetailController extends GetxController {
  final callbackRepository = Get.find<OptimusCallbackRepository>();
  final isLoading = false.obs;
  final prospectId = ''.obs;
  final callbackDetailDataList = <CallbackDetailData>[].obs;
  final expandedIndexList = <int>[].obs;

  @override
  void onInit() {
    String? prospect_id = Get.parameters["prospect_id"];
    prospectId(prospect_id);
    getDetailCallbacks();
    super.onInit();
  }
  
  getDetailCallbacks() {
    isLoading(true);
    callbackRepository.getDetailCallbacks(Get.context, prospectId.value).then((value) {
      if (value.callbackDetailData != null) {
        callbackDetailDataList.addAll(value.callbackDetailData!);
      }
    }).whenComplete(() => isLoading(false));
  }

  onTapExpand(int index) {
    if (expandedIndexList.contains(index)) {
      expandedIndexList.removeWhere((element) => element == index);
    } else {
      expandedIndexList.add(index);
      expandedIndexList.toSet().toList();
    }
  }
}