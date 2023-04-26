import 'package:deasy_size_config/deasy_size_config.dart';
import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deasy_color/deasy_color.dart';

class KMOBSubmissionTextFieldWidget extends StatefulWidget {
  final String title;
  final String extraText;
  final String hint;
  final bool isNumberOnly;
  final bool isAlfabethOnly;
  final Function? onChange;
  final Function? onFieldTap;
  final Function? validation;
  final bool obscureText;
  final bool isNext;
  final bool isReadOnly;
  final bool isEnabled;
  final double borderRadius;
  final Widget? widgetSuffix;
  final TextEditingController controller;
  final double titleSize;
  final FontFamily titleFontFamily;

  KMOBSubmissionTextFieldWidget({
    required this.title,
    required this.hint,
    required this.controller,
    this.isNumberOnly = false,
    this.isAlfabethOnly = false,
    this.onFieldTap,
    this.onChange,
    this.extraText = "",
    this.obscureText = false,
    this.isNext = true,
    this.isReadOnly = false,
    this.widgetSuffix,
    this.borderRadius = 8.0,
    this.validation,
    this.isEnabled = true,
    this.titleSize = 14.0,
    this.titleFontFamily = FontFamily.medium,
  });

  @override
  State<KMOBSubmissionTextFieldWidget> createState() =>
      _KMOBSubmissionTextFieldWidgetState();
}

class _KMOBSubmissionTextFieldWidgetState
    extends State<KMOBSubmissionTextFieldWidget> {
  bool isError = false;
  String? errorMessage = "data ini tidak boleh kosong";

  @override
  Widget build(BuildContext context) {
    DeasySizeConfigUtils().init(context: context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        DeasyTextView(
          text: widget.title,
          fontSize: widget.titleSize,
          fontFamily: widget.titleFontFamily,
        ),
        SizedBox(height: 8.0),
        TextFormField(
          keyboardType:
              widget.isNumberOnly ? TextInputType.phone : TextInputType.text,
          onChanged: (val) {
            if (widget.onChange != null) widget.onChange!(val);
          },
          inputFormatters: widget.isNumberOnly
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : widget.isAlfabethOnly
                  ? <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ]
                  : [],
          obscureText: widget.obscureText,
          controller: widget.controller,
          enabled: widget.isEnabled,
          textInputAction:
              widget.isNext ? TextInputAction.next : TextInputAction.none,
          readOnly: widget.isReadOnly,
          validator: (value) {
            setState(() => isError = false);
            if (widget.validation != null) {
              if (widget.validation!(value) != null) {
                setState(() {
                  errorMessage = widget.validation!(value);
                  isError = true;
                });
                return '';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: widget.isEnabled
                ? DeasyColor.neutral000
                : DeasyColor.neutral100,
            filled: true,
            hintStyle: TextStyle(
              color: DeasyColor.neutral400,
            ),
            errorStyle: TextStyle(height: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.kpBlue600),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.neutral300),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      isError ? DeasyColor.dmsF46363 : DeasyColor.neutral300),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.kpBlue600),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.neutral300),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            contentPadding: EdgeInsets.all(15.0),
            hintText: widget.hint,
            suffixIcon: widget.widgetSuffix,
          ),
          onTap: () {
            if (widget.onFieldTap != null) widget.onFieldTap!();
          },
        ),
        Visibility(
            visible: isError,
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: DeasyTextView(
                text: errorMessage,
                maxLines: 2,
                fontFamily: FontFamily.light,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.3,
                fontColor: DeasyColor.dmsF46363,
              ),
            )),
        Visibility(
            visible: widget.extraText.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: DeasyTextView(
                text: widget.extraText,
                maxLines: 2,
                fontFamily: FontFamily.light,
                fontSize: DeasySizeConfigUtils.blockVertical * 1.3,
                fontColor: DeasyColor.kpBlue600,
              ),
            )),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
