import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:kreditplus_deasy_website/optimus/modules/register/controllers/optimus_register_merchant_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/routes/optimus_app_routes.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:deasy_models/deasy_models.dart';

class OptimusRegisterCard extends GetView<OptimusRegisterMerchantController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Container(
      width: DeasySizeConfigUtils.screenWidth,
      height: DeasySizeConfigUtils.screenHeight,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: Form(
        key: _formKey,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: Get.back,
                  icon: Icon(
                    Icons.arrow_back,
                    color: DeasyColor.neutral900,
                  )
                ),
                SizedBox(
                  width: 2.08.w,
                ),
                DeasyTextView(
                  text: ContentConstant.registerMerchant,
                  fontFamily: FontFamily.bold,
                  fontSize: 1.66.w,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Isi Supplier ID',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    focusNode: controller.focusSupplierId,
                    text: "Supplier ID",
                    controller: controller.supplierIdController,
                    customValidatorMethod: (val) =>
                        controller.supplierIdValidator(val!),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Catatan : Pastikan  Supplier ID anda benar.',
                      style: TextStyle(color: DeasyColor.neutral900),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Tipe Merchant',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    text: "Tipe Merchant",
                    isReadOnly: true,
                    controller: controller.supplierTypeController,
                    widgetSuffix: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20.0),
                    onFieldTap: () {
                      SelectDialog.showModal<MerchantTypeData>(
                        context,
                        items: controller.listMerchantType.value,
                        backgroundColor: DeasyColor.neutral000,
                        label: 'Tipe Merchant',
                        showSearchBox: false,
                        titleStyle: TextStyle(color: DeasyColor.neutral900),
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
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Nama User',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    text: "Nama User",
                    controller: controller.usernameController,
                    customValidatorMethod: (val) => val.userNameValidator(
                        msgUserNameCantBeEmpty:
                            ContentConstant.userNameCantBeNull,
                        msgUserNameCantContainSpecialChar:
                            ContentConstant.userNameCantContainSpecialChar),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Nomor Handphone',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    text: "Contoh: 08123456788",
                    isNumberOnly: true,
                    controller: controller.phoneNumberController,
                    isRequired: false,
                    customValidatorMethod: (val) =>
                        controller.phoneValidator(val!),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Email',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    text: "Email",
                    hint: "Contoh: finansia@email.com",
                    controller: controller.emailController,
                    customValidatorMethod: (val) => val.emailValidator(
                        msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                        msgEmailNotValid:
                            ValidationConstant.emailNotValid.capitalizeFirst!),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Provinsi',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    isReadOnly: true,
                    onFieldTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      SelectDialog.showModal<ProvinceDatum>(
                        context,
                        items: controller.listProvince,
                        backgroundColor: DeasyColor.neutral000,
                        label: ContentConstant.searchByProvince,
                        titleStyle: TextStyle(color: DeasyColor.neutral900),
                        searchBoxDecoration: InputDecoration(
                          hintText: 'Cari...',
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onFind: (String filter) =>
                            controller.filterListProvince(filter),
                        itemBuilder: (BuildContext context, ProvinceDatum item,
                            bool isSelected) {
                          return Container(
                            child: ListTile(
                              selected: isSelected,
                              title: Text(item.name!),
                            ),
                          );
                        },
                        emptyBuilder: (BuildContext context) {
                          return Center(
                              child: Text(ContentConstant.provinsiNotFound));
                        },
                        onChange: (ProvinceDatum result) {
                          controller.provinceController.text = result.name!;
                          controller.getCity(result.code);
                        },
                      );
                    },
                    onChange: (val) {},
                    text: "Provinsi",
                    widgetSuffix: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20.0),
                    controller: controller.provinceController,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '   Kota/Kabupaten',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    widgetSuffix: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20.0),
                    text: "Kota/Kabupaten",
                    isReadOnly: true,
                    onFieldTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      SelectDialog.showModal<CityDatum>(
                        context,
                        items: controller.listCity,
                        backgroundColor: DeasyColor.neutral000,
                        label: "",
                        titleStyle: TextStyle(color: DeasyColor.neutral900),
                        searchBoxDecoration: InputDecoration(
                          hintText: 'Cari...',
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onFind: (String filter) =>
                            controller.filterListCity(filter),
                        itemBuilder: (BuildContext context, CityDatum item,
                            bool isSelected) {
                          return Container(
                            child: ListTile(
                              selected: isSelected,
                              title: Text(item.name!),
                            ),
                          );
                        },
                        emptyBuilder: (BuildContext context) {
                          return Center(
                              child: Text(ContentConstant.kotaNotFound));
                        },
                        onChange: (CityDatum result) {
                          controller.cityController.text = result.name!;
                          controller.getDistrict(result.code);
                        },
                      );
                    },
                    controller: controller.cityController,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Kecamatan',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    isReadOnly: true,
                    onChange: (val) {},
                    onFieldTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      SelectDialog.showModal<DistrictDatum>(
                        context,
                        items: controller.listDistrict,
                        backgroundColor: DeasyColor.neutral000,
                        label: "",
                        titleStyle: TextStyle(color: DeasyColor.neutral900),
                        searchBoxDecoration: InputDecoration(
                          hintText: 'Cari...',
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onFind: (String filter) =>
                            controller.filterListDistrict(filter),
                        itemBuilder: (BuildContext context, DistrictDatum item,
                            bool isSelected) {
                          return Container(
                            child: ListTile(
                              selected: isSelected,
                              title: Text(item.name!),
                            ),
                          );
                        },
                        emptyBuilder: (BuildContext context) {
                          return Center(
                              child: Text(ContentConstant.kecamatanNotFound));
                        },
                        onChange: (DistrictDatum result) {
                          controller.districtController.text = result.name!;
                          controller.getVillage(result.code);
                        },
                      );
                    },
                    text: "Kecamatan",
                    widgetSuffix: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20.0),
                    controller: controller.districtController,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '   Kelurahan',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineTextInputWithoutLabel(
                    borderRadius: 8,
                    onChange: (val) {},
                    isReadOnly: true,
                    onFieldTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      SelectDialog.showModal<VillageDatum>(
                        context,
                        items: controller.listVillage,
                        backgroundColor: DeasyColor.neutral000,
                        label: "",
                        titleStyle: TextStyle(color: DeasyColor.neutral900),
                        searchBoxDecoration: InputDecoration(
                          hintText: 'Cari...',
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: DeasyColor.neutral600, width: 0.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onFind: (String filter) =>
                            controller.filterListVillage(filter),
                        itemBuilder: (BuildContext context, VillageDatum item,
                            bool isSelected) {
                          return Container(
                            child: ListTile(
                              selected: isSelected,
                              title: Text(item.name!),
                            ),
                          );
                        },
                        emptyBuilder: (BuildContext context) {
                          return Center(
                              child: Text(ContentConstant.kelurahanNotFound));
                        },
                        onChange: (VillageDatum result) {
                          controller.villageController.text = result.name!;
                          controller.zipCodeController.text =
                              result.postCode.toString();
                        },
                      );
                    },
                    widgetSuffix: Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20.0),
                    text: "Kelurahan",
                    controller: controller.villageController,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'RT/RW',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomOutlineTextInputWithoutLabel(
                          borderRadius: 8,
                          widgetSuffix: null,
                          isNumberOnly: true,
                          onChange: (val) {},
                          text: "RT",
                          controller: controller.rtController,
                          customValidatorMethod: (val) =>
                              controller.rtValidator(val!),
                        ),
                      ),
                      Text(' / '),
                      Expanded(
                        flex: 1,
                        child: CustomOutlineTextInputWithoutLabel(
                          borderRadius: 8,
                          onChange: (val) {},
                          text: "RW",
                          isNumberOnly: true,
                          controller: controller.rwController,
                          customValidatorMethod: (val) =>
                              controller.rwValidator(val!),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    '   Kode Pos',
                    style: TextStyle(color: DeasyColor.neutral900),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: CustomOutlineTextInputWithoutLabel(
                    isReadOnly: true,
                    borderRadius: 8.0,
                    isNext: false,
                    isNumberOnly: true,
                    onChange: (val) {},
                    text: "Kode Pos",
                    controller: controller.zipCodeController,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 1,
                  child: DeasyCustomElevatedButton(
                    text: "Registrasi",
                    primary: DeasyColor.kpYellow500,
                    textColor: DeasyColor.neutral000,
                    paddingButton: 10,
                    borderColor: DeasyColor.kpYellow500,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        controller.submit();
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
