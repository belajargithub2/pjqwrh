import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_asset_data_submission/kmob_asset_data_submission_container_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_consumer_data_submission/kmob_consumer_data_submission_container_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_upload_document_submission/kmob_upload_document_submission_container_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/step_indicator/bumblebee_step_indicator_mobile_screen.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/widgets/step_indicator/bumblebee_step_indicator_tab_screen.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';

class KMOBSubmissionContainerScreen
    extends GetView<BumblebeeKMOBSubmissionController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      appBar: _appBar() as PreferredSizeWidget?,
      body: Stack(
        children: [
          DeasyResponsive(
            builder: (context, orientation, screenType) {
              if (screenType == DeasyScreenType.desktop) {
                return Text('under development');
              }

              if (screenType == DeasyScreenType.tablet) {
                return _contentTabWidget();
              }

              return _contentMobileWidget();
            },
          ),
          _loadingWidget(),
          _errorSnackBar(),
        ],
      ),
    );
  }

  Widget _errorSnackBar() {
    return Obx(() => controller.isShowError.value ? _showError() : Container());
  }

  Widget _showError() {
    controller.isShowError.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.rawSnackbar(
          messageText: Text(
            controller.errorMessage.value,
            style: TextStyle(color: DeasyColor.neutral000),
          ),
          icon: Image.asset(IconConstant.RESOURCES_ICON_ALERT_PATH,
              height: 16, width: 16),
          snackPosition: SnackPosition.TOP,
          backgroundColor: DeasyColor.dmsF46363);
    });
    return SizedBox();
  }

  Widget _loadingWidget() {
    return Obx(
      () => Visibility(
        visible: controller.isLoading.value,
        child: AbsorbPointer(
          absorbing: true,
          child: FullScreenSpinner(),
        ),
      ),
    );
  }

  Widget _contentMobileWidget() {
    return Container(
      height: DeasySizeConfigUtils.screenHeight,
      width: DeasySizeConfigUtils.screenWidth,
      child: Obx(() => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SideInAnimation(
                  delay: 1,
                  child: Container(
                    child: BumblebeeMobileStepIndicatorScreen(
                        index: controller.index.value,
                        nameSectionOne:
                            ContentConstant.nameSectionOneKMOBSubmissionMobile,
                        nameSectionTwo:
                            ContentConstant.nameSectionTwoKMOBSubmissionMobile,
                        nameSectionThree: ContentConstant
                            .nameSectionThreeKMOBSubmissionMobile),
                  )),
              controller.activeMainSection.isBlank!
                  ? Container()
                  : _mainSection(controller.activeMainSection.value),
            ],
          )),
    );
  }

  Widget _contentTabWidget() {
    return Container(
      height: DeasySizeConfigUtils.screenHeight,
      width: DeasySizeConfigUtils.screenWidth,
      child: Obx(() => ListView(
            physics: BouncingScrollPhysics(),
            children: [
              SideInAnimation(
                  delay: 1,
                  child: Container(
                    child: BumblebeeTabStepIndicatorScreen(
                        index: controller.index.value,
                        nameSectionOne:
                            ContentConstant.nameSectionOneKMOBSubmissionTab,
                        nameSectionTwo:
                            ContentConstant.nameSectionTwoKMOBSubmissionTab,
                        nameSectionThree:
                            ContentConstant.nameSectionThreeKMOBSubmissionTab),
                  )),
              controller.activeMainSection.isBlank!
                  ? Container()
                  : _mainSection(controller.activeMainSection.value),
            ],
          )),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: DeasyColor.neutral000,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: DeasyColor.neutral900,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      title: DeasyTextView(
          text: ContentConstant.submitConsumer,
          fontSize: DeasySizeConfigUtils.blockVertical * 2,
          fontColor: DeasyColor.neutral900,
          fontFamily: FontFamily.medium),
    );
  }

  Widget _mainSection(SECTION name) {
    switch (name) {
      case SECTION.DATA_KONSUMEN:
        {
          return SideInAnimation(
              delay: ContentConstant.TWO,
              child: KMOBConsumerDataSubmissionContainerScreen());
        }
      case SECTION.DATA_ASET:
        {
          return SideInAnimation(
              delay: ContentConstant.TWO,
              child: KMOBAssetDataSubmissionContainerScreen());
        }
      case SECTION.UPLOAD_DOKUMEN:
        {
          return SideInAnimation(
              delay: ContentConstant.TWO,
              child: KMOBUploadDocumentSubmissionContainerScreen());
        }
      default:
        {
          return Text('-');
        }
    }
  }
}
