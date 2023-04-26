import 'package:deasy_text_form/src/widgets/custom_outline_text_without_label.dart';
import 'package:flutter/material.dart';

class BuildRegisterTextForm extends StatelessWidget {
  final Key textFieldKey;
  final String title;
  final String hintText;
  final TextEditingController controller;
  final Widget? widgetSuffix;
  final bool obscureText;
  final bool isReadOnly;
  final Function? onFieldTap;
  final double borderRadius;
  final Function(String)? onChange;
  final bool isNumberOnly;
  final bool isRequired;
  final bool isNext;
  final FocusNode? focusNode;
  final String bottomNote;
  final bool bottomNoteVisibility;
  final bool customValidator;
  final String? customValidatorMessage;
  final String? Function(String?)? customValidatorMethod;
  final int? maxInputLength;

  BuildRegisterTextForm(
      {required this.textFieldKey,
      required this.title,
      required this.hintText,
      required this.controller,
      this.widgetSuffix,
      this.obscureText = false,
      this.isReadOnly = false,
      this.onFieldTap,
      this.borderRadius = 4.0,
      this.onChange,
      this.isNumberOnly = false,
      this.isRequired = true,
      this.isNext = true,
      this.customValidator = false,
      this.customValidatorMessage,
      this.customValidatorMethod,
      this.focusNode,
      this.maxInputLength,
      required this.bottomNote,
      required this.bottomNoteVisibility});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 8,
        ),
        CustomOutlineTextInputWithoutLabel(
          borderRadius: borderRadius,
          isRequired: isRequired,
          onChange: onChange,
          focusNode: focusNode,
          isReadOnly: isReadOnly,
          text: title,
          hint: hintText,
          maxInputLength: maxInputLength,
          isNumberOnly: isNumberOnly,
          controller: controller,
          onFieldTap: onFieldTap,
          widgetSuffix: widgetSuffix,
          customValidator: customValidator,
          customValidatorMessage: customValidatorMessage,
          customValidatorMethod: customValidatorMethod,
        ),
        Visibility(
          visible: bottomNoteVisibility,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Text(
                bottomNote,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
