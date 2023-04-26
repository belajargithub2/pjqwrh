import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/controllers/merchant_user_management_controller.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';

class MerchantAddUserManagementController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final drawerController = Get.find<OptimusDrawerCustomController>();

  bool get isOpenDrawer => drawerController.isOpened.value;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final UserRepository _userRepository;
  final isFormNotEmpty = false.obs;
  final _merchantUserManagementController =
      Get.find<MerchantUserManagementController>();

  bool isShowSuccessDialog = false;
  late String merchantEmployeeRoleId;
  late String supplierId;
  late String token;
  late String createPasswordUrl;
  late String lobType;
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  MerchantAddUserManagementController({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  void onInit() async {
    nameController.addListener(_formListenerController);
    emailController.addListener(_formListenerController);
    merchantEmployeeRoleId = Get.arguments;
    await getSupplierId();

    super.onInit();
  }

  void _formListenerController() {
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      isFormNotEmpty.value = true;
    } else {
      isFormNotEmpty.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.removeListener(_formListenerController);
    emailController.removeListener(_formListenerController);
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
        await _merchantUserManagementController
            .setTokenAndUrl(emailController.text);
        await _userRepository
            .postApiCreateUser(Get.context, createJsonRequestParameter())
            .then((value) {
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
            createPasswordUrl:
                _merchantUserManagementController.createPasswordUrl,
            token: _merchantUserManagementController.token,
            lobType: lobType)
        .toJson();
  }

  setLobTypes() async {
    await _userRepository.fetchApiLobTypes(Get.context).then((value) {
      value.lobTypes!.forEach((lob) {
        if (lob.lobType!.isContainIgnoreCase(ContentConstant.deaLobType) ||
            lob.lobTypeName
                .isContainIgnoreCase(ContentConstant.electronicLobName)) {
          lobType = lob.lobType!;
        }
      });
    });
  }
}
