import 'package:get/get.dart';
import 'package:order/controllers/order_controller.dart';
import 'package:newwg_repository/newwg_repository.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewWgRepositoryImpl>(() => NewWgRepositoryImpl());

    Get.lazyPut<OrderController>(() =>
        OrderController(repository: Get.find<NewWgRepositoryImpl>()));
  }
}
