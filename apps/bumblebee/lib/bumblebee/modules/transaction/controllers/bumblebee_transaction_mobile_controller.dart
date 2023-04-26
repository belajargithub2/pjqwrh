import 'dart:async';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BumblebeeTransactionMobileController extends GetxController
    with SingleGetTickerProviderMixin {
  TextEditingController searchController = new TextEditingController();
  BumblebeeTransactionRepository transactionRepository =
      new BumblebeeTransactionRepository();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController scrollController = new ScrollController();

  Timer? debounce;
  final dateFilter = "".obs;
  final dateSelectedFormat = "".obs;
  final year = 0.obs;
  final day = 0.obs;
  final month = 0.obs;
  final supplierOrAgentId = ''.obs;

  final RxList<TransactionListModel> listTransaction =
      <TransactionListModel>[].obs;
  final RxList<TransactionModel> listFilter = <TransactionModel>[].obs;
  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
  final isSearching = false.obs;
  final isMerchantOnline = false.obs;
  final searchQuery = "".obs;
  final isAgent = false.obs;
  final isFilter = false.obs;
  final index = 1.obs;
  final lastPage = 0.obs;
  final RxList<String?> listSelectedStatus = <String>[].obs;
  final Rx<DateTime> maxDate = DateTime.now().obs;
  final Rx<DateTime> minDate = DateTime(0, 0, 0, 0).obs;
  final startDate = "".obs;
  final endDate = "".obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() async {
    isLoading(true);
    await DeasyPocket().getSupplierIdOrAgentId().then((value) {
      supplierOrAgentId.value = value;
    });

    await DeasyPocket().getRole().then((value) {
      isAgent.value =
          value.isContainIgnoreCase(ContentConstant.ROLE_AGENT) ? true : false;
    });

    await DeasyPocket().isMerchantOnline().then((value) {
      isMerchantOnline.value = value;
    });

    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });

    addFilter();

    clearList();
    await fetchOrder(requestBody: requestWithSupplierOrAgentId());
    scrollController.addListener(() {
      isScroll();
    });
  }

  Future refreshTransactionPage() async {
    isLoading(true);
    await Future.delayed(Duration(milliseconds: 1200));
    clearList();
    await fetchOrder(requestBody: requestWithSupplierOrAgentId());
  }

  Future<void> fetchOrder(
      {BuildContext? context, Map<String, dynamic>? requestBody}) async {
    Future.delayed(const Duration(milliseconds: 500), () async {
      if (isAgent.isTrue) {
        await transactionRepository
            .fetchApiAllAgentOrders(Get.context, requestBody)
            .then((val) {
          lastPage.value = val.pageInfo!.totalPage!;

          if (val.data!.length > 0) {
            val.data!.forEach((element) {
              listTransaction.add(TransactionListModel(
                orderDate: element.orderDate,
                orderStatus: element.orderStatus,
                prospectId: element.prospectId,
                customerName: element.customerName,
                payToDealerAmount: element.disbursedAmount,
              ));
            });
          }
          isLoading(false);
        });
      } else {
        await transactionRepository
            .fetchApiAllOrders(Get.context, requestBody)
            .then((val) {
          lastPage.value = val.pageInfo!.totalPage!;

          if (val.data!.length > 0) {
            val.data!.forEach((element) {
              listTransaction.add(TransactionListModel(
                  orderDate: element.orderDate,
                  confirmationMethods: element.confirmationMethods,
                  orderStatus: element.orderStatus,
                  bastDate: element.bastDate,
                  sourceApplication: element.sourceApplication,
                  trackingExists: element.trackingExists,
                  epoDate: element.epoDate,
                  customerReceiptPhotoUrl: element.customerReceiptPhotoUrl,
                  imeiUrl: element.imeiUrl,
                  prospectId: element.prospectId,
                  invoiceDate: element.invoiceDate,
                  payToDealerAmount: element.payToDealerAmount,
                  customerName: element.customerName));
            });
          }

          isLoading(false);
        });
      }
    });
  }

  void stopSearching() {
    isSearching.value = false;
    searchQuery.value = "";
    searchController.text = "";
    clearList();
    fetchOrder(
        context: Get.context, requestBody: requestWithSupplierOrAgentId());
  }

  void startSearch(BuildContext context) {
    searchQuery.value = "";
    ModalRoute.of(context)!
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: () {
      stopSearching();
    }));
    isSearching.value = true;
  }

  void clearSearch() {
    searchQuery.value = "";
    searchController.text = "";
    clearList();
    fetchOrder(
        context: Get.context, requestBody: requestWithSupplierOrAgentId());
  }

  void changeStatusFilter() {
    isFilter.toggle();
  }

  void onSelectionChanged(
      DateRangePickerSelectionChangedArgs args, BuildContext context) {
    if (args.value is PickerDateRange) {
      DateTime startDateTime = args.value.startDate;
      DateTime? endDateTime =
          args.value.endDate != null ? args.value.endDate : DateTime.now();

      startDate.value = args.value.startDate.toString().substring(0, 10);
      endDate.value = args.value.endDate != null
          ? args.value.endDate.toString().substring(0, 10)
          : "";

      maxDate.value = startDateTime
              .add(Duration(days: ContentConstant.FILTER_DATE_RANGE))
              .isBefore(DateTime.now())
          ? startDateTime.add(Duration(days: ContentConstant.FILTER_DATE_RANGE))
          : DateTime.now();

      minDate.value = startDateTime
          .subtract(Duration(days: ContentConstant.FILTER_DATE_RANGE));

      if (startDate.isNotEmpty && endDate.isNotEmpty) {
        isLoading(true);
        clearList();
        dateFilter.value =
            "${DateFormat('dd/MM/yyyy').format(startDateTime).toString()} - ${DateFormat('dd/MM/yyyy').format(endDateTime!).toString()}";
        var request = Map<String, dynamic>();
        request["order_date_from"] = startDate.value;
        request["order_date_to"] = endDate.value;
        request["order_status"] = listSelectedStatus;
        request["limit"] = ContentConstant.INITIAL_LIMIT;
        request["search"] = searchController.text;
        request["page"] = index.value;
        String key = isAgent.isTrue ? "agent_id" : "supplier_id";
        request[key] = isAgent.isTrue
            ? int.parse(supplierOrAgentId.value)
            : supplierOrAgentId.value;
        fetchOrder(context: context, requestBody: request);
        maxDate.value = DateTime.now();
        minDate.value = DateTime(0, 0, 0, 0);
        Get.back();
      }
    }
  }

  void filterByStatus(BuildContext context, String? id) {
    isLoading(true);
    clearList();

    if (listSelectedStatus.contains(id)) {
      listSelectedStatus
          .removeWhere((element) => element!.isContainIgnoreCase(id!));
    } else if (id!.isContainIgnoreCase("clear")) {
      listSelectedStatus.clear();
    } else {
      listSelectedStatus.add(id);
    }

    var request = Map<String, dynamic>();
    request["order_date_from"] = startDate.value;
    request["order_date_to"] = endDate.value;
    request["order_status"] = listSelectedStatus;
    request["limit"] = ContentConstant.INITIAL_LIMIT;
    request["page"] = index.value;
    request["search"] = searchController.text;
    String key = isAgent.isTrue ? "agent_id" : "supplier_id";
    request[key] = isAgent.isTrue
        ? int.parse(supplierOrAgentId.value)
        : supplierOrAgentId.value;
    fetchOrder(context: context, requestBody: request);
  }

  void isScroll() {
    if (scrollController.position.extentAfter <= 0 &&
        index.value.isLowerThan(lastPage.value)) {
      index.value += 1;
      var request = Map<String, dynamic>();
      request["limit"] = ContentConstant.INITIAL_LIMIT;
      request["page"] = index.value;
      if (listSelectedStatus.isNotEmpty) {
        request["order_status"] = listSelectedStatus;
      }

      if (startDate.isNotEmpty && endDate.isNotEmpty) {
        request["order_date_from"] = startDate.value;
        request["order_date_to"] = endDate.value;
      }

      if (searchController.text.isNotEmpty) {
        request["search"] = searchController.text;
      }
      String key = isAgent.isTrue ? "agent_id" : "supplier_id";
      request[key] = isAgent.isTrue
          ? int.parse(supplierOrAgentId.value)
          : supplierOrAgentId.value;
      fetchOrder(context: Get.context, requestBody: request);
    }
  }

  void clearList() {
    listTransaction.clear();
    index.value = 1;
  }

  void removeDate(BuildContext context) {
    clearList();
    isLoading(true);
    dateFilter.value = "";
    dateSelectedFormat.value = "";
    startDate.value = "";
    endDate.value = "";
    fetchOrder(context: context, requestBody: requestWithSupplierOrAgentId());
  }

  void findTransaction(String query) {
    isLoading(true);
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () async {
      clearList();
      if (query.isNotEmpty) {
        var request = Map<String, dynamic>();
        request["limit"] = ContentConstant.INITIAL_LIMIT;
        request["page"] = index.value;
        request["order_date_from"] = startDate.value;
        request["order_date_to"] = endDate.value;
        request["order_status"] = listSelectedStatus;
        request["search"] = searchController.text;
        String key = isAgent.isTrue ? "agent_id" : "supplier_id";
        request[key] = isAgent.isTrue
            ? int.parse(supplierOrAgentId.value)
            : supplierOrAgentId.value;
        fetchOrder(context: Get.context, requestBody: request);
      } else {
        fetchOrder(
            context: Get.context, requestBody: requestWithSupplierOrAgentId());
      }
    });
  }

  void addFilter() {
    listFilter.clear();

    if (isAgent.isFalse)
      listFilter.add(new TransactionModel(
          name: EnumOrderTransaction.purchaseConfirmed.name,
          id: EnumOrderTransaction.purchaseConfirmed.id,
          textColor: DeasyColor.kpBlue500,
          bgColor: DeasyColor.kpBlue50,
          image: "${IconConstant.RESOURCES_ICON_PATH}ic_purchase_confirm.svg"));

    listFilter.add(new TransactionModel(
        name: EnumOrderTransaction.rejected.name,
        id: EnumOrderTransaction.rejected.id,
        bgColor: DeasyColor.dmsFFF1F1,
        textColor: DeasyColor.dmsF46363,
        image: "${IconConstant.RESOURCES_ICON_PATH}ic_reject.svg"));

    listFilter.add(new TransactionModel(
        name: EnumOrderTransaction.approved.name,
        id: EnumOrderTransaction.approved.id,
        bgColor: DeasyColor.dmsEBFFF2,
        textColor: DeasyColor.dms2ED477,
        image: "${IconConstant.RESOURCES_ICON_PATH}ic_approve.svg"));

    listFilter.add(new TransactionModel(
        name: EnumOrderTransaction.onProgress.name,
        id: EnumOrderTransaction.onProgress.id,
        bgColor: DeasyColor.kpYellow50,
        textColor: DeasyColor.kpYellow500,
        image: "${IconConstant.RESOURCES_ICON_PATH}ic_process.svg"));

    listFilter.add(new TransactionModel(
        name: isAgent.isFalse
            ? EnumOrderTransaction.disbursed.name
            : EnumOrderTransaction.goLive.name,
        id: EnumOrderTransaction.disbursed.id,
        bgColor: DeasyColor.sally50,
        textColor: DeasyColor.sally900,
        image: "${IconConstant.RESOURCES_ICON_PATH}ic_melted.svg"));

    if (isAgent.isFalse)
      listFilter.add(new TransactionModel(
          name: EnumOrderTransaction.cancelRequest.name,
          id: EnumOrderTransaction.cancelRequest.id,
          bgColor: DeasyColor.neutral50,
          textColor: DeasyColor.neutral800,
          image: "${IconConstant.RESOURCES_ICON_PATH}ic_request_cancel.svg"));

    listFilter.add(new TransactionModel(
        name: EnumOrderTransaction.canceled.name,
        id: EnumOrderTransaction.canceled.id,
        bgColor: DeasyColor.neutral50,
        textColor: DeasyColor.neutral400,
        image: "${IconConstant.RESOURCES_ICON_PATH}ic_cancel.svg"));
  }

  void removeAllFilter() {
    clearList();
    dateFilter.value = "";
    isSearching.value = false;
    isFilter.value = false;
  }

  @override
  void onReady() {
    index.value = 1;
    super.onReady();
  }

  requestWithSupplierOrAgentId() {
    var request = Map<String, dynamic>();
    request["order_date_from"] = startDate.value;
    request["order_date_to"] = endDate.value;
    request["order_status"] = listSelectedStatus;
    request["limit"] = ContentConstant.INITIAL_LIMIT;
    String key = isAgent.isTrue ? "agent_id" : "supplier_id";
    request[key] = isAgent.isTrue
        ? int.parse(supplierOrAgentId.value)
        : supplierOrAgentId.value;
    return request;
  }

  void navigateToDetail(
      TransactionListModel transactionListModel, bool isMerchantOnline) {
    Get.toNamed(BumblebeeRoutes.DETAIL_TRANSACTION, arguments: {
      "transaction": transactionListModel,
      "isMerchantOnline": isMerchantOnline
    })!
        .then((value) {
      removeAllFilter();
      fetchOrder(requestBody: requestWithSupplierOrAgentId());
    });
  }
}
