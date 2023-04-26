import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';

class DeasyMinutesTimerWidget extends StatefulWidget {
  final Duration duration;
  final bool visible;
  final Function? onEnd;
  final String? endTimerText;
  final Color fontColor;
  final FontFamily fontFamily;
  final double fontSize;
  final bool parenthesis;

  const DeasyMinutesTimerWidget(
      {
        this.duration = const Duration(minutes: 5),
        this.visible = true,
        this.onEnd,
        this.endTimerText,
        this.fontColor = DeasyColor.neutral400,
        this.fontFamily = FontFamily.medium,
        this.fontSize = 12.0,
        this.parenthesis = false
      });

  @override
  _DeasyMinutesTimerWidgetState createState() => _DeasyMinutesTimerWidgetState();
}

class _DeasyMinutesTimerWidgetState extends State<DeasyMinutesTimerWidget> with SingleTickerProviderStateMixin {
  String? endTimerText;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: TweenAnimationBuilder<Duration>(
        duration: widget.duration,
        tween: Tween(
          begin: widget.duration,
          end: Duration.zero,
        ),
        onEnd: () {
          if (widget.onEnd != null) {
            widget.onEnd!();
          }
          endTimerText = widget.endTimerText;
        },
        builder: (BuildContext context, Duration value, Widget? child) {
          final minutes = value.inMinutes;
          final seconds = value.inSeconds % 60;
          String minutesText = minutes.toString().length < 2
              ? "0$minutes"
              : minutes.toString();
          String secondsText = seconds.toString().length < 2
              ? "0$seconds"
              : seconds.toString();
          String timerText = '$minutesText:$secondsText';

          if (endTimerText != null) {
            timerText = endTimerText!;
          }

          if (widget.parenthesis) {
            timerText = "($timerText)";
          }

          return DeasyTextView(
            text: timerText,
            fontFamily: widget.fontFamily,
            fontColor: widget.fontColor,
            fontSize: widget.fontSize,
          );
        },
      ),
    );
  }
}