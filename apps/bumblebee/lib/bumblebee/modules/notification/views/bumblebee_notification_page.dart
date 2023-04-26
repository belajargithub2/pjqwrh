import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/notification/controllers/bumblebee_notification_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';
import 'package:kreditplus_deasy_mobile/core/utils/status_translator.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/connection_checker_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BumblebeeNotificationPage
    extends GetView<BumblebeeNotificationController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: DeasyColor.neutral000,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: DeasyColor.neutral900),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Notifikasi',
            style: TextStyle(
                color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
          ),
          elevation: 0,
        ),
        body: ConnectionCheckerWidget(
          onRefresh: () => controller.refreshNotificationWhenHasInternet(),
          child: SmartRefresher(
            controller: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            child: Stack(
              children: [
                Container(
                  color: DeasyColor.neutral50,
                  width: DeasySizeConfigUtils.screenWidth,
                  height: DeasySizeConfigUtils.screenHeight,
                  child: Stack(
                    children: [
                      Obx(() => controller.notifList.length > 0
                          ? ListView.builder(
                              padding: EdgeInsets.only(bottom: 100),
                              controller: controller.scrollController,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: controller.notifList.length,
                              itemBuilder: (context, i) {
                                var list = controller.notifList;
                                return Obx(
                                  () => Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Column(
                                      children: [
                                        Slidable(
                                          key: ValueKey(list[i]!.id),
                                          child: InkWell(
                                              onTap: () {
                                                controller
                                                    .onTapReadNotif(list[i]!);
                                              },
                                              child: Container(
                                                  child: notifItemWidget(
                                                      list[i]!.title,
                                                      titleByRole(
                                                          customerName: list[i]!
                                                              .customerName,
                                                          assetCode: list[i]!
                                                              .assetCode,
                                                          prospectId: list[i]!
                                                              .prospectId!),
                                                      list[i]!.orderStatus,
                                                      list[i]!.message!,
                                                      list[i]!.createdAt!,
                                                      list[i]!.isRead!,
                                                      controller
                                                          .isTapped.value,
                                                      list[i]!.action))),
                                          endActionPane: ActionPane(
                                            extentRatio: 1 / 3.5,
                                            motion: const ScrollMotion(),
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    controller
                                                        .deleteNotifFromList(
                                                            list[i]!.id);
                                                    controller.showFlushBar(
                                                        list[i]!.id);
                                                    controller
                                                        .deleteNotifFromApi(
                                                            list[i]!.id);
                                                  },
                                                  child: Container(
                                                    color: DeasyColor.dmsF46363,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SvgPicture.asset(
                                                            IconConstant
                                                                .RESOURCES_ICON_DELETE_NOTIF,
                                                            color: DeasyColor
                                                                .neutral000),
                                                        SizedBox(height: 2.h),
                                                        Text(
                                                          ContentConstant
                                                              .deleteNotifQuestionMark,
                                                          style: TextStyle(
                                                              color: DeasyColor
                                                                  .neutral000),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (!(i == list.length - 1))
                                          Divider(
                                              thickness: 1,
                                              color: DeasyColor.neutral400),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : emptyNotifWidget()),
                    ],
                  ),
                ),
                Obx(() => Visibility(
                    visible: controller.isLoading.value,
                    child: FullScreenSpinner()))
              ],
            ),
          ),
        ),
      ),
    );
  }

  emptyNotifWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Wah, notifikasi anda masih kosong",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: DeasyColor.neutral900),
        ),
        SizedBox(height: 16.0),
        SvgPicture.asset(
          'resources/images/img_pengajuan_empty.svg',
        ),
      ],
    ));
  }

  notifItemWidget(String? title, String? prospectId, String? status,
      String content, DateTime date, bool isRead, bool isTapped, ActionNotification? action) {
    Widget icon;
    String notifDate;

    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      notifDate =
          "Hari Ini " + DateFormat('dd, hh.mm a', 'id').format(date.toLocal());
    } else {
      notifDate = DateFormat('EEEE dd, hh.mm a', 'id').format(date.toLocal());
    }

    if (content.isContainIgnoreCase("unggah") ||
        content.isContainIgnoreCase("upload")) {
      icon = isRead
          ? SvgPicture.asset('resources/images/icons/ic_upload_notif_read.svg')
          : SvgPicture.asset('resources/images/icons/ic_upload_notif.svg');
      title = "Upload";
    } else {
      icon = isRead
          ? SvgPicture.asset(
              'resources/images/icons/ic_transaction_notif_read.svg')
          : SvgPicture.asset('resources/images/icons/ic_transaction_notif.svg');
      title = "Transaksi";
    }

    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: DeasySizeConfigUtils.blockVertical * 1.5,
            vertical: DeasySizeConfigUtils.blockVertical * 1.5),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon,
                SizedBox(width: DeasySizeConfigUtils.blockVertical * 1.5),
                Expanded(
                    child: Text(title,
                        style: TextStyle(
                            color: isRead
                                ? DeasyColor.neutral600
                                : DeasyColor.neutral900,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                DeasySizeConfigUtils.blockVertical * 1.6))),
                Expanded(
                    child: Text(
                  notifDate,
                  style: TextStyle(
                      color: DeasyColor.neutral600,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.2),
                  textAlign: TextAlign.end,
                ))
              ],
            ),
            Row(children: [
              SizedBox(width: 45.0),
              Expanded(
                  child: Text(
                      action != null
                        ?"$prospectId - Edit Pesanan"
                        :"$prospectId - ${StatusTranslator.formatStringStatus(status: status!, role: controller.role.value)}",
                      maxLines: 3,
                      style: TextStyle(
                          color: isRead
                              ? DeasyColor.neutral600
                              : DeasyColor.neutral900,
                          fontWeight: FontWeight.bold,
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.3)))
            ]),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 1.2),
            Row(
              children: [
                SizedBox(width: 45.0),
                Expanded(
                    child: Text(
                  content,
                  style: TextStyle(
                      color: DeasyColor.neutral600,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.3),
                ))
              ],
            ),
          ],
        ));
  }

  String? titleByRole(
      {required String? customerName,
      required String? assetCode,
      required String? prospectId}) {
    if (controller.role.value.isContainIgnoreCase(ContentConstant.ROLE_AGENT)) {
      String titleForAgent =
          "${customerName!} - ${assetCode!} - ${prospectId!}";
      return titleForAgent;
    }
    if (controller.role.value
        .isContainIgnoreCase(ContentConstant.ROLE_MERCHANT)) {
      String titleForMerchant = "${customerName!} - ${prospectId!}";
      return titleForMerchant;
    }
    return null;
  }
}
