import 'package:additional_documents/src/modules/constans/icons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:additional_documents/src/modules/view/widgets/dot_decoration.dart';
import 'package:flutter_svg/svg.dart';

class FramePreviewMobile extends StatelessWidget {
  final String description;
  final String errorMessage;
  Color borderColor;
  bool isError;
  Function()? onTap;

  FramePreviewMobile(
      {Key? key,
        required this.description,
        required this.errorMessage,
        this.borderColor = DeasyColor.neutral300,
        this.isError = false,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: DottedDecoration(
              shape: Shape.box,
              color: borderColor,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 164,
            width: 100.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  IconsConstant.icPhotoDoc,
                ),
                const SizedBox(height: 16),
                DeasyTextView(
                  text: description,
                  fontSize: 12.0,
                  letterSpacing: 0.2,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontFamily.medium,
                  fontColor: DeasyColor.neutral800,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          isError
              ? DeasyTextView(
            text: errorMessage,
            fontWeight: FontWeight.w500,
            fontSize: 12.0,
            fontColor: DeasyColor.dmsF46363,
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
