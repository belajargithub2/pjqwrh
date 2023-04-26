part of 'package:kreditplus_deasy_website/optimus/modules/merchant_user_management/views/screens/merchant_user_management_add_screen.dart';

class MerchantUserManagementAddWebScreen
    extends GetWidget<MerchantAddUserManagementController> {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: SingleChildScrollView(
        child: Container(
          color: DeasyColor.dmsF8F9FC,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_header(), _form()],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MenuWidgets.threeMenu(
          menuNameOne: MenuConstant.dashboardLabel,
          menuNameTwo: MenuConstant.merchantUserManagement,
          menuNameThree: MenuConstant.merchantUserManagementAdd,
          onTapMenuOne: () {
            controller.drawerController.handleIcon();
            Get.back();
            Get.offNamed(OptimusRoutes.DASHBOARD_WEB);
          },
          fontSize: 12,
          onTapMenuTwo: () {
            controller.drawerController.handleIcon();
            Get.back();
          },
        ),
        SizedBox(height: 15),
        DeasyTextView(
          text: MenuConstant.merchantUserManagementAdd,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _form() {
    return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Form(
          key: controller.formKey,
          autovalidateMode: controller.autoValidate.value,
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
              margin: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DeasyTextForm.outlinedTextForm(
                    labelText: "Nama",
                    hintText: "Nama Merchant User",
                    obscure: false,
                    readOnly: false,
                    controller: controller.nameController,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    parametersValidate: "Nama tidak boleh kosong",
                    prefixIcon: null,
                    customValidation: (String val) => val.nameValidator(
                        msgNameCantBeEmpty: ContentConstant.nameCantBeNull,
                        msgNameMaxLength: ContentConstant.msgNameMaxLength,
                        msgNameCantContainSpecialChar: ValidationConstant
                            .nameMustBeCharacterWith1To50Words),
                  ),
                  SizedBox(height: 25),
                  DeasyTextForm.outlinedTextForm(
                    labelText: "No Handphone (opsional)",
                    hintText: "Contoh: 08111111111",
                    obscure: false,
                    readOnly: false,
                    controller: controller.phoneController,
                    textInputType: TextInputType.number,
                    isNumberOnly: true,
                    maxInputLength: 14,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String val) => val.phoneValidator(
                        msgPhoneNotValid: ValidationConstant.phoneValidation),
                    prefixIcon: null,
                  ),
                  SizedBox(height: 25),
                  DeasyTextForm.outlinedTextForm(
                    labelText: "Email",
                    hintText: "Contoh: user@email.com",
                    obscure: false,
                    readOnly: false,
                    controller: controller.emailController,
                    textInputType: TextInputType.text,
                    actionKeyboard: TextInputAction.next,
                    customValidation: (String val) => val.emailValidator(
                        msgEmailCantBeEmpty: ContentConstant.emailCantBeEmpty,
                        msgEmailNotValid:
                            ValidationConstant.emailNotValid.capitalizeFirst!),
                    prefixIcon: null,
                  ),
                  SizedBox(height: 25),
                  Row(children: [
                    Spacer(),
                    Obx(() => DeasyPrimaryButton(
                          text: "Tambah User",
                          width: 154,
                          color: controller.isFormNotEmpty.isTrue
                              ? DeasyColor.kpYellow500
                              : DeasyColor.neutral200,
                          borderColor: controller.isFormNotEmpty.isTrue
                              ? DeasyColor.kpYellow500
                              : DeasyColor.neutral200,
                          onPressed: () async {
                            controller.submit().then((value) {
                              if (controller.isShowSuccessDialog) {
                                successAddUserDialog(
                                    email: controller.emailController.text,
                                    isShowSuccessDialog:
                                        controller.isShowSuccessDialog);
                              }
                            });
                          },
                        ))
                  ])
                ],
              ),
            ),
          ),
        ));
  }
}
