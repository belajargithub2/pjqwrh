import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOutlineTextInputWithoutLabel extends StatefulWidget {
  String? text;
  String? hint;
  TextEditingController? controller;
  Widget? widgetSuffix;
  bool obscureText;
  bool isReadOnly;
  Function? onFieldTap;
  double borderRadius;
  Function? onChange;
  bool isNumberOnly;
  bool isRequired;
  bool isNext;
  Key? myKey;
  FocusNode? focusNode;
  bool customValidator;
  String? customValidatorMessage;
  String? Function(String?)? customValidatorMethod;
  int? maxInputLength;

  CustomOutlineTextInputWithoutLabel({
    super.key,
    this.controller,
    this.text,
    this.hint,
    this.widgetSuffix,
    this.isNumberOnly = false,
    this.onChange,
    this.isRequired = true,
    this.myKey,
    this.focusNode,
    this.onFieldTap,
    this.isNext = true,
    this.isReadOnly = false,
    this.borderRadius = 4.0,
    this.obscureText = false,
    this.customValidator = false,
    this.customValidatorMessage,
    this.customValidatorMethod,
    this.maxInputLength,
  });

  @override
  _CustomOutlineTextInputWithoutLabelState createState() =>
      _CustomOutlineTextInputWithoutLabelState();
}

class _CustomOutlineTextInputWithoutLabelState extends State<CustomOutlineTextInputWithoutLabel> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.isNumberOnly
          ? TextInputType.phone
          : TextInputType.emailAddress,
      onChanged: (val) {
        if (widget.onChange != null) widget.onChange!(val);
      },
      inputFormatters: widget.isNumberOnly
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.maxInputLength),
            ]
          : [],
      obscureText: widget.obscureText,
      controller: widget.controller,
      focusNode: widget.focusNode,
      key: widget.myKey ?? Key(widget.text!.toLowerCase().trim()),
      textInputAction:
          widget.isNext ? TextInputAction.next : TextInputAction.none,
      readOnly: widget.isReadOnly,
      validator: (value) {
        if (widget.customValidatorMethod != null) {
          return widget.customValidatorMethod!(value);
        } else if (widget.isRequired) {
          if (value!.isEmpty) {
            return '${widget.text} tidak boleh kosong';
          } else if (widget.customValidator) {
            return '${widget.customValidatorMessage}';
          }
        }
        return null;
      },
      decoration: InputDecoration(
        errorMaxLines: 3,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF01A3DE )),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD1D1D1)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFF46363)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF01A3DE )),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFD1D1D1)),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        contentPadding: const EdgeInsets.all(10.0),
        hintText: widget.hint ?? widget.text,
        suffixIcon: widget.widgetSuffix,
      ),
      onTap: () {
        if (widget.onFieldTap != null) widget.onFieldTap!();
      },
    );
  }
}
