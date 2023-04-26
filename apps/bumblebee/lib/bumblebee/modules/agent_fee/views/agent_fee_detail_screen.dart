import 'package:deasy_animation/deasy_animation.dart';
import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/controller/agent_fee_detail_controller.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';

part 'widgets/bottom_sheet_content_monthly_incentive.dart';
part 'widgets/bottom_sheet_content_loyalty.dart';
part 'widgets/bottom_sheet_content_disbursement.dart';
part 'widgets/content_card_item.dart';
part 'widgets/footer_card_item.dart';
part 'widgets/header_card_item.dart';


class AgentFeeDetailScreen extends GetView<AgentFeeDetailController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: DeasyColor.neutral50,
        body: DeasyResponsive(builder: (context, orientation, screenType) {
          return Stack(
            children: [
              Column(
                children: [
                  _buildHeader(),
                  _buildBanner(),
                  _buildContent(context),
                ],
              ),
              _buildBottomButton(),
              _loading()
            ],
          );
        }),
      ),
    );
  }

  Widget _buildHeader() {
    return SideInAnimation(
      delay: 1,
      child: Container(
        color: DeasyColor.neutral000,
        padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
        child: Row(
          children: [
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DeasyColor.neutral800,
              ),
              onPressed: () => Get.back(),
            ),
            DeasyTextView(
              text: ContentConstant.agentFeeDetailRincianAgentFee,
              fontSize: 16.sp,
              fontColor: DeasyColor.neutral800,
              fontFamily: FontFamily.bold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return SideInAnimation(
      delay: 2,
      child: Container(
        color: DeasyColor.kpBlue500,
        padding: EdgeInsets.all(8.0),
        width: double.infinity,
        child: Center(
          child: Obx(
            () => DeasyTextView(
              text: "Periode ${controller.getPeriodDatetime(
                  start: controller.startDate.value,
                  end: controller.endDate.value,
              )}",
              fontSize: 14.sp,
              maxLines: 2,
              letterSpacing: 0.2,
              fontWeight: FontWeight.w700,
              fontColor: DeasyColor.neutral000,
              fontFamily: FontFamily.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
        child: SideInAnimation(
      delay: 3,
      child: Obx(() => ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 100),
            itemCount: controller.listDetailAgentFee.length,
            itemBuilder: (context, index) {
              final data = controller.listDetailAgentFee[index];
              if (data.type == ContentConstant.agentFeeDisbursement) {
                return _buildPencairanWidget(context, data);
              }

              if (data.type == ContentConstant.agentFeeMonthlyIncentive) {
                return _buildInsentifBulananWidget(context, data);
              }

              if (data.type == ContentConstant.agentFeeLoyalty) {
                return _buildLoyaltyWidget(context, data);
              }

              return SizedBox();
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 10.0,
                color: DeasyColor.neutral50,
              );
            },
          )),
    ));
  }

  Widget _buildBottomButton() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: SideInAnimation(
        delay: 4,
        child: Container(
          color: DeasyColor.neutral000,
          padding: EdgeInsets.all(12.0),
          child: DeasyCustomElevatedButton(
            primary: DeasyColor.kpYellow500,
            borderColor: DeasyColor.kpYellow500,
            onPress: () {
              downloadDocument();
            },
            fontSize: 17.0.sp,
            text: ContentConstant.agentFeeDetailDownloadDocument,
            textColor: DeasyColor.neutral000,
          ),
        ),
      ),
    );
  }

  Widget _buildPencairanWidget(BuildContext context, Incentive data) {
    return Container(
      color: DeasyColor.neutral000,
      child: Column(
        children: [
          HeaderCardItem(
            title: ContentConstant.agentFeeDetailDisbursement,
            subTitle: ContentConstant.agentFeeDetailHeaderCardItem,
            onDetailPress: () {
              _bottomSheetDetailFee(
                context,
                content: BottomSheetContentDisbursement(
                  data: data,
                ),
                type: AgentFeeDetailType.DISBURSEMENT,
                data: data,
              );
            },
          ),
          Divider(
            thickness: 0.7,
            color: DeasyColor.neutral200,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailConsumerName,
            subTitle: "${data.customerName}",
            fontColor: DeasyColor.kpBlue900,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailAsset,
            subTitle: "${data.assetCode}",
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDisbursementDate,
            subTitle:
                "${DateFormat(DateConstant.dateFormat2).format(data.date!)}",
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDisbursementValue,
            subTitle: "${data.ntf?.toDouble().toString().toRupiah() ?? "-"}",
          ),
          Divider(
            thickness: 0.7,
            indent: 16.0,
            endIndent: 16.0,
            color: DeasyColor.neutral200,
          ),
          FooterCardItem(
            title: ContentConstant.agentFeeDetailTotalAgentFee,
            subTitle: "${data.afterTax!.toDouble().toString().toRupiah()}",
          ),
        ],
      ),
    );
  }

  Widget _buildInsentifBulananWidget(BuildContext context, Incentive data) {
    return Container(
      color: DeasyColor.neutral000,
      child: Column(
        children: [
          HeaderCardItem(
            title: ContentConstant.agentFeeDetailMonthlyIntencive,
            subTitle: ContentConstant.agentFeeDetailHeaderCardItem,
            onDetailPress: () {
              _bottomSheetDetailFee(
                context,
                content: BottomSheetContentMonthlyIncentive(
                  data: data,
                  description: "${data.description}",
                ),
                type: AgentFeeDetailType.MONTHLY_INCENTIVE,
                data: data,
              );
            },
          ),
          Divider(
            thickness: 0.7,
            color: DeasyColor.neutral200,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDescription,
            subTitle: "${data.description}",
            fontColor: DeasyColor.kpBlue900,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDisbursementDate,
            subTitle:
                "${DateFormat(DateConstant.dateFormat2).format(data.date!)}",
          ),
          Divider(
            thickness: 0.7,
            indent: 16.0,
            endIndent: 16.0,
            color: DeasyColor.neutral200,
          ),
          FooterCardItem(
            title: ContentConstant.agentFeeDetailTotalAgentFee,
            subTitle: "${data.afterTax!.toDouble().toString().toRupiah()}",
          ),
        ],
      ),
    );
  }

  Widget _buildLoyaltyWidget(BuildContext context, Incentive data) {
    return Container(
      color: DeasyColor.neutral000,
      child: Column(
        children: [
          HeaderCardItem(
            title: ContentConstant.agentFeeDetailLoyalty,
            subTitle: ContentConstant.agentFeeDetailHeaderCardItem,
            onDetailPress: () {
              _bottomSheetDetailFee(
                context,
                content: BottomSheetContentLoyalty(
                  data: data,
                  description: "${data.description}",
                ),
                type: AgentFeeDetailType.LOYALTY,
                data: data,
              );
            },
          ),
          Divider(
            thickness: 0.7,
            color: DeasyColor.neutral200,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDescription,
            subTitle: "${data.description}",
            fontColor: DeasyColor.kpBlue900,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDisbursementDate,
            subTitle:
                "${DateFormat(DateConstant.dateFormat2).format(data.date!)}",
          ),
          Divider(
            thickness: 0.7,
            indent: 16.0,
            endIndent: 16.0,
            color: DeasyColor.neutral200,
          ),
          FooterCardItem(
            title: ContentConstant.agentFeeDetailTotalAgentFee,
            subTitle: "${data.afterTax!.toDouble().toString().toRupiah()}",
          ),
        ],
      ),
    );
  }

  Future<dynamic> _bottomSheetDetailFee(
    BuildContext context, {
    required Widget content,
    required AgentFeeDetailType type,
    Incentive? data,
  }) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var child;
          if (child == null) {
            child = Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Container(
                  width: 60,
                  height: 4,
                  margin: EdgeInsets.fromLTRB(37.w, 15, 37.w, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: DeasyColor.neutral200,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  child: DeasyTextView(
                    text: ContentConstant.agentFeeDetailRincianAgentFee,
                    textAlign: TextAlign.center,
                    fontSize: 18.sp,
                    fontColor: DeasyColor.neutral800,
                    fontFamily: FontFamily.bold,
                  ),
                ),
                content,
                Divider(
                  thickness: 0.7,
                  indent: 8.0,
                  endIndent: 8.0,
                  color: DeasyColor.neutral200,
                ),
                ContentCardItem(
                  title: ContentConstant.agentFeeLabel,
                  paddingText: 8.0,
                  fontSize: 15.0.sp,
                  paddingHorizontal: 18.0,
                  subTitle: data!.beforeTax!.toDouble().toString().toRupiah(),
                ),
                ContentCardItem(
                  title: ContentConstant.agentFeeDetailTaxSheet,
                  paddingText: 8.0,
                  fontSize: 15.0.sp,
                  fontColor: DeasyColor.neutral400,
                  paddingHorizontal: 18.0,
                  subTitle: "- ${data.tax!.toDouble().toString().toRupiah()}",
                ),
                FooterCardItem(
                  title: ContentConstant.agentFeeDetailTotalAgentFee,
                  paddingText: 3.0,
                  fontSize: 16.0.sp,
                  paddingHorizontal: 22.0,
                  subTitle: data.afterTax!.toDouble().toString().toRupiah(),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 25.0),
                  child: DeasyCustomElevatedButton(
                    primary: DeasyColor.kpYellow500,
                    borderColor: DeasyColor.kpYellow500,
                    onPress: () {
                      Navigator.pop(context);
                    },
                    fontSize: 16.0.sp,
                    text: ContentConstant.agentFeeDetailButtonBottomSheet,
                    textColor: DeasyColor.neutral000,
                  ),
                ),
              ],
            );
          }
          return child;
        });
  }

  Widget _loading() {
    return Obx(() => Visibility(
        visible: controller.agentFeeState.value == AgentFeeState.LOADING,
        child: FullScreenSpinner()));
  }

  Future<void> downloadDocument() async {
    DeasyBaseDialogs.getInstance().simpleDialog(
      context: Get.context!,
      title: DialogConstant.agentFeeDetailDownloadTitleDialog,
      subTitle: DialogConstant.agentFeeDetailDownloadSubtitleDialog +
          controller.getPeriodDatetime(
            start: controller.startDate.value,
            end: controller.endDate.value),
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      subTitleTextAlign: TextAlign.center,
      height: 245.0,
      buttonOkText: ContentConstant.agentFeeDetailDownloadButtonOk,
      buttonCancelTextSize: 16.0.sp,
      buttonOkTextSize: 16.0.sp,
      direction: Direction.horizontal,
      onPressButtonOk: () {
        Get.back();
        controller
            .downloadAgentFee()
            .then((value) => value == true
                ? successDownloadDialog()
                : failedDownloadDialog())
            .catchError((e) => failedDownloadDialog())
            .whenComplete(() => controller.hiddenLoading());
      },
      onPressButtonCancel: () {
        Get.back();
      },
      buttonCancelText: ContentConstant.agentFeeDetailDownloadButtonCancel,
    );
  }

  Future<void> successDownloadDialog() async {
    DeasyBaseDialogs.getInstance().iconDialog(
        context: Get.context!,
        title: DialogConstant.agentFeeDetailSuccessDownloadTitleDialog,
        subTitle: DialogConstant.agentFeeDetailSuccessDownloadSubtitleDialog,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        height: 300,
        buttonOkText: DialogConstant.agentFeeDetailSuccessDownloadOkButtonDialog,
        onPressButtonOk: () {
          Get.back();
        },
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(IconConstant.RESOURCES_ICON_SUCCESS_PATH),
        ));
  }

  Future<void> failedDownloadDialog() async {
    DeasyBaseDialogs.getInstance().iconDialog(
        context: Get.context!,
        title: DialogConstant.agentFeeDetailFailedDownloadTitleDialog,
        subTitle: DialogConstant.agentFeeDetailFailedDownloadSubtitleDialog,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        height: 320,
        onPressButtonOk: () {
          Get.back();
          controller
              .downloadAgentFee()
              .then((success) => success
              ? successDownloadDialog()
              : failedDownloadDialog())
              .catchError((e) => failedDownloadDialog())
              .whenComplete(() => controller.hiddenLoading());
        },
        onPressButtonCancel: () {
          Get.back();
        },
        buttonOkText: DialogConstant.agentFeeDetailRetryDownloadDialog,
        buttonCancelText: DialogConstant.agentFeeDetailCancelDownloadDialog,
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(IconConstant.RESOURCES_ICON_FAILED_PATH),
        ));
  }
}
