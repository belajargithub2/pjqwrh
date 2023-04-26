import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/models/dashboard_search_merchant_response.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/constant/constants.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/controllers/optimus_automail_controller.dart';

class OptimusSearchMerchantDropdownWidget
    extends GetWidget<OptimusAutomailController> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: DeasyColor.neutral000,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Container(
        color: Colors.white,
        height: 325,
        width: 250,
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          children: [
            TextField(
              decoration: new InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.semanticInfo300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: DeasyColor.kpBlue200),
                ),
                hintText: ContentConstant.typeToSearch,
              ),
              controller: controller.textEditingSearchMerchantController,
              readOnly: false,
              obscureText: false,
              onTap: () {},
              onChanged: (String text) {
                controller.onSearchTextChanged();
              },
            ),
            Expanded(
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: PagedListView<int, DashboardSearchMerchantData>(
                    pagingController: controller.searchMerchantPagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<DashboardSearchMerchantData>(
                      itemBuilder: (context, item, index) => ListTile(
                        onTap: () {
                          controller.onTapSelectMerchant(
                              item.supplierId, item.name!);
                        },
                        title: DeasyTextView(
                          text: item.name,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (_) => Center(
                        child: DeasyTextView(
                            text: ContentConstant.merchantNotFound),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
