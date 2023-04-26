part of '../agent_fee_detail_screen.dart';

class HeaderCardItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onDetailPress;

  const HeaderCardItem({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onDetailPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: DeasyTextView(
                text: title,
                fontSize: 16,
                fontColor: DeasyColor.neutral800,
                fontFamily: FontFamily.bold,
              ),
            ),
          ),
          InkWell(
            onTap: () => onDetailPress(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: DeasyTextView(
                text: subTitle,
                fontSize: 16,
                fontColor: DeasyColor.kpYellow500,
                fontFamily: FontFamily.medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
