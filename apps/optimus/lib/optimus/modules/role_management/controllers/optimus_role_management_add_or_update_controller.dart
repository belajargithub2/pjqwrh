import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/role_management/models/optimus_role_management_request.dart'
    as request;
import 'package:kreditplus_deasy_website/optimus/modules/role_management/repositories/optimus_role_management_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

class OptimusRoleManagementAddOrUpdateController extends GetxController {
  late OptimusRoleManagementRepository roleManagementRepository;
  final isUpdate = false.obs;
  final isLoading = false.obs;
  TextEditingController nameController = TextEditingController();
  final Rx<OptimusRoleDetailResponse> role =
      OptimusRoleDetailResponse().obs;

  final isActive = false.obs;

  final isSNB = false.obs;
  final isOnline = false.obs;
  final isOffline = false.obs;

  final isEnable = true.obs;

  final isPO = false.obs;
  final isBuktiTerimaView = false.obs;
  final isBuktiTerimaUpload = false.obs;
  final isImeiView = false.obs;
  final isImeiUpload = false.obs;

  final isInvoice = false.obs;
  final isBastView = false.obs;
  final isBastUpload = false.obs;

  final isRequestCancel = false.obs;

  final isSourceApp = false.obs;
  final isEKey = false.obs;
  final isCallback = false.obs;
  final isRoleM = false.obs;
  final isDelaerM = false.obs;
  final isMerchantUserM = false.obs;
  final isUserM = false.obs;
  final isSubsidiDealer = false.obs;

  final roleName = "Tambah Role".obs;
  final roleId = "".obs;

  //This is a hardcoded flag for show/hide BAST switch widget
  //TODO: set isShowBast = true, to show BAST switch again
  final isShowBast = false.obs;

