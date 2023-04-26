import 'dart:typed_data';

import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_responsive/deasy_responsive.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:additional_documents/src/modules/view/widgets/dot_decoration.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  final String title;
  final Future<Uint8List?> image;
  Function()? onTap;

  ImagePreview({
    Key? key,
    required this.title,
    required this.image,
    this.onTap,
  }) : super(key: key);

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
      child: Stack(
        children: [
          Container(
            width: 100.w,
            height: 124,
            padding: const EdgeInsets.all(2.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
              ),
            ),
            child: ColoredBox(
              color: Colors.black.withOpacity(0.5),
              child: Visibility(
                visible: image.isBlank == false,
                child: FutureBuilder(
                  future: image,
                  builder: (context, snapshot) {
                    if (snapshot.hasError || snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    return Image.memory(snapshot.data!, fit: BoxFit.cover);
                  },
                ),
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
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                        DeasyTextView(
                          text: "Ubah",
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
      ),
    );
  }
}
