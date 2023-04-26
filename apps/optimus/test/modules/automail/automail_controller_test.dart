import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/bindings/optimus_automail_binding.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/repositories/optimus_automail_repository.dart';

import 'repositories/optimus_automail_repository_mock.dart';

void main() {
  setFlavor(DevFlavorConfig());
  OptimusAutomailController? controller;

  final binding = BindingsBuilder(() {
    OptimusAutomailBinding().dependencies();
    Get.lazyReplace<OptimusAutomailRepository>(
        () => OptimusAutomailRepositoryMock());
  });

  setUp(() async {
    binding.builder();

    controller = Get.find<OptimusAutomailController>();
  });

  tearDown(() {
    Get.delete<OptimusAutomailController>();
  });

  group('Validation input email recipients', () {
    test('email must not be empty', () {
      String email = '';
      String? validatorMessages = controller?.isEmailValid(email);
      print(validatorMessages);
      expect(validatorMessages, 'Email tidak boleh kosong');
    });

    test('email must be valid', () {
      String email = 'baguskto@gmail.com';
      String? validatorMessages = controller?.isEmailValid(email);
      print(validatorMessages);
      expect(validatorMessages, null);
    });

    test('email must not be invalid', () {
      String email = 'bagusktogmail.com';
      String? validatorMessages = controller?.isEmailValid(email);
      print(validatorMessages);
      expect(validatorMessages, 'Email tidak sesuai');
    });
  });
  //from database
  //test get list penerima
  //test add penerima
  //test type penerima
  //test put enabler (update)
  //test get detail penerima
  //test update data penerima
  //test search penerima
  //test get all dealer

  // internal functions
  //test button switch enabler
}
