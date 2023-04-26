import 'package:deasy_text_form/src/common/decoration.dart';
import 'package:flutter/material.dart';

class UnderlinedTextForm extends StatefulWidget {
  final TextInputType? textInputType;
  final String hintText;
  final String labelText;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? defaultText;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextEditingController? controller;
  final Function? functionValidate;
  final String? parametersValidate;
  final TextInputAction actionKeyboard;
  final Function? onSubmitField;
  final Function? onFieldTap;
  final Function? onChange;
  final bool readOnly;

  const UnderlinedTextForm({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscureText = false,
    this.controller,
    this.functionValidate,
    this.parametersValidate,
    this.actionKeyboard = TextInputAction.next,
    this.onSubmitField,
    this.onFieldTap,
    this.onChange,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
  });

  @override
  _UnderlinedTextFormState createState() => _UnderlinedTextFormState();
}

class _UnderlinedTextFormState extends State<UnderlinedTextForm> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        if (widget.onChange != null) widget.onChange!(value);
      },
      cursorColor: Colors.blue,
      obscureText: widget.obscureText,
      keyboardType: widget.textInputType,
      textInputAction: widget.actionKeyboard,
      focusNode: widget.focusNode,
      readOnly: widget.readOnly,
      textAlignVertical: TextAlignVertical.bottom,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14.0,
        height: 1,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        letterSpacing: 1.2,
      ),
      initialValue: widget.defaultText,
      decoration: underlinedInputDecoration(
          context: context,
          prefixText: widget.prefixText,
          hinText: widget.hintText,
          labelText: widget.labelText,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon),
      controller: widget.controller,
      validator: (value) {
        if (widget.functionValidate != null) {
          String? resultValidate =
              widget.functionValidate!(value, widget.parametersValidate);
          if (resultValidate != null) {
            return resultValidate;
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
    );
  }
}
