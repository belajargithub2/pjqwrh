import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:order/controllers/order_controller.dart';
import 'package:order/data/constants/image_constant.dart';
import 'package:order/data/constants/string_constant.dart';
import 'package:order/views/mobile/widgets/item_asset.dart';
import 'package:order/views/web/widgets/item_asset_web.dart';
import 'package:order/views/widgets/dot_decoration.dart';

part 'mobile/order_mobile_screen.dart';
part 'web/order_web_screen.dart';

class OrderScreen extends GetWidget<OrderController> {
  final Function? onBackToDashboard;
  const OrderScreen({super.key, this.onBackToDashboard});

  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(builder: (context, orientation, screenType) {
      if (screenType == DeasyScreenType.mobile) {
        return const OrderMobileScreen();
      }

      return OrderWebScreen(
        onBackToDashboard: onBackToDashboard,
      );
    });
  }
}
