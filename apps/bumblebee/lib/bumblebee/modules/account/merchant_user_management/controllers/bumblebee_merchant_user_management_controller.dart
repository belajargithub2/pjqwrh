import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeMerchantUserManagementController extends GetxController {
  BumblebeeMerchantUserManagementController(
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
  final isLoading = false.obs;
  final userList = <UserItemResponse>[].obs;
  final isActiveTimer = <bool>[].obs;

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
        if (role.name!.isContainIgnoreCase(ContentConstant.ROLE_MERCHANT_EMPLOYEE)) {
          merchantEmployeeRoleId = role.id!;
        }
      });
    }).catchError((_) {
      isLoading.value = false;
    });
  }

  fetchUserList() async {
    await _userRepository.fetchApiAllUsers(Get.context, createJsonRequestParameter()).then((value) {
      userList.addAll(value.data!);
    }).catchError((_) {
      isLoading.value = false;
    });
  }

  createJsonRequestParameter() {
    return {"roles": [merchantEmployeeRoleId]};
  }

  getTimerDuration({
    DateTime? createdAt,
    DateTime? retryAt
  }) {
    var duration;
    if (retryAt != null) {
      var formattedRetryAtTime = convertToISODateFormat(retryAt, true);
      var differenceInMinutes = formattedRetryAtTime.difference(DateTime.now()).inMinutes;

      if (!(differenceInMinutes <= 0)) {
        isActiveTimer.add(true);
        duration = formattedRetryAtTime.difference(DateTime.now());
      } else {
        isActiveTimer.add(false);
      }
    } else {
      var formattedCreatedAtTime = convertToISODateFormat(createdAt!, false);

      var differenceInMinutes = DateTime.now()
        .difference(formattedCreatedAtTime).inMinutes;
        
      if (differenceInMinutes < 5) {
        isActiveTimer.add(true);
        var addedTime = formattedCreatedAtTime.add(Duration(minutes: 5));
        duration = addedTime.difference(DateTime.now());
      } else {
        isActiveTimer.add(false);
      }
    }

    return duration;
  }

  DateTime convertToISODateFormat(DateTime dateTime, bool convertToLocal) {
    return DateTime.parse(
      dateTime.toString().toFormattedDate(
        convertToLocal: convertToLocal,
        format: DateConstant.dateFormatISO8601
      )
    );
  }

  navigateToAddUser() {
    if (isLoading.isFalse && userList.length != 3) {
      Get.toNamed(
        BumblebeeRoutes.ADD_MERCHANT_USER_MANAGEMENT,
        arguments: merchantEmployeeRoleId
      )!.then((value) => reloadUserList());
    }
  }

  reloadUserList() async {
    isLoading.value = true;
    isActiveTimer.clear();
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
      token,
      _deepLinkRepository,
      email,
      "create",
      "new-password"
    );
  }

  Future<String?> getToken() async {
    GetTokenResponse _tokenResponse = await _authRepository.getTokenEmail(Get.context, null);
    return _tokenResponse.data!.token;
  }

  sendEmail(String email, Uri url, String? token) async {
    await _authRepository
        .postPasswordEmail(Get.context, createRequestPasswordMail(email, url, token),
            "Add_Merchant_Verify_Email")
        .then((value) {
      isShowSuccessResendDialog = true;
    }).catchError((_) {
      isShowSuccessResendDialog = false;
    });
  }

  Map<String, dynamic> createRequestPasswordMail(String email, Uri url, String? token) {
    var request = Map<String, String>();
    request["email"] = email;
    request["type"] = "create_password";
    request["url"] = "$url";
    request["token"] = "$token";
    return request;
  }

  Future<void> deleteUser(String userId) async {
    isLoading.value = true;
    await _userRepository.deleteAccount(Get.context, null, userId).then((value) {
      isShowSuccessDeleteDialog = true;
    }).catchError((error) {
      isShowSuccessDeleteDialog = false;
    });
  }
}