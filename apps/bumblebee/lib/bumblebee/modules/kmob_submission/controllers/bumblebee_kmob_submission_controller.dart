import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_generate_prospect_id_agent.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/request/request_generate_prospect_id_agent.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_local_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

enum SECTION { DATA_KONSUMEN, DATA_ASET, UPLOAD_DOKUMEN }

class BumblebeeKMOBSubmissionController extends GetxController {
  final BumblebeeKMOBSubmissionRepository? kmobSubmissionRepository;
  final BumblebeeDraftRepository? draftRepository;
  final BumblebeeLocalRepository? localRepository;

  BumblebeeKMOBSubmissionController({this.kmobSubmissionRepository, this.draftRepository, this.localRepository});

  final index = 0.obs;
  final Rx<AgentSubmission?> source = AgentSubmission.NEW.obs;
  final prospectId = ''.obs;
  final agentId = ''.obs;
  final isLoading = false.obs;
  final Rx<SECTION> activeMainSection = SECTION.DATA_KONSUMEN.obs;
  static const regExpAlphabetOnly = r'^[0-9]+$';
  static const regExpNumericOnly = '^[a-zA-Z]+';
  final typeOfLob = 'KMOB'.obs;
  final isShowError = false.obs;
  final errorMessage = ''.obs;
  final Rx<KmobSubmissionModel> kmobSubmissionModel = KmobSubmissionModel().obs;

  @override
  void onInit() {
    setAgentId();
    checkSource();
    super.onInit();
  }

  void goToAssetSection() {
    activeMainSection.value = SECTION.DATA_ASET;
    index.value = 1;
  }

  Future<List<ResponseLocalGetKmobSubmission>?> getLocalSubmission() async {
    List<ResponseLocalGetKmobSubmission>? list = await localRepository!.getLocalRecord();
    return list;
  }

  Future<void> saveOrUpdateToLocal(ResponseLocalGetKmobSubmission responseLocalGetKmobSubmission) {
    return localRepository!.saveOrUpdateToLocal(responseLocalGetKmobSubmission);
  }

  Future<void> deleteLocalRecord() async {
    await getLocalSubmission().then((value) {
      if (value!.length > 0) {
        return localRepository!.deleteRecord();
      }
    });
  }

  Map<String, dynamic> getRequestBranch(String branchId) {
    RequestGenerateProspectIdAgent requestGenerateProspectIdAgent =
        RequestGenerateProspectIdAgent()
          ..branchId = branchId
          ..lobType = typeOfLob.value;
    return requestGenerateProspectIdAgent.toJson();
  }

  Future<ResponseGenerateProspectIdAgent> generateProspectIdAgent(String branchId, BuildContext? context) async {
    ResponseGenerateProspectIdAgent result =  await kmobSubmissionRepository!.generateProspectIdAgent(context, requestBody: getRequestBranch(branchId));
    if (result != null) {
      updateProspectiD(result.data!.prospectId!);
    }
    return result;
  }

  void errorSnackBar(String message) {
    errorMessage.value = message;
    isShowError.value = true;
  }

  String? ktpValidation(String value) {
    if (value.isEmpty) {
      return ContentConstant.ktpCantBeNull;
    } else if (value.length != 16) {
      return ContentConstant.ktpMustBe16Digit;
    } else {
      return null;
    }
  }

  String? checkValueEmpty(String value, String message) {
    if (value.isEmpty) {
      return message;
    }

    return null;
  }

  String? checkLicenseNumber(String value) {
    if (value.isEmpty) {
      return ContentConstant.licenseNumberCantBeNull;
    } else if (value.contains(RegExp(regExpAlphabetOnly)) && value.length > 4) {
      return ContentConstant.licenseNumberMustBe4Digit;
    } else {
      return null;
    }
  }

  String? checkLicenseArea(String value) {
    if (value.isEmpty) {
      return ContentConstant.licenseAreaCantBeNull;
    } else if (value.contains(RegExp(regExpNumericOnly)) && value.length > 2) {
      return ContentConstant.licenseAreaMustBe2Digit;
    } else {
      return null;
    }
  }

  String? checkLicenseCode(String value) {
    if (value.isEmpty) {
      return ContentConstant.licenseCodeCantBeNull;
    } else if (value.contains(RegExp(regExpNumericOnly)) && value.length > 3) {
      return ContentConstant.licenseCodeMustBe3Digit;
    } else {
      return null;
    }
  }

  void goToUploadDocumentSection() {
    activeMainSection.value = SECTION.UPLOAD_DOKUMEN;
    index.value = 2;
  }

  void setAgentId() async {
    agentId.value = await getAgentId();
  }

  Future<String> getAgentId() async {
    return await DeasyPocket().getSupplierIdOrAgentId();
  }

  void checkSource() async{
    source.value = Get.arguments == null
        ? AgentSubmission.NEW
        : Get.arguments['source'];

    if (source.value == AgentSubmission.DRAFT) {
      prospectId(Get.arguments['prospectId']);
    }
  }

  void showLoading() {
    isLoading.value = true;
  }

  void hiddenLoading() {
    isLoading.value = false;
  }

  void setSource(AgentSubmission? agentSubmission) {
    source.value = agentSubmission;
  }

  void updateProspectiD(String value) {
    prospectId.value = value;
  }

}
