import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:kreditplus_deasy_website/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/constant/date_constant.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

class MerchantUserManagementController extends GetxController {
  final isLoading = false.obs;
  final drawerController = Get.find<OptimusDrawerCustomController>();
  RxBool showActionButton = false.obs;

  bool get isOpenDrawer => drawerController.isOpened.value;

  MerchantUserManagementController(
      {required AuthRepository authRepository,
      required DeepLinkRepository deepLinkRepository,
      required DynamicLinkConfig dynamicLinkConfig,
      required RoleManagementRepository roleManagementRepository,
      required UserRepository userRepository})
      : _authRepository = authRepository,
        _deepLinkRepository = deepLinkRepository,
        _dynamicLinkConfig = dynamicLinkConfig,
        _roleManagementRepository = roleManagementRepository,
        _userRepository = userRepository;

  final AuthRepository _authRepository;
  final DeepLinkRepository _deepLinkRepository;
  final DynamicLinkConfig _dynamicLinkConfig;
  final UserRepository _userRepository;
  final RoleManagementRepository _roleManagementRepository;
  final userList = <UserItemResponse>[].obs;
  final isActiveTimer = <bool>[false, false, false].obs;
  ScrollController tableScrollController = ScrollController();


  late String createPasswordUrl;
  late String merchantEmployeeRoleId;
  late String token;

  bool isShowSuccessResendDialog = false;
  bool isShowSuccessDeleteDialog = false;

  @override
  void onInit() async {
    isLoading.value = true;
    await fetchRoles();
    await fetchUserList();
    isLoading.value = false;
    super.onInit();
  }

  fetchRoles() async {
    await _roleManagementRepository.getRoles(Get.context).then((value) {
      value.data!.forEach((role) {
        if (role.name!
            .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE)) {
          merchantEmployeeRoleId = role.id!;
        }
      });
    });
  }

  fetchUserList() async {
    await _userRepository
        .fetchApiAllUsers(Get.context, getRequest())
        .then((value) {
      userList.addAll(value.data!);
    });
  }

  getRequest() {
    return {
      "roles": [merchantEmployeeRoleId]
    };
  }

  getTimerDuration({DateTime? createdAt, DateTime? retryAt, int? index}) {
    var duration;
    if (retryAt != null) {
      var formattedRetryAtTime = convertToISODateFormat(retryAt, true);
      var differenceInMinutes =
          formattedRetryAtTime.difference(DateTime.now()).inMinutes;

      if (!(differenceInMinutes <= 0)) {
        duration = formattedRetryAtTime.difference(DateTime.now());
      }
    } else {
      var formattedCreatedAtTime = convertToISODateFormat(createdAt!, false);

      var differenceInMinutes =
          DateTime.now().difference(formattedCreatedAtTime).inMinutes;

      if (differenceInMinutes < 5) {
        var addedTime = formattedCreatedAtTime.add(Duration(minutes: 5));
        duration = addedTime.difference(DateTime.now());
      }
    }

    if (duration != null) {
      isActiveTimer[index!] = true;
    } else {
      isActiveTimer[index!] = false;
    }

    return duration;
  }

  DateTime convertToISODateFormat(DateTime dateTime, bool convertToLocal) {
    return DateTime.parse(dateTime.toString().toFormattedDate(
        convertToLocal: convertToLocal,
        format: DateConstant.dateFormatISO8601));
  }

  navigateToAddUser() {
    if (isLoading.isFalse && userList.length < 3) {
      Get.toNamed(OptimusRoutes.MERCHANT_USER_MANAGEMENT_ADD,
              arguments: merchantEmployeeRoleId)!
          .then((value) => reloadUserList());
    }
  }

  reloadUserList() async {
    isLoading.value = true;
    userList.clear();
    await fetchUserList();
    isLoading.value = false;
  }

  Future<void> resendEmail(String email) async {
    isLoading.value = true;
    await setTokenAndUrl(email);
    await sendEmail(email, Uri.parse(createPasswordUrl), token);
  }

  setTokenAndUrl(String email) async {
    token = (await getToken())!;
    createPasswordUrl = await createDynamicLink(token, email);
  }

  Future<String> createDynamicLink(String token, String email) async {
    return await _dynamicLinkConfig.createDynamicLink(
        token, _deepLinkRepository, email, "create", "new-password");
  }

  Future<String?> getToken() async {
    GetTokenResponse _tokenResponse =
        await _authRepository.getTokenEmail(Get.context, null);
    return _tokenResponse.data!.token;
  }

  sendEmail(String email, Uri url, String? token) async {
    await _authRepository
        .postPasswordEmail(
            Get.context,
            createRequestPasswordMail(email, url, token),
            "Add_Merchant_Verify_Email")
        .then((value) {
      isShowSuccessResendDialog = true;
    }).catchError((_) {
      isShowSuccessResendDialog = false;
    }).whenComplete(() => reloadUserList());
  }

  Map<String, dynamic> createRequestPasswordMail(
      String email, Uri url, String? token) {
    var request = Map<String, String>();
    request["email"] = email;
    request["type"] = "create_password";
    request["url"] = "$url";
    request["token"] = "$token";
    return request;
  }

  Future<void> deleteUser(String userId) async {
    isLoading.value = true;
    await _userRepository
        .deleteAccount(Get.context, null, userId)
        .then((value) {
      isShowSuccessDeleteDialog = true;
    }).catchError((error) {
      isShowSuccessDeleteDialog = false;
    });
  }

  String incrementNumber(int index){
    int number = index + 1;
    return number.toString();
  }
}
