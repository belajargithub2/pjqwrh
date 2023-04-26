import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/models/callback_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/callback/repositories/optimus_callback_repository.dart';
import 'package:deasy_color/deasy_color.dart';

class OptimusCallbackController extends GetxController {
  final callbackRepository = Get.find<OptimusCallbackRepository>();
  final limit = ContentConstant.INITIAL_LIMIT;
  final totalPage = 0.obs;
  final searchQuery = ''.obs;
  final isLoading = true.obs;
  final RxList<CallbackData> callbackList = <CallbackData>[].obs;
  final Rx<PageInfo?> pageInfo = PageInfo().obs;
  final searchController = TextEditingController();
  Widget icon = Icon(Icons.search, color: DeasyColor.neutral400);
  final tableScrollController = ScrollController();

  @override
  void onInit() {
    Future.delayed(Duration.zero, () {
      fetchApiAllCallbacks();
    });
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchApiAllCallbacks({int? page = 1}) {
    isLoading.value = true;
    if (searchQuery.isNotEmpty) {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      filters["limit"] = limit;
      filters["page"] = page;
      filters["name"] = searchQuery.value;
      fetchCallbacks(filters);
    } else {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      filters["limit"] = limit;
      filters["page"] = page;
      fetchCallbacks(filters);
    }
  }

  fetchCallbacks(Map<String, dynamic> filters) {
    callbackList.clear();
    callbackRepository.getAllCallbacks(Get.context, filters).then((value) {
      isLoading.value = false;
      callbackList.addAll(value.callbackData!);
      pageInfo.value = value.pageInfo;
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  resendCallback(String? prospectId) {
    isLoading.value = true;
    callbackRepository.resendCallbacks(Get.context, prospectId).then((value) {
      fetchApiAllCallbacks(page: pageInfo.value!.page);
    });
  }

  onBack() {
    if (pageInfo.value!.page != pageInfo.value!.prevPage) {
      fetchApiAllCallbacks(page: pageInfo.value!.prevPage);
    }
  }

  onForward() {
    if (pageInfo.value!.page != pageInfo.value!.nextPage) {
      fetchApiAllCallbacks(page: pageInfo.value!.nextPage);
    }
  }

  onSearch(String searchValue) {
    if (searchValue.isNotEmpty) {
      searchQuery.value = searchValue;
    } else {
      searchQuery.value = '';
    }
    callbackList.clear();
    fetchApiAllCallbacks();
  }

  onClear() {
    searchController.clear();
    callbackList.clear();
    fetchApiAllCallbacks();
  }
}
