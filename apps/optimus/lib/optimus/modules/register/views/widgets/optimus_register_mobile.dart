import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/controllers/optimus_register_merchant_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/base_widget.dart';
import 'package:deasy_animation/deasy_animation.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:select_dialog/select_dialog.dart';

// import 'package:kreditplus_deasy_website/core/model/location/response_city.dart'
//     as city;
// import 'package:kreditplus_deasy_website/core/model/location/response_province.dart'
//     as province;
// import 'package:kreditplus_deasy_website/core/model/location/response_district.dart'
//     as district;
// import 'package:kreditplus_deasy_website/core/model/location/response_villages.dart'
//     as village;
// import 'package:kreditplus_deasy_website/core/model/user/merchant_type_response_model.dart'
//     as merchantType;

import 'package:deasy_models/deasy_models.dart';

class OptimusRegisterMobileWeb
    extends GetView<OptimusRegisterMerchantController> {
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: DeasyColor.neutral000,
        elevation: 0,
        leading: IconButton(
            onPressed: Get.back,
            icon: Icon(
              Icons.arrow_back,
              color: DeasyColor.neutral900,
            )),
        title: Text(
          'Registrasi Merchant',
          style: TextStyle(
              color: DeasyColor.neutral900, fontWeight: FontWeight.bold),
        ),
      ),
      body: BaseWidget(
        child: Container(
            width: DeasySizeConfigUtils.screenWidth,
            height: DeasySizeConfigUtils.screenHeight,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Obx(() => Form(
                  key: _formKey,
                  autovalidateMode: controller.autoValidate.value,
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Isi Supplier ID',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                            delay: 1,
                            child: CustomOutlineTextInputWithoutLabel(
                              borderRadius: 8,
                              isRequired: true,
                              myKey: Key('supplierIdkey'),
                              onChange: (val) {},
                              focusNode: controller.focusSupplierId,
                              text: "Supplier ID",
                              controller: controller.supplierIdController,
                              customValidatorMethod: (val) =>
                                  controller.supplierIdValidator(val!),
                            ),
                          ),
                          Text(
                            'Catatan : Pastikan  Supplier ID anda benar.',
                            style: TextStyle(color: DeasyColor.neutral900),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Tipe Merchant',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                            delay: 1,
                            child: CustomOutlineTextInputWithoutLabel(
                              borderRadius: 8,
                              isRequired: true,
                              myKey: Key('supplierTypeKey'),
                              onChange: () {},
                              text: "Tipe merchant",
                              isReadOnly: true,
                              widgetSuffix: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black,
                                  size: 20.0),
                              controller: controller.supplierTypeController,
                              onFieldTap: () {
                                SelectDialog.showModal<MerchantTypeData>(
                                  context,
                                  items: controller.listMerchantType.value,
                                  backgroundColor: DeasyColor.neutral000,
                                  showSearchBox: false,
                                  label: 'Tipe Merchant',
                                  onChange: (MerchantTypeData result) {
                                    controller.selectMerchantType(result.text!);
                                  },
                                  itemBuilder: (BuildContext context,
                                      MerchantTypeData item, bool isSelected) {
                                    return Container(
                                      child: ListTile(
                                        selected: isSelected,
                                        title: Text(item.text!),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Nama User',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                            delay: 1,
                            child: CustomOutlineTextInputWithoutLabel(
                              borderRadius: 8,
                              onChange: (val) {},
                              text: "Nama User",
                              controller: controller.usernameController,
                              customValidatorMethod: (val) => val
                                  .userNameValidator(
                                      msgUserNameCantBeEmpty:
                                          ContentConstant.userNameCantBeNull,
                                      msgUserNameCantContainSpecialChar:
                                          ContentConstant
                                              .userNameCantContainSpecialChar),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Nomor Handphone',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                            delay: 1,
                            child: CustomOutlineTextInputWithoutLabel(
                              borderRadius: 8,
                              onChange: (val) {},
                              text: "Nomor Handphone",
                              hint: "Contoh: 08123456788",
                              isNumberOnly: true,
                              controller: controller.phoneNumberController,
                              customValidatorMethod: (val) =>
                                  controller.phoneValidator(val!),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Email',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8,
                                onChange: (val) {},
                                text: "Email",
                                hint: "Contoh: finansia@email.com",
                                controller: controller.emailController,
                                customValidatorMethod: (val) =>
                                    val.emailValidator(
                                        msgEmailCantBeEmpty:
                                            ContentConstant.emailCantBeEmpty,
                                        msgEmailNotValid: ValidationConstant
                                            .emailNotValid.capitalizeFirst!),
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Provinsi',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8,
                                isReadOnly: true,
                                onFieldTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  SelectDialog.showModal<ProvinceDatum>(
                                    context,
                                    items: controller.listProvince,
                                    backgroundColor: DeasyColor.neutral000,
                                    label: ContentConstant.searchByProvince,
                                    titleStyle:
                                        TextStyle(color: DeasyColor.neutral900),
                                    searchBoxDecoration: InputDecoration(
                                      hintText: 'Cari...',
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                    onFind: (String filter) =>
                                        controller.filterListProvince(filter),
                                    itemBuilder: (BuildContext context,
                                        ProvinceDatum item, bool isSelected) {
                                      return Container(
                                        child: ListTile(
                                          selected: isSelected,
                                          title: Text(item.name!),
                                        ),
                                      );
                                    },
                                    emptyBuilder: (BuildContext context) {
                                      return Center(
                                        child: Text(
                                          ContentConstant.provinsiNotFound,
                                        ),
                                      );
                                    },
                                    onChange: (ProvinceDatum result) {
                                      controller.provinceController.text =
                                          result.name!;
                                      controller.getCity(result.code);
                                    },
                                  );
                                },
                                onChange: (val) {},
                                text: "Provinsi",
                                widgetSuffix: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 20.0),
                                controller: controller.provinceController,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Kota/Kabupaten',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8,
                                onChange: (val) {},
                                widgetSuffix: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 20.0),
                                text: "Kota/Kabupaten",
                                isReadOnly: true,
                                onFieldTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  SelectDialog.showModal<CityDatum>(
                                    context,
                                    items: controller.listCity,
                                    backgroundColor: DeasyColor.neutral000,
                                    label: "",
                                    titleStyle:
                                        TextStyle(color: DeasyColor.neutral900),
                                    searchBoxDecoration: InputDecoration(
                                      hintText: 'Cari...',
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                    onFind: (String filter) =>
                                        controller.filterListCity(filter),
                                    itemBuilder: (BuildContext context,
                                        CityDatum item, bool isSelected) {
                                      return Container(
                                        child: ListTile(
                                          selected: isSelected,
                                          title: Text(item.name!),
                                        ),
                                      );
                                    },
                                    emptyBuilder: (BuildContext context) {
                                      return Center(
                                        child: Text(
                                          ContentConstant.kotaNotFound,
                                        ),
                                      );
                                    },
                                    onChange: (CityDatum result) {
                                      controller.cityController.text =
                                          result.name!;
                                      controller.getDistrict(result.code);
                                    },
                                  );
                                },
                                controller: controller.cityController,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Kecamatan',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8,
                                isReadOnly: true,
                                onChange: (val) {},
                                onFieldTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  SelectDialog.showModal<DistrictDatum>(
                                    context,
                                    items: controller.listDistrict,
                                    backgroundColor: DeasyColor.neutral000,
                                    label: "",
                                    titleStyle:
                                        TextStyle(color: DeasyColor.neutral900),
                                    searchBoxDecoration: InputDecoration(
                                      hintText: 'Cari...',
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                    onFind: (String filter) =>
                                        controller.filterListDistrict(filter),
                                    itemBuilder: (BuildContext context,
                                        DistrictDatum item, bool isSelected) {
                                      return Container(
                                        child: ListTile(
                                          selected: isSelected,
                                          title: Text(item.name!),
                                        ),
                                      );
                                    },
                                    emptyBuilder: (BuildContext context) {
                                      return Center(
                                        child: Text(
                                          ContentConstant.kecamatanNotFound,
                                        ),
                                      );
                                    },
                                    onChange: (DistrictDatum result) {
                                      controller.districtController.text =
                                          result.name!;
                                      controller.getVillage(result.code);
                                    },
                                  );
                                },
                                text: "Kecamatan",
                                widgetSuffix: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 20.0),
                                controller: controller.districtController,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Kelurahan',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8,
                                onChange: (val) {},
                                isReadOnly: true,
                                onFieldTap: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  SelectDialog.showModal<VillageDatum>(
                                    context,
                                    items: controller.listVillage,
                                    backgroundColor: DeasyColor.neutral000,
                                    label: "",
                                    titleStyle:
                                        TextStyle(color: DeasyColor.neutral900),
                                    searchBoxDecoration: InputDecoration(
                                      hintText: 'Cari...',
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: DeasyColor.neutral600,
                                            width: 0.0),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                    ),
                                    onFind: (String filter) =>
                                        controller.filterListVillage(filter),
                                    itemBuilder: (BuildContext context,
                                        VillageDatum item, bool isSelected) {
                                      return Container(
                                        child: ListTile(
                                          selected: isSelected,
                                          title: Text(item.name!),
                                        ),
                                      );
                                    },
                                    emptyBuilder: (BuildContext context) {
                                      return Center(
                                        child: Text(
                                          ContentConstant.kelurahanNotFound,
                                        ),
                                      );
                                    },
                                    onChange: (VillageDatum result) {
                                      controller.villageController.text =
                                          result.name!;
                                      controller.zipCodeController.text =
                                          result.postCode.toString();
                                    },
                                  );
                                },
                                widgetSuffix: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Colors.black,
                                    size: 20.0),
                                text: "Kelurahan",
                                controller: controller.villageController,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'RT/RW',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child:
                                                    CustomOutlineTextInputWithoutLabel(
                                                  borderRadius: 8,
                                                  widgetSuffix: null,
                                                  isNumberOnly: true,
                                                  onChange: (val) {},
                                                  text: "RT",
                                                  customValidatorMethod:
                                                      (val) => controller
                                                          .rtValidator(val!),
                                                  controller:
                                                      controller.rtController,
                                                ),
                                              ),
                                              Text(' / '),
                                              Expanded(
                                                flex: 1,
                                                child:
                                                    CustomOutlineTextInputWithoutLabel(
                                                  borderRadius: 8,
                                                  onChange: (val) {},
                                                  text: "RW",
                                                  isNumberOnly: true,
                                                  customValidatorMethod:
                                                      (val) => controller
                                                          .rwValidator(val!),
                                                  controller:
                                                      controller.rwController,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Kode Pos',
                            style: TextStyle(
                                color: DeasyColor.neutral900,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: CustomOutlineTextInputWithoutLabel(
                                borderRadius: 8.0,
                                isNext: false,
                                isRequired: true,
                                isNumberOnly: true,
                                onChange: (val) {},
                                isReadOnly: true,
                                text: "Kode Pos",
                                controller: controller.zipCodeController,
                              )),
                          SizedBox(
                            height: 15,
                          ),
                          FadeInAnimation(
                              delay: 1,
                              child: DeasyCustomElevatedButton(
                                text: "Registrasi",
                                primary: DeasyColor.kpYellow500,
                                textColor: DeasyColor.neutral000,
                                paddingButton: 10,
                                borderColor: DeasyColor.kpYellow500,
                                onPress: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.submit();
                                  } else {
                                    controller.autoValidate.value =
                                        AutovalidateMode.always;
                                  }
                                },
                              )),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      )),
                ))),
      ),
    );
  }
}
