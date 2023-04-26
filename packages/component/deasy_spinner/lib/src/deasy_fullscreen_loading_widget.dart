import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class DeasyFullScreenLoading extends StatelessWidget {
  final String? messageLoading;

  DeasyFullScreenLoading({this.messageLoading});

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
              visible: messageLoading!.isNotEmpty,
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