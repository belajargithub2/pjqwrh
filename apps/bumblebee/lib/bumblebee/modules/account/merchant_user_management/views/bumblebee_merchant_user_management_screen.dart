import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/controllers/bumblebee_merchant_user_management_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/account/merchant_user_management/widgets/bumblebee_merchant_item_widget.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class BumblebeeMerchantUserManagementScreen extends GetView<BumblebeeMerchantUserManagementController> {
  @override
  Widget build(BuildContext context) {
    return DeasyResponsive(
      builder: (context, orientation, screenType) {
        return Obx(() => Scaffold(
            appBar: _appBar(),
            body: _bodyContainer(),
          ),
        );
      }
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: DeasyColor.neutral000,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
        onPressed: () => Get.back(),
      ),
      title: DeasyTextView(
        text: ContentConstant.merchantUserManagement,
        fontColor: DeasyColor.neutral900,
        fontFamily: FontFamily.bold,
        fontSize: 16.5.sp,
      ),
      elevation: 2,
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_rounded,
            color: controller.isLoading.isFalse && controller.userList.length != 3
              ? DeasyColor.kpYellow500
              : DeasyColor.neutral300,
            size: 5.14.h
          ),
          onPressed: () => controller.navigateToAddUser(),
        ),
      ],
    );
  }

  Widget _bodyContainer() {
    if (controller.isLoading.isTrue) {
      return loadingSpinner();
    } else if (controller.userList.isEmpty) {
      return _emptyWidget();
    } else {
      return _body();
    }
  }

  Widget loadingSpinner() {
    return AbsorbPointer(
      absorbing: true,
      child: FullScreenSpinner(),
    );
  }

  Widget _body() {
    return Container(
      color: DeasyColor.neutral50,
      child: Column(
        children: [
          _maxMerchantInfoWidget(),
          Expanded(
            child: _listMerchantWidget()
          )
        ]
      ),
    );
  }

  Widget _emptyWidget() {
    return Column(
      children: [
        SizedBox(height: 5.88.h),
        SvgPicture.asset(
          ImageConstant.RESOURCES_IMAGE_EMPTY_SUBMISSION,
        ),
        SizedBox(height: 2.35.h),
        DeasyTextView(
          text: ContentConstant.emptyMerchantEmployee,
          fontColor: DeasyColor.neutral500,
          fontFamily: FontFamily.medium,
          fontSize: 2.35.h,
          margin: EdgeInsets.symmetric(horizontal: 5.88.h),
          maxLines: 3,
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget _maxMerchantInfoWidget() {
    return Container(
      color: DeasyColor.sally50,
      padding: EdgeInsets.symmetric(horizontal: 2.64.h, vertical: 1.76.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: DeasyColor.kpBlue600,
            size: 1.76.h,
          ),
          SizedBox(width: 1.17.h),
          Expanded(
            child: DeasyTextView(
              text: ContentConstant.maxMerchantInfo,
              fontColor: DeasyColor.kpBlue600,
              fontSize: 1.76.h,
              fontFamily: FontFamily.medium,
              maxLines: 3,
            )
          )
        ],
      ),
    );
  }

  Widget _listMerchantWidget() {
    return ListView.builder(
      itemCount: controller.userList.length,
      itemBuilder: (context, index) {
        return BumblebeeMerchantItemWidget(
          isVerified: controller.userList[index].isVerified!,
          name: controller.userList[index].name!,
          email: controller.userList[index].email!,
          phone: controller.userList[index].phoneNumber.toDashIfNull(),
          index: index,
          userId: controller.userList[index].id!,
          updatedAt: controller.userList[index].updatedAt
            .toString()
            .toFormattedDate(format: DateConstant.dateFormat4),
          duration: controller.getTimerDuration(
            createdAt: controller.userList[index].createdAt ?? null,
            retryAt: controller.userList[index].emailVerifiedAfterRetry ?? null
          ),
        );
      }
    );
  }


}