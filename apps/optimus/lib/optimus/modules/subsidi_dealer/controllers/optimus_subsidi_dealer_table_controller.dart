import 'package:deasy_helper/deasy_helper.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_subsidies_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_subsidies_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/optimus/widgets/transaction/widget/downloader/transaction_download_interface.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/repositories/optimus_subsidi_dealer_repository.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class OptimusSubsidiDealerTableController extends GetxController {
  OptimusSubsidiDealerTableController(
      {required OptimusSubsidiDealerRepository subsidiDealerRepository})
      : _subsidiDealerRepository = subsidiDealerRepository;

  final OptimusSubsidiDealerRepository _subsidiDealerRepository;
  final subsidiDealerController = Get.find<OptimusSubsidiDealerController>();
  final drawerBodyWidth = Get.find<OptimusDrawerCustomController>().bodyWidth;

  final page = 1.obs;
  final isOpenDateFilter = false.obs;
  final isOpenStatusFilter = false.obs;
  final statusFilterList = List<String>.empty().obs;
  final activeStartDate = DateTime.now().obs;
  final activeEndDate = DateTime.now().obs;
  final statusMap = RxMap<String, bool?>();
  final downloader = TransactionDownloader();

  String? orderDateFrom;
  String? orderDateTo;
  String orderId = "";
  DateTime maxDate = DateTime.now();
  ScrollController tableScrollController = ScrollController();
  ScrollController pageScrollController = ScrollController();
  TextEditingController searchTextController = TextEditingController();

  Rxn<OptimusSubsidiesResponse> subsidies = Rxn<OptimusSubsidiesResponse>();
  RxList<SubsidiesData> subsidiList = RxList<SubsidiesData>();

  @override
  void onInit() {
    initDateFilter();
    initStatusFilterItem();
    fetchAllSubsidi();
    super.onInit();
  }

  OptimusSubsidiesRequest getSubsidiesRequest() {
    return OptimusSubsidiesRequest(
      orderDateFrom: orderDateFrom,
      orderDateTo: orderDateTo,
      orderId: orderId,
      page: page.value,
      orderStatus: statusFilterList,
    );
  }

  Future<void> fetchAllSubsidi({int? pageNumber}) async {
    subsidiList.clear();
    page.value = pageNumber ?? 1;
    try {
      await _subsidiDealerRepository
          .fetchAllTransactionSubsidi(Get.context, getSubsidiesRequest())
          .then((value) {
        subsidiList(value.data!);
        subsidies.value = value;
      });
    } catch (e) {
      rethrow;
    }
  }

  void onSubmitSearch() {
    orderId = searchTextController.text;
    fetchAllSubsidi();
  }

  void initStatusFilterItem() {
    statusMap[ContentConstant.STATUS_ON_PROGRESS] = false;
    statusMap[ContentConstant.STATUS_APPROVED] = false;
    statusMap[ContentConstant.STATUS_REJECT] = false;
    statusMap[ContentConstant.STATUS_CANCELED] = false;
    statusMap[ContentConstant.STATUS_CANCEL_REQUEST] = false;
    statusMap[ContentConstant.STATUS_PURCHASE_CONFIRMED] = false;
    statusMap[ContentConstant.STATUS_PAID] = false;
  }

  void clearStatusFilter() {
    statusMap.forEach((key, value) {
      statusMap[key] = false;
      statusFilterList.clear();
    });

    fetchAllSubsidi();
    isOpenStatusFilter(false);
  }

  void onApplyStatusFilter() {
    statusFilterList.clear();
    statusMap.forEach((key, value) {
      if (value == true) {
        if (key == "Paid") {
          statusFilterList.add("Disbursed");
        } else {
          final List<String> _keyPool = [];
          _keyPool.add(key);
          var _selectedKey = _keyPool.toSet().toList();
          statusFilterList.addAll(_selectedKey);
        }
      } else {
        statusFilterList.remove(key);
      }
    });
    fetchAllSubsidi();
    isOpenStatusFilter(false);
  }

  void onClickStatusFilter() {
    isOpenStatusFilter.toggle();
    isOpenDateFilter(false);
  }

  void initDateFilter() {
    DateTime dateNow = DateTime.now();
    orderDateTo = dateNow.toFormattedDate(format: DateConstant.dateFormat5);
    orderDateFrom = dateNow.firstDayOfMonth.toFormattedDate(format: DateConstant.dateFormat5);
  }

  void onClickDateFilter() {
    isOpenDateFilter.toggle();
    isOpenStatusFilter(false);
  }

  void onDateFilterConfirmed(DateTime startDate, DateTime endDate) {
    orderDateFrom = startDate.toFormattedDate(format: DateConstant.dateFormat5);
    orderDateTo = endDate.toFormattedDate(format: DateConstant.dateFormat5);
    activeStartDate(startDate);
    activeEndDate(endDate);
    fetchAllSubsidi();

    subsidiDealerController.orderDateFrom = orderDateFrom;
    subsidiDealerController.orderDateTo = orderDateTo;
    subsidiDealerController.fecthSummarySubsidi();
  }

  void onDateFilterCancel() {
    activeStartDate(DateTime.now());
    activeEndDate(DateTime.now());

    initDateFilter();
    fetchAllSubsidi();

    subsidiDealerController.orderDateFrom = orderDateFrom;
    subsidiDealerController.orderDateTo = orderDateTo;
    subsidiDealerController.fecthSummarySubsidi();

    isOpenDateFilter.toggle();
  }

  void onSelectedDateChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      maxDate = DateTime.now();
    }
  }

  void download() async {
    subsidiDealerController.showLoading();
    try {
      final result = await _subsidiDealerRepository.downloadSubsidi(Get.context,
          requestBody: getSubsidiesRequest());
      String reportName = getReportName();
      downloader.downloadFile(result, reportName);
      subsidiDealerController.hideLoading();
    } catch (_) {
      subsidiDealerController.hideLoading();
    }
  }

  void fetchPrevPageData(int? prevPage) {
    fetchAllSubsidi(pageNumber: prevPage);
  }

  void onForwardClick() {
    if (subsidies.value!.pageInfo!.page !=
        subsidies.value!.pageInfo!.nextPage) {
      fetchPrevPageData(subsidies.value!.pageInfo!.nextPage);
    }
  }

  void onBackClick() {
    if (subsidies.value!.pageInfo!.page !=
        subsidies.value!.pageInfo!.prevPage) {
      fetchPrevPageData(subsidies.value!.pageInfo!.prevPage);
    }
  }

  int? getTotalIndex() {
    return subsidies.value!.pageInfo!.page ==
            subsidies.value!.pageInfo!.totalPage
        ? subsidies.value!.pageInfo!.totalRecord
        : subsidies.value!.pageInfo!.page! * subsidies.value!.pageInfo!.limit!;
  }

  int getFirstIndex() {
    return subsidies.value!.pageInfo!.page == 1
        ? 1
        : subsidies.value!.pageInfo!.prevPage *
                    subsidies.value!.pageInfo!.limit +
                1 ??
            1;
  }

  int getTotalRecord() {
    return subsidies.value!.pageInfo!.totalRecord ?? 1;
  }

  String getReportName() {
    String reportName = "Report_Subsidi_Dealer_";
    String formatFile = ".xlsx";
    DateTime now = new DateTime.now();

    if (orderDateFrom!.isNullOrEmpty || orderDateTo!.isNullOrEmpty) {
      String lastDayOfMonth = now.lastDayOfMonth
          .toFormattedDate(format: DateConstant.dateFormatddMMyyWithoutDash);
      String firstDayOfMonth = now.firstDayOfMonth
          .toFormattedDate(format: DateConstant.dateFormatddMMyyWithoutDash);

      return reportName + firstDayOfMonth + "-" + lastDayOfMonth + formatFile;
    }

    if (orderDateFrom != null && orderDateTo != null) {
      String orderDateFromFormatted = orderDateFrom!
          .toFormattedDate(format: DateConstant.dateFormatddMMyyWithoutDash);
      String orderDateToFormatted = orderDateTo!
          .toFormattedDate(format: DateConstant.dateFormatddMMyyWithoutDash);

      return reportName +
          orderDateFromFormatted +
          "-" +
          orderDateToFormatted +
          formatFile;
    }

    return reportName + formatFile;
  }
}
