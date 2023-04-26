import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/optimus_versioning_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_versioning_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusVersioningController extends GetxController {
  final OptimusVersioningRepository versioningRepo;
  OptimusVersioningController({required this.versioningRepo});

  final isLoading = true.obs;
  final iosBtnActive = false.obs;
  final androidBtnActive = false.obs;

  final formKey = GlobalKey<FormState>();
  final iosTextC = TextEditingController().obs;
  final androidTextC = TextEditingController().obs;
  final versioningRes = OptimusVersioningResponse().obs;

  @override
  void onInit() {
    getVersion('ios');
    getVersion('android');
    super.onInit();
  }

  void getVersion(String os) async {
    isLoading.value = true;
    await versioningRepo.getVersion(os).then((value) {
      if (os == 'ios') {
        iosTextC.value.text = value.data!.appVersion!;
      } else {
        androidTextC.value.text = value.data!.appVersion!;
      }
    }).catchError((e) {
      printError(info: e.toString());
    });
    isLoading.value = false;
  }

  void generateVersion(String os, String? ver) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2));
    await versioningRepo.setVersion(os, ver).then((_) {
      dialogSuccess(os, ver);
      iosBtnActive.value = false;
      androidBtnActive.value = false;
    }).catchError((e) {
      printError(info: e.toString());
    });
    isLoading.value = false;
  }

  dialogConfirm(String os, String? newVersion) {
    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 560,
              height: 340,
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
                            text: 'Generate Versi $os Terbaru?',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: DeasyTextView(
                              text:
                                  'Anda akan melakukan generate $os versi V.$newVersion pada aplikasi Deasy Mobile',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
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
                                generateVersion(os, newVersion);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: DeasyTextView(
                                  text: ContentConstant.generate,
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
                                padding: const EdgeInsets.all(15.0),
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

  dialogSuccess(String os, String? ver) {
    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (_, __, ___) {
        return Material(
          color: Colors.transparent,
          child: Center(
            child: Container(
              width: 560,
              height: 300,
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
                      IconConstant.RESOURCES_ICON_SUCCESS_GENERATE),
                  SizedBox(
                    height: 36,
                  ),
                  DeasyTextView(
                    text: ContentConstant.successGenerateTitle,
                    fontSize: 20,
                    fontColor: DeasyColor.neutral900,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DeasyTextView(
                    text:
                        'Anda berhasil generate $os versi V.$ver pada aplikasi Deasy Mobile',
                    textAlign: TextAlign.center,
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
                      getVersion(os.toLowerCase());
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
