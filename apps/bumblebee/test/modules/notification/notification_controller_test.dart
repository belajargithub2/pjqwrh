import 'dart:io';

import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/controllers/bumblebee_notification_controller.dart';
import 'package:kreditplus_deasy_mobile/flavor/dev/flavor_config_dev.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/no_internet_checker_controller.dart';

import 'package:matcher/matcher.dart' as m;

import '../../mocks/repository/notification_repository_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setFlavor(DevFlavorConfig());
  group('Test Notification Controller', () {
    setFlavor(DevFlavorConfig());

    setUp(() {
      HttpOverrides.global = null;
    });

    final binding = BindingsBuilder(() {
      Get.lazyPut<NotificationRepository>(() => NotificationRepositoryMock());

      Get.lazyPut<BumblebeeNotificationController>(
        () => BumblebeeNotificationController(
            notificationRepository: Get.find()),
      );

      Get.lazyPut<NoInternetCheckerController>(
        () => NoInternetCheckerController(),
      );
    });
    test('Test BumblebeeNotificationController Initialization', () async {
      /// Controller can't be on memory
      expect(() => Get.find<BumblebeeNotificationController>(tag: 'success'),
          throwsA(m.TypeMatcher<String>()));

      /// binding will put the controller on memory
      binding.builder();

      /// recover your controller
      final controller = Get.find<BumblebeeNotificationController>();

      /// check if onInit was called
      expect(controller.initialized, true);

      /// await time request
      await Future.delayed(Duration(milliseconds: 100));

      ///check controller isRegistered
      bool test = Get.isRegistered<BumblebeeNotificationController>();
      expect(test, true);
    });

    test('Test Fetch Notification Data List', () async {
      final controller = Get.find<BumblebeeNotificationController>();

      //check fetch notif function
      await controller.fetchNotifList().then((value) {
        expect(controller.notifList.length, greaterThan(0));
      });
    });

    test('Test Read Notification', () async {
      final controller = Get.find<BumblebeeNotificationController>();

      //check read notif function
      await controller.onTapReadNotif(NotificationData()).then((value) {
        expect(value.message, "OK");
        expect(value.data!.isRead, true);
      });
    });

    test('Test Delete and Undo Notification', () async {
      final controller = Get.find<BumblebeeNotificationController>();

      //check delete notif from list
      controller.deleteNotifFromList("9b5c2e38-2d2f-4210-933e-bcef03314f99");
      var deletedData = controller.notifList.where((value) => value!.id == "9b5c2e38-2d2f-4210-933e-bcef03314f99");
      expect(deletedData.length, equals(0));
      expect(controller.indexUndoData, isNotNull);
      expect(controller.undoData, isNotNull);

      //check undo delete
      controller.undoDelete();
      var undoData = controller.notifList.where((value) => value!.id == "9b5c2e38-2d2f-4210-933e-bcef03314f99");
      expect(undoData.length, equals(1));
      expect(controller.isUndo, true);

      //check delete notif from api
      controller.isUndo = false;
      await controller.deleteNotifFromApi("9b5c2e38-2d2f-4210-933e-bcef03314f99").then((value) {
        expect(value, true);
        expect(controller.isUndo, false);
      });

      // onClose was called
      Get.delete<BumblebeeNotificationController>();
    });
  });
}
