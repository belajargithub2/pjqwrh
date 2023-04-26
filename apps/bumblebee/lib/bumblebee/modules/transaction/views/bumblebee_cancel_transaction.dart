import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/controllers/bumblebee_cancel_transaction_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_spinner/deasy_spinner.dart';
import 'package:deasy_animation/deasy_animation.dart';

class BumblebeeCancelTransaction
    extends GetView<BumblebeeCancelTransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: DeasyColor.neutral000,
          elevation: 2,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: DeasyColor.neutral900,
              ),
              onPressed: () => Get.back()),
          title: Text('Permintaan Pembatalan Order',
              style: TextStyle(
                  color: DeasyColor.neutral900, fontWeight: FontWeight.bold))),
      body: Stack(
        children: [
          Form(
            key: controller.formKey,
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  FadeInAnimation(
                      delay: 1,
                      child: Text(
                        'Apakah anda yakin ingin melakukan  cancel order',
                        style: TextStyle(
                            fontSize: DeasySizeConfigUtils.blockVertical * 2.3),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeInAnimation(
                    delay: 1,
                    child: Row(
                      children: [
                        Obx(() => Text('${controller.prospectId.value}',
                            style: TextStyle(
                                color: DeasyColor.sally900,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2.3))),
                        Text(' ?'),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInAnimation(
                    delay: 2,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0, top: 00.0),
                        child: new GestureDetector(
                          onTap: () {
                            showMobileModal(context);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: new Icon(
                                    Icons.arrow_drop_down,
                                    color: DeasyColor.neutral600,
                                  ),
                                  hintText: 'Alasan Permintaan Pembatalan',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: DeasyColor.neutral600,
                                        width: 0.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                controller: controller.reasonController),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() => Expanded(
                        child: Visibility(
                          visible: controller.isShowDetail.value,
                          child: DeasyTextForm.outlinedTextForm(
                            labelText: "Detail Alasan",
                            hintText: "Detail Alasan maksimal 100 karakter",
                            obscure: false,
                            readOnly: false,
                            maxInputLength: 100,
                            customValidation: (text) =>
                                controller.detailReasonValidator(text),
                            controller: controller.detailReasonController,
                            textInputType: TextInputType.text,
                            actionKeyboard: TextInputAction.next,
                          ),
                        ),
                      )),
                  Container(
                    width: DeasySizeConfigUtils.screenWidth,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: DeasyColor.kpYellow500,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            controller.cancel();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            ContentConstant.sendRequestCancelOrder,
                            style: TextStyle(
                                color: DeasyColor.neutral000,
                                fontSize:
                                    DeasySizeConfigUtils.blockVertical * 2.5),
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
          Obx(() =>
              controller.isLoading.isTrue ? FullScreenSpinner() : Container())
        ],
      ),
    );
  }

  showMobileModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        context: context,
        builder: (context) {
          return SizedBox(
            width: DeasySizeConfigUtils.screenWidth,
            height: 550,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 4,
                  width: 80,
                  color: DeasyColor.neutral400,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(ContentConstant.reasonCancelOrder,
                              style: TextStyle(
                                  color: DeasyColor.neutral900,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      DeasySizeConfigUtils.blockHorizontal! *
                                          4)),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: TextButton(
                              child: Text(
                                "Reset",
                                style: TextStyle(
                                    color: DeasyColor.kpYellow500,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                controller.resetList();
                              },
                            ))
                      ]),
                      Container(
                        width: double.infinity,
                        child: DeasyTextForm.outlinedTextForm(
                          hintText: "Cari",
                          controller: controller.searchReasonController,
                          obscure: false,
                          readOnly: false,
                          textInputType: TextInputType.text,
                          actionKeyboard: TextInputAction.go,
                          suffixIcon:
                              Icon(Icons.search, color: DeasyColor.neutral400),
                          paddingBottom: 0.0,
                          onChange: (String value) {
                            controller.searchCancelReason(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        bottom: 20.0, left: 20.0, right: 20.0),
                    child: Obx(() => controller.listReason.isEmpty
                        ? DeasyTextView(text: "Alasan tidak ditemukan")
                        : _widgetListReason()),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _widgetListReason() {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: DeasyColor.neutral400),
      physics: BouncingScrollPhysics(),
      itemCount: controller.listReason.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            controller.setReason(controller.listReason[i]);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("${controller.listReason[i]}"),
          ),
        );
      },
    );
  }
}
