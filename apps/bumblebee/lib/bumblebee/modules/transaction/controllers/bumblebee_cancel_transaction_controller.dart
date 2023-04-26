import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';

class BumblebeeCancelTransactionController extends GetxController {
  BumblebeeTransactionRepository transactionRepository =
      new BumblebeeTransactionRepository();
  final listReason = <String>[].obs;
  final prospectId = ''.obs;
  final isLoading = false.obs;
  final isAgent = false.obs;
  TextEditingController reasonController = new TextEditingController(text: "");
  TextEditingController detailReasonController = TextEditingController();
  TextEditingController searchReasonController = TextEditingController();
  final isShowDetail = false.obs;
  var tempReasons = <String>[];
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    prospectId.value = Get.arguments['prospectId'];
    update();
    await DeasyPocket().getRole().then((value) {
      isAgent.value =
          value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) ? true : false;
    });
    fetchFilterCancelReason();
    super.onInit();
  }

  String? detailReasonValidator(String text) {
    if (text.isNullOrEmpty) {
      return "Detail Alasan harus diisi";
    }
    return null;
  }

  void fetchFilterCancelReason() async {
    tempReasons.clear();
    if (isAgent.isTrue) {
      transactionRepository
          .fetchApiAgentCancelReasonList(Get.context, null)
          .then((value) {
        listReason.addAll(value.data!);
        listReason.add(ContentConstant.otherReason);
        tempReasons.addAll(listReason);
      });
    } else {
      transactionRepository
          .fetchApiCancelReasonList(Get.context, null)
          .then((value) {
        listReason.addAll(value.data!);
        tempReasons.addAll(value.data!);
      });
    }
  }

  Future<List<String>> filterCancelReason(String filter) async {
    List<String> list = [];
    for (var item in tempReasons) {
      if (item.isContainIgnoreCase(filter)) {
        list.add(item);
      }
    }
    return list;
  }

  void searchCancelReason(String search) async {
    if (search.isEmpty) {
      listReason.clear();
      fetchFilterCancelReason();
    } else {
      List<String> x =
          tempReasons.where((e) => e.isContainIgnoreCase(search)).toList();
      listReason(x);
    }
  }

  void setReason(String reason) {
    if (reason == ContentConstant.otherReason) {
      isShowDetail(true);
    } else {
      isShowDetail(false);
    }
    reasonController.text = reason;

    Get.back();
  }

  void resetList() {
    listReason.clear();
    searchReasonController.clear();
    fetchFilterCancelReason();
  }

  void cancel() {
    isLoading.value = true;
    var requestBody = <String, dynamic>{
      "prospect_id": prospectId.value,
      "reason": detailReasonController.text.isNotEmpty
          ? detailReasonController.text
          : reasonController.text
    };
    if (reasonController.text.isEmpty) {
      isLoading.toggle();
      DeasySnackBarUtil.showFlushBarError(
          Get.context!, "Alasan tidak boleh kosong");
    } else if (isAgent.isTrue) {
      transactionRepository
          .putApiAgentCancelOrder(Get.context, requestBody)
          .then((value) {
        if (value.message == "OK") {
          showSuccessStateWidget();
        }
      }).catchError((onError) {
        isLoading.toggle();
      });
    } else {
      transactionRepository
          .putApiCancelOrder(Get.context, requestBody)
          .then((value) {
        if (value.message == "OK") {
          showSuccessStateWidget();
        }
      }).catchError((onError) {
        isLoading.toggle();
      });
    }
  }

  showSuccessStateWidget() {
    isLoading.toggle();
    showDialogMobile();
  }

  showDialogMobile() {
    Get.defaultDialog(
        title: "",
        barrierDismissible: false,
        backgroundColor: DeasyColor.neutral000,
        content: Container(
          width: DeasySizeConfigUtils.screenWidth! / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'resources/images/checklist.svg',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Berhasil',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: DeasyColor.neutral900,
                    fontSize: DeasySizeConfigUtils.blockVertical * 2),
              ),
              SizedBox(
                height: 20,
              ),
              Text('Order kamu telah dibatalkan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: DeasyColor.neutral400,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.7)),
              SizedBox(
                height: 15,
              ),
              BouncingWidget(
                duration: Duration(milliseconds: 100),
                scaleFactor: 1.5,
                onPressed: () async {
                  Future.delayed(const Duration(milliseconds: 800), () {
                    Get.back();
                    Get.back();
                    Get.back();
                  });
                },
                child: Container(
                  decoration: new BoxDecoration(
                      color: DeasyColor.kpYellow500,
                      borderRadius:
                          new BorderRadius.all(Radius.circular(10.0))),
                  width: DeasySizeConfigUtils.screenWidth! / 2,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      'Kembali',
                      style: TextStyle(color: DeasyColor.neutral000),
                    ),
                  )),
                ),
              )
            ],
          ),
        ));
  }
}
