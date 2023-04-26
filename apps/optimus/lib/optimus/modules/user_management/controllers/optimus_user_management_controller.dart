import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_model.dart';

class OptimusUserManagementController extends GetxController {
  final UserRepository _userRepository;
  final RoleManagementRepository _roleManagementRepository;

  final userResponse = UserResponse().obs;
  final tableScrollController = ScrollController();
  final isAscDelear = false.obs;
  final isAscUsername = false.obs;
  final isAlreadyAdd = false.obs;
  final isLoading = true.obs;
  final isOpenFilter = false.obs;
  final isOpenDialogMerchant = false.obs;

  final idNumber = ''.obs;
  final orderBy = ''.obs;
  final orderStatus = ''.obs;
  final prospectId = ''.obs;
  final search = ''.obs;
  final activeSearch = ''.obs;
  final notFound = "".obs;
  final limit = 10.obs;
  final scrollPixel = 0.0.obs;
  final itemCount = 10;
  final listRole = <OptimusRoleModel>[].obs;
  final listRoleFilter = <String?>[].obs;

  DateTime date = DateTime.now();
  DateTime? tomorrow;
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<OrderBy> orderList = [];
  Map<String, dynamic> filters = new Map<String, dynamic>();
  Widget icon = Icon(Icons.search, color: DeasyColor.neutral400);

  OptimusUserManagementController({
    required UserRepository userRepository,
    required RoleManagementRepository roleManagementRepository,
  })  : _userRepository = userRepository,
        _roleManagementRepository = roleManagementRepository;
  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(Duration(milliseconds: 700));

    tomorrow = DateTime(date.year, date.month, date.day + 1);
    searchController.addListener(() {
      if (searchController.text.isNotEmpty) {
        icon = IconButton(
            onPressed: () {
              searchController.text = "";
              onSearchSubmitted(searchController.text);
            },
            icon: Icon(Icons.clear, color: DeasyColor.neutral400));
      } else {
        icon = Icon(Icons.search, color: DeasyColor.neutral400);
      }
    });
    if (activeSearch != null) {
      searchController.text = activeSearch.value;
    }

    Future.delayed(Duration.zero, () {
      getAllRoles();
      fetchApiAllUsers();
    });
    scrollController = ScrollController()..addListener(_scroll);
  }

  void _scroll() {
    scrollPixel.value = scrollController.position.pixels;
  }

  @override
  void onClose() {
    super.onClose();
  }

  fetchApiAllUsers({int? page = 1}) async {
    scrollPixel.value = 0.0;
    isLoading.value = true;
    var request = fetchAllUserRequest(page);
    await Future.delayed(Duration(milliseconds: 700));
    _userRepository
        .fetchApiAllUsers(Get.context, request.toJson())
        .then((value) {

      notFound("");
      userResponse.value = value;
      isLoading.value = false;
      isOpenFilter.value = false;

    }).catchError((e) {
      notFound(ContentConstant.dataNotFound);
      userResponse.value.data!.clear();
      isLoading.value = false;
    });
  }

  void submitFilter(OptimusRoleModel roleModel, bool value) async {
    await Future.delayed(Duration(milliseconds: 100));
    roleModel.isChecked = value;
    if (value) {
      listRoleFilter.add(roleModel.id);
    } else {
      listRoleFilter.removeWhere((item) => item == roleModel.id);
    }
    listRoleFilter.refresh();
    listRole.refresh();
  }

  void applyFilter() {
    fetchApiAllUsers();
    isOpenFilter.value = false;
  }

  void clearFilter() {
    listRoleFilter.clear();
    listRole.forEach((element) {
      element.isChecked = false;
    });
    listRole.refresh();
    listRoleFilter.refresh();
    fetchApiAllUsers();
    isOpenFilter.value = false;
  }

  void getAllRoles() {
    _roleManagementRepository.getRoles(Get.context).then((value) {
      listRole.add(new OptimusRoleModel(
        name: "N/A",
        id: "N/A",
        isChecked: false,
      ));

      value.data!.forEach((element) {
        listRole.add(new OptimusRoleModel(
          name: element.name,
          id: element.id,
          isChecked: false,
        ));
      });
    });
  }

  dialogFilter() {
    isOpenFilter.toggle();
  }

  void delete(String? id) {
    _userRepository.deleteUser(Get.context, id).then((value) {
      Get.back();
      fetchApiAllUsers();
    }).catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, "Gagal menghapus data");
    });
  }

  void onSearchSubmitted(String searchValue) {
    if (searchValue.isNotEmpty) {
      activeSearch.value = searchValue;
      search.value = searchValue;
    } else {
      search.value = '';
      activeSearch.value = '';
      filters.remove("keyword");
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      fetchApiAllUsers();
    });
  }

  FetchAllUserRequest fetchAllUserRequest(int? page) {
    FetchAllUserRequest fetchAllUserRequest = FetchAllUserRequest(
        page: page,
        limit: limit.value,
        roles: listRoleFilter,
        keyword: search.value.isNotEmpty ? search.value : '',
        orderBy: orderList.isNotEmpty ? orderList : []);

    return fetchAllUserRequest;
  }

  void orderBySupplierName() {
    isAlreadyAdd.value = false;
    orderList.forEach((element) {
      if (element.columnName == "supplier.name") {
        isAlreadyAdd.value = true;
        if (element.dir == ContentConstant.ASCENDING) {
          element.dir = ContentConstant.DESCENDING;
        } else {
          element.dir = ContentConstant.ASCENDING;
        }
      }
    });
    if (isAlreadyAdd.isFalse) {
      OrderBy orderBy = new OrderBy();
      orderBy.columnName = "supplier.name";
      orderBy.dir = ContentConstant.ASCENDING;
      orderList.clear();
      orderList.add(orderBy);
    }
    isAscDelear.value = !isAscDelear.value;
    fetchApiAllUsers();
  }

  void orderByUserName() {
    isAlreadyAdd.value = false;
    orderList.forEach((element) {
      if (element.columnName == "name") {
        isAlreadyAdd.value = true;
        if (element.dir == ContentConstant.ASCENDING) {
          element.dir = ContentConstant.DESCENDING;
        } else {
          element.dir = ContentConstant.ASCENDING;
        }
      }
    });
    if (isAlreadyAdd.isFalse) {
      OrderBy orderBy = new OrderBy();
      orderBy.columnName = "name";
      orderBy.dir = ContentConstant.ASCENDING;
      orderList.clear();
      orderList.add(orderBy);
    }
    isAscUsername.value = !isAscUsername.value;
    fetchApiAllUsers();
  }
}
