part of 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/views/screens/kmob_consumer_data_submission/kmob_consumer_data_submission_container_screen.dart';

class KMOBConsumerDataSubmissionMobileScreen
    extends GetView<BumblebeeKMOBConsumerDataSubmissionController> {
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
        physics: NeverScrollableScrollPhysics(),
        children: [
          _formConsumenDataWidget(context),
          _spaceWidget(),
          _formConsumenPartnerDataWidget(context),
          _spaceWidget(),
          _nextButton(),
        ],
      ),
    );
  }

  Widget _spaceWidget() {
    return Obx(() => SizedBox(
          height: controller.isMarried.value ? 10 : 5,
        ));
  }

  Widget _formConsumenPartnerDataWidget(BuildContext context) {
    bool isConsumen = false;
    return Obx(() => Visibility(
          visible: controller.isMarried.value,
          child: Container(
            padding: EdgeInsets.all(12.0),
            color: DeasyColor.neutral000,
            child: Form(
              autovalidateMode: controller.autoValidate.value,
              key: controller.formConsumenPartnerDataKey,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: DeasyTextView(
                      text: "Data Pasangan Konsumen",
                      fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Nama Pasangan',
                    hint: 'Masukan Nama Pasangan',
                    isNext: true,
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.partnerNameCantBeNull);
                    },
                    controller: controller.spouseNameController,
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Nomor KTP',
                    hint: 'Masukan Nomor KTP',
                    isNext: true,
                    isNumberOnly: true,
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .ktpValidation(value);
                    },
                    controller: controller.spouseIdNumberController,
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Tanggal Lahir',
                    hint: 'Masukan Tanggal Lahir',
                    isNext: true,
                    isReadOnly: true,
                    widgetSuffix: Icon(
                      Icons.date_range,
                      size: 20,
                      color: DeasyColor.neutral900.withOpacity(0.5),
                    ),
                    controller: controller.spouseBirthDateController,
                    onFieldTap: () {
                      controller.onTapDatePicker(isConsumen: isConsumen);
                    },
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.dateOfBirthCantBeNull);
                    },
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Tempat Lahir',
                    hint: 'Masukan Kota Kelahiran',
                    isNext: true,
                    controller: controller.spouseBirthPlaceController,
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.placeOfBirthCantBeNull);
                    },
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Jenis Kelamin',
                    hint: 'Pilih Jenis kelamin',
                    isNext: true,
                    isReadOnly: true,
                    widgetSuffix: Icon(
                      Icons.keyboard_arrow_down,
                      size: 35,
                      color: DeasyColor.neutral900.withOpacity(0.5),
                    ),
                    controller: controller.spouseGenderController,
                    onFieldTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      dialogGender(isConsumen: isConsumen);
                    },
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.genderCantBeNull);
                    },
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: 'Nomor Telepon',
                    hint: 'Contoh: 08123456789',
                    isNext: true,
                    isNumberOnly: true,
                    controller: controller.spouseMobilePhoneController,
                    validation: (value) {
                      return controller.phoneNumberValidation(value);
                    },
                  ),
                  KMOBSubmissionTextFieldWidget(
                    title: ContentConstant.kmobSpouseSurgateMotherNameTitle,
                    hint: ContentConstant.kmobSpouseSurgateMotherNameHint,
                    isNext: true,
                    validation: (value) {
                      return controller.kmobSubmissionController!
                          .checkValueEmpty(
                              value, ContentConstant.motherNameCantBeNull);
                    },
                    controller: controller.spouseSurgateMotherNameController,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _formConsumenDataWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      color: DeasyColor.neutral000,
      child: Form(
        autovalidateMode: controller.autoValidate.value,
        key: controller.formConsumenDataKey,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DeasyTextView(
                text: "Data Konsumen",
                fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
                fontFamily: FontFamily.bold,
              ),
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Cabang',
              hint: 'Pilih Cabang',
              isNext: true,
              widgetSuffix: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: DeasyColor.neutral900.withOpacity(0.5),
              ),
              controller: controller.branchController,
              validation: (value) {
                return controller.kmobSubmissionController!
                    .checkValueEmpty(value, ContentConstant.branchCantBeNull);
              },
              onFieldTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                dialogBranch();
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Nama',
              hint: 'Nama Konsumen',
              isNext: true,
              validation: (value) {
                return controller.kmobSubmissionController!
                    .checkValueEmpty(value, ContentConstant.nameCantBeNull);
              },
              controller: controller.customerNameController,
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Nomor KTP',
              hint: 'Masukan Nomor KTP',
              isNext: true,
              isNumberOnly: true,
              controller: controller.idNumberController,
              validation: (value) {
                return controller.kmobSubmissionController!
                    .ktpValidation(value);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Tanggal Lahir',
              hint: 'Masukan Tanggal Lahir',
              isNext: true,
              isReadOnly: true,
              widgetSuffix: Icon(
                Icons.date_range,
                size: 20,
                color: DeasyColor.neutral900.withOpacity(0.5),
              ),
              controller: controller.birthDateController,
              onFieldTap: () {
                controller.onTapDatePicker(isConsumen: true);
              },
              validation: (value) {
                return controller.kmobSubmissionController!.checkValueEmpty(
                    value, ContentConstant.dateOfBirthCantBeNull);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Tempat Lahir',
              hint: 'Masukan Kota Kelahiran',
              isNext: true,
              controller: controller.birthPlaceController,
              validation: (value) {
                return controller.kmobSubmissionController!.checkValueEmpty(
                    value, ContentConstant.placeOfBirthCantBeNull);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Jenis Kelamin',
              hint: 'Pilih Jenis kelamin',
              isNext: true,
              isReadOnly: true,
              widgetSuffix: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: DeasyColor.neutral900.withOpacity(0.5),
              ),
              controller: controller.genderController,
              onFieldTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                dialogGender(isConsumen: true);
              },
              validation: (value) {
                return controller.kmobSubmissionController!
                    .checkValueEmpty(value, ContentConstant.genderCantBeNull);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Status Perkawinan',
              hint: 'Pilih Status Perkawinan',
              isNext: true,
              isReadOnly: true,
              widgetSuffix: Icon(
                Icons.keyboard_arrow_down,
                size: 35,
                color: DeasyColor.neutral900.withOpacity(0.5),
              ),
              controller: controller.maritalStatusController,
              onFieldTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                dialogMaritalStatus();
              },
              validation: (value) {
                return controller.kmobSubmissionController!.checkValueEmpty(
                    value, ContentConstant.maritalStatusCantBeNull);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Nomor Telepon',
              hint: 'Contoh: 08123456789',
              isNext: true,
              isNumberOnly: true,
              controller: controller.mobilePhoneController,
              validation: (value) {
                return controller.phoneNumberValidation(value);
              },
            ),
            KMOBSubmissionTextFieldWidget(
              title: 'Nama Ibu Kandung',
              hint: 'Nama Ibu Kandung Konsumen',
              isNext: true,
              controller: controller.surgateMotherNameController,
              validation: (value) {
                return controller.kmobSubmissionController!.checkValueEmpty(
                    value, ContentConstant.motherNameCantBeNull);
              },
            ),
          ],
        ),
      ),
    );
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
            controller.checkValidation();
          },
        ),
      ),
    );
  }

  dialogMaritalStatus() {
    SelectDialog.showModal<MaritalStatusData>(
      Get.context!,
      items: controller.listMaritalStatus,
      backgroundColor: DeasyColor.neutral000,
      label: ContentConstant.maritalStatusTitle,
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
      itemBuilder:
          (BuildContext context, MaritalStatusData item, bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item.text!),
          ),
        );
      },
      onChange: (MaritalStatusData result) {
        controller.onChangeMaritalStatus(result);
      },
    );
  }

  dialogBranch() {
    SelectDialog.showModal<BranchData>(
      Get.context!,
      items: controller.listBranch,
      backgroundColor: DeasyColor.neutral000,
      label: "Cari berdasarkan nama cabang",
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
      onFind: (String filter) => controller.filterListBranch(filter),
      itemBuilder: (BuildContext context, BranchData item, bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item.branchFullName!),
          ),
        );
      },
      onChange: (BranchData result) {
        controller.onChangeBranch(result);
      },
    );
  }

  dialogGender({bool isConsumen = false}) {
    SelectDialog.showModal<String>(
      Get.context!,
      items: ['Laki-laki', 'Perempuan'],
      backgroundColor: DeasyColor.neutral000,
      label: "Pilih jenis kelamin",
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
      itemBuilder: (BuildContext context, String item, bool isSelected) {
        return Container(
          child: ListTile(
            selected: isSelected,
            title: Text(item),
          ),
        );
      },
      onChange: (String result) {
        controller.onChangeGender(result, isConsumen);
      },
    );
  }
}
