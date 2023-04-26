import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:kreditplus_deasy_website/core/utils/hover.dart';

enum MenuType { ONE_MENU, TWO_MENU, THREE_MENU }

class MenuWidgets extends GetView {
  String? menuNameOne, menuNameTwo, menuNameThree;
  Function? onTapMenuOne, onTapMenuTwo, onTapMenuThree;
  MenuType menuType;
  Color? notActiveColor;
  Color? activeColor;
  double? fontSize;

  MenuWidgets({
    Key? key,
    required this.menuNameOne,
    required this.onTapMenuOne,
    this.menuType = MenuType.ONE_MENU,
    this.notActiveColor,
    this.activeColor,
    this.fontSize,
  })  : assert(menuType == MenuType.ONE_MENU, "Menu type should be ONE_MENU"),
        super(key: key);

  MenuWidgets.twoMenu({
    Key? key,
    required this.menuNameOne,
    required this.menuNameTwo,
    required this.onTapMenuOne,
    this.menuType = MenuType.TWO_MENU,
    this.notActiveColor,
    this.activeColor,
    this.fontSize,
  })  : assert(menuType == MenuType.TWO_MENU, "Menu type should be TWO_MENU"),
        super(key: key);

  MenuWidgets.threeMenu({
    Key? key,
    required this.menuNameOne,
    required this.menuNameTwo,
    required this.menuNameThree,
    required this.onTapMenuOne,
    required this.onTapMenuTwo,
    this.menuType = MenuType.THREE_MENU,
    this.notActiveColor,
    this.activeColor,
    this.fontSize,
  })  : assert(menuType == MenuType.THREE_MENU, "Menu type should be THREE_MENU"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = DeasySizeConfigUtils.isMobile ? 14.sp : 11.sp;
    double sizeOnHover = DeasySizeConfigUtils.isMobile ? 14.5.sp : 11.5.sp;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OnHover(
              builder: (isHovered) {
                return InkWell(
                  onTap: () => onTapMenuOne!(),
                  child: Row(
                    children: [
                      DeasyTextView(
                        fontSize: isHovered ? sizeOnHover : fontSize ?? size,
                        text: menuNameOne,
                        fontColor: menuType == MenuType.TWO_MENU ||
                                menuType == MenuType.THREE_MENU
                            ? notActiveColor ?? DeasyColor.kpYellow500
                            : activeColor ?? DeasyColor.neutral800,
                      ),
                      Visibility(
                        visible: menuType == MenuType.TWO_MENU ||
                            menuType == MenuType.THREE_MENU,
                        child: DeasyTextView(
                            fontSize: fontSize ?? size,
                            fontColor: activeColor ?? DeasyColor.neutral800,
                            text: " > "),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
              width: 4,
            ),
            Visibility(
              visible: menuType == MenuType.TWO_MENU ||
                  menuType == MenuType.THREE_MENU,
              child: OnHover(
                builder: (isHovered) {
                  return InkWell(
                    onTap: () => onTapMenuTwo!(),
                    child: Row(
                      children: [
                        DeasyTextView(
                            fontSize: isHovered ? sizeOnHover : fontSize ?? size,
                            text: menuNameTwo,
                            fontColor: menuType == MenuType.TWO_MENU
                                ? activeColor ?? DeasyColor.neutral800
                                : notActiveColor ?? DeasyColor.kpYellow500),
                        Visibility(
                          visible: menuType == MenuType.THREE_MENU,
                          child: DeasyTextView(
                              fontSize: fontSize ?? size,
                              fontColor: activeColor ?? DeasyColor.neutral800,
                              text: " > "),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Visibility(
              visible: menuType == MenuType.THREE_MENU,
              child: OnHover(
                builder: (isHovered) {
                  return InkWell(
                    onTap: () => onTapMenuThree!(),
                    child: DeasyTextView(
                        fontSize: isHovered ? sizeOnHover : fontSize ?? size,
                        text: menuNameThree,
                        fontColor: activeColor ?? DeasyColor.neutral800),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
