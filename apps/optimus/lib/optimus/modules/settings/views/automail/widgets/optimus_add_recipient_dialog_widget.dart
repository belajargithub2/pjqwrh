import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipient_type_response.dart';
import 'package:select_dialog/select_dialog.dart';

class OptimusAddRecipientDialogWidget
    extends GetView<OptimusAutomailController> {
  final bool? hasData;
  final bool? isDealer;
  final bool? isNewData;
  final bool canEdit;

  OptimusAddRecipientDialogWidget(
      {this.hasData = false,
      this.isDealer = false,
      this.canEdit = false,
      this.isNewData = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: DeasyColor.neutral000,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Obx(() => controller.isLoadingInDialog.isTrue
          ? FullScreenSpinner()
          : ListView(
              controller: ScrollController(),
              children: [
                Form(
                  key: controller.formKey,
                  child: Card(
                    color: DeasyColor.neutral000,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Container(
                      margin: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _headerDialog(
                              title: ContentConstant.automailDetailRecipient),
                          EditTextWidget(
                            controller: controller.recipientTypeTextCont,
                            title: ContentConstant.automailRecipientType,
                            hint: ContentConstant.automailChooseRecipientType,
                            onFieldTap: () {
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              SelectDialog.showModal<RecipentType>(
                                context,
                                showSearchBox: false,
                                items: controller.listRecipientTypes,
                                backgroundColor: DeasyColor.neutral000,
                                label: ContentConstant.automailRecipientType,
                                titleStyle:
                                    TextStyle(color: DeasyColor.neutral900),
                                itemBuilder: (BuildContext context,
                                    RecipentType item, bool isSelected) {
                                  return Container(
                                    child: ListTile(
                                      selected: isSelected,
                                      title: Text(item.text),
                                    ),
                                  );
                                },
                                onChange: (RecipentType result) {
                                  controller.onChangeType(result);
                                },
                              );
                            },
                            widgetSuffix: Icon(Icons.keyboard_arrow_down,
                                color: DeasyColor.neutral900),
                            isReadOnly: true,
                            isEnabled: isNewData == true ? true : false,
                            validation: (value) => commonValidation(
                                value, ContentConstant.automailTypeCantBeEmpty),
                          ),
                          Obx(
                            () => Visibility(
                              visible: controller.showDealerField.isTrue ||
                                  isDealer!,
                              child: EditTextWidget(
                                controller: controller.dealerName,
                                title: ContentConstant.automailDealer,
                                hint: ContentConstant.automailDealer,
                                onFieldTap: () {
                                  controller.showDialogMerchants();
                                },
                                widgetSuffix: Icon(Icons.keyboard_arrow_down,
                                    color: DeasyColor.neutral900),
                                isReadOnly: true,
                                isEnabled: hasData == true ? false : true,
                                validation: (value) => hasData == true
                                    ? null
                                    : controller.sameDealerValidation(
                                        value,
                                        ContentConstant
                                            .automailDealerHasBeenRegistered,
                                        ContentConstant
                                            .automailDealerCantBeEmpty,
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          _headerDialog(
                              title: ContentConstant.automailRecipientsForm),
                          EditTextWidget(
                            controller: controller.email1TextController,
                            title: ContentConstant.automailRecipients1,
                            hint: ContentConstant.emailHint,
                            isEnabled: canEdit == true ? true : false,
                            paddingBottom: 10,
                            validation: (value) => controller.isEmailValid(
                              value,
                            ),
                          ),
                          EditTextWidget(
                              controller: controller.email2TextController,
                              title: ContentConstant.automailRecipients2,
                              hint: ContentConstant.emailHint,
                              isEnabled: canEdit == true ? true : false,
                              paddingBottom: 10,
                              validation: (value) {
                                if (controller
                                    .email2TextController.text.isNotEmpty) {
                                  return controller.isEmailValid(
                                    value,
                                  );
                                }
                              }),
                          EditTextWidget(
                              controller: controller.email3TextController,
                              title: ContentConstant.automailRecipients3,
                              hint: ContentConstant.emailHint,
                              isEnabled: canEdit == true ? true : false,
                              paddingBottom: 10,
                              validation: (value) {
                                if (controller
                                    .email3TextController.text.isNotEmpty) {
                                  return controller.isEmailValid(
                                    value,
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                canEdit == false ? _singleButton() : _doubleButton(),
                SizedBox(height: 40),
              ],
            )),
    );
  }

  Widget _singleButton() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Spacer(),
          DeasyPrimaryButton(
              text: ContentConstant.close,
              width: 154,
              onPressed: () => controller.onCancelInput()),
        ],
      ),
    );
  }

  Widget _doubleButton() {
    return Padding(
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          Spacer(),
          _buttonCancel(),
          SizedBox(
            width: 15,
          ),
          _dialogSaveConfirmation(),
        ],
      ),
    );
  }

  Widget _buttonCancel() {
    return DeasyPrimaryStrokedButton(
        width: 154,
        text: ButtonConstant.dialogBtnCancel,
        onPressed: () => controller.onCancelInput());
  }

  Widget _dialogSaveConfirmation() {
    return DeasyPrimaryButton(
        text: ButtonConstant.save,
        width: 154,
        onPressed: () {
          controller.submit(isNewData!);
        });
  }

  Widget _headerDialog({required String title}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: DeasySizeConfigUtils.blockHorizontal! * 1.3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DeasyTextView(
                text: title,
                fontSize: 16.sp,
                fontFamily: FontFamily.bold,
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          thickness: 1,
        ),
      ],
    );
  }
}
