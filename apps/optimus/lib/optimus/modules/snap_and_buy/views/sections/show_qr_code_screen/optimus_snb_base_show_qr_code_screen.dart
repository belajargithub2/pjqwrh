import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/show_qr_code_screen/optimus_snb_mobile_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/show_qr_code_screen/optimus_snb_tab_show_qr_code_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/show_qr_code_screen/optimus_snb_web_show_qr_code_screen.dart';

class OptimusSnbBaseShowQrCodeScreen extends StatefulWidget {
  const OptimusSnbBaseShowQrCodeScreen({Key? key}) : super(key: key);

  @override
  State<OptimusSnbBaseShowQrCodeScreen> createState() =>
      _OptimusSnbBaseShowQrCodeScreenState();
}

class _OptimusSnbBaseShowQrCodeScreenState
    extends State<OptimusSnbBaseShowQrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return OptimusSnbWebShowQrCodeScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return OptimusSnbTabShowQrCodeScreen();
        }

        return OptimusSnbMobileShowQrCodeScreen();
      },
    );
  }
}
