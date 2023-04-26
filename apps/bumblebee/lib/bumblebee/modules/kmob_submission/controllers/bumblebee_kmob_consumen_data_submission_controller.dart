import 'dart:async';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_branch.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_marital_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/repositories/draft_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/repositories/bumblebee_kmob_submission_repository.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/mapper/bumblebee_kmob_mapper.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeKMOBConsumerDataSubmissionController extends GetxController {
  final BumblebeeKMOBSubmissionRepository? kmobSubmissionRepository;
  final BumblebeeKMOBSubmissionController? kmobSubmissionController;
  final BumblebeeDraftRepository? draftRepository;

  BumblebeeKMOBConsumerDataSubmissionController({
    this.kmobSubmissionRepository,
    this.kmobSubmissionController,
    this.draftRepository,
  });

  final formConsumenDataKey = GlobalKey<FormState>();
  final formConsumenPartnerDataKey = GlobalKey<FormState>();
  final Rx<AutovalidateMode> autoValidate = AutovalidateMode.disabled.obs;

  final branchController = TextEditingController();
  final customerNameController = TextEditingController();
  final idNumberController = TextEditingController();
  final birthPlaceController = TextEditingController();
  final genderController = TextEditingController();
  final surgateMotherNameController = TextEditingController();
  final mobilePhoneController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final birthDateController = TextEditingController();
  final Rx<ResponseLocalGetKmobSubmission> responseDetailDraft = ResponseLocalGetKmobSubmission().obs;

  final spouseNameController = TextEditingController();
  final spouseIdNumberController = TextEditingController();
  final spouseBirthDateController = TextEditingController();
  final spouseBirthPlaceController = TextEditingController();
  final spouseGenderController = TextEditingController();
  final spouseMobilePhoneController = TextEditingController();
  final spouseSurgateMotherNameController = TextEditingController();

  final branchId = ''.obs;
  final moId = ''.obs;
  final moName = ''.obs;
  final agentIdConfins = ''.obs;
  final maritalStatusId = ''.obs;
  final listBrandVisible = false.obs;
  final isMarried = false.obs;
  final RxList<BranchData> listBranch = <BranchData>[].obs;
  final RxList<MaritalStatusData> listMaritalStatus = <MaritalStatusData>[].obs;
  final RxList<KmobSubmissionModel> listKmob = <KmobSubmissionModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    Future.wait([
      fetchApiBranch(),
      fetchMaritalStatus(),
    ]).whenComplete(() {
      checkDraftConsumerData();
    });
  }

  Future<ResponseGetBranch> fetchApiBranch() async {
      final result = await kmobSubmissionRepository!.getBranch(null);
    listBranch.value = result.data!;
    return result;
  }

  Future<List<BranchData>> filterListBranch(String filter) async {
    List<BranchData> list = [];
    for (var item in listBranch) {
      if (item.branchFullName!.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  void onTapDatePicker({required bool isConsumen}) async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateConstant.getDateNow,
        firstDate: DateConstant.getFirstDate,
        lastDate: DateConstant.getEndDate);

    if (pickedDate != null) {
      String formattedDate =
          DateFormat(DateConstant.dateFormat).format(pickedDate);
      if (isConsumen) {
        birthDateController.text = formattedDate;
      } else {
        spouseBirthDateController.text = formattedDate;
      }
    }
  }

  Future<ResponseGetMaritalStatus> fetchMaritalStatus() async {
    final result =  await kmobSubmissionRepository!.getMaritalStatus();
    listMaritalStatus.value = result.data!;
    return result;
  }

  void onChangeMaritalStatus(MaritalStatusData result) {
    isMarried.value = false;
    if (result.id == "M") {
      isMarried.value = true;
    }
    maritalStatusId.value = result.id!;
    maritalStatusController.text = result.text!;
  }

  void clearPartnerData() {
    spouseNameController.clear();
    spouseNameController.clear();
    spouseIdNumberController.clear();
    spouseBirthDateController.clear();
    spouseBirthPlaceController.clear();
    spouseGenderController.clear();
    spouseMobilePhoneController.clear();
    spouseSurgateMotherNameController.clear();
  }

  void onChangeGender(String result, bool isConsumen) {
    if (isConsumen) {
      genderController.text = result;
    } else {
      spouseGenderController.text = result;
    }
  }

  String? phoneNumberValidation(String value) {
    if (value.isEmpty) {
      return ContentConstant.phoneNumberCantBeNull;
    } else if (value.length > 1 && value.substring(0, 2) != '08' ||
        checkLengthPhoneNumber(value.length)) {
      return ContentConstant.phoneNumberNotValid;
    } else {
      return null;
    }
  }

  bool checkLengthPhoneNumber(int length) {
    if (length.isGreaterThan(8) && length.isLowerThan(15)) {
      return false;
    } else {
      return true;
    }
  }

  Future<KmobSubmissionModel> setConsumerDataToLocal() async {
    KmobSubmissionModel model = kmobSubmissionController!.kmobSubmissionModel.value
      ..agentId = kmobSubmissionController!.agentId.value.toInt()
      ..birthDate = birthDateController.text
      ..birthPlace = birthPlaceController.text
      ..branchId = branchId.value
      ..customerName = customerNameController.text
      ..gender = genderController.text
      ..idNumber = idNumberController.text
      ..legalName = customerNameController.text
      ..maritalStatus = maritalStatusId.value
      ..mobilePhone = mobilePhoneController.text
      ..spouseBirthDate = spouseBirthDateController.text
      ..spouseBirthPlace = spouseBirthPlaceController.text
      ..prospectId = kmobSubmissionController!.prospectId.value
      ..spouseGender = spouseGenderController.text
      ..spouseIdNumber = spouseIdNumberController.text
      ..spouseLegalName = spouseNameController.text
      ..spouseMobilePhone = spouseMobilePhoneController.text
      ..spouseName = spouseNameController.text
      ..spouseSurgateMotherName = spouseSurgateMotherNameController.text
      ..surgateMotherName = surgateMotherNameController.text
      ..typeOfLob = kmobSubmissionController!.typeOfLob.value;
    return model;
  }

  void checkValidation() async {
    autoValidate.value = AutovalidateMode.always;
    if (isMarried.isTrue) {
      if (formConsumenDataKey.currentState!.validate() && formConsumenPartnerDataKey.currentState!.validate()) {
        goToStepTwo();
      } else {
        kmobSubmissionController!.errorSnackBar(ContentConstant.errorValidationKMOBSubmission);
      }
    } else {
      if (formConsumenDataKey.currentState!.validate()) {
        clearPartnerData();
        goToStepTwo();
      } else {
        kmobSubmissionController!.errorSnackBar(ContentConstant.errorValidationKMOBSubmission);
      }
    }
  }

  void goToStepTwo() async {
    if (kmobSubmissionController!.source.value == AgentSubmission.NEW) {
      await kmobSubmissionController!.getLocalSubmission().then((list) async {
        if (list!.length < 1) {
          await kmobSubmissionController!.generateProspectIdAgent(branchId.value, Get.context).then((value) {
            setConsumerDataToLocal().then((value) async {
              await kmobSubmissionController!.saveOrUpdateToLocal(value.toLocal());
            });
          });
        } else {
          kmobSubmissionController!.updateProspectiD(list.first.prospectId!);
          setConsumerDataToLocal().then((value) async {
            await kmobSubmissionController!.saveOrUpdateToLocal(value.toLocal());
          });
        }
      });
    }
    kmobSubmissionController!.goToAssetSection();
  }

  void onChangeBranch(BranchData result) {
    branchController.text = result.branchFullName!;
    branchId.value = result.branchId!;
    agentIdConfins.value = result.agentIdConfins!;
    moId.value = result.moId!;
    moName.value = result.moName!;
  }

  Future<void> checkDraftConsumerData() async {
    kmobSubmissionController!.showLoading();
    kmobSubmissionController!.setSource(kmobSubmissionController!.source.value);
    if (kmobSubmissionController!.source.value == AgentSubmission.DRAFT) {
      kmobSubmissionController!.kmobSubmissionModel.value = await getDetailDraft(Get.context, kmobSubmissionController!.prospectId.value);
      setDataFromDraftOrLocal();
    } else {
      checkWhetherDataFromLocal();
    }
    kmobSubmissionController!.hiddenLoading();
  }

  Future<String> getDateFromString({String date = ""}) async {
    if (date.trim().length > 10) {
      String dateWithSubstring = date.substring(0, 10);
      return dateWithSubstring.toFormattedDate(format: DateConstant.dateFormat);
    } else {
      return date;
    }
  }

  void getBranchByIdBranch(String? idBranch) async {
    BranchData branchData = listBranch.firstWhere((data) => data.branchId!.isContainIgnoreCase(idBranch!));
    branchController.text = branchData.branchFullName!;
    branchId.value = branchData.branchId!;
    agentIdConfins.value = branchData.agentIdConfins!;
    moId.value = branchData.moId!;
    moName.value = branchData.moName!;
  }

  void getMaritalStatusById(String? idMaritalStatus) async {
    isMarried.value = false;
    MaritalStatusData maritalStatusData = listMaritalStatus.firstWhere((data) => data.id == idMaritalStatus);
    if (maritalStatusData.id == "M") {
      isMarried.value = true;
    }
    maritalStatusId.value = maritalStatusData.id!;
    maritalStatusController.text = maritalStatusData.text!;
  }

  void checkWhetherDataFromLocal() async {
    List<ResponseLocalGetKmobSubmission>? list = await kmobSubmissionController!.getLocalSubmission();
    if (list!.length > 0) {
      kmobSubmissionController!.kmobSubmissionModel.value = list.first.toModel();
      setDataFromDraftOrLocal();
    }
  }

  Future<void> setDataFromDraftOrLocal() async {
    KmobSubmissionModel model = kmobSubmissionController!.kmobSubmissionModel.value;
    customerNameController.text = model.customerName!;
    birthDateController.text = await getDateFromString(date: model.birthDate!);
    birthPlaceController.text = model.birthPlace!;
    genderController.text = model.gender!;
    idNumberController.text = model.idNumber!;
    maritalStatusController.text = model.maritalStatus!;
    mobilePhoneController.text = model.mobilePhone!;
    surgateMotherNameController.text = model.surgateMotherName!;

    spouseNameController.text = model.spouseName!;
    spouseIdNumberController.text = model.spouseIdNumber!;
    spouseBirthDateController.text = await getDateFromString(date: model.spouseBirthDate!);
    spouseBirthPlaceController.text = model.spouseBirthPlace!;
    spouseGenderController.text = model.spouseGender!;
    spouseMobilePhoneController.text = model.spouseMobilePhone!;
    spouseSurgateMotherNameController.text = model.spouseSurgateMotherName!;
    getBranchByIdBranch(model.branchId);
    getMaritalStatusById(model.maritalStatus);
  }

  Future<KmobSubmissionModel> getDetailDraft(BuildContext? context, prospectId) async {
    return await draftRepository!.getDetailDraft(context, prospectId: prospectId);
  }
}
