part of '../agent_fee_detail_screen.dart';

class FooterCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final double paddingHorizontal;
  final double paddingText;
  final double fontSize;

  const FooterCardItem({
    required this.title,
    required this.subTitle,
    this.paddingHorizontal = 8.0,
    this.paddingText = 8.0,
    this.fontSize = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(paddingText),
              child: DeasyTextView(
                text: title,
                fontSize: fontSize,
                fontColor: DeasyColor.neutral400,
                fontFamily: FontFamily.medium,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(paddingText),
            child: DeasyTextView(
              text: subTitle,
              fontSize: fontSize,
              fontColor: DeasyColor.kpBlue900,
              fontFamily: FontFamily.bold,
            ),
          ),
        ],
      ),
    );
  }
}
