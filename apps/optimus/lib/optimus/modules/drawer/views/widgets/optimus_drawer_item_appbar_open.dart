import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_logout/deasy_logout.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_website/core/utils/status_translator.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/controllers/optimus_drawer_custom_controller.dart';
import 'package:kreditplus_deasy_website/core/routes/app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/hover.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/models/optimus_notification_list_response.dart';

class OptimusDrawerItemOpen extends GetView<OptimusDrawerCustomController> {
  final String? username;
  final String? role;
  final bool? isNotif;
  Function? hiddenAppBar;

  OptimusDrawerItemOpen(
      {this.username, this.role, this.isNotif, this.hiddenAppBar});

  @override
  Widget build(BuildContext context) {
    if (isNotif!) {
      return Material(
        child: Card(
          elevation: 4,
          child: Container(
            height: DeasySizeConfigUtils.screenHeight! / 1.3,
            decoration: BoxDecoration(
              color: DeasyColor.neutral000,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: DeasySizeConfigUtils.blockVertical * 2,
                      horizontal: DeasySizeConfigUtils.blockHorizontal! * 4),
                  child: DeasyTextView(
                    text: ContentConstant.notification,
                    fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(thickness: 1, color: DeasyColor.neutral400),
                Expanded(
                  child: Obx(
                    () => controller.notifList.isEmpty
                        ? emptyNotifWidget()
                        : notifListWidget(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Material(
      child: Card(
        elevation: 4,
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: DeasyColor.dms0096D0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$username\n$role',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: DeasyColor.neutral000),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              OnHover(
                builder: (isHovered) {
                  return InkWell(
                    onTap: () {
                      if (kIsWeb) {
                        Get.offNamed(Routes.PROFILE);
                      } else {
                        Get.toNamed(Routes.PROFILE);
                      }
                      controller.onTapMenu(context);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              ContentConstant.manageAccount,
                              style: TextStyle(
                                color: DeasyColor.neutral800,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 2,
              ),
              Divider(),
              SizedBox(
                height: 2,
              ),
              OnHover(
                builder: (isHovered) {
                  return InkWell(
                    onTap: () {
                      hiddenAppBar!();
                      DeasyLogout().logout();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              ContentConstant.exit,
                              style: TextStyle(
                                color: DeasyColor.neutral800,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  notifListWidget() {
    return ListView.builder(
        controller: controller.scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: controller.notifList.length,
        itemBuilder: (context, i) {
          var list = controller.notifList;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    var requestBody = <String, dynamic>{
                      "id": list[i].id,
                      "is_read": true
                    };
                    controller.onTapReadNotif(context, i, requestBody);
                  },
                  child: Obx(
                    () => Container(
                      child: notifItemWidget(
                          list[i].title,
                          list[i].customerName,
                          list[i].prospectId,
                          list[i].orderStatus,
                          list[i].message!,
                          list[i].createdAt!,
                          list[i].isRead!,
                          controller.isTapped.value,
                          list[i].action),
                    ),
                  ),
                ),
                if (!(i == list.length - 1))
                  Divider(thickness: 1, color: DeasyColor.neutral400),
              ],
            ),
          );
        });
  }

  notifItemWidget(
      String? title,
      String? customerName,
      String? prospectId,
      String? status,
      String content,
      DateTime date,
      bool isRead,
      bool isTapped,
      ActionNotification? action,) {
    Widget icon;
    String notifDate;

    date = date.add(Duration(hours: 7));

    if (date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year) {
      notifDate = "Hari Ini " + DateFormat('dd, hh.mm a', 'id').format(date);
    } else {
      notifDate = DateFormat('EEEE dd, hh.mm a', 'id').format(date);
    }

    if (content.isContainIgnoreCase("unggah") ||
        content.isContainIgnoreCase("upload")) {
      icon = isRead
          ? SvgPicture.asset(IconConstant.RESOURCES_ICON_UPLOAD_NOTIF_READ)
          : SvgPicture.asset(IconConstant.RESOURCES_ICON_UPLOAD_NOTIF);
      title = ContentConstant.upload;
    } else {
      icon = isRead
          ? SvgPicture.asset(IconConstant.RESOURCES_ICON_TRANSACTION_NOTIF_READ)
          : SvgPicture.asset(IconConstant.RESOURCES_ICON_TRANSACTION_NOTIF);
      title = ContentConstant.transaction;
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
                child: Text(
                  title,
                  style: TextStyle(
                      color: isRead
                          ? DeasyColor.neutral600
                          : DeasyColor.neutral900,
                      fontWeight: FontWeight.bold,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.6),
                ),
              ),
              Expanded(
                child: Text(
                  notifDate,
                  style: TextStyle(
                      color: DeasyColor.neutral600,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.2),
                  textAlign: TextAlign.end,
                ),
              )
            ],
          ),
          Row(children: [
            SizedBox(width: 45.0),
            Expanded(
              child: Text(
                action != null
                  ?"$customerName - $prospectId - Edit Pesanan"
                  :"$customerName - $prospectId - ${StatusTranslator.formatStringStatus(status: status!, role: role!)}",
                style: TextStyle(
                    color:
                        isRead ? DeasyColor.neutral600 : DeasyColor.neutral900,
                    fontWeight: FontWeight.bold,
                    fontSize: DeasySizeConfigUtils.blockVertical * 1.3),
              ),
            )
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  emptyNotifWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ContentConstant.emptyNotif,
            style: TextStyle(
                fontSize: DeasySizeConfigUtils.blockVertical * 2.3,
                fontWeight: FontWeight.bold,
                color: DeasyColor.neutral900),
          ),
          SizedBox(height: DeasySizeConfigUtils.blockVertical * 3),
          SvgPicture.asset(
            ImageConstant.RESOURCES_IMAGE_PENGAJUAN_EMPTY,
          ),
        ],
      ),
    );
  }
}
