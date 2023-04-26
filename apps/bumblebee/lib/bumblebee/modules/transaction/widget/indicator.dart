import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_mobile/core/constant/constants.dart';

class Indicator extends StatelessWidget {
  final int index;
  final bool isAgent;

  Indicator({this.index = 0, this.isAgent = false});

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init();
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 18,
                left: DeasySizeConfigUtils.screenWidth! * 0.08,
                right: DeasySizeConfigUtils.screenWidth! * 0.08),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [..._listIndicator()],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: 16,
                top: 18,
                left: DeasySizeConfigUtils.screenWidth! * 0.04),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [..._listStatusText()],
            ),
          ),
        ],
      ),
    );
  }

  _listStatusText() {
    if (isAgent) {
      return [
        _statusTextWidget(true, ContentConstant.biCheckingIndicatorText),
        _statusTextWidget(index > 0, ContentConstant.surveyIndicatorText),
        _statusTextWidget(
            index >= 2, ContentConstant.creditProcessIndicatorText),
        _statusTextWidget(
            index >= 3,
            index == 4
                ? ContentConstant.rejectedIndicatorText
                : ContentConstant.approvedIndicatorText),
        if (index != 4)
          _statusTextWidget(index == 6 || index == 7,
              ContentConstant.disbursedIndicatorTextForAgent)
      ];
    } else {
      return [
        _statusTextWidget(
            index == 1 ||
                index == 6 ||
                index == 5 ||
                index == 3 ||
                index == 2 ||
                index == 4 ||
                index == 0,
            ContentConstant.onProgressIndicatorText),
        _statusTextWidget(
            index == 1 ||
                index == 6 ||
                index == 3 ||
                index == 4 ||
                index == 5 ||
                index == 2,
            index == 2
                ? ContentConstant.rejectedIndicatorText
                : ContentConstant.approvedIndicatorText),
        _statusTextWidget(
            index == 3 || index == 5 || index == 6 || index == 4,
            index == 4 || index == 6
                ? ContentConstant.cancelRequestIndicatorText
                : ContentConstant.purchaseConfirmedIndicatorText),
        _statusTextWidget(
            index == 6 || index == 5,
            index == 2
                ? ContentConstant.disbursedIndicatorText
                : index == 4
                    ? ContentConstant.inactiveCanceledIndicatorText
                    : index == 6
                        ? ContentConstant.activeCanceledIndicatorText
                        : ContentConstant.disbursedIndicatorText)
      ];
    }
  }

  _statusTextWidget(bool isSelected, String status) {
    return Expanded(
      flex: 1,
      child: Container(
        alignment: Alignment.center,
        child: Text(status,
            style: TextStyle(
                color: isSelected
                    ? DeasyColor.semanticInfo300
                    : DeasyColor.neutral400,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.7)),
      ),
    );
  }

  _listIndicator() {
    if (isAgent) {
      return [
        _circleIndicator(true),
        _line(),
        _circleIndicator(index > 0 ? true : false),
        _line(),
        _circleIndicator(index >= 2 ? true : false),
        _line(),
        _circleIndicator(index >= 3 ? true : false),
        if (index != 4) _line(),
        if (index != 4)
          _circleIndicator(index == 6 || index == 7 ? true : false),
      ];
    } else {
      return [
        _circleIndicator(true),
        _line(),
        _circleIndicator(index > 0 ? true : false),
        _line(),
        _circleIndicator(index >= 3 ? true : false),
        _line(),
        _circleIndicator(index == 5 || index == 6 ? true : false),
      ];
    }
  }

  _circleIndicator(bool isActive) {
    final selectedColor =
        isActive ? DeasyColor.semanticInfo300 : DeasyColor.neutral400;
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 19.0,
            height: 19.0,
            decoration: new BoxDecoration(
              color: selectedColor,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 17.0,
            height: 17.0,
            decoration: new BoxDecoration(
              color: DeasyColor.neutral000,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 12.0,
            height: 12.0,
            decoration: new BoxDecoration(
              color: selectedColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  _line() {
    return Expanded(
      flex: 1,
      child: Container(
        height: 1,
        color: DeasyColor.neutral400,
      ),
    );
  }
}
