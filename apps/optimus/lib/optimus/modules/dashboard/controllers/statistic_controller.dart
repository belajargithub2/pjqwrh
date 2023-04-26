import 'package:kreditplus_deasy_website/core/model/statistic_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/dashboard_repository.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';

class StatisticController extends GetxController
    with StateMixin<StatisticResponse> {
  DashboardRepository _dashboardRepository;

  StatisticController({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository;

  final _newColor = Color(0xFFFF9D3B);
  final _confirmedColor = Color(0xFF4782FC);
  final _paidColor = Color(0xFF0083BD);
  final _processedColor = Color(0xFFFFBC00);
  final _approvedColor = Color(0xFF2ED477);
  final _rejectedColor = Color(0xFFF46363);

  final List<String> listMonth = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];
  int _month = 1;

  RxString selectedMonthX = "Januari".obs;

  @override
  void onInit() {
    _dashboardRepository = DashboardRepository();
    super.onInit();
  }

  @override
  void onReady() {
    _getCurrentMonth();
    fetchApiDashboardsStatistic(Get.context, _month);
    super.onReady();
  }

  fetchApiDashboardsStatistic(BuildContext? context, int month) async {
    change(null, status: RxStatus.loading());
    try {
      StatisticResponse response =
          await _dashboardRepository.fetchApiDashboardStatistic(context, month);
      change(response, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error('$e'));
    }
  }

  setMonth(String selectedMonth) {
    selectedMonthX.value = selectedMonth;
    for (int i = 0; i < listMonth.length; i++) {
      if (selectedMonth == listMonth[i]) {
        _month = i + 1;
        fetchApiDashboardsStatistic(Get.context, _month);
      }
    }
  }

  _getCurrentMonth() {
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);

    _month = dateParse.month;
    for (int i = 0; i < listMonth.length; i++) {
      if (_month == i + 1) {
        selectedMonthX.value = listMonth[i];
      }
    }
  }

  String getGridImagePath(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case "baru":
        {
          return "resources/images/icons/ic_new_transaction_flag.svg";
        }
        
      case "dikonfirmasi":
        {
          return "resources/images/icons/ic_confirmed_transaction_flag.svg";
        }
        
      case "dibayar":
        {
          return "resources/images/icons/ic_paid_transaction_flag.svg";
        }
        
      case "diproses":
        {
          return "resources/images/icons/ic_processed_transaction_flag.svg";
        }
        
      case "disetujui":
        {
          return "resources/images/icons/ic_approved_transaction_flag.svg";
        }
        
      default:
        {
          return "resources/images/icons/ic_rejected_transaction_flag.svg";
        }
        
    }
  }

  Color getGridItemColor(String transactionType) {
    switch (transactionType.toLowerCase()) {
      case "baru":
        {
          return _newColor;
        }
        
      case "dikonfirmasi":
        {
          return _confirmedColor;
        }
        
      case "dibayar":
        {
          return _paidColor;
        }
        
      case "diproses":
        {
          return _processedColor;
        }
        
      case "disetujui":
        {
          return _approvedColor;
        }
        
      default:
        {
          return _rejectedColor;
        }
        
    }
  }
}

class Transactions {
  final String weekNumber;
  final int weekCount;

  Transactions(this.weekNumber, this.weekCount);
}
