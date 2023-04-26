import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class EmptyDraftWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
          Container(
            width: 300,
            height: 300,
            child: SvgPicture.asset(
              ImageConstant.RESOURCES_IMAGE_EMPTY_SUBMISSION,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 16.0),
          DeasyTextView(
              text: ContentConstant.draftIsEmpty,
              fontSize: DeasySizeConfigUtils.blockVertical * 1.8,
              fontFamily: FontFamily.medium),
        ],
      ),
    );
  }
}
