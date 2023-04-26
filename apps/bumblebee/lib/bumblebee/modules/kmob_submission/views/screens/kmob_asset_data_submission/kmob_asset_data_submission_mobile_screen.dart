import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_custom_paging/deasy_custom_paging.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_get_bpkb_ownership_status.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/controllers/bumblebee_kmob_asset_data_submission_controller.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/widgets/kmob_submission_text_field_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:kreditplus_deasy_mobile/core/utils/extensions.dart';
import 'package:select_dialog/select_dialog.dart';

class KMOBAssetDataSubmissionMobileScreen
    extends GetView<BumblebeeKMOBAssetDataSubmissionController> {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Container(
      color: DeasyColor.neutral50,
      child: ListView(
        shrinkWrap: true,
        controller: controller.listviewController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _formAssetDataWidget(context),
          _spaceWidget(),
          _nextButton(),
        ],
      ),
    );
  }

  Widget _formAssetDataWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: DeasyColor.neutral000,
      child: Obx(
        () => Form(
          autovalidateMode: controller.autoValidate.value,
          key: controller.formAssetDataKey,
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: DeasyTextView(
                  text: "Data Aset Konsumen",
                  fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
                  fontFamily: FontFamily.bold,
                ),
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Brand Kendaraan',
                hint: 'Pilih Brand Kendaraan',
                isNext: true,
                isReadOnly: true,
                widgetSuffix: Obx(() => controller.listBrandVisible.isTrue
                    ? Icon(
                        Icons.keyboard_arrow_up_outlined,
                        size: 34,
                        color: DeasyColor.neutral400,
                      )
                    : Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 34,
                        color: DeasyColor.neutral400,
                      )),
                onFieldTap: () {
                  controller.onTapBrand();
                },
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkValueEmpty(value, ContentConstant.brandCantBeNull);
                },
                controller: controller.vehicleBrandController,
              ),
              Obx(() => controller.listBrandVisible.value
                  ? _listItemBrand()
                  : SizedBox()),
              Obx(() => KMOBSubmissionTextFieldWidget(
                    title: 'Model Kendaraan',
                    hint: 'Pilih Model Kendaraan',
                    isNext: true,
                    widgetSuffix: Obx(() => controller.listModelVisible.isTrue
                        ? Icon(
                            Icons.keyboard_arrow_up_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )),
                    isEnabled: controller.isModelEnabled.value,
                    isReadOnly: true,
                    onFieldTap: () {
                      controller.onTapModel();
                    },
                    validation: (value) {
                      return controller.bumblebeeKmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.vehicleModelCantBeNull);
                    },
                    controller: controller.vehicleModelController,
                  )),
              Obx(() => controller.listModelVisible.value
                  ? _listItemModel()
                  : SizedBox()),
              Obx(() => KMOBSubmissionTextFieldWidget(
                    title: 'Tipe Kendaraan',
                    hint: 'Pilih Tipe Kendaraan',
                    isNext: true,
                    widgetSuffix: Obx(() => controller.listTypeVisible.isTrue
                        ? Icon(
                            Icons.keyboard_arrow_up_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )
                        : Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 34,
                            color: DeasyColor.neutral400,
                          )),
                    isEnabled: controller.isTypeEnabled.value,
                    isReadOnly: true,
                    onFieldTap: () {
                      controller.onTapType();
                    },
                    validation: (value) {
                      return controller.bumblebeeKmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.vehicleTypeCantBeNull);
                    },
                    controller: controller.vehicleTypeController,
                  )),
              Obx(() => controller.listTypeVisible.value
                  ? _listItemType()
                  : SizedBox()),
              KMOBSubmissionTextFieldWidget(
                title: 'Nilai Pencairan',
                hint: 'Rp ',
                isNumberOnly: true,
                onChange: (val) {
                  controller.onChangeDisbursedAmount(val);
                },
                isNext: true,
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkValueEmpty(
                          value, ContentConstant.disbursedAmountCantBeNull);
                },
                controller: controller.disbursedAmountController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Plat',
                hint: 'Contoh: B ',
                isNext: true,
                isReadOnly: true,
                onFieldTap: () {
                  _bottomSheetLicenseArea(context);
                },
                extraText: "Merupakan kode wilayah",
                isAlfabethOnly: true,
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkLicenseArea(value);
                },
                controller: controller.licenseAreaController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Nomor Kendaraan',
                hint: 'Contoh: 4356',
                isNext: true,
                extraText: ContentConstant.extraLicenseNumber,
                isNumberOnly: true,
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkLicenseNumber(value);
                },
                controller: controller.licenseNumberController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Kode',
                hint: 'Contoh: TZT',
                isNext: true,
                extraText: ContentConstant.extraTextCode,
                isAlfabethOnly: true,
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkLicenseCode(value);
                },
                controller: controller.licenseCodeController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Tahun Kendaraan',
                hint: 'Pilih Tahun Kendaraan',
                isNext: true,
                isReadOnly: true,
                isNumberOnly: true,
                onFieldTap: () {
                  _yearPicker(context);
                },
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkValueEmpty(
                          value, ContentConstant.licenseYearCantBeNull);
                },
                controller: controller.vehicleYearController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Nama Pada STNK',
                hint: 'Nama Pemilik pada STNK',
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkValueEmpty(value,
                          ContentConstant.vehicleRegistrationNameCantBeNull);
                },
                controller: controller.vehicleRegistrationNameController,
              ),
              KMOBSubmissionTextFieldWidget(
                title: 'Status Kepemilikan BPKB',
                hint: 'Pilih Status Kepemilikan BPKB',
                isReadOnly: true,
                widgetSuffix: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 34,
                  color: DeasyColor.neutral400,
                ),
                onFieldTap: () {
                  showDialogBpkpOwnerShipStatus();
                },
                validation: (value) {
                  return controller.bumblebeeKmobSubmissionController!
                      .checkValueEmpty(
                          value, ContentConstant.licenseStatusCantBeNull);
                },
                controller: controller.bpkbOwnerShipStatusController,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _spaceWidget() {
    return SizedBox(height: 10);
  }

  Widget _nextButton() {
    return Container(
      color: DeasyColor.neutral000,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DeasyCustomElevatedButton(
          text: "Selanjutnya",
          primary: DeasyColor.kpYellow500,
          textColor: DeasyColor.neutral000,
          paddingButton: 10,
          borderColor: DeasyColor.kpYellow500,
          onPress: () {
            controller.submit();
          },
        ),
      ),
    );
  }

  _yearPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Tahun Kendaraan'),
          content: Container(
            // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              selectedDate: DateTime(1997),
              firstDate: DateTime(1800),
              lastDate: DateTime.now(),
              onChanged: (val) {
                controller
                    .onChangeYearPicker(val)
                    .whenComplete(() => Get.back());
              },
            ),
          ),
        );
      },
    );
  }

  _listItemType() {
    return Container(
      color: DeasyColor.neutral000,
      height: 325,
      width: 400,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.kpBlue600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.kpBlue200),
                ),
                hintText: ContentConstant.typeToSearch,
                suffixIcon: Icon(Icons.search, color: DeasyColor.kpBlue600),
              ),
              controller: controller.searchTypeController,
              readOnly: false,
              onTap: () {
                controller.fetchApiType();
              },
              obscureText: false,
              onChanged: (String text) async {
                controller.onChangeFindType(text);
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: RefreshIndicator(
              onRefresh: controller.refreshType,
              child: Obx(
                () => DeasyCustomPaging(
                  whenEmptyLoad: false,
                  delegate: DefaultLoadMoreDelegate(),
                  isFinish: controller.isLoadMoreType.isFalse,
                  textBuilder: DefaultLoadMoreTextBuilder.english,
                  onLoadMore: controller.loadMoreType,
                  child: ListView.builder(
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => InkWell(
                            onTap: () => controller
                                .onTapTypeItem(controller.listType[index]),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: Text(controller.listType[index].typeName!),
                              height: 40.0,
                              alignment: Alignment.centerLeft,
                            ),
                          ));
                    },
                    itemCount: controller.listType.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listItemModel() {
    return Container(
      color: DeasyColor.neutral000,
      height: 325,
      width: 400,
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: TextField(
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.kpBlue600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.kpBlue200),
                ),
                hintText: ContentConstant.typeToSearch,
                suffixIcon: Icon(Icons.search, color: DeasyColor.kpBlue600),
              ),
              controller: controller.searchModelController,
              readOnly: false,
              onTap: () {
                controller.fetchApiModel();
              },
              obscureText: false,
              onChanged: (String text) async {
                controller.onChangeFindModel(text);
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: RefreshIndicator(
              onRefresh: controller.refreshModel,
              child: Obx(
                () => DeasyCustomPaging(
                  whenEmptyLoad: false,
                  delegate: DefaultLoadMoreDelegate(),
                  isFinish: controller.isLoadMoreModel.isFalse,
                  textBuilder: DefaultLoadMoreTextBuilder.english,
                  onLoadMore: controller.loadMoreModel,
                  child: ListView.builder(
                    primary: false,
                    itemBuilder: (BuildContext context, int index) {
                      return Obx(() => InkWell(
                            onTap: () {
                              controller
                                  .onTapModelItem(controller.listModel[index]);
                            },
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child:
                                  Text(controller.listModel[index].modelName!),
                              height: 40.0,
                              alignment: Alignment.centerLeft,
                            ),
                          ));
                    },
                    itemCount: controller.listModel.length,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _listItemBrand() {
    return Container(
        color: DeasyColor.neutral000,
        height: 325,
        width: 400,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextField(
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: DeasyColor.kpBlue600),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: DeasyColor.kpBlue200),
                  ),
                  hintText: ContentConstant.typeToSearch,
                  suffixIcon: Icon(Icons.search, color: DeasyColor.kpBlue600),
                ),
                controller: controller.searchBrandController,
                readOnly: false,
                onTap: () {
                  controller.fetchApiBrand();
                },
                obscureText: false,
                onChanged: (String text) async {
                  controller.onChangeFindBrand(text);
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: RefreshIndicator(
                onRefresh: controller.refreshBrand,
                child: Obx(() => DeasyCustomPaging(
                      whenEmptyLoad: false,
                      delegate: DefaultLoadMoreDelegate(),
                      isFinish: controller.isLoadMoreBrand.isFalse,
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                      onLoadMore: controller.loadMoreBrand,
                      child: ListView.builder(
                        primary: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Obx(() => InkWell(
                                onTap: () {
                                  controller.onTapBrandItem(
                                      controller.listBrand[index]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                      controller.listBrand[index].brandName!),
                                  height: 40.0,
                                  alignment: Alignment.centerLeft,
                                ),
                              ));
                        },
                        itemCount: controller.listBrand.length,
                      ),
                    )),
              ),
            ),
          ],
        ));
  }

  showDialogBpkpOwnerShipStatus() {
    SelectDialog.showModal<DataBpkbOwnerShipStatus>(
      Get.context!,
      items: controller.listBpkbOwnerShipStatus,
      backgroundColor: DeasyColor.neutral000,
      label: "Cari Status Kepemilikan BPKB",
      titleStyle: TextStyle(color: DeasyColor.neutral900),
      searchBoxDecoration: InputDecoration(
        hintText: 'Cari...',
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral600, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ),
      onFind: (String filter) => controller.filterLicenseStatus(filter),
      itemBuilder: (BuildContext context, DataBpkbOwnerShipStatus item,
          bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item.name!),
          ),
        );
      },
      onChange: (DataBpkbOwnerShipStatus result) {
        controller.onChangeBpkbOwnerShipStatus(result);
      },
    );
  }

  Future<dynamic> _bottomSheetLicenseArea(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          var child;
          return DraggableScrollableSheet(
            maxChildSize: 0.9,
            expand: false,
            builder: (_, dragableController) {
              if (child == null) {
                child = ListView(
                  physics: BouncingScrollPhysics(),
                  controller: dragableController,
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: 80,
                      height: 4,
                      margin: EdgeInsets.fromLTRB(37.w, 15, 37.w, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: DeasyColor.neutral200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: KMOBSubmissionTextFieldWidget(
                        title: 'Pilih Kode Area Plat Nomor',
                        titleSize: 16,
                        titleFontFamily: FontFamily.bold,
                        hint: ContentConstant.searchLicenseArea,
                        onChange: (value) {
                          controller.onChangeLicenseArea(value);
                        },
                        widgetSuffix: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            IconConstant.RESOURCES_ICON_SEARCH,
                            color: DeasyColor.neutral500,
                          ),
                        ),
                        controller: controller.searchPlatController,
                      ),
                    ),
                    Obx(() => controller.listLicenceArea.isBlank!
                        ? SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            controller: dragableController,
                            itemCount: controller.listLicenceArea.length,
                            itemBuilder: (_, indexRegion) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 16),
                              child: _chipLicenseArea(
                                  controller.listLicenceArea[indexRegion]),
                            ),
                          )),
                  ],
                );
              }
              return child;
            },
          );
        });
  }

  Widget _chipLicenseArea(LicenceAreaModel modelPoliceNo) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DeasyTextView(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            text: "${modelPoliceNo.region}",
            fontFamily: FontFamily.light),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: List.generate(modelPoliceNo.policeNoList!.length, (index) {
            bool isSelected = controller
                .isChipSelected(modelPoliceNo.policeNoList![index].policeNo);
            return InkWell(
              onTap: () {
                controller.onTapChipPlatNo(
                    modelPoliceNo.policeNoList![index].policeNo!);
              },
              child: Chip(
                side: BorderSide(
                    color: isSelected
                        ? DeasyColor.kpYellow500
                        : DeasyColor.neutral200),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                label: DeasyTextView(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    fontColor: isSelected
                        ? DeasyColor.neutral000
                        : DeasyColor.neutral400,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    text: "${modelPoliceNo.policeNoList![index].policeNo}",
                    fontFamily: FontFamily.bold),
                backgroundColor:
                    isSelected ? DeasyColor.kpYellow500 : DeasyColor.neutral000,
              ),
            );
          }),
        ),
      ],
    );
  }
}
