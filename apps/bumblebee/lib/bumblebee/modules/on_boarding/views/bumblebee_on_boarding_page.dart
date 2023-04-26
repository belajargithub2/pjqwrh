import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/controllers/bumblebee_on_boarding_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/on_boarding/views/widgets/bumblebee_on_boarding_item.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/bounce_widget.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';

class BumblebeeOnBoardingPage extends GetView<BumblebeeOnBoardingController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: Scaffold(body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              Obx(() => PageView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.onBoardingArrayList.length,
                    itemBuilder: (ctx, i) => Obx(() => BumblebeeOnBoardingItem(
                        controller.onBoardingArrayList[i])),
                  )),
              Positioned(
                bottom: 20,
                child: Container(
                  width: DeasySizeConfigUtils.screenWidth,
                  child: Row(
                    children: <Widget>[
                      Obx(() => controller.currentPage.value > 1
                          ? SizedBox(
                              width: DeasySizeConfigUtils.screenWidth! / 7,
                            )
                          : Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: 15.0, bottom: 15.0),
                                child: BouncingWidget(
                                  duration: Duration(milliseconds: 100),
                                  scaleFactor: 1.5,
                                  onPressed: () => controller.skip(),
                                  child: Text(
                                    "Lewati",
                                    style: TextStyle(
                                      color: DeasyColor.neutral400,
                                      fontSize:
                                          DeasySizeConfigUtils.blockVertical *
                                              2,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      Spacer(),
                      Container(
                        alignment: AlignmentDirectional.bottomCenter,
                        margin: EdgeInsets.only(bottom: 20.0),
                        child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.onBoardingArrayList
                                .asMap()
                                .map((i, element) => MapEntry(
                                    i,
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 300),
                                      height:
                                          DeasySizeConfigUtils.blockVertical *
                                              0.9,
                                      width: controller.currentPage.value == i
                                          ? DeasySizeConfigUtils
                                                  .blockHorizontal! *
                                              6
                                          : DeasySizeConfigUtils
                                                  .blockHorizontal! *
                                              1.5,
                                      margin: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                          color:
                                              controller.currentPage.value == i
                                                  ? DeasyColor.kpYellow500
                                                  : DeasyColor.neutral400,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    )))
                                .values
                                .toList())),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                          child: BouncingWidget(
                            duration: Duration(milliseconds: 100),
                            scaleFactor: 1.5,
                            onPressed: () => controller.nextPage(),
                            child: CircleAvatar(
                                backgroundColor: DeasyColor.kpYellow500,
                                radius: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: DeasyColor.neutral000,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
