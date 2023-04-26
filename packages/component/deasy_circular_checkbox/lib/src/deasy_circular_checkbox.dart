import 'package:flutter/material.dart';
import 'package:deasy_color/deasy_color.dart';

/**
 * Created by bayu404.dart@gmail.com
 * Copyright (c) 2021 . All rights reserved.
 */

class DeasyCircularCheckBox extends StatefulWidget {
  const DeasyCircularCheckBox({
    Key? key,
    this.isChecked,
    this.checkedWidget,
    this.uncheckedWidget,
    this.checkedColor,
    this.isEnable,
    this.uncheckedColor,
    this.disabledColor,
    this.border,
    this.borderColor,
    this.size,
    this.animationDuration,
    required this.onTap,
  }) : super(key: key);

  final bool? isChecked;

  final Widget? checkedWidget;

  final Widget? uncheckedWidget;

  final Color? checkedColor;

  final Color? uncheckedColor;

  final Color? disabledColor;

  final Border? border;

  final bool? isEnable;

  final Color? borderColor;

  final double? size;

  final Function(bool?) onTap;

  final Duration? animationDuration;

  @override
  _DeasyCircularCheckBoxState createState() => _DeasyCircularCheckBoxState();
}

class _DeasyCircularCheckBoxState extends State<DeasyCircularCheckBox> {
  bool? isChecked;
  Duration? animationDuration;
  double? size;
  Widget? checkedWidget;
  Widget? uncheckedWidget;
  Color? checkedColor;
  Color? uncheckedColor;
  Color? disabledColor;
  Color? borderColor;

  @override
  void initState() {
    isChecked = widget.isChecked ?? false;
    animationDuration = widget.animationDuration ?? Duration(milliseconds: 500);
    size = widget.size ?? 40.0;
    checkedColor = widget.checkedColor ?? DeasyColor.kpYellow500;
    uncheckedColor = widget.uncheckedColor;
    borderColor = widget.borderColor ?? DeasyColor.neutral400;
    checkedWidget = widget.checkedWidget ??
        Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(Icons.check, size: size! / 2, color: Colors.white),
        );
    uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    super.initState();
  }

  @override
  void didUpdateWidget(DeasyCircularCheckBox oldWidget) {
    uncheckedColor =
        widget.uncheckedColor ?? Theme.of(context).scaffoldBackgroundColor;
    if (isChecked != widget.isChecked) {
      isChecked = widget.isChecked ?? false;
    }
    if (animationDuration != widget.animationDuration) {
      animationDuration =
          widget.animationDuration ?? Duration(milliseconds: 500);
    }
    if (size != widget.size) {
      size = widget.size ?? 40.0;
    }
    if (checkedColor != widget.checkedColor) {
      checkedColor = widget.checkedColor ?? DeasyColor.kpYellow500;
    }
    if (borderColor != widget.borderColor) {
      borderColor = widget.borderColor ?? DeasyColor.neutral400;
    }
    if (checkedWidget != widget.checkedWidget) {
      checkedWidget = widget.checkedWidget ??
          Icon(Icons.check, size: size! / 2, color: Colors.white);
    }
    if (uncheckedWidget != widget.uncheckedWidget) {
      uncheckedWidget = widget.uncheckedWidget ?? const SizedBox.shrink();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return widget.onTap != null
        ? GestureDetector(
            onTap: () {
              if (widget.isEnable!) {
                setState(() => isChecked = !isChecked!);
                widget.onTap(isChecked);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size! / 2),
              child: AnimatedContainer(
                duration: animationDuration!,
                height: size,
                width: size,
                decoration: BoxDecoration(
                  color: isChecked! ? checkedColor : uncheckedColor,
                  border: widget.border ??
                      Border.all(
                        color: borderColor!,
                      ),
                  borderRadius: BorderRadius.circular(size! / 2),
                ),
                child: isChecked! ? checkedWidget : uncheckedWidget,
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(size! / 2),
            child: AnimatedContainer(
              duration: animationDuration!,
              height: size,
              width: size,
              decoration: BoxDecoration(
                color: widget.disabledColor ?? Theme.of(context).disabledColor,
                border: widget.border ??
                    Border.all(
                      color: widget.disabledColor ??
                          Theme.of(context).disabledColor,
                    ),
                borderRadius: BorderRadius.circular(size! / 2),
              ),
              child: isChecked! ? checkedWidget : uncheckedWidget,
            ),
          );
  }
}
