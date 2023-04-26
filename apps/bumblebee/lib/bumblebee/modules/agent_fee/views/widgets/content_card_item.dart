part of '../agent_fee_detail_screen.dart';

class ContentCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Color fontColor;
  final double paddingHorizontal;
  final double paddingText;
  final double fontSize;

  const ContentCardItem({
    required this.title,
    required this.subTitle,
    this.fontColor = DeasyColor.neutral800,
    this.paddingHorizontal = 8.0,
    this.paddingText = 8.0,
    this.fontSize = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: 2.0,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(paddingText),
            child: DeasyTextView(
              text: title,
              fontSize: fontSize,
              fontColor: DeasyColor.neutral400,
              fontFamily: FontFamily.medium,
            ),
          ),
          SizedBox(
            width: 8.0,),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(paddingText),
              child: DeasyTextView(
                text: subTitle,
                maxLines: 2,
                textAlign: TextAlign.end,
                fontSize: fontSize,
                fontColor: fontColor,
                fontFamily: FontFamily.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
