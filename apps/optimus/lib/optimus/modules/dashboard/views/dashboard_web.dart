import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/optimus/modules/drawer/views/optimus_drawer_container.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_main_controller.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/filter_date_container_widget.dart';
import 'package:kreditplus_deasy_website/optimus/modules/dashboard/views/widget/filter_status_container_widget.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/widgets/decoration.dart';

import 'dashboard_transaction_table.dart';
import 'dashboard_summary_box.dart';

class DashboardWeb extends GetView<DashboardMainController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: baseSystemUiOverlayStyle(),
      child: OptimusDrawerCustom(
        body: Container(
          color: DeasyColor.neutral50,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: DeasyResponsive(
              builder: (context, orientation, screenType) {
                if (screenType == DeasyScreenType.desktop) {
                  return Container(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        DashboardSummaryBox(),
                        Stack(
                          children: [
                            DashboardTransactionTable(),
                            FilterStatusContainerWidget(),
                            FilterDateContainerWidget()
                          ],
                        )
                      ],
                    ),
                  );
                }

                if (screenType == DeasyScreenType.tablet) {
                  return Container(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      children: [
                        DashboardSummaryBox(),
                        Stack(
                          children: [
                            DashboardTransactionTable(),
                            FilterStatusContainerWidget(),
                            FilterDateContainerWidget()
                          ],
                        )
                      ],
                    ),
                  );
                }

                return Container(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      DashboardSummaryBox(),
                      Stack(
                        children: [
                          DashboardTransactionTable(),
                          FilterStatusContainerWidget(),
                          FilterDateContainerWidget()
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
