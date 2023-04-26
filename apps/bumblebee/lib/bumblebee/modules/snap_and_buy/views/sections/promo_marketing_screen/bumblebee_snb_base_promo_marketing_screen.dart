import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/promo_marketing_screen/bumblebee_snb_tab_promo_marketing_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/snap_and_buy/views/sections/promo_marketing_screen/bumblebee_snb_web_promo_marketing_screen.dart';

import 'bumblebee_snb_mobile_promo_marketing_screen.dart';

class BumblebeeSnbBasePromoMarketingScreen extends StatefulWidget {
  const BumblebeeSnbBasePromoMarketingScreen({Key? key}) : super(key: key);

  @override
  State<BumblebeeSnbBasePromoMarketingScreen> createState() =>
      _BumblebeeSnbBasePromoMarketingScreenState();
}

class _BumblebeeSnbBasePromoMarketingScreenState
    extends State<BumblebeeSnbBasePromoMarketingScreen> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        if (screenType == DeasyScreenType.desktop) {
          return BumblebeeSnbWebPromoMarketingScreen();
        }

        if (screenType == DeasyScreenType.tablet) {
          return BumblebeeSnbTabPromoMarketingScreen();
        }

        return BumblebeeSnbMobilePromoMarketingScreen();
      },
    );
  }
}
