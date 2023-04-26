import 'package:kreditplus_deasy_website/optimus/modules/dashboard/controllers/dashboard_transaction_controller.dart';
import 'package:kreditplus_deasy_website/core/utils/main_part.dart';

import 'dashboard_applicant_card_item.dart';

class DashboardTransactionGrid extends GetView<DashboardTransactionController> {
  final double height;
  final double width;

  DashboardTransactionGrid({required this.height, required this.width});

  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Wrap(
        direction: Axis.horizontal,
        spacing: 4.0,
        runSpacing: 4.0,
        children: state!
            .map((e) => DashboardApplicantCardItem(
                itemHeight: height,
                itemWidth: width,
                status: e.status,
                qty: e.qty.toString(),
                value: e.value ?? 0))
            .toList(),
      ),
      onLoading: Center(
        child:
            SizedBox(width: 20, height: 20, child: CircularProgressIndicator()),
      ),
      onError: (err) => Text(err.toString()),
    );
  }
}
