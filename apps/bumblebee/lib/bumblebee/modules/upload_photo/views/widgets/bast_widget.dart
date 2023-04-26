import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/controllers/upload_photo_bast_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/upload_photo/views/widgets/empty_upload_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';

class BastWidget extends GetView<UploadPhotoBastController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => bodyWidget());
  }

  Widget bodyWidget() {
    if (controller.isLoading.isTrue) {
      return loadingSpinner();
    } else if (controller.listBast.isEmpty) {
      return EmptyUploadWidget();
    } else {
      return contentContainer();
    }
  }

  Widget loadingSpinner() {
    return AbsorbPointer(
      absorbing: true,
      child: FullScreenSpinner(),
    );
  }

  Widget contentContainer() {
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      child: Column(
        children: [
          Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight! / 12,
            color: DeasyColor.dmsEBFFF2,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.arrow_circle_up_sharp, color: DeasyColor.dms2ED477),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Yuk, segera upload BAST kamu',
                  style: TextStyle(
                      color: DeasyColor.dms2ED477,
                      fontSize: DeasySizeConfigUtils.blockVertical * 1.5),
                )
              ],
            ),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.listBast.length,
                  itemBuilder: (context, i) {
                    return Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      margin: EdgeInsets.all(4),
                      child: Card(
                        color: DeasyColor.neutral000,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 10.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${controller.listBast[i].name}',
                                    style: TextStyle(
                                        color: DeasyColor.dms2ED477,
                                        fontSize:
                                            DeasySizeConfigUtils.blockVertical *
                                                1.5),
                                  ),
                                  Spacer(),
                                  Text('${controller.listBast[i].date}',
                                      style: TextStyle(
                                          color: DeasyColor.neutral400,
                                          fontSize: DeasySizeConfigUtils
                                                  .blockVertical *
                                              1.2)),
                                ],
                              ),
                            ),
                            Divider(
                              height: 0,
                              thickness: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0,
                                  right: 16.0,
                                  top: 6.0,
                                  bottom: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text('${controller.listBast[i].id}',
                                      style: TextStyle(
                                          color: DeasyColor.kpBlue500,
                                          fontSize: DeasySizeConfigUtils
                                                  .blockVertical *
                                              1.5)),
                                  Row(
                                    children: [
                                      Text('${controller.listBast[i].price}',
                                          style: TextStyle(
                                              color: DeasyColor.neutral900,
                                              fontSize: DeasySizeConfigUtils
                                                      .blockVertical *
                                                  2.1,
                                              fontWeight: FontWeight.bold)),
                                      Spacer(),
                                      InkWell(
                                          onTap: () {
                                            controller.checkOrder(
                                                controller.listBast[i].id,
                                                controller.listBast[i].price,
                                                controller.listBast[i].date);
                                          },
                                          child: Text(
                                              ContentConstant.uploadHere,
                                              style: TextStyle(
                                                  color: DeasyColor.kpBlue500,
                                                  fontSize: DeasySizeConfigUtils
                                                          .blockVertical *
                                                      1.5))),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: DeasyColor.neutral400,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
