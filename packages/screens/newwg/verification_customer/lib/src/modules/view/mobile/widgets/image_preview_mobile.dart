import 'dart:typed_data';

import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_dialog/deasy_dialog.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newwg/config/app_config.dart';
import 'package:verification_customer/src/modules/view/widgets/dot_decoration.dart';

class ImagePreviewMobile extends StatelessWidget {
  final String title;
  final Future<Uint8List?> image;
  const ImagePreviewMobile({Key? key, required this.title, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: DottedDecoration(
        shape: Shape.box,
        color: DeasyColor.neutral300,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 164,
      width: 100.h,
      child: Visibility(
        visible: image.isBlank == false,
        child: FutureBuilder(
          future: image,
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            }
            
            return _content(context, snapshot.data);
          },
        ),
      ),
    );
  }

  _contentDialog(BuildContext context, image) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        DeasyTextView(
          text: title,
          fontSize: 20.0,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w500,
          fontFamily: FontFamily.medium,
          fontColor: DeasyColor.neutral800,
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0)),
          child: Image.memory(
            image,
            height: 200,
            width: 100.w,
            fit: BoxFit.cover,
          ),
        ),
        const Spacer(),
        DeasyPrimaryButton(
          text: 'Tutup',
          textStyle: TextStyle(
            fontSize: 17.0.sp,
            color: AppConfig.instance.buttonPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
          borderColor: AppConfig.instance.buttonPrimaryColor,
          color: DeasyColor.neutral000,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _content(BuildContext context, image) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10.0),
              topLeft: Radius.circular(10.0)),
          child: Container(
            width: 100.w,
            padding: const EdgeInsets.all(2.0),
            height: 124,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(DeasyColor.neutral800.withOpacity(0.5), BlendMode.darken),
              child: Image.memory(image, fit: BoxFit.cover),
            ),
          ),
        ),
        Positioned.fill(
          top: -40,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 93,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: DeasyColor.neutral000, width: 1.0),
              ),
              child: InkWell(
                onTap: () {
                  DeasyBaseDialogs.getInstance().customContentDialog(
                      height: 290,
                      width: 100.w,
                      radius: 15,
                      context: context, content: _contentDialog(context, image));
                },
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      DeasyTextView(
                        text: "Lihat",
                        fontSize: 14,
                        fontColor: DeasyColor.neutral000,
                        fontFamily: FontFamily.medium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 18.0,
              child: DeasyTextView(
                text: title,
                fontSize: 12.0,
                letterSpacing: 0.2,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.medium,
                fontColor: DeasyColor.neutral800,
              ),
            ),
          ),
        )
      ],
    );
  }
}
