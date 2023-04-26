import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/promo_marketing_screen/optimus_snb_tab_promo_marketing_screen.dart';
import 'package:kreditplus_deasy_website/optimus/modules/snap_and_buy/views/sections/promo_marketing_screen/optimus_snb_web_promo_marketing_screen.dart';

import 'optimus_snb_mobile_promo_marketing_screen.dart';

class OptimusSnbBasePromoMarketingScreen extends StatefulWidget {
  const OptimusSnbBasePromoMarketingScreen({Key? key}) : super(key: key);

  @override
  State<OptimusSnbBasePromoMarketingScreen> createState() =>
      _OptimusSnbBasePromoMarketingScreenState();
}

class _OptimusSnbBasePromoMarketingScreenState
    extends State<OptimusSnbBasePromoMarketingScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return OptimusSnbWebPromoMarketingScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return OptimusSnbTabPromoMarketingScreen();
        }

        return OptimusSnbMobilePromoMarketingScreen();
      },
    );
  }
}
