import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:deasy_color/deasy_color.dart';

class ErrorPage404 extends GetView {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        child: DeasyResponsive(
          builder: (context, orientation, screenType) {
            if (screenType == DeasyScreenType.desktop) {
              return _webSiteOrDesktopWidget();
            }

            if (screenType == DeasyScreenType.tablet) {
              return _tabletWidget();
            }

            return _mobileWidget();
          },
        ),
      ),
    );
  }

  Widget _webSiteOrDesktopWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 15.h,
        ),
        Expanded(
            flex: 4,
            child:
                SvgPicture.asset(ImageConstant.RESOURCES_IMAGE_NOT_FOUND_PAGE)),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              DeasyTextView(
                text: ContentConstant.notFoundTitle,
                fontSize: 24,
                isSelectable: true,
                fontWeight: FontWeight.w700,
                fontColor: DeasyColor.neutral800,
                fontFamily: FontFamily.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                child: DeasyTextView(
                    text: ContentConstant.notFoundSubTitle,
                    fontSize: 14,
                    fontColor: DeasyColor.neutral800,
                    maxLines: 2,
                    isSelectable: true,
                    fontFamily: FontFamily.medium,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500),
              ),
              DeasyTextView(
                  text: ContentConstant.notFoundMessage,
                  isSelectable: true,
                  fontColor: DeasyColor.neutral400,
                  fontSize: 14),
              SizedBox(height: 24),
              DeasyCustomElevatedButton(
                text: '  ${ContentConstant.backToDashBoard}  ',
                textColor: DeasyColor.neutral000,
                borderColor: DeasyColor.kpYellow500,
                primary: DeasyColor.kpYellow500,
                onPress: () => Get.toNamed(OptimusRoutes.LOGIN),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabletWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20.h,
        ),
        Expanded(
          flex: 4,
          child: SvgPicture.asset(
            ImageConstant.RESOURCES_IMAGE_NOT_FOUND_PAGE,
            width: 25.w,
            height: 25.h,
            fit: BoxFit.fill,
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: [
              DeasyTextView(
                text: ContentConstant.notFoundTitle,
                fontSize: 15.0.sp,
                isSelectable: true,
                fontWeight: FontWeight.w700,
                fontColor: DeasyColor.neutral800,
                fontFamily: FontFamily.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: DeasyTextView(
                    text: ContentConstant.notFoundSubTitle,
                    fontSize: 11.8.sp,
                    fontColor: DeasyColor.neutral800,
                    maxLines: 2,
                    isSelectable: true,
                    fontFamily: FontFamily.medium,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500),
              ),
              DeasyTextView(
                  text: ContentConstant.notFoundMessage,
                  fontColor: DeasyColor.neutral400,
                  isSelectable: true,
                  fontSize: 12.sp),
              SizedBox(height: 24),
              DeasyCustomElevatedButton(
                text: '  ${ContentConstant.backToDashBoard}  ',
                textColor: DeasyColor.neutral000,
                fontSize: 12.sp,
                paddingButton: 10,
                borderColor: DeasyColor.kpYellow500,
                primary: DeasyColor.kpYellow500,
                onPress: () => Get.toNamed(OptimusRoutes.LOGIN),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _mobileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          ImageConstant.RESOURCES_IMAGE_NOT_FOUND_PAGE,
          width: 20.w,
          height: 20.h,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 2.5.h,
        ),
        DeasyTextView(
          text: ContentConstant.notFoundTitle,
          fontSize: 15.sp,
          isSelectable: true,
          fontWeight: FontWeight.w700,
          fontColor: DeasyColor.neutral800,
          fontFamily: FontFamily.bold,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: DeasyTextView(
              text: ContentConstant.notFoundSubTitle,
              fontSize: 13.sp,
              fontColor: DeasyColor.neutral800,
              maxLines: 2,
              isSelectable: true,
              fontFamily: FontFamily.medium,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500),
        ),
        DeasyTextView(
            text: ContentConstant.notFoundMessage,
            fontColor: DeasyColor.neutral400,
            isSelectable: true,
            fontSize: 12.sp),
        SizedBox(height: 24),
        DeasyCustomElevatedButton(
          text: '  ${ContentConstant.backToDashBoard}  ',
          textColor: DeasyColor.neutral000,
          fontSize: 13.sp,
          paddingButton: 4.0,
          borderColor: DeasyColor.kpYellow500,
          primary: DeasyColor.kpYellow500,
          onPress: () => Get.toNamed(OptimusRoutes.LOGIN),
        )
      ],
    );
  }
}
