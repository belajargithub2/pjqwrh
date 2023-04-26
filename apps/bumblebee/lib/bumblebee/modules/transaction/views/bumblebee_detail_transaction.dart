import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_detail_transaction_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/indicator.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/routes/bumblebee_app_routes.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_animation/deasy_animation.dart';

class BumblebeeDetailTransaction
    extends GetView<BumblebeeDetailTransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: DeasyColor.neutral900,
            ),
            onPressed: () => Get.back()),
        title: Text(
          ContentConstant.detail,
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: DeasyColor.neutral000,
      ),
      body: Obx(() => SingleChildScrollView(
            child: Container(
              color: DeasyColor.neutral50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: controller.checkShowIndicator(),
                    child: SideInAnimation(
                        delay: 1,
                        child: Indicator(
                          index: controller.getIndex(),
                          isAgent: controller.role.value
                              .isContainIgnoreCase(ContentConstant.ROLE_AGENT),
                        )),
                  ),
                  SideInAnimation(
                    delay: 2,
                    child: Container(
                      color: DeasyColor.kpBlue500,
                      width: DeasySizeConfigUtils.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '${ContentConstant.orderId}: ${controller.transaction!.prospectId}',
                          style: TextStyle(
                              color: DeasyColor.neutral000,
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 2.3),
                        ),
                      ),
                    ),
                  ),
                  SideInAnimation(delay: 3, child: controller.setStatus()),
                  Container(
                    width: double.infinity,
                    color: DeasyColor.neutral000,
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: controller.role.value
                            .isContainIgnoreCase(ContentConstant.ROLE_AGENT)
                        ? agentColumn()
                        : merchantColumn(
                            dateTime: controller.transaction!.orderDate!,
                            payToDealerAmount:
                                controller.transaction!.payToDealerAmount !=
                                        null
                                    ? controller.transaction!.payToDealerAmount
                                        .toString()
                                        .toRupiah()
                                    : '0'),
                  ),
                  SizedBox(height: DeasySizeConfigUtils.screenHeight! * 0.02),
                  SideInAnimation(
                    delay: 6,
                    child: Container(
                        width: double.infinity,
                        color: DeasyColor.neutral000,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: controller.role.value
                                .isContainIgnoreCase(ContentConstant.ROLE_AGENT)
                            ? assetColumn()
                            : transactionColumn(context)),
                  ),
                  Visibility(
                    visible: controller.checkCancelOrder(),
                    child: Container(
                      width: DeasySizeConfigUtils.screenWidth,
                      margin: EdgeInsets.all(10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: DeasyColor.kpYellow500,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            Get.toNamed(BumblebeeRoutes.CANCEL_TRANSACTION,
                                arguments: {
                                  "prospectId":
                                      controller.transaction!.prospectId
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              ContentConstant.cancelOrderDetailButtonText,
                              style: TextStyle(
                                  color: DeasyColor.neutral000,
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 2.5),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget agentColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ContentConstant.orderDate,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 3,
          child: Text(
            controller.getOrderDate(),
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          ContentConstant.consumerName,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.customerNameAgent.value}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          ContentConstant.dashboardTableHeaderTextDisbursement,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentDisbursedAmount.toString().toRupiah()}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          ContentConstant.marketingProgram,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentProductOfferingName}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          ContentConstant.agentFee,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentFee.toString().toRupiah()}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget merchantColumn(
      {required DateTime dateTime, required String payToDealerAmount}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ContentConstant.date,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 3,
          child: Text(
            '${DateFormat(DateConstant.dateFormat4).format(dateTime)}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          ContentConstant.price,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            payToDealerAmount,
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget transactionColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ContentConstant.viewReports,
          style: TextStyle(
              color: DeasyColor.neutral900,
              fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Visibility(
          visible: controller.hasPOAccess.isTrue,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                controller.fetchDocument(ContentConstant.PO);
              },
              child: Row(
                children: [
                  Visibility(
                      visible: controller.isNotEmptyPO.isTrue,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            '${IconConstant.RESOURCES_ICON_PATH}ic_done.svg',
                          )
                        ],
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    ContentConstant.PO,
                    style: TextStyle(
                        fontSize: DeasySizeConfigUtils.blockVertical * 2),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: DeasyColor.neutral900,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.documentAccessList.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {
                  controller.fetchDocument(controller.documentAccessList[i]);
                },
                child: Row(
                  children: [
                    Visibility(
                        visible: controller.isDocumentAvailable(
                            controller.documentAccessList[i]),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              '${IconConstant.RESOURCES_ICON_PATH}ic_done.svg',
                            )
                          ],
                        )),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      controller.documentAccessList[i],
                      style: TextStyle(
                          fontSize: DeasySizeConfigUtils.blockVertical * 2),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: DeasyColor.neutral900,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Visibility(
          visible: controller.hasInvoiceAccess.isTrue,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: InkWell(
              onTap: () {
                controller.fetchDocument(ContentConstant.INVOICE);
              },
              child: Row(
                children: [
                  Visibility(
                      visible: controller.isNotEmptyInvoice.isTrue,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          SvgPicture.asset(
                            '${IconConstant.RESOURCES_ICON_PATH}ic_done.svg',
                          )
                        ],
                      )),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    ContentConstant.INVOICE,
                    style: TextStyle(
                        fontSize: DeasySizeConfigUtils.blockVertical * 2),
                  ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: DeasyColor.neutral900,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget assetColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ContentConstant.assetData,
          style: TextStyle(
              color: DeasyColor.neutral900,
              fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 25),
        Text(
          ContentConstant.vehicleBrand,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentBrand}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
        Text(
          ContentConstant.vehicleModel,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentModel}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
        Text(
          ContentConstant.vehicleType,
          style: TextStyle(
              color: DeasyColor.neutral400,
              fontSize: DeasySizeConfigUtils.blockVertical * 2),
        ),
        SizedBox(height: 8),
        SideInAnimation(
          delay: 5,
          child: Text(
            '${controller.agentType}',
            style: TextStyle(
                color: DeasyColor.neutral600,
                fontSize: DeasySizeConfigUtils.blockVertical * 2.2,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
