import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/bindings/bumblebee_transaction_pdf_preview_binding.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_pdf_preview_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:matcher/matcher.dart' as m;
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../mocks/repository/transaction_repository_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());

  setUp(() {
    setToken();
  });

  final binding = BindingsBuilder(() {
    Get.lazyPut<BumblebeeTransactionRepository>(() => TransactionRepositoryMock());
    Get.lazyPut<BumblebeeTransactionPdfPreviewController>(
      () => BumblebeeTransactionPdfPreviewController(transactionRepository: Get.find()),
    );
  });

  group('Test PDF Controller', () {

    test('Test Init Controller', () async {
      expect(() => Get.find<BumblebeeTransactionPdfPreviewController>(),
          throwsA(m.TypeMatcher<String>()));
      binding.builder();

      BumblebeeTransactionPdfPreviewBinding transactionPdfPreviewBinding = BumblebeeTransactionPdfPreviewBinding();
      transactionPdfPreviewBinding.dependencies();
      expect(transactionPdfPreviewBinding.dependencies, returnsNormally);

      final controller = Get.find<BumblebeeTransactionPdfPreviewController>();
      expect(controller.initialized, true);

      await Future.delayed(Duration(milliseconds: 100));
      bool test = Get.isRegistered<BumblebeeTransactionPdfPreviewController>();
      expect(test, true);

      controller.onReady();
    });

    test('Test get dokument should be as mocked-data', () async {
      final controller = Get.find<BumblebeeTransactionPdfPreviewController>();
      controller.loadDocument().then((value) => {
            expect(value, "https://dev-merchant-api.kreditplus.com/reports/bast/KPM-TST-DGS8901610/view")
          });
    });

    test('Test get token value should be as mocked-data', () async {
      final controller = Get.find<BumblebeeTransactionPdfPreviewController>();
      controller.getToken().then((value) {expect(value, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
      });
    });
  });
}

void setToken() async {
  SharedPreferences.setMockInitialValues({});
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString('access_token', DeasyEncryptorUtil.encryptString("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"));
}
