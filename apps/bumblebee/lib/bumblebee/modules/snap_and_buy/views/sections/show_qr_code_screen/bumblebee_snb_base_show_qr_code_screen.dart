import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/show_qr_code_screen/bumblebee_snb_mobile_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/show_qr_code_screen/bumblebee_snb_tab_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/show_qr_code_screen/bumblebee_snb_web_show_qr_code_screen.dart';

class BumblebeeSnbBaseShowQrCodeScreen extends StatefulWidget {
  const BumblebeeSnbBaseShowQrCodeScreen({Key? key}) : super(key: key);

  @override
  State<BumblebeeSnbBaseShowQrCodeScreen> createState() =>
      _BumblebeeSnbBaseShowQrCodeScreenState();
}

class _BumblebeeSnbBaseShowQrCodeScreenState
    extends State<BumblebeeSnbBaseShowQrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return BumblebeeSnbWebShowQrCodeScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return BumblebeeSnbTabShowQrCodeScreen();
        }

        return BumblebeeSnbMobileShowQrCodeScreen();
      },
    );
  }
}
