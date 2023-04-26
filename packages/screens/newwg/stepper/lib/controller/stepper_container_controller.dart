import 'package:get/get.dart';
import 'package:newwg/config/data_config.dart';

enum SECTION {
  VERIFIKASI_DATA_KONSUMEN,
  DOKUMEN_TAMBAHAN,
  PESANAN,
}

class StepperContainerController extends GetxController {
  final konfirmasiKonsumenRoute = "".obs;
  final stepIndex = 0.obs;
  final customerName = ''.obs;
  final limitType = ''.obs;
  final phoneNumber = ''.obs;
  final prospectId = ''.obs;
  final customerId = 0.obs;
  final isShowIndicator = true.obs;
  final isLibrary = false.obs;
  final Rx<SECTION> activeMainSection = SECTION.VERIFIKASI_DATA_KONSUMEN.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      customerId.value = Get.arguments['customer_id'];
      customerName.value = Get.arguments['customer_name'];
      limitType.value = Get.arguments['limit_type'];
      phoneNumber.value = Get.arguments['phone_number'];
      prospectId.value = DataConfig.instance.prospectId;

      if (Get.arguments['document_check'] != null && Get.arguments['document_check'] == false) {
        goToDokumenTambahan();
        return;
      }
    }

    isShowIndicator.value = DataConfig.instance.isShowIndicator;

    if (isShowIndicator.isFalse) {
      goToPesanan();
    }

    super.onInit();
  }

  void goToVerifikasi() {
    stepIndex(0);
    activeMainSection(SECTION.VERIFIKASI_DATA_KONSUMEN);
  }

  void goToDokumenTambahan() {
    stepIndex.value = 1;
    activeMainSection.value = SECTION.DOKUMEN_TAMBAHAN;
  }

  void goToPesanan() {
    stepIndex.value = 2;
    activeMainSection.value = SECTION.PESANAN;
  }

  void goToKonfirmasiKonsumen() {
    Get.offNamed(konfirmasiKonsumenRoute.value);
  }
}
