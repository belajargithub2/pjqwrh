import 'dart:io';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/agent_fee_request.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum AgentFeeState { DEFAULT,LOADING, SUCCESS, ERROR }

enum AgentFeeDetailType { DISBURSEMENT, MONTHLY_INCENTIVE, LOYALTY }

class AgentFeeDetailController extends GetxController {
  final String downloadDirectory = "/storage/emulated/0/Download";
  final AgentFeeRepository? agentFeeRepository;
  final listDetailAgentFee = <Incentive>[].obs;
  final startDate = "".obs;
  final endDate = "".obs;
  final agentFeeState = AgentFeeState.DEFAULT.obs;

  AgentFeeDetailController({this.agentFeeRepository});

  @override
  void onInit() {
    startDate.value = Get.arguments?["start_date"] ?? "";
    endDate.value = Get.arguments?["end_date"] ?? "";
    listDetailAgentFee.value = Get.arguments != null
        ? List<Incentive>.from(Get.arguments["incentives"].map((x) => Incentive.fromJson(x)))
        : [];
    super.onInit();
  }

  RequestGetAgentFee requestGetAgentFee() {
    String start = startDate.value.toFormattedDate(format: DateConstant.dateFormatRFC3339);
    String end = endDate.value.toFormattedDate(format: DateConstant.dateFormatRFC3339);

    return RequestGetAgentFee(
      startDate: start,
      endDate: end,
    );
  }

  Future<bool> downloadAgentFee() async {
    agentFeeState(AgentFeeState.LOADING);

    if (!(await requestWritePermission())) {
      return false;
    }

    if (await postDownloadAgentFee()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> storeToPhoneStorage(Uint8List data) async {
    final path = await getDownloadPath();

    final file = File('$path/${startDate.value}_${endDate.value}.pdf');
    await file.writeAsBytes(data);
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory(downloadDirectory);
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (_) {
      print("Cannot get download folder path");
    }
    return directory?.path;
  }

  Future<bool> requestWritePermission() async {
    return await Permission.storage.request().isGranted;
  }

  String getPeriodDatetime({required String start, required String end}) {
    String startDate = start.toFormattedDate(format: DateConstant.dateFormat2);
    String endDate = end.toFormattedDate(format: DateConstant.dateFormat2);

    return "$startDate - $endDate";
  }

  void hiddenLoading() {
    agentFeeState(AgentFeeState.SUCCESS);
  }

  Future<bool> postDownloadAgentFee() async {
    bool status = false;
    await agentFeeRepository!
        .postDownloadAgentFee("get_agent_fee_pdf",
            requestBody: requestGetAgentFee().toJson())
        .then((data) {
          storeToPhoneStorage(data);
          agentFeeState(AgentFeeState.SUCCESS);
          status = true;
    }).catchError((_) {
      agentFeeState(AgentFeeState.ERROR);
      status = false;
    });

    return status;
  }
}
