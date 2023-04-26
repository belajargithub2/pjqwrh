import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NoInternetCheckerController extends GetxController {
  final _hasInterNetConnection = false.obs;
  RxBool isLoading = false.obs;

  bool get isConnected => _hasInterNetConnection.value;

  set isConnected(bool val) => _hasInterNetConnection.value = val;


  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    super.onInit();
    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          _hasInterNetConnection.value = true;
          break;
        case InternetConnectionStatus.disconnected:
          _hasInterNetConnection.value = false;
          break;
      }
    });
  }

  @override
  void onClose() {
    _listener.cancel();
    super.onClose();
  }
}
