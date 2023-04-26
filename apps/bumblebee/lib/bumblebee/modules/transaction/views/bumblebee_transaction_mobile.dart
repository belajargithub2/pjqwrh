import 'dart:io';

import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_transaction_mobile_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/widget/empty_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/decoration.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/no_internet/connection_checker_widget.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BumblebeeTransactionMobile
    extends GetView<BumblebeeTransactionMobileController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BumblebeeTransactionMobileController>(
        init: BumblebeeTransactionMobileController(),
        builder: (c) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
              value: baseSystemUiOverlayStyle(),
              child: RefreshIndicator(
                onRefresh: () => c.refreshTransactionPage(),
                child: ConnectionCheckerWidget(
                  onRefresh: () => c.refreshTransactionPage(),
                  child: SafeArea(
                      child: Scaffold(
                          resizeToAvoidBottomInset: false,
                          key: c.scaffoldKey,
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            elevation: 2,
                            backgroundColor: DeasyColor.neutral000,
                            title: Obx(() => c.isSearching.isTrue
                                ? _buildSearchField(c)
                                : _buildTitle(context, c)),
                            actions: [
                              Obx(() => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          c.isSearching.isTrue ? 0 : 12.0),
                                  child: c.isSearching.isTrue
                                      ? SizedBox()
                                      : IconButton(
                                          icon: SvgPicture.asset(
                                              "${IconConstant.RESOURCES_ICON_PATH}ic_search.svg"),
                                          onPressed: () {
                                            c.startSearch(context);
                                          },
                                        )))
                            ],
                          ),
                          body: Container(
                            width: DeasySizeConfigUtils.screenWidth,
                            height: DeasySizeConfigUtils.screenHeight,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16.0, horizontal: 24.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: DeasyColor.kpBlue200),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: SideInAnimation(
                                              delay: 1,
                                              child: ElevatedButton.icon(
                                                  icon: Icon(
                                                    Icons.date_range,
                                                    color:
                                                        DeasyColor.neutral900,
                                                    size: 24.0,
                                                  ),
                                                  label: Text('Tanggal'),
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            backgroundColor:
                                                                DeasyColor
                                                                    .neutral000,
                                                            actions: <Widget>[
                                                              Container(
                                                                height: 30,
                                                                child:
                                                                    MaterialButton(
                                                                  color: DeasyColor
                                                                      .semanticInfo300,
                                                                  child: Text(
                                                                    'Kembali',
                                                                    style: TextStyle(
                                                                        color: DeasyColor
                                                                            .neutral000),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Get.back();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                            content: Container(
                                                              height: 300,
                                                              width: 300,
                                                              child: Theme(
                                                                data: ThemeData(
                                                                  primaryColor:
                                                                      DeasyColor
                                                                          .neutral000,
                                                                ),
                                                                child: Obx(() =>
                                                                    SfDateRangePicker(
                                                                      initialSelectedDate: DateTime(
                                                                          c.year
                                                                              .value,
                                                                          c.month
                                                                              .value,
                                                                          c.day
                                                                              .value),
                                                                      onSelectionChanged:
                                                                          (args) {
                                                                        c.onSelectionChanged(
                                                                            args,
                                                                            context);
                                                                      },
                                                                      minDate: c
                                                                          .minDate
                                                                          .value,
                                                                      maxDate: c
                                                                          .maxDate
                                                                          .value,
                                                                      selectionMode:
                                                                          DateRangePickerSelectionMode
                                                                              .extendableRange,
                                                                    )),
                                                              ),
                                                            ),
                                                          );
                                                        });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: c
                                                                  .dateFilter
                                                                  .value
                                                                  .isNotEmpty
                                                              ? DeasyColor
                                                                  .neutral400
                                                              : DeasyColor
                                                                  .neutral50,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          elevation: 0,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      7))),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Obx(() => Expanded(
                                                child: SideInAnimation(
                                                  delay: 2,
                                                  child: ElevatedButton.icon(
                                                      icon: Icon(
                                                        Icons.filter_list,
                                                        color: DeasyColor
                                                            .neutral900,
                                                        size: 24.0,
                                                      ),
                                                      label: Text('Filter'),
                                                      onPressed: () {
                                                        c.changeStatusFilter();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              primary: c.isFilter
                                                                      .isTrue
                                                                  ? DeasyColor
                                                                      .neutral400
                                                                  : DeasyColor
                                                                      .neutral50,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                              elevation: 0,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          7))),
                                                ),
                                              )),
                                        ],
                                      ),
                                      Obx(() => Visibility(
                                            visible:
                                                c.dateFilter.value.isNotEmpty,
                                            child: Container(
                                              width: DeasySizeConfigUtils
                                                      .screenWidth! /
                                                  1.5,
                                              child: InkWell(
                                                onTap: () {
                                                  c.removeDate(context);
                                                },
                                                child: Card(
                                                  color: DeasyColor.neutral000,
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.close,
                                                          color: DeasyColor
                                                              .neutral900,
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                                '${c.dateFilter.value}',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                      SizedBox(height: 10),
                                      Obx(() => Visibility(
                                            visible: c.isFilter.value &&
                                                    c.listFilter.length > 0
                                                ? true
                                                : false,
                                            child: Container(
                                              width: DeasySizeConfigUtils
                                                  .screenWidth,
                                              height: DeasySizeConfigUtils
                                                      .screenHeight! *
                                                  0.07,
                                              child: Row(
                                                children: [
                                                  Visibility(
                                                    visible: c
                                                        .listSelectedStatus
                                                        .isNotEmpty,
                                                    child: InkWell(
                                                      onTap: () {
                                                        c.filterByStatus(
                                                            context, "clear");
                                                      },
                                                      child: Card(
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        color: DeasyColor
                                                            .neutral50,
                                                        child: Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        6,
                                                                    vertical:
                                                                        4),
                                                            child: Icon(
                                                                Icons.close,
                                                                color: DeasyColor
                                                                    .neutral900,
                                                                size: 30)),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        itemCount:
                                                            c.listFilter.length,
                                                        itemBuilder:
                                                            (context, i) {
                                                          return Obx(
                                                              () => InkWell(
                                                                    onTap: () {
                                                                      c.filterByStatus(
                                                                          context,
                                                                          c.listFilter[i]
                                                                              .id);
                                                                    },
                                                                    child: Card(
                                                                      elevation:
                                                                          0,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        side: c.listSelectedStatus.contains(c.listFilter[i].id)
                                                                            ? BorderSide(
                                                                                width: 1,
                                                                                color: c.listFilter[i].textColor!)
                                                                            : BorderSide.none,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.0),
                                                                      ),
                                                                      color: c
                                                                          .listFilter[
                                                                              i]
                                                                          .bgColor,
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                DeasySizeConfigUtils.blockHorizontal! * 4.3),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            SvgPicture.asset('${c.listFilter[i].image}',
                                                                                width: DeasySizeConfigUtils.blockVertical * 2,
                                                                                height: DeasySizeConfigUtils.blockVertical * 2),
                                                                            SizedBox(width: DeasySizeConfigUtils.blockHorizontal! * 2),
                                                                            Text(
                                                                              ' ${c.listFilter[i].name}',
                                                                              style: TextStyle(color: c.listFilter[i].textColor, fontWeight: FontWeight.bold),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ));
                                                        }),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 16),
                                      color: DeasyColor.neutral50,
                                      child: Obx(() => bodyWidget(c))),
                                )
                              ],
                            ),
                          ))),
                ),
              ));
        });
  }

  Widget bodyWidget(BumblebeeTransactionMobileController c) {
    if (c.isLoading.isTrue) {
      return loadingSpinner();
    } else if (c.listTransaction.isEmpty) {
      return SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: DeasySizeConfigUtils.blockVertical * 7),
              EmptyWidget(isAgent: c.isAgent.value),
            ],
          ));
    } else {
      return contentContainer(c);
    }
  }

  Widget loadingSpinner() {
    return AbsorbPointer(
      absorbing: true,
      child: FullScreenSpinner(),
    );
  }

  Widget contentContainer(BumblebeeTransactionMobileController c) {
    return ListView.builder(
      controller: c.scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: c.listTransaction.length,
      itemBuilder: (context, i) {
        if (i == c.listTransaction.length - 1 &&
            c.index.value.isLowerThan(c.lastPage.value)) {
          return const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Container(
          width: DeasySizeConfigUtils.screenWidth,
          margin: EdgeInsets.only(bottom: 8),
          child: Card(
            color: DeasyColor.neutral000,
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              width: DeasySizeConfigUtils.screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${DateFormat('dd MMM yyyy').format(c.listTransaction[i].orderDate!)}',
                                style: TextStyle(
                                    color: DeasyColor.neutral600,
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            1.3),
                              ),
                              Text('${c.listTransaction[i].prospectId}',
                                  style: TextStyle(
                                    color: c.isAgent.isTrue
                                        ? DeasyColor.kpBlue500
                                        : DeasyColor.kpBlue500,
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            1.5,
                                  )),
                            ],
                          ),
                        ),
                        c.listTransaction.length > 0
                            ? setStatus(c.listTransaction[i].orderStatus)
                            : SizedBox()
                      ],
                    ),
                  ),
                  Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: DeasySizeConfigUtils.screenWidth! * 0.65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.listTransaction[i].customerName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize:
                                      DeasySizeConfigUtils.blockVertical * 2.1,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                c.listTransaction[i].payToDealerAmount != null
                                    ? '${c.listTransaction[i].payToDealerAmount.toString().toRupiah()}'
                                    : '-',
                                style: TextStyle(
                                    fontSize:
                                        DeasySizeConfigUtils.blockVertical *
                                            2.1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerRight,
                          icon: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: DeasyColor.neutral400,
                            size: DeasySizeConfigUtils.blockVertical * 3.7,
                          ),
                          onPressed: () {
                            c.navigateToDetail(
                                c.listTransaction[i], c.isMerchantOnline.value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle(
      BuildContext context, BumblebeeTransactionMobileController c) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    return new InkWell(
      onTap: () {
        c.scaffoldKey.currentState!.openDrawer();
      },
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            Text(
              c.isAgent.isTrue ? 'Laporan Order' : 'Laporan Transaksi',
              style: TextStyle(
                  color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(BumblebeeTransactionMobileController c) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DeasyColor.neutral800,
              ),
              onPressed: () {
                c.stopSearching();
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16.0),
                decoration: BoxDecoration(
                  color: DeasyColor.neutral50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textAlignVertical: TextAlignVertical.top,
                        controller: c.searchController,
                        onChanged: (value) {
                          c.findTransaction(value);
                        },
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: DeasyColor.neutral600),
                        ),
                        style: TextStyle(
                            color: DeasyColor.neutral900, fontSize: 16.0),
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: c.searchQuery.isNotEmpty,
                        child: IconButton(
                          icon: SvgPicture.asset(
                              "${IconConstant.RESOURCES_ICON_PATH}ic_clear.svg"),
                          onPressed: () {
                            c.clearSearch();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  Widget setStatus(EnumOrderTransaction? orderStatus) {
    switch (orderStatus) {
      case EnumOrderTransaction.purchaseConfirmed:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.kpBlue50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_purchase_confirm.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.purchaseConfirmed.name,
                    style: TextStyle(
                        color: DeasyColor.kpBlue500,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.disbursed:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.sally50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_melted.svg'),
                  SizedBox(width: 8),
                  Text(
                    controller.isAgent.isTrue
                        ? EnumOrderTransaction.goLive.name
                        : EnumOrderTransaction.disbursed.name,
                    style: TextStyle(
                        color: DeasyColor.sally900,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.canceled:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.neutral50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_cancel.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.canceled.name,
                    style: TextStyle(
                        color: DeasyColor.neutral400,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.cancelRequest:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.neutral50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_request_cancel.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.cancelRequest.name,
                    style: TextStyle(
                        color: DeasyColor.neutral800,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.rejected:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.dmsFFF1F1,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_reject.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.rejected.name,
                    style: TextStyle(
                        color: DeasyColor.dmsF46363,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.onProgress:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.kpYellow50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_process.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.onProgress.name,
                    style: TextStyle(
                        color: DeasyColor.kpYellow500,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      case EnumOrderTransaction.approved:
        {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            color: DeasyColor.dmsEBFFF2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 18),
              child: Row(
                children: [
                  SvgPicture.asset(
                      '${IconConstant.RESOURCES_ICON_PATH}ic_approve.svg'),
                  SizedBox(width: 8),
                  Text(
                    EnumOrderTransaction.approved.name,
                    style: TextStyle(
                        color: DeasyColor.dms2ED477,
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.5,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        }
      default:
        {
          return Text('');
        }
    }
  }
}
