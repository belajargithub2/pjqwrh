import 'dart:async';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/core/widgets/loading/loading_controller.dart';
import 'package:deasy_repository/deasy_repository.dart';

class OptimusAddOrUpdateUserManagementController extends GetxController {
  final AuthRepository authRepository;
  final DeepLinkRepository deepLinkRepository;
  final DynamicLinkConfig dynamicLinkConfig;
  final UserRepository userRepository;
  final MerchantRepository merchantRepository;
  final RoleManagementRepository roleManagementRepository;
  final LoadingController loadingController;

  OptimusAddOrUpdateUserManagementController({
    required this.authRepository,
    required this.deepLinkRepository,
    required this.dynamicLinkConfig,
    required this.userRepository,
    required this.merchantRepository,
    required this.roleManagementRepository,
    required this.loadingController,
  });

  Timer? debounce;
  late UserManagementRequest request;
  UserRole? roleResponse;
  UserSupplier? supplierResponse;
  String? id;
  String? supplierId;
  String? userEmail;

  TextEditingController searchControllerMerchant = TextEditingController();

  final RxList<MerchantData> merchantDropdownList = <MerchantData>[].obs;
  final nextPageMerchant = 1.obs;
  final countMerchant = 0.obs;
  final isLoadMore = false.obs;
  final isOpenDialogMerchant = false.obs;
  final isFirstSearchMerchant = true.obs;

  final userId = "".obs;
  final isEdit = false.obs;
  final nameTextController = TextEditingController();
  final merchantTextController = TextEditingController();
  final nikController = TextEditingController();
  final lineTypeController = TextEditingController();
  final roleName = TextEditingController();
  final phoneNumberTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final RxList<RoleManagementData> listRole = <RoleManagementData>[].obs;
  final RxList<LobType> listLobType = <LobType>[].obs;
  final Rx<LobType> lobTypeSelected = LobType().obs;
  final role = ''.obs;
  final isShowDialogSubmit = false.obs;
  final isShowLobType = false.obs;

