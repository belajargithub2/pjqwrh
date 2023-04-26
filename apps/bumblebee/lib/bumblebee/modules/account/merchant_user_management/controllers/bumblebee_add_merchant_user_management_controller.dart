import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeAddMerchantUserManagementController extends GetxController {
  BumblebeeAddMerchantUserManagementController(
    {required UserRepository userRepository})
    : _userRepository = userRepository;

  final UserRepository _userRepository;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final isFormNotEmpty = false.obs;
  final isLoading = false.obs;
  BumblebeeMerchantUserManagementController merchantUserManagementController =
    Get.find<BumblebeeMerchantUserManagementController>();
  
  bool isShowSuccessDialog = false;
  late String merchantEmployeeRoleId;
  late String supplierId;
  late String token;
  late String createPasswordUrl;
  late String lobType;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  @override
  void onInit() async {
    merchantEmployeeRoleId = Get.arguments ?? "";
    await getSupplierId();
    nameController.addListener(_formListenerController);
    emailController.addListener(_formListenerController);

    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.removeListener(_formListenerController);
    emailController.removeListener(_formListenerController);
  }

  void _formListenerController() {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      isFormNotEmpty.value = true;
    } else {
      isFormNotEmpty.value = false;
    }
  }

  getSupplierId() async {
    supplierId = await DeasyPocket().getSupplierId();
  }

  Future<void> submit() async {
    if (isFormNotEmpty.isFalse) {
      return;
    } else {
      autoValidate.value = AutovalidateMode.always;
      if (formKey.currentState!.validate()) {
        isLoading.value = true;
        await setLobTypes();
        await merchantUserManagementController.setTokenAndUrl(emailController.text);
        await _userRepository.postApiCreateUser(Get.context, createJsonRequestParameter()).then((value) {
          isLoading.value = false;
          isShowSuccessDialog = true;
        }).catchError((error) {
          isLoading.value = false;
          isShowSuccessDialog = false;
        });
      }
    }
  }

  createJsonRequestParameter() {
    return UserManagementRequest(
      supplier: UserManagementSupplier(supplierId: supplierId),
      name: nameController.text,
      phoneNumber: phoneController.text,
      email: emailController.text,
      role: UserManagementRole(id: merchantEmployeeRoleId),
      createPasswordUrl: merchantUserManagementController.createPasswordUrl,
      token: merchantUserManagementController.token,
      lobType: lobType
    ).toJson();
  }

  setLobTypes() async {
    await _userRepository.fetchApiLobTypes(Get.context).then((value) {
      value.lobTypes!.forEach((lob) {
        if (lob.lobType!.isContainIgnoreCase(ContentConstant.deaLobType) ||
            lob.lobTypeName.isContainIgnoreCase(ContentConstant.electronicLobName)) {
          lobType = lob.lobType!;
        }
      });
    });
  }
}