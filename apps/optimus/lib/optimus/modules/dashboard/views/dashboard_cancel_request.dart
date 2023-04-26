import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_cancel_request_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/core/widgets/text_field.dart';

class DashboardCancelRequestWeb
    extends GetView<DashboardCancelRequestController> {
  @override
  Widget build(BuildContext context) {
    return OptimusDrawerCustom(
        scaffoldKey: controller.scaffoldKey,
        body: Container(
          color: DeasyColor.neutral100,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _menuWidget(context),
                  SizedBox(height: 40),
                  _formWidget(context)
                ],
              ),
            ),
          ),
        ));
  }

  Widget _menuWidget(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            child: Icon(Icons.arrow_back, color: Colors.black),
            onTap: () {
              Navigator.pop(context);
            }),
        SizedBox(width: 8),
        DeasyTextView(
            text: ContentConstant.requestCancelOrder,
            fontSize: 20,
            fontFamily: FontFamily.bold)
      ],
    );
  }

  Widget _formWidget(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          margin: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: DeasySizeConfigUtils.blockVertical * 2.0,
                      fontFamily: getFontFamily(FontFamily.light)),
                  children: <TextSpan>[
                    TextSpan(
                        text: ContentConstant.cancelOrderLabel,
                        style: TextStyle(
                          fontFamily: getFontFamily(FontFamily.medium),
                          color: DeasyColor.neutral900,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                        )),
                    TextSpan(
                        text: controller.orderId,
                        style: TextStyle(
                          fontFamily: getFontFamily(FontFamily.medium),
                          color: DeasyColor.semanticInfo300,
                          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Divider(
                color: DeasyColor.neutral300,
                thickness: 1.0,
              ),
              SizedBox(height: 16),
              DeasyTextForm.outlinedTextForm(
                labelText: ContentConstant.reasonCancelOrder,
                hintText: ContentConstant.selectReasonCancelOrder,
                controller: controller.cancelOrderTextController,
                obscure: false,
                readOnly: true,
                suffixIcon: Icon(
                    controller.isActiveReason.isTrue
                        ? Icons.keyboard_arrow_up_outlined
                        : Icons.keyboard_arrow_down_outlined,
                    color: DeasyColor.neutral600),
                onFieldTap: () {
                  controller.isActiveReason.toggle();
                },
                textInputType: TextInputType.text,
                actionKeyboard: TextInputAction.next,
                functionValidate: commonValidation,
                parametersValidate: ContentConstant.reasonCantBeEmpty,
                prefixIcon: null,
              ),
              Obx(() => Visibility(
                  visible: controller.isActiveReason.isTrue,
                  child: Container(
                    constraints: BoxConstraints(
                      maxHeight: 539,
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: DeasyColor.neutral400,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Container(
                      height: 539,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: _searchField(),
                          ),
                          Expanded(
                            flex: 4,
                            child: controller.searchValue.isNotEmpty
                                ? buildSearchReasonList()
                                : buildReasonList(),
                          )
                        ],
                      ),
                    ),
                  ))),
              SizedBox(height: 25),
              Row(
                children: [
                  Spacer(),
                  DeasyPrimaryStrokedButton(
                      text: ContentConstant.cancelRequestCancelOrder,
                      width: 154,
                      onPressed: () {
                        Get.back();
                      }),
                  SizedBox(width: 30),
                  Obx(() => DeasyPrimaryButton(
                      color: controller.reason.isNotEmpty
                          ? Theme.of(context).buttonColor
                          : DeasyColor.kpBlue200,
                      text: ContentConstant.sendRequestCancelOrder,
                      width: 154,
                      onPressed: () {
                        if (controller.formKey.currentState!.validate()) {
                          controller.submitCancelRequest();
                        }
                      })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReasonList() {
    return controller.reasonList.length < 1
        ? emptyList()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.reasonList.length,
            itemBuilder: (context, i) {
              return InkWell(
                  onTap: () {
                    controller.cancelOrderTextController!.text =
                        controller.reasonList[i];
                    controller.isActiveReason.value = false;
                    controller.reason.value = controller.reasonList[i];
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: DeasyTextView(text: controller.reasonList[i])),
                      if (!(i == controller.reasonList.length - 1))
                        Divider(thickness: 1, color: DeasyColor.kpBlue200),
                    ],
                  ));
            },
          );
  }

  Widget buildSearchReasonList() {
    return controller.searchReasonList.length < 1
        ? emptyList()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: controller.searchReasonList.length,
            itemBuilder: (context, i) {
              return InkWell(
                  onTap: () {
                    controller.cancelOrderTextController!.text =
                        controller.searchReasonList[i];
                    controller.isActiveReason.value = false;
                    controller.reason.value = controller.reasonList[i];
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.all(10),
                          child: DeasyTextView(
                              text: controller.searchReasonList[i])),
                      if (!(i == controller.searchReasonList.length - 1))
                        Divider(thickness: 1, color: DeasyColor.kpBlue200),
                    ],
                  ));
            },
          );
  }

  Widget _searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DeasyTextForm.outlinedTextForm(
        hintText: ContentConstant.findReasonCancelOrder,
        controller: controller.searchReasonTextController,
        obscure: false,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            IconConstant.RESOURCES_ICON_SEARCH,
            color: DeasyColor.neutral500,
          ),
        ),
        textInputType: TextInputType.text,
        actionKeyboard: TextInputAction.next,
        prefixIcon: null,
        onChange: (String text) {
          controller.onReasonSearchTextChanged(text);
        },
      ),
    );
  }

  Widget emptyList() {
    return Container(
      height: DeasySizeConfigUtils.screenHeight,
      width: DeasySizeConfigUtils.screenWidth,
      child: Center(
        child: DeasyTextView(
          text: ContentConstant.emptyReasonCancelOrder,
          fontSize: DeasySizeConfigUtils.blockVertical * 2.5,
        ),
      ),
    );
  }
}
