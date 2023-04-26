import 'package:customer_confirmation/customer_confirmation.dart';
import 'package:customer_confirmation/src/view/widgets/mobile_customer_confirmation.dart';
import 'package:customer_confirmation/src/view/widgets/web_customer_confirmation.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CustomerConfirmationScreen
    extends GetView<CustomerConfirmationController> {
  const CustomerConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: ((context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return const WebCustomerConfirmation();
        } else if (screenType == DeasyScreenType.mobile) {
          return const MobileCustomerConfirmation();
        } else {
          return const WebCustomerConfirmation();
        }
      }),
    );
  }
}
