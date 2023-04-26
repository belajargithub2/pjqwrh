import 'package:deasy_helper/deasy_helper.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/models/optimus_summary_subsidi_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/repositories/optimus_subsidi_dealer_repository.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusSubsidiDealerController extends GetxController {
  OptimusSubsidiDealerController({
    required this.subsidiDealerRepo,
  });

  final OptimusSubsidiDealerRepository subsidiDealerRepo;

  final isLoading = false.obs;
  final listSummarySubsidiAmount = List<String>.empty().obs;

  final summarySubsidi = Data(
    otr: 0,
    ntfAmount: 0,
    subsidiAmount: 0,
    totalOtr: 0,
    aprovedCount: 0,
  ).obs;

  final listSummarySubsidiLabel = [
    ContentConstant.hargaProdukOtr,
    ContentConstant.hargaNtf,
    ContentConstant.hargaTotalOtr,
    ContentConstant.subsidiAmount,
  ].obs;

  String? orderDateFrom;
  String? orderDateTo;

  @override
  void onInit() {
    initDatefilter();
    fecthSummarySubsidi();
    super.onInit();
  }

  void initDatefilter() {
    DateTime dateNow = DateTime.now();
    orderDateTo = dateNow.toFormattedDate(format: DateConstant.dateFormat5);
    orderDateFrom = dateNow
        .previousMonth(months: 2)
        .toFormattedDate(format: DateConstant.dateFormat5);
  }

  Future<void> fecthSummarySubsidi() async {
    isLoading(true);
    final requestBody = {
      "order_date_from": orderDateFrom,
      "order_date_to": orderDateTo,
    };

    await subsidiDealerRepo
        .fectSummarySubsidi(Get.context, requestBody)
        .then((value) {
      summarySubsidi(value.data!);
      listSummarySubsidiAmount([
        summarySubsidi.value.otr.toString().toRupiah(),
        summarySubsidi.value.ntfAmount.toString().toRupiah(),
        summarySubsidi.value.totalOtr.toString().toRupiah(),
        summarySubsidi.value.subsidiAmount.toString().toRupiah(),
      ]);
    }).catchError((error) {
      listSummarySubsidiAmount([
        summarySubsidi.value.otr.toString().toRupiah(),
        summarySubsidi.value.ntfAmount.toString().toRupiah(),
        summarySubsidi.value.totalOtr.toString().toRupiah(),
        summarySubsidi.value.subsidiAmount.toString().toRupiah(),
      ]);
      isLoading(false);
    });
    isLoading(false);
  }

  void showLoading() {
    isLoading(true);
  }

  void hideLoading() {
    isLoading(false);
  }

}
