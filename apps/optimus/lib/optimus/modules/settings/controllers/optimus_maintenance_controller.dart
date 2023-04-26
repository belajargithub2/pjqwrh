import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/optimus_maintenance_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_maintenance_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusMaintenanceController extends GetxController {
  final OptimusMaintenanceRepository maintenanceRepo;
  OptimusMaintenanceController({required this.maintenanceRepo});

  final isLoading = true.obs;
  final btnEdit = false.obs;
  final isEdit = false.obs;
  final snbModul = false.obs;
  final allModulMerchant = false.obs;
  final orderFromModul = false.obs;
  final allModulAgent = false.obs;

  @override
  void onInit() {
    getMaintenance();
    super.onInit();
  }

  void getMaintenance() async {
    isLoading.value = true;
    isEdit.value = false;
    await maintenanceRepo.getMaintenances().then((value) {
      snbModul.value = value.data!.merchant!.snbModul!;
      allModulMerchant.value = value.data!.merchant!.allModulMerchant!;
      orderFromModul.value = value.data!.agent!.orderFormModul!;
      allModulAgent.value = value.data!.agent!.allModulAgent!;
    }).catchError((e) {
      printError(info: e.toString());
    });
    isLoading.value = false;
  }

  void setMaintenance() async {
    isLoading.value = true;
    Merchant m = Merchant(
        snbModul: snbModul.value, allModulMerchant: allModulMerchant.value);
    Agent a = Agent(
        orderFormModul: orderFromModul.value,
        allModulAgent: allModulAgent.value);
    MaintenanceDataResponse param =
        MaintenanceDataResponse(merchant: m, agent: a);
    await Future.delayed(Duration(seconds: 2));
    await maintenanceRepo.setMaintenances(param.toJson()).then((_) {
      dialogSuccess();
    }).catchError((e) {
      print(e.toString());
      printError(info: e.toString());
    });
    isLoading.value = false;
  }

  dialogConfirm() {
    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 560,
              height: 270,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: DeasyColor.neutral000,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(
                    IconConstant.RESOURCES_ICON_WARNING_PATH,
                    width: 64,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DeasyTextView(
                            text: '${ContentConstant.saveChangesLabel}?',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.kpYellow500,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                setMaintenance();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DeasyTextView(
                                  text: ButtonConstant.save,
                                  fontColor: DeasyColor.neutral000,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: DeasyColor.neutral000,
                                side: BorderSide(
                                    width: 1, color: DeasyColor.kpYellow500),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DeasyTextView(
                                  text: ButtonConstant.cancel,
                                  fontColor: DeasyColor.kpYellow500,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  dialogSuccess() {
    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 560,
              height: 280,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: DeasyColor.neutral000,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  SvgPicture.asset(
                    IconConstant.RESOURCES_ICON_SUCCESS_GENERATE,
                    height: 64,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  DeasyTextView(
                    text: ContentConstant.changeSuccess,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: DeasyColor.kpYellow500,
                      side: BorderSide(width: 1, color: DeasyColor.kpYellow500),
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size.fromHeight(50),
                      padding: EdgeInsets.all(8),
                    ),
                    onPressed: () {
                      Get.back();
                      getMaintenance();
                    },
                    child: DeasyTextView(
                      text: ButtonConstant.back,
                      fontColor: DeasyColor.neutral000,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
