import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/repositories/bumblebee_notification_repository.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/no_internet_checker_controller.dart';
import 'package:newwg/config/data_config.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BumblebeeNotificationController extends GetxController {
  BumblebeeNotificationController({required this.notificationRepository});

  final BumblebeeNotificationRepository notificationRepository;

  ScrollController scrollController = ScrollController();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  bool isUndo = false;
  int? indexUndoData;
  NotificationData? undoData;

  final isMerchantOnline = false.obs;
  final isLoading = true.obs;
  final isTapped = false.obs;
  final page = 1.obs;
  final role = "".obs;
  final notifList = <NotificationData?>[].obs;
  final _noInternetController = Get.find<NoInternetCheckerController>();

  @override
  void onInit() {
    Future.delayed(Duration(milliseconds: 500), () {
      initFetchNotifList();
      scrollController.addListener(() {
        loadMoreNotif();
      });
    });
    DeasyPocket().isMerchantOnline().then((value) {
      if (value != null) {
        isMerchantOnline.value = value;
      }
    });
    DeasyPocket().getRole().then((value) {
      role.value = value;
    });
    super.onInit();
  }

  initFetchNotifList() {
    var request = Map<String, dynamic>();
    request["limit"] = 10;
    request["page"] = page.value;
    fetchNotifList(requestBody: request);
  }

  fetchNotifList({Map<String, dynamic>? requestBody}) async {
    isLoading.value = true;

    await notificationRepository
        .fetchNotificationList(Get.context, requestBody)
        .then((value) {
      notifList.addAll(value.data!);
      isLoading.value = false;
    });
  }

  deleteNotifFromList(String? id) {
    indexUndoData = notifList.indexWhere((element) => element!.id == id);
    undoData = notifList[indexUndoData!];
    notifList.removeWhere((element) => element!.id == id);
  }

  Future<bool> deleteNotifFromApi(String? id) async {
    var response = false;
    await Future.delayed(const Duration(milliseconds: 4000), () async {
      if (isUndo == false) {
        await notificationRepository.deleteNotif(Get.context, id).then((value) {
          isUndo = false;
          response = value;
        });
      }
    });
    return response;
  }

  showFlushBar(String? id) {
    DeasySnackBarUtil.showFlushBarDelete(Get.context!, () => undoDelete());
  }

  undoDelete() {
    isUndo = true;
    if (!notifList.contains(undoData)) {
      notifList.insert(indexUndoData!, undoData);
    }
  }

  Future<NotificationReadResponse> onTapReadNotif(
      NotificationData orderData) async {
    isLoading.value = true;
    var notifReadResponse = NotificationReadResponse();
    var index = notifList.indexWhere((element) => element!.id == orderData.id);

    if (!notifList[index]!.isRead!) {
      isTapped.toggle();
      notifList[index]!.isRead = true;
      var requestBody = <String, dynamic>{
        "id": notifList[index]!.id,
        "is_read": true
      };
      await notificationRepository
          .patchNotifRead(Get.context, requestBody)
          .then((value) {
        notifReadResponse = value;
      });
    }

    if (orderData.action == ActionNotification.EDIT_SUBMISSION) {
      goToEditSubmission(orderData.prospectId!);
    } else {
      if (role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
        goToDetailTransactionForAgentOnly(orderData);
      }
    }
    isLoading.value = false;

    return notifReadResponse;
  }

  loadMoreNotif() async {
    if (scrollController.position.extentAfter <= 0) {
      ///TODO(bagusktto): set max page as total_page from API to stop infinity load when in the max page
      page.value += 1;
      var request = Map<String, dynamic>();
      request["limit"] = 10;
      request["page"] = page.value;
      fetchNotifList(requestBody: request);
    }
  }

  Future refreshNotificationWhenHasInternet() async {
    _noInternetController.isLoading.toggle();
    await Future.delayed(Duration(milliseconds: 1200));
    notifList.clear();
    fetchNotifList();
    _noInternetController.isLoading.toggle();
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    notifList.clear();
    fetchNotifList();
    refreshController.loadComplete();
  }

  goToDetailTransactionForAgentOnly(NotificationData orderdata) {
    var transaction = TransactionListModel(
        prospectId: orderdata.prospectId,
        orderDate: orderdata.orderDate,
        orderStatus: ResponseEnumOrderTransactionMap[orderdata.orderStatus]);
    Get.toNamed(BumblebeeRoutes.DETAIL_TRANSACTION, arguments: {
      "transaction": transaction,
      "isMerchantOnline": isMerchantOnline.value
    });
  }

  void goToEditSubmission(String prospectID) {
    DataConfig.instance.prospectId = prospectID;
    DataConfig.instance.isShowIndicator = false;
    DataConfig.instance.isEditOrder = true;
    Get.toNamed(
        BumblebeeRoutes.HUMAN_VERIFICATION_NEW_WG
      );
  }
}
