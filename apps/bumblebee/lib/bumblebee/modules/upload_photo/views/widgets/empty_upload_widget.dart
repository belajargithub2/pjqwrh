import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:deasy_color/deasy_color.dart';

class EmptyUploadWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Container(
        color: DeasyColor.neutral50,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("resources/images/img_empty_upload.svg"),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 4),
            Text("List Upload Kosong !",
                style: TextStyle(
                    fontSize: DeasySizeConfigUtils.blockVertical * 3,
                    fontFamily: 'KBFGDisplayBold',
                    color: Colors.black)),
            SizedBox(height: DeasySizeConfigUtils.blockVertical * 1.5),
            Text('Saat ini belum ada yang bisa kamu upload.')
          ],
        ));
  }
}
