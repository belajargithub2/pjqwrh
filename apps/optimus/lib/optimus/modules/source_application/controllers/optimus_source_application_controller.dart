import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/repositories/optimus_source_application_repository.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusSourceApplicationController extends GetxController {
  late OptimusSourceApplicationRepository sourceApplicationRepository;
  final limit = ContentConstant.INITIAL_LIMIT;
  final totalPage = 0.obs;
  RxString activeSearch = ''.obs;
  RxBool isLoading = true.obs;
  final Rx<OptimusSourceAppResponse> sourceApplicationListResponse =
      OptimusSourceAppResponse().obs;
  RxList<Map<String, dynamic>> orderList = RxList<Map<String, dynamic>>();
  TextEditingController searchController = TextEditingController();
  final searchQuery = ''.obs;
  final tableScrollController = ScrollController();
  final isCreatedAtDesc = true.obs;
  final isUpdatedAtDesc = true.obs;

  @override
  void onInit() async {
    sourceApplicationRepository = OptimusSourceApplicationRepository();
    await fetchApiAllSourceApplications();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchApiAllSourceApplications(
      {int? page = 1, String sourceApplication = ''}) {
    isLoading.value = true;
    if (sourceApplication.isNotEmpty) {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit != null) filters["limit"] = limit;
      filters["page"] = page;
      filters["source_application"] = sourceApplication;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      fetchSourceApplication(filters);
    } else {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit != null) filters["limit"] = limit;
      filters["page"] = page;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      fetchSourceApplication(filters);
    }
  }

  fetchSourceApplication(Map<String, dynamic> filters) {
    sourceApplicationRepository
        .fetchApiAllSource(Get.context, filters)
        .then((value) {
      isLoading.value = false;
      sourceApplicationListResponse.value = value;
      update();
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  void onEdit(SourceAppData data) {
    Get.toNamed(
      OptimusRoutes.EDIT_SOURCE_APPLICATION,
      parameters: {"id": "${data.id}"},
    )!.then((value) {
      fetchApiAllSourceApplications();
    });
  }

  void onOrderByCreatedAt() {
    isCreatedAtDesc.toggle();
    sortingCreatedAt();
  }

  void onOrderByUpdatedAt() {
    isUpdatedAtDesc.toggle();
    sortingUpdatedAt();
  }

  void sortingCreatedAt() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "created_at";
    orderBody["dir"] = isCreatedAtDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllSourceApplications();
  }

  void sortingUpdatedAt() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "updated_at";
    orderBody["dir"] = isUpdatedAtDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllSourceApplications();
  }

  void onCreateSourceApplication() {
    Get.toNamed(OptimusRoutes.CREATE_SOURCE_APPLICATION)!.then((value) {
      fetchApiAllSourceApplications();
    });
  }

  void deleteSourceApplicationById(String? id) {
    sourceApplicationRepository.deleteSource(Get.context, id).then((value) {
      fetchApiAllSourceApplications();
      Get.back();
    }).catchError((error) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, "Gagal menghapus data");
    });
  }

  void onClear() {
    searchController.clear();
    sourceApplicationListResponse.value.listSourceAppData!.clear();
    fetchApiAllSourceApplications();
  }
}
