import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

class EmptyTable extends StatelessWidget {
  Function onPressSubmission;
  EmptyTable({required this.onPressSubmission});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 16),
      Text('Kamu belum memiliki pengajuan.',
          style: TextStyle(
            fontSize: DeasySizeConfigUtils.blockVertical * 2.35,
            color: DeasyColor.neutral400,
            fontFamily: 'KBFGDisplayLight',
          )),
      TextButton(
          child: Text(
            "Mulai Ajukan Konsumen",
            style: TextStyle(
                color: DeasyColor.kpYellow500, fontFamily: 'KBFGDisplayLight'),
          ),
          onPressed: onPressSubmission as void Function()?)
    ]);
  }
}