  @override
  void onInit() async {
    super.onInit();
    roleResponse = UserRole();
    request = UserManagementRequest();
    await getAllMerchant();
    await getAllRoles();
    await getAllLobTypes();
    userId.value = Get.parameters['user_id'] ?? '';
    isEdit.value = Get.parameters['is_edit'] == null ? false : true;

    if (userId.value.isNotEmpty) {
      await getUserById(userId.value);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> submit() async {
    var role = UserManagementRole()..id = roleResponse!.id;

    request.name = nameTextController.text;
    request.phoneNumber = phoneNumberTextController.text;
    request.email = emailTextController.text;
    request.nik = nikController.text;
    request.lobType = lobTypeSelected.value.lobType;
    request.role = role;

    if (isEdit.isTrue) {
      if (!userEmail!.isContainIgnoreCase(emailTextController.text)) {
        requestToken();
      } else {
        updateUser();
      }
    } else {
      var supplier = UserManagementSupplier()..supplierId = supplierId;
      request.supplier = supplier;
      requestToken();
    }
  }

  Future<void> refreshMerchant() async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    merchantDropdownList.clear();
    if (searchControllerMerchant.text == "") {
      getAllMerchant();
    } else {
      getAllMerchant(q: searchControllerMerchant.text);
    }
  }

  void onTapMerchant(MerchantData merchant) {
    merchantTextController.text = merchant.name!;
    supplierId = merchant.supplierId;
    isOpenDialogMerchant.toggle();

    if (isEdit.isTrue) {
      request.supplier!.supplierId = merchant.supplierId;
    }
  }

  Future<void> getAllMerchant({int page = 1, String q = ''}) async {
    var requestBody = <String, dynamic>{
      "limit": 10,
      "page": page,
      if (q.isNotEmpty) "q": q,
    };
    merchantRepository.getAllMerchant(Get.context, requestBody).then((value) {
      if (value.merchantData!.length > 0) {
        nextPageMerchant.value++;
        countMerchant.value = value.pageInfo!.totalRecord!;
        merchantDropdownList.addAll(value.merchantData!);
        merchantDropdownList.toSet().toList();
        merchantDropdownList.refresh();
        isLoadMore.value = true;
      } else {
        isLoadMore.value = false;
      }
    }).catchError((onError) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, '$onError');
    });
  }

  onChangeSearch(String text) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      merchantDropdownList.clear();
      merchantDropdownList.refresh();
      nextPageMerchant.value = 1;
      if (text == "") {
        if (isFirstSearchMerchant.isTrue) {
          getAllMerchant();
          isFirstSearchMerchant.toggle();
        } else {
          getAllMerchant(page: nextPageMerchant.value);
        }
      } else {
        getAllMerchant(q: text);
      }
    });
  }

  Future<bool> loadMore() async {
    if (isLoadMore.isTrue) {
      await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
      if (searchControllerMerchant.text.isNotEmpty) {
        getAllMerchant(
            page: nextPageMerchant.value, q: searchControllerMerchant.text);
      } else {
        getAllMerchant(page: nextPageMerchant.value);
      }
      return true;
    } else {
      return false;
    }
  }

  Future<List<RoleManagementData>> filterListRoleUser(String filter) async {
    List<RoleManagementData> list = [];
    for (var item in listRole) {
      if (item.name!.isContainIgnoreCase(filter.toLowerCase())) {
        list.add(item);
      }
    }
    return list;
  }

  Future<void> getAllRoles() async {
    roleManagementRepository.getRoles(Get.context).then((value) {
      listRole.value = value.data!.cast<RoleManagementData>();
    });
  }

  bool checkRole() {
    if (role.value
            .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE) ||
        role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      return true;
    }

    return false;
  }

  void onChangeRole(RoleManagementData result) {
    roleResponse!.id = result.id;
    roleResponse!.name = result.name;
    roleName.text = result.name!;
    role.value = result.name!.toLowerCase();

    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) ||
        role.value
            .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE) ||
        role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      isShowLobType.value = true;
    } else {
      isShowLobType.value = false;
    }
  }

  void requestToken() async {
    try {
      String? token = await getToken();
      String urlResponse = await createDynamicLink(token);
      request.token = token;
      request.createPasswordUrl = urlResponse;
      if (isEdit.isFalse) {
        addUser();
      } else {
        updateUser();
      }
    } catch (e) {
      DeasySnackBarUtil.showFlushBarError(Get.context!, '$e');
    }
  }

  Future<void> updateUser({String? url, String? token}) async {
    loadingController.isLoading = true;

    request.id = id;
    await userRepository
        .postApiUpdateUser(Get.context, request.toJson())
        .then((value) {
      isShowDialogSubmit.value = true;
    }).catchError((onError) {
      loadingController.isLoading = false;
      isShowDialogSubmit.value = false;
    });
    loadingController.isLoading = false;
  }

  Future<void> addUser() async {
    loadingController.isLoading = true;

    if (role.value
            .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE) ||
        role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      request.supplier!.supplierId = supplierId;
    }

    await userRepository
        .postApiCreateUser(Get.context, request.toJson())
        .then((value) async {
      isShowDialogSubmit.value = true;
    }).catchError((onError) {
      loadingController.isLoading = false;
      isShowDialogSubmit.value = false;
    });
    loadingController.isLoading = false;
  }

  Future<String> createDynamicLink(String? token) async {
    return await dynamicLinkConfig.createDynamicLink(token, deepLinkRepository,
        emailTextController.text, "create", 'new-password');
  }

  Future<String?> getToken() async {
    GetTokenResponse _tokenResponse =
        await authRepository.getTokenEmail(Get.context, null);
    return _tokenResponse.data!.token;
  }

  bool checkNikEditText() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      return true;
    }

    return false;
  }

  String? nikValidation(String value) {
    if (value.isEmpty) {
      return ContentConstant.ktpCantBeNull;
    } else if (value.length != 16) {
      return ValidationConstant.ktpMustBe16Digit;
    } else {
      return null;
    }
  }

  Future<void> getAllLobTypes() async {
    userRepository
        .fetchApiLobTypes(Get.context)
        .then((value) => listLobType.value = value.lobTypes!);
  }

  Future<List<LobType>> filterListLobType(String filter) async {
    List<LobType> list = [];
    for (var item in listLobType) {
      if (item.lobTypeName!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  void onChangeLobType(LobType result) {
    lobTypeSelected.value = result;
    lineTypeController.text = result.lobTypeName!;
  }

  bool checkingTextFieldIsEnable() {
    if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) &&
        isEdit.isTrue) {
      return false;
    }

    return true;
  }

  Future<void> getUserById(String userId) async {
    userRepository.getUserById(Get.context, userId).then((value) {
      id = userId;
      roleResponse = value.data!.role;
      supplierResponse = value.data!.supplier;
      userEmail = value.data!.email;
      var roleRequest = UserManagementRole()..id = value.data!.role!.id;
      int index = listLobType.indexWhere((element) =>
          element.lobType!.isContainIgnoreCase(value.data!.lobTypeName!) ||
          element.lobTypeName!.isContainIgnoreCase(value.data!.lobTypeName!));
      role.value = value.data!.role!.name!;

      if (index != -1) {
        lobTypeSelected.value = listLobType[index];
        lineTypeController.text = listLobType[index].lobTypeName!;
      }

      if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
        isShowLobType.value = true;
        request.nik = value.data!.agent!.nik;
        nikController.text = value.data!.agent!.nik!;
      }

      if (role.value
              .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE) ||
          role.value.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
        merchantTextController.text = supplierResponse!.supplierName!;
        isShowLobType.value = true;
        var supplier = UserManagementSupplier()
          ..supplierId = value.data!.supplier!.supplierId;
        request.supplier = supplier;
      }

      request.role = roleRequest;

      request.name = value.data!.name;
      request.phoneNumber = value.data!.phoneNumber;
      request.email = value.data!.email;

      nameTextController.text = value.data!.name!;
      phoneNumberTextController.text = value.data!.phoneNumber!;
      emailTextController.text = value.data!.email!;
      roleName.text = value.data!.role!.name!;
    });
  }
}
