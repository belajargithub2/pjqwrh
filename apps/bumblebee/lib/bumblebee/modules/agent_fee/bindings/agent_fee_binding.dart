import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';

class AgentFeeBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<AgentFeeRepository>(() => AgentFeeRepository());

    Get.lazyPut<AgentFeeController>(() => AgentFeeController(
      agentFeeRepository: Get.find<AgentFeeRepository>(),
    ));
  }
}