  @override
  void onInit() {
    DeasySizeConfigUtils().init(context: Get.context);
    isUpdate.value = Get.parameters['type'] == null
        ? false
        : Get.parameters['type']!.isContainIgnoreCase("edit");
    roleId.value = Get.parameters['role_id'] ?? '';
    roleManagementRepository = OptimusRoleManagementRepository();
    getDetailRole();
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

  void changeStatus(bool status) {
    if (status == false) {
      if (nameController.text != "Super Admin") {
        showDialogChangeStatus(status);
      }
    } else {
      isActive.value = status;
    }
  }

  showDialogChangeStatus(bool status) {
    showDialog(
        context: Get.context!,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.fromLTRB(27, 40, 27, 40),
              backgroundColor: DeasyColor.neutral000,
              content: Container(
                width: DeasySizeConfigUtils.screenWidth! / 4.5,
                height: DeasySizeConfigUtils.screenHeight! / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'resources/images/icons/ic_warning.svg',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Anda yakin untuk menonaktifkan Role ini?',
                        style: TextStyle(
                          fontSize: 20,
                          color: DeasyColor.neutral900,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Dengan ini Role ini akan di nonaktifkan untuk sementara waktu.',
                        style: TextStyle(
                          fontSize: 14,
                          color: DeasyColor.neutral400,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: DeasyCustomElevatedButton(
                            text: "Setuju",
                            textColor: DeasyColor.neutral000,
                            borderColor: DeasyColor.neutral000,
                            primary: DeasyColor.kpYellow500,
                            onPress: () {
                              isActive.value = status;
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: DeasyCustomElevatedButton(
                            text: "Batalkan",
                            textColor: DeasyColor.kpYellow500,
                            borderColor: DeasyColor.kpYellow500,
                            primary: DeasyColor.neutral000,
                            onPress: () {
                              Get.back();
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  void getDetailRole() {
    if (isUpdate.isTrue) {
      nameController.text = roleName.value;
      isLoading.value = true;
      roleManagementRepository
          .getDetailRoles(Get.context, {"role_id": roleId.value}).then((value) {
        setDetail(value);
      }).catchError((e) {
        roleName.value = '-';
        isLoading.value = false;
      });

      if (roleName.value == "Super Admin") {
        isEnable.value = false;
      }
    }
  }

  submit() {
    if (nameController.text.isEmpty) {
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, "Nama Role tidak boleh kosong");
    } else {
      if (isUpdate.isTrue) {
        isLoading.value = true;
        roleManagementRepository
            .updateRoles(Get.context, requestRoleM().toJson())
            .then((value) {
          if (value.message == "OK") {
            isLoading.value = false;
            showDialogSuccessCreateRole();
          }
        }).catchError((onError) {
          DeasySnackBarUtil.showFlushBarError(Get.context!, "$onError");
        });
      } else {
        roleManagementRepository
            .createRoles(Get.context, requestRoleM().toJson())
            .then((value) {
          if (value.message == "OK") {
            showDialogSuccessCreateRole();
          }
        }).catchError((onError) {
          DeasySnackBarUtil.showFlushBarError(Get.context!, "$onError");
        });
      }
    }
  }

  request.OptimusRequestRoleManagement requestRoleM() {
    var dashboardPermission = request.DashboardPermission(
      invoice: isInvoice.value,
      offline: isOffline.value,
      online: isOnline.value,
      po: isPO.value,
      snb: isSNB.value,
      uploadBast: isBastUpload.value,
      uploadBuktiTerima: isBuktiTerimaUpload.value,
      uploadImei: isImeiUpload.value,
      viewBast: isBastView.value,
      viewBuktiTerima: isBuktiTerimaView.value,
      viewImei: isImeiView.value,
      requestCancel: isRequestCancel.value
    );

    var menuPermission = request.MenuPermission(
      callback: isCallback.value,
      dealerManagement: isDelaerM.value,
      ecommerceClientKey: isEKey.value,
      merchantUserManagement: isMerchantUserM.value,
      roleManagement: isRoleM.value,
      sourceApplication: isSourceApp.value,
      userManagement: isUserM.value,
      subsidyDealer: isSubsidiDealer.value,
    );

    if (isUpdate.isTrue) {
      return request.OptimusRequestRoleManagement(
          dashboardPermission: dashboardPermission,
          menuPermission: menuPermission,
          roleName: nameController.text,
          roleId: roleId.value,
          status: isActive.value);
    } else {
      return request.OptimusRequestRoleManagement(
          dashboardPermission: dashboardPermission,
          menuPermission: menuPermission,
          roleName: nameController.text,
          roleId: "",
          status: isActive.value);
    }
  }

  void setDetail(OptimusRoleDetailResponse value) {
    isActive.value = value.data!.status!;

    isSNB.value = value.data!.dashboardPermission!.snb!;
    isOnline.value = value.data!.dashboardPermission!.online!;
    isOffline.value = value.data!.dashboardPermission!.offline!;

    isPO.value = value.data!.dashboardPermission!.po!;
    isBuktiTerimaView.value = value.data!.dashboardPermission!.viewBuktiTerima!;
    isBuktiTerimaUpload.value =
        value.data!.dashboardPermission!.uploadBuktiTerima!;
    isImeiView.value = value.data!.dashboardPermission!.viewImei!;
    isImeiUpload.value = value.data!.dashboardPermission!.uploadImei!;

    isRequestCancel.value = value.data!.dashboardPermission!.requestCancel!;

    isInvoice.value = value.data!.dashboardPermission!.invoice!;
    isBastView.value = value.data!.dashboardPermission!.viewBast!;
    isBastUpload.value = value.data!.dashboardPermission!.uploadBast!;

    isSourceApp.value = value.data!.menuPermission!.sourceApplication!;
    isEKey.value = value.data!.menuPermission!.ecommerceClientKey!;
    isCallback.value = value.data!.menuPermission!.callback!;
    isRoleM.value = value.data!.menuPermission!.roleManagement!;
    isDelaerM.value = value.data!.menuPermission!.dealerManagement!;
    isMerchantUserM.value = value.data!.menuPermission!.merchantUserManagement!;
    isUserM.value = value.data!.menuPermission!.userManagement!;
    isSubsidiDealer.value = value.data!.menuPermission!.subsidyDealer!;
    roleName.value = value.data!.name!;
    isLoading.value = false;
  }

  showDialogSuccessCreateRole() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)),
        child: Container(
          width: DeasySizeConfigUtils.screenWidth! / 2.5,
          height: DeasySizeConfigUtils.screenHeight! / 1.98,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: DeasyColor.neutral400,
                    ),
                    onPressed: () {
                      Get.back();
                      Get.offNamed(OptimusRoutes.ROLE_MANAGEMENT);
                    },
                  ),
                ),
              ),
              Image.asset(
                "resources/images/success_add_role.png",
                fit: BoxFit.cover,
                scale: 1.2,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: DeasyTextView(
                  text: isUpdate.isTrue
                    ? ContentConstant.successUpdateRole
                    : ContentConstant.successAddRole,
                  fontSize: 15,
                  fontColor: DeasyColor.neutral900,
                  fontFamily: FontFamily.medium,
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer()
            ],
          ),
        )
      ),
      barrierDismissible: false
    );
  }
}
