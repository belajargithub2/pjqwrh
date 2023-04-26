import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/request/optimus_source_application_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_create_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/models/response/optimus_source_application_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/source_application/repositories/optimus_source_application_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusAddOrUpdateSourceApplicationController extends GetxController {
  late OptimusSourceApplicationRepository sourceApplicationRepository;
  String? id;
  late OptimusSourceAppRequest request;

  final sourceAppData = SourceAppData().obs;
  final isEdit = false.obs;
  final sourceAppTextController = TextEditingController();
  final callbackUrlStatusTextController = TextEditingController();
  final callbackUrlOrderTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    sourceApplicationRepository = OptimusSourceApplicationRepository();
    String? id = Get.parameters['id'];
    await getSourceApp(id);
    request = OptimusSourceAppRequest();
    var _data = sourceAppData.value;
    setValue(_data);
    request.id = _data.id;
    request.callbackUrlSignature = _data.callbackUrlSignature;
    request.callbackUrlOrder = _data.callbackUrlOrder;
    request.callbackUrlStatus = _data.callbackUrlStatus;
    super.onInit();
  }

  Future<void> getSourceApp(String? id) async {
    OptimusSourceAppCreateResponse sourceApp = await sourceApplicationRepository
        .getSourceApplicationById(Get.context, "$id");
    isEdit(sourceApp.sourceAppData?.id != null);
    sourceAppData.value.id = sourceApp.sourceAppData?.id;
    sourceAppData.value.createdAt = sourceApp.sourceAppData?.createdAt;
    sourceAppData.value.updatedAt = sourceApp.sourceAppData?.updatedAt;
    sourceAppData.value.sourceApplication =
        sourceApp.sourceAppData?.sourceApplication;
    sourceAppData.value.callbackUrlSignature =
        sourceApp.sourceAppData?.callbackUrlSignature;
    sourceAppData.value.callbackUrlStatus =
        sourceApp.sourceAppData?.callbackUrlStatus;
    sourceAppData.value.callbackUrlOrder =
        sourceApp.sourceAppData?.callbackUrlOrder;
  }

  String? urlValidator(String value) {
    if (value.isEmpty || value.isBlank!) {
      return ContentConstant.urlCantBeNull;
    } else if (!value.urlValidation()) {
      return ContentConstant.urlNotValid;
    }
    return null;
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      OptimusSourceAppRequest request = OptimusSourceAppRequest();
      if (isEdit.isTrue) request.id = id;
      request.sourceApplication = sourceAppTextController.text;
      request.callbackUrlStatus = callbackUrlStatusTextController.text.isEmpty
          ? "https://"
          : callbackUrlStatusTextController.text;
      request.callbackUrlOrder = callbackUrlOrderTextController.text;
      request.callbackUrlSignature = "https://";
      postCreateEditSourceApp(request.generateRequest());
    }
  }

  void postCreateEditSourceApp(Map<String, dynamic> requestBody) {
    if (isEdit.isTrue) {
      request.id = id;
      request.callbackUrlSignature = sourceAppData.value.callbackUrlSignature;
      sourceApplicationRepository
          .fetchApiEditSourceApp(Get.context, requestBody)
          .then((value) {
        showSuccessDialog();
      }).catchError((onError) {});
    } else {
      sourceApplicationRepository
          .fetchApiCreateSourceApp(Get.context, requestBody)
          .then((value) {
        showSuccessDialog();
      });
    }
  }

  showSuccessDialog() {
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
                      Get.back();
                    },
                  ),
                ),
              ),
              Image.asset(
                "resources/images/success_add_role.png",
                fit: BoxFit.cover,
                scale: 1.2,
              ),
              SizedBox(height: 30),
              DeasyTextView(
                text: isEdit.isTrue
                    ? "Source Application telah berhasil diubah."
                    : "Source Application telah berhasil ditambahkan.",
                textAlign: TextAlign.center,
                fontColor: DeasyColor.neutral900,
                fontFamily: FontFamily.medium,
              ),
              Spacer()
            ],
          ),
        )
      ),
      barrierDismissible: false
    );
  }

  void setValue(SourceAppData data) {
    sourceAppTextController.text = data.sourceApplication!;
    callbackUrlStatusTextController.text = data.callbackUrlStatus!;
    callbackUrlOrderTextController.text = data.callbackUrlOrder!;
    id = data.id;
  }
}
