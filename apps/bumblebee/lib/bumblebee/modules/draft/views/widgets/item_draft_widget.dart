import 'package:deasy_helper/deasy_helper.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_get_draft.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';
import 'package:deasy_animation/deasy_animation.dart';

class ItemDraftWidget extends StatelessWidget {
  final DataDraft? dataDraft;
  Function? onTap;

  ItemDraftWidget({this.dataDraft, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SideInAnimation(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            elevation: 2,
            color: DeasyColor.neutral000,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      DeasyTextView(
                          text: ' Draft',
                          fontSize: DeasySizeConfigUtils.blockVertical * 1.3,
                          fontColor: DeasyColor.kpBlue600,
                          fontFamily: FontFamily.medium),
                      SizedBox(width: 15),
                      DeasyTextView(
                        text: dataDraft!.orderDate!
                            .toFormattedDate(format: DateConstant.dateFormat2),
                        fontSize: DeasySizeConfigUtils.blockVertical * 1.3,
                        fontColor: DeasyColor.neutral400,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: DeasyColor.neutral200,
                          thickness: 1,
                        ),
                        Row(
                          children: [
                            DeasyTextView(
                              text: ' ${dataDraft!.customerName}',
                              fontSize:
                                  DeasySizeConfigUtils.blockVertical * 1.5,
                              fontFamily: FontFamily.medium,
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: DeasyColor.neutral400,
                              size: 25,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
