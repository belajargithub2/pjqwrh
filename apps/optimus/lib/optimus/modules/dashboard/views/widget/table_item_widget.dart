import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/table_transaction_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class ItemTableWidget extends GetView<TableTransactionController> {
  final String? title;
  final Function()? onPressedUpload;
  final Function()? onPressedPreview;
  final String? action;
  final bool isButton;
  final fontColor;

  ItemTableWidget(
      {this.title,
      this.onPressedPreview,
      this.onPressedUpload,
      this.action,
      this.isButton = false,
      this.fontColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isButton
          ? Align(
              alignment: Alignment.center,
              child: _actionWidget(),
            )
          : Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  controller.onCopyToClipBoard(title);
                },
                child: DeasyTextView(
                  textAlign: TextAlign.left,
                  text: title,
                  fontSize: DeasySizeConfigUtils.blockVertical * 1.6,
                  fontFamily: FontFamily.medium,
                  overflow: TextOverflow.fade,
                  fontColor: fontColor,
                  maxLines: 3,
                ),
              ),
            ),
    );
  }

  Widget _actionWidget() {
    switch (action) {
      case ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_NONE:
        return _noActionStripWidget();

      case ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_VIEW:
        return IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              IconConstant.RESOURCES_ICON_VIEW_BAST,
              color: DeasyColor.semanticInfo300,
            ),
            onPressed: onPressedPreview);

      case ContentConstant.DASHBOARD_DOCUMENT_ACTION_FLAG_UPLOAD:
        return IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            icon: SvgPicture.asset(
              IconConstant.RESOURCES_ICON_UPLOAD_BAST,
              color: DeasyColor.dms2ED477,
            ),
            onPressed: onPressedUpload);

      default:
        return _noActionStripWidget();
    }
  }

  Widget _noActionStripWidget() {
    return Container(
      width: 15,
      height: 3,
      margin: EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        color: DeasyColor.neutral400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
