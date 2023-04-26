import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_get_all_role_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_role_management_repository.dart';

class OptimusRoleManagementController extends GetxController {
  late OptimusRoleManagementRepository _roleManagementRepository;
  final Rx<OptimusResponseGetAllRole> responseGetAllRole = OptimusResponseGetAllRole().obs;
  final RxList<Map<String, dynamic>> orderList = <Map<String, dynamic>>[].obs;
  RxString id = ''.obs;
  final limit = 10.obs;
  final totalPage = 0.obs;

  TextEditingController searchController = TextEditingController();
  final isLoading = true.obs;
  final isStatus = true.obs;
  final isCreatedAtDesc = true.obs;
  final isStatusDesc = true.obs;
  final isUpdateAtDesc = true.obs;

  @override
  void onInit() {
    _roleManagementRepository = OptimusRoleManagementRepository();
    Future.delayed(Duration.zero, () {
      fetchApiGetAllRoles();
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  fetchApiGetAllRoles({int? page = 1, String name = ''}) async {
    isLoading.value = true;
    if (name.isNotEmpty) {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      filters["page"] = page;
      filters["q"] = name;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      fetchRM(filters);
    } else {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      filters["page"] = page;
      fetchRM(filters);
    }
  }


  void sortingCreatedAt(){
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "created_at";
    orderBody["dir"] = isCreatedAtDesc.isTrue ? "desc": "asc";
    orderList.add(orderBody);
    fetchApiGetAllRoles();
  }

  void sortingStatus(){
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "status";
    orderBody["dir"] = isStatusDesc.isTrue ? "desc": "asc";
    orderList.add(orderBody);
    fetchApiGetAllRoles();
  }

  void sortingUpdateAt(){
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "updated_at";
    orderBody["dir"] = isUpdateAtDesc.isTrue ? "desc": "asc";
    orderList.add(orderBody);
    fetchApiGetAllRoles();
  }


  void fetchRM(Map<String, dynamic> filters) {
    _roleManagementRepository.getAllRoles(Get.context, filters).then((value) {
      isLoading.value = false;
      responseGetAllRole.value = value;
      update();
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  void onSubmitSearch(String value) {
    if (value.isNotEmpty) {
      searchController.text = value;
    } else {
      searchController.text = '';
    }
    fetchApiGetAllRoles(name: value);
  }

}
