import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeHowToScanWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: DeasySizeConfigUtils.isMobile ? 20 : 40, horizontal: DeasySizeConfigUtils.isMobile ? 1 : 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DeasyTextView(
              text: ContentConstant.howToUse,
              fontSize: DeasySizeConfigUtils.blockVertical * (kIsWeb ?2.2 :1.8),
              fontFamily: FontFamily.medium),
          SizedBox(height: 15),
          DeasyTextView(
              text: ContentConstant.howToUse1,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              maxLines: 3
          ),
          SizedBox(height: 16),
          Row(
            children: [
              DeasyTextView(
                  text: "2. Tekan Icon ",
                  maxLines: 3,
                  fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
              ),
              SvgPicture.asset("${ImageConstant.RESOURCES_IMAGES_PATH}qr_code.svg"),
              Expanded(
                child: DeasyTextView(
                    text: "  untuk melakukan scan QR Code",
                    fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
                    maxLines: 3,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          DeasyTextView(
            text: ContentConstant.howToUse3,
            maxLines: 3,
            fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
          ),
          SizedBox(height: 24)
        ],
      ),
    );
  }

}

