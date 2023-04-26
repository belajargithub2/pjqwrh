import 'package:deasy_text_form/deasy_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/subsidi_dealer/controllers/optimus_subsidi_dealer_table_controller.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';

class OptimusSearchFilterWidget
    extends GetView<OptimusSubsidiDealerTableController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: DeasyTextForm.outlinedTextForm(
              controller: controller.searchTextController,
              labelText: null,
              hintText: ContentConstant.searchByOrderid,
              obscure: false,
              readOnly: false,
              textInputType: TextInputType.text,
              actionKeyboard: TextInputAction.go,
              prefixIcon: Icon(
                Icons.search,
                color: DeasyColor.neutral400,
              ),
              onSubmitField: () {
                controller.onSubmitSearch();
              },
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 1, child: buildStatusFilterButton()),
          SizedBox(width: 20),
          Expanded(flex: 1, child: buildDateFilterButton())
        ],
      ),
    );
  }

  buildStatusFilterButton() {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.onClickStatusFilter();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: controller.isOpenStatusFilter.isTrue
                  ? DeasyColor.kpBlue600
                  : DeasyColor.neutral400,
              style: BorderStyle.solid,
              width: 0.80,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  ContentConstant.selectStatus,
                  maxLines: 1,
                  style: TextStyle(
                    color: controller.isOpenStatusFilter.isTrue
                        ? DeasyColor.kpBlue600
                        : DeasyColor.neutral400,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Icon(
                Icons.keyboard_arrow_down_outlined,
                color: controller.isOpenStatusFilter.isTrue
                    ? DeasyColor.kpBlue600
                    : DeasyColor.neutral400,
              )
            ],
          ),
        ),
      ),
    );
  }

  buildDateFilterButton() {
    return Obx(
      () => InkWell(
        onTap: () {
          controller.onClickDateFilter();
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: DeasyColor.neutral000,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: controller.isOpenDateFilter.isTrue
                  ? DeasyColor.kpBlue600
                  : DeasyColor.neutral400,
              style: BorderStyle.solid,
              width: 0.80,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.date_range,
                color: controller.isOpenDateFilter.isTrue
                    ? DeasyColor.kpBlue600
                    : DeasyColor.neutral400,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  ContentConstant.date,
                  maxLines: 1,
                  style: TextStyle(
                    color: controller.isOpenDateFilter.isTrue
                        ? DeasyColor.kpBlue600
                        : DeasyColor.neutral400,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
