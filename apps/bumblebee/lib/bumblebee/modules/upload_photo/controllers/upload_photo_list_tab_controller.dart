import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/widgets/bast_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/widgets/empty_upload_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/widgets/imei_widget.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/widgets/receipt_widget.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class UploadPhotoListTabController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController? tabController;
  final hasBuktiTerimaAccess = false.obs;
  final hasBASTAccess = false.obs;
  final hasImeiAccess = false.obs;
  final isShowTab = false.obs;
  final RxList<Widget> tabViewLabelList = <Widget>[].obs;
  final RxList<Widget> tabViewChildList = <Widget>[].obs;

  @override
  void onInit() async {
    await getDocumentAccess();
    tabController = TabController(vsync: this, length: tabViewLabelList.length);
    super.onInit();
  }

  Future<void> getDocumentAccess() async {
    hasBuktiTerimaAccess(await DeasyPocket().getUploadBuktiTerimaAccess());
    hasBASTAccess(await DeasyPocket().getUploadBASTAccess());
    hasImeiAccess(await DeasyPocket().getUploadImeiAccess());

    if (hasBuktiTerimaAccess.isTrue) {
      tabViewLabelList.add(Tab(text: ContentConstant.documentReceipt));
      tabViewChildList.add(ReceiptWidget());
    }

    if (hasBASTAccess.isTrue) {
      tabViewLabelList.add(Tab(text: ContentConstant.documentBast));
      tabViewChildList.add(BastWidget());
    }

    if (hasImeiAccess.isTrue) {
      tabViewLabelList.add(Tab(text: ContentConstant.NOMOR_IMEI));
      tabViewChildList.add(ImeiWidget());
    }

    if(tabViewLabelList.isEmpty) {
      tabViewChildList.add(EmptyUploadWidget());
    }
    setIsShowTab();
  }

  setIsShowTab() {
    isShowTab(tabViewLabelList.length > 1);
  }
}