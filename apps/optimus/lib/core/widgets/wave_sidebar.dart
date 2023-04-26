import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deasy_color/deasy_color.dart';

class WaveSidebar extends StatelessWidget {
  String name;
  WaveSidebar({this.name = ''});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      color: DeasyColor.kpBlue500,
      height: DeasySizeConfigUtils.screenHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: SvgPicture.asset(
              'resources/images/wave_group_top.svg',
              width: DeasySizeConfigUtils.screenWidth! / 2.5,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: DeasySizeConfigUtils.screenHeight! / 4,
            left: 30,
            child: name != ''
                ? Text(
                    '$name',
                    style: TextStyle(
                        color: DeasyColor.neutral000,
                        fontWeight: FontWeight.bold,
                        fontSize: DeasySizeConfigUtils.isTab
                            ? DeasySizeConfigUtils.blockVertical * 2.5
                            : DeasySizeConfigUtils.blockVertical * 3),
                  )
                : SvgPicture.asset('resources/images/logo/deasy.svg',
                    width: DeasySizeConfigUtils.screenWidth! / 9,
                    height: DeasySizeConfigUtils.screenHeight! / 9,
                    fit: BoxFit.fill,
                    color: DeasyColor.neutral000),
          ),
          Positioned(
              bottom: -20,
              child: SvgPicture.asset(
                'resources/images/wave_group_1.svg',
                width: DeasySizeConfigUtils.screenWidth! / 2.5,
                fit: BoxFit.fill,
              )),
          Positioned(
            bottom: -20,
            child: SvgPicture.asset(
              'resources/images/wave_group_2.svg',
              width: DeasySizeConfigUtils.screenWidth! / 2.5,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
