import 'package:deasy_color/deasy_color.dart';
import 'package:deasy_text_form/src/common/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OutlinedTextForm extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final String? labelText;
  final Widget? customLabelWidget;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final Function? customValidation;
  final String? parametersValidate;
  final TextInputAction actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final Function? onChange;
  final bool readOnly;
  final bool isNumberOnly;
  final bool isNoSpaceOnly;
  final bool isDisabled;
  final double fontSize;
  final double? labelSize;
  final double paddingBottom;
  final double contentPaddingHorizontal;
  final FontFamilyTextForm labelFontFamily;
  final Widget? trailing;
  final int? maxInputLength;

  OutlinedTextForm({
    this.hintText,
    this.labelText,
    this.customLabelWidget,
    this.prefixText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.functionValidate,
    this.parametersValidate = "",
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.customValidation,
    this.isNumberOnly = false,
    this.isDisabled = false,
    this.fontSize = 14.0,
    this.labelSize,
    this.paddingBottom = 16,
    this.contentPaddingHorizontal = 24,
    this.labelFontFamily = FontFamilyTextForm.light,
    this.trailing,
    this.maxInputLength,
    this.isNoSpaceOnly = false,
  });

  @override
  _OutlinedTextFormState createState() => _OutlinedTextFormState();
}

class _OutlinedTextFormState extends State<OutlinedTextForm> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.customLabelWidget != null
          ? widget.customLabelWidget!
          : widget.labelText != null ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.labelText!,
                    style: TextStyle(
                        fontFamily: getFontFamilyTextForm(widget.labelFontFamily),
                        fontSize: widget.labelSize == null
                            ? widget.fontSize
                            : widget.labelSize)),
                if (widget.trailing != null) widget.trailing!,
              ],
            ) : SizedBox(),
        if (widget.trailing == null)
          SizedBox(
            height: widget.paddingBottom,
          ),
        TextFormField(
          onChanged: (value) {
            if (widget.onChange != null) widget.onChange!(value);
          },
          inputFormatters: <TextInputFormatter>[
            if (widget.isNumberOnly) FilteringTextInputFormatter.digitsOnly,
            if (widget.isNumberOnly)
              LengthLimitingTextInputFormatter(widget.maxInputLength),
            if (widget.isNoSpaceOnly)
              FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
          ],
          cursorColor: Colors.blue,
          obscureText: widget.obscureText,
          keyboardType: widget.textInputType,
          textInputAction: widget.actionKeyboard,
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(
            color: Colors.black,
            fontSize: widget.fontSize,
            height: 2,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            letterSpacing: 1.2,
          ),
          initialValue: widget.defaultText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: 16, horizontal: widget.contentPaddingHorizontal),
              isDense: false,
              enabledBorder: getInputBorder(color: DeasyColor.neutral400),
              focusedBorder: getInputBorder(color: DeasyColor.kpBlue700),
              errorBorder: getInputBorder(color: Color(0xFFF46363)),
              focusedErrorBorder: getInputBorder(color: Color(0xFFF46363)),
              disabledBorder: getInputBorder(color: DeasyColor.neutral000),
              prefixText: widget.prefixText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              errorMaxLines: 2,
              errorStyle: TextStyle(
                  fontFamily: getFontFamilyTextForm(FontFamilyTextForm.light),
                  fontSize: 12,
                  color: Color(0xFFF46363),
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
              filled: widget.isDisabled,
              fillColor: Color(0x6FBFBFBF)),
          controller: widget.controller,
          validator: (value) {
            if (widget.functionValidate != null) {
              String? resultValidate =
              widget.functionValidate!(value!, widget.parametersValidate);
              if (resultValidate != null) {
                return resultValidate;
              }
            } else if (widget.customValidation != null) {
              String? customResult = widget.customValidation!(value!);
              if (customResult != null) {
                return customResult;
              }
            }
            return null;
          },
          onFieldSubmitted: (value) {
            if (widget.onSubmitField != null) widget.onSubmitField!();
          },
          onTap: () {
            if (widget.onFieldTap != null) widget.onFieldTap!();
          },
        ),
      ],
    );
  }

  InputBorder getInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color),
    );
  }
}