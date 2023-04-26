import 'dart:ui';

import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FullScreenSpinner extends StatelessWidget {
  final bool showLoadingMessage;

  FullScreenSpinner({this.showLoadingMessage = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: showLoadingMessage ?
        Container(
          height: DeasySizeConfigUtils.screenHeight,
          width: DeasySizeConfigUtils.screenWidth,
          color: Colors.black.withOpacity(0.5), child: Center(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.transparent,
                  width: 100.0,
                  height: 100.0,
                  child: Image.asset("resources/images/deasy_loading_animation.gif"),
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                DeasyTextView(
                  text: "Mohon tunggu yaa...",
                  fontSize: DeasySizeConfigUtils.blockHorizontal! * 6,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
                DeasyTextView(
                  text: "Prosesnya ga lama ko, serius deh.",
                  fontSize: DeasySizeConfigUtils.blockHorizontal! * 4,
                  fontColor: Colors.white,
                ),
                SizedBox(height: DeasySizeConfigUtils.blockVertical * 10),
              ],
            )
          )
        )
      ) :
      Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.transparent,
            width: 100.0,
            height: 100.0,
            child: Image.asset("resources/images/deasy_loading_animation.gif"),
          ),
        )
      ),
    );
  }
}

class FullScreenSpinnerWithMessage extends StatelessWidget {
  final String? messageLoading;

  FullScreenSpinnerWithMessage({this.messageLoading});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
        height: DeasySizeConfigUtils.screenHeight,
        width: DeasySizeConfigUtils.screenWidth,
        color: Colors.black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              child: Image.asset("resources/images/deasy_loading_animation.gif"),
            ),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
            Visibility(
              visible: messageLoading != null,
              child: DeasyTextView(
                text: "$messageLoading",
                fontSize: kIsWeb ? DeasySizeConfigUtils.blockHorizontal! * 2 : DeasySizeConfigUtils.blockHorizontal! * 5,
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
    );
  }
}
