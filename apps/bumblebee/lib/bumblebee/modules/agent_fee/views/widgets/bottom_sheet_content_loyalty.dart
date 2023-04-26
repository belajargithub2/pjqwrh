part of '../agent_fee_detail_screen.dart';

class BottomSheetContentLoyalty extends StatelessWidget {
  final Incentive data;
  final String description;

  const BottomSheetContentLoyalty({
    Key? key,
    required this.data,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DeasyTextView(
              text: ContentConstant.agentFeeDetailLoyalty,
              fontSize: 16.sp,
              fontColor: DeasyColor.neutral800,
              fontFamily: FontFamily.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDescription,
            subTitle: description,
            paddingText: 8.0,
            fontSize: 15.0.sp,
            paddingHorizontal: 8.0,
            fontColor: DeasyColor.kpBlue900,
          ),
          ContentCardItem(
            title: ContentConstant.agentFeeDetailDisbursementDate,
            paddingText: 8.0,
            fontSize: 15.0.sp,
            paddingHorizontal: 8.0,
            subTitle: "${DateFormat(DateConstant.dateFormat2).format(data.date!)}",
          ),
        ],
      ),
    );
  }
}
