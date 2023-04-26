import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_detail_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';

class AgentFeeDetailBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => AgentFeeRepository());

    Get.lazyPut<AgentFeeDetailController>(() => AgentFeeDetailController(
        agentFeeRepository: Get.find<AgentFeeRepository>()
    ));
  }
}
