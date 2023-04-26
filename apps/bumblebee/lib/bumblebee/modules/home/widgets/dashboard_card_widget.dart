import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/home/controllers/bumblebee_home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCardWidget extends GetView<BumblebeeHomePageController> {
  final Widget? prefixIcon;
  final double? rightPosition;
  final double? circleWidth;
  final bool? isBlue;
  final String? text;
  final bool? isSubmit;
  final bool? showButton;

  DashboardCardWidget({
    required this.prefixIcon,
    required this.rightPosition,
    required this.circleWidth,
    required this.isBlue,
    required this.text,
    required this.isSubmit,
    required this.showButton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.navigate(isSubmit!);
      },
      child: Container(
        width: DeasySizeConfigUtils.screenWidth,
        height: DeasySizeConfigUtils.screenHeight! / 8,
        color: DeasyColor.neutral50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Card(
            key: showButton! ? null : controller.keyInfo3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            color: DeasyColor.neutral000,
            elevation: 3,
            child: Stack(
              children: [
                Positioned(
                  left: -30,
                  top: -20,
                  right: rightPosition,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: circleWidth,
                        height: DeasySizeConfigUtils.screenHeight! / 7,
                        decoration: BoxDecoration(
                          color: isBlue! ? DeasyColor.kpBlue200 : DeasyColor.neutral200,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: prefixIcon
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          text!,
                          style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 1.7,
                            fontFamily: 'KBFGDisplayMedium',
                          ),
                          maxLines: 2,
                        ),
                      ),
                      if (showButton!) Container(
                        width: DeasySizeConfigUtils.blockVertical * 5,
                        height: DeasySizeConfigUtils.blockHorizontal! * 5,
                        decoration: BoxDecoration(
                          color: DeasyColor.kpBlue300,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(Icons.arrow_forward_ios_rounded,
                            color: DeasyColor.neutral000,
                            size: DeasySizeConfigUtils.blockHorizontal! * 3
                          )
                        )
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
