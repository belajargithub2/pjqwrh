// import 'dart:io';
//
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get/get.dart';
// import 'package:kreditplus_deasy_website/flavor/dev/flavor_config_dev.dart';
// import 'package:deasy_config/deasy_config.dart';
// import 'package:kreditplus_deasy_website/src/modules/account/controllers/account_controller.dart';
// import 'package:kreditplus_deasy_website/core/repositories/user_repository.dart';
// import 'package:kreditplus_deasy_website/core/widgets/no_internet/no_internet_checker_controller.dart';
//
// import 'package:matcher/matcher.dart' as m;
//
// void main() {
//
//   TestWidgetsFlutterBinding.ensureInitialized();
//   setFlavor(DevFlavorConfig());
//
//   setUp(() {
//     HttpOverrides.global = null;
//   });
//
//   group('Account Controller', () {
//     final binding = BindingsBuilder(() {
//       Get.lazyPut(() => UserRepository());
//       Get.lazyPut(() => AccountController());
//       Get.lazyPut<NoInternetCheckerController>(
//               () => NoInternetCheckerController());
//     });
//
//     test('Test AccountController', () async {
//       /// Controller can't be on memory
//       expect(() => Get.find<AccountController>(tag: 'success'),
//           throwsA(m.TypeMatcher<String>()));
//
//       /// binding will put the controller on memory
//       binding.builder();
//       /// recover your controller
//       final controller = Get.find<AccountController>();
//
//       /// check if onInit was called
//       expect(controller.initialized, true);
//
//
//       /// await time request
//       await Future.delayed(Duration(milliseconds: 100));
//
//       ///check controller isRegistered
//       bool test = Get.isRegistered<AccountController>();
//       expect(test, true);
//     });
//   });
// }
