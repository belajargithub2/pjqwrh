import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/models/optimus_e_commerce_list_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/ecommerce_client_key/repositories/optimus_e_commerce_client_key_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class OptimusECommerceClientKeyWebController extends GetxController {
  late OptimusECommerceClientKeyRepository eCommerceClientKeyRepository;
  TextEditingController searchController = TextEditingController();

  final limit = 10.obs;
  final totalPage = 0.obs;
  final isLoading = true.obs;
  final isNameDesc = true.obs;
  final isCreatedAtDesc = true.obs;
  final isUpdateAtDesc = true.obs;
  final Rx<OptimusECommerceClientKeyListResponse>
      eCommerceClientKeyListResponse =
      OptimusECommerceClientKeyListResponse().obs;
  final RxList<Map<String, dynamic>> orderList = <Map<String, dynamic>>[].obs;
  final searchQuery = ''.obs;
  final tableScrollController = ScrollController();

  @override
  void onInit() async {
    eCommerceClientKeyRepository = OptimusECommerceClientKeyRepository();
    await fetchApiAllClientKey();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
    super.onInit();
  }

  void sortingName() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "name";
    orderBody["dir"] = isNameDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllClientKey();
  }

  void sortingCreatedAt() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "created_at";
    orderBody["dir"] = isCreatedAtDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllClientKey();
  }

  void sortingUpdateAt() {
    orderList.clear();
    Map<String, dynamic> orderBody = new Map<String, dynamic>();
    orderBody["column_name"] = "updated_at";
    orderBody["dir"] = isUpdateAtDesc.isTrue ? "desc" : "asc";
    orderList.add(orderBody);
    fetchApiAllClientKey();
  }

  dialogDelete(String? id, String? name) {
    showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
              backgroundColor: DeasyColor.neutral000,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                      "${IconConstant.RESOURCES_ICON_PATH}ic_warning.svg"),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 13,
                        ),
                        Text(
                          'Hapus $name ?',
                          style: TextStyle(
                              fontSize: 20, color: DeasyColor.neutral900),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Dengan ini Key merchant ini akan terhapus.',
                          style: TextStyle(
                              fontSize: 15, color: DeasyColor.neutral400),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: DeasyColor.kpYellow500,
                                  side: BorderSide(
                                      width: 1, color: DeasyColor.kpYellow500),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  deleteEcmmerceClientKeyBySupplierId(id);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Hapus",
                                    style:
                                        TextStyle(color: DeasyColor.neutral000),
                                  ),
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: DeasyColor.neutral000,
                                  side: BorderSide(
                                      width: 1, color: DeasyColor.kpYellow500),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "Batalkan",
                                    style: TextStyle(
                                        color: DeasyColor.kpYellow500),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  void deleteEcmmerceClientKeyBySupplierId(String? supplierId) {
    eCommerceClientKeyRepository
        .deleteECommerceClientKey(Get.context, supplierId)
        .then((value) {
      fetchApiAllClientKey();
      Get.back();
    }).catchError((error) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, "Gagal menghapus data");
    });
  }

  fetchApiAllClientKey({int? page = 1, String name = ''}) {
    isLoading.value = true;
    if (name.isNotEmpty) {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      filters["page"] = page;
      filters["name"] = name;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      fetchECK(filters);
    } else {
      Map<String, dynamic> filters = new Map<String, dynamic>();
      if (limit.value != null) filters["limit"] = limit.value;
      if (orderList.isNotEmpty) filters["order_by"] = orderList;
      filters["page"] = page;
      fetchECK(filters);
    }
  }

  void fetchECK(Map<String, dynamic> filters) {
    eCommerceClientKeyRepository
        .fetchApiAllClientKey(Get.context, filters)
        .then((value) {
      isLoading.value = false;
      eCommerceClientKeyListResponse.value = value;
      update();
    }).catchError((error) {
      isLoading.value = false;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onOrderByName() {
    isNameDesc.toggle();
    sortingName();
  }

  void onOrderByCreatedAt() {
    isCreatedAtDesc.toggle();
    sortingCreatedAt();
  }

  void onOrderByUpdateAt() {
    isUpdateAtDesc.toggle();
    sortingUpdateAt();
  }

  void onClear() {
    searchController.clear();
    eCommerceClientKeyListResponse.value.eCommerceClientKeyData!.clear();
    fetchApiAllClientKey();
  }

  void onCreateECK() {
    Get.toNamed(OptimusRoutes.CREATE_ECOMMERCE_CLIENT_KEY,
            arguments: {"data": null})!
        .then((value) {
      fetchApiAllClientKey();
    });
  }

  void onEdit(ECommerceClientKeyData eCommerceClientKeyData) {
    Get.toNamed(OptimusRoutes.EDIT_ECOMMERCE_CLIENT_KEY,
            parameters: {"data": eCommerceClientKeyData.supplierId.toString()})!
        .then((value) {
      fetchApiAllClientKey();
    });
  }

  void onDeleteECK(String? supplierId, String? name) {
    dialogDelete(supplierId, name);
  }
}
