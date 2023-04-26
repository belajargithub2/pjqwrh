import 'package:deasy_text_form/src/common/font_family.dart';
import 'package:deasy_text_form/src/widgets/custom_outline_text_form.dart';
import 'package:deasy_text_form/src/widgets/custom_outline_text_without_label.dart';
import 'package:deasy_text_form/src/widgets/outlined_text_form.dart';
import 'package:deasy_text_form/src/widgets/register_text_form.dart';
import 'package:deasy_text_form/src/widgets/under_lined_text_form.dart';
import 'package:flutter/material.dart';

enum DeasyStyle {
  registerTextForm,
  underlinedTextForm,
  outlinedTextForm,
  customTextForm,
  customTextFormWithoutLabel,
}

class DeasyTextForm extends StatelessWidget {
  late final DeasyStyle _deasyStyle;
  late final FocusNode? focusNode;
  late final bool obscure;
  late final String? hintText;
  late final TextEditingController? controller;
  late final Function? onFieldTap;
  late final Function? onChange;
  late final Key? textFieldKey;
  late final String title;
  late final Widget? widgetSuffix;
  late final bool isReadOnly;
  late final double borderRadius;
  late final bool isNumberOnly;
  late final bool isRequired;
  late final bool isNext;
  late final String bottomNote;
  late final bool bottomNoteVisibility;
  late final bool customValidator;
  late final String? customValidatorMessage;
  late final String? Function(String?)? customValidatorMethod;
  late final int? maxInputLength;
  late final TextInputType? textInputType;
  late final String? labelText;
  late final Widget? customLabelWidget;
  late final String? prefixText;
  late final Widget? prefixIcon;
  late final Widget? suffixIcon;
  late final String? defaultText;
  late final Function? functionValidate;
  late final String? parametersValidate;
  late final TextInputAction actionKeyboard;
  late final Function? onSubmitField;
  late final bool readOnly;
  late final Function? customValidation;
  late final bool isNoSpaceOnly;
  late final bool isDisabled;
  late final double fontSize;
  late final double? labelSize;
  late final double paddingBottom;
  late final double contentPaddingHorizontal;
  late final FontFamilyTextForm labelFontFamily;
  late final Widget? trailing;

  DeasyTextForm.customTextFormWithoutLabel({
    Key? key,
    this.labelText = '',
    this.hintText = '',
    this.widgetSuffix,
    this.isNumberOnly = false,
    this.controller,
    this.onChange,
    this.isRequired = true,
    this.textFieldKey,
    this.focusNode,
    this.onFieldTap,
    this.isNext = true,
    this.isReadOnly = false,
    this.borderRadius = 4.0,
    this.obscure = false,
    this.customValidator = false,
    this.customValidatorMessage,
    this.customValidatorMethod,
    this.maxInputLength,
  }) : super(key: key) {
    _deasyStyle = DeasyStyle.customTextFormWithoutLabel;
  }

  DeasyTextForm.customTextForm({
    Key? key,
    required this.title,
    required this.controller,
    this.widgetSuffix,
    this.obscure = false,
    this.onChange,
    this.isRequired = true,
    this.labelSize,
    this.isNumberOnly = false,
  }) : super(key: key) {
    assert(controller != null, 'Controller cannot be null');
    assert(title.isNotEmpty, "Title must not be empty");
    _deasyStyle = DeasyStyle.customTextForm;
  }

  DeasyTextForm.outlinedTextForm({
    required this.controller,
    this.hintText,
    this.labelText,
    this.customLabelWidget,
    this.prefixText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscure = false,
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
  }) {
    assert(controller != null, 'Controller cannot be null');
    _deasyStyle = DeasyStyle.outlinedTextForm;
  }

  DeasyTextForm.underlinedTextForm({
    super.key,
    required this.hintText,
    required this.labelText,
    this.prefixText,
    this.focusNode,
    this.textInputType,
    this.defaultText,
    this.obscure = false,
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
  }) {
    _deasyStyle = DeasyStyle.underlinedTextForm;
  }

  DeasyTextForm.registerTextForm({
    required this.title,
    required this.hintText,
    required this.controller,
    required this.bottomNote,
    required this.bottomNoteVisibility,
    required this.textFieldKey,
    this.onFieldTap,
    this.widgetSuffix,
    this.obscure = false,
    this.isReadOnly = false,
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
  }) {
    assert(controller != null, 'Controller cannot be null');
    assert(textFieldKey != null, 'textFieldKey cannot be null');
    _deasyStyle = DeasyStyle.registerTextForm;
  }

  @override
  Widget build(BuildContext context) {
    switch (_deasyStyle) {
      case DeasyStyle.registerTextForm:
        return _buildRegisterTextForm();
      case DeasyStyle.underlinedTextForm:
        return _buildUnderlinedTextForm();
      case DeasyStyle.outlinedTextForm:
        return _buildOutlinedTextForm();
      case DeasyStyle.customTextForm:
        return _buildCustomTextForm();
      case DeasyStyle.customTextFormWithoutLabel:
        return _buildCustomTextFormWithoutLabel();
      default:
        return Container();
    }
  }

  Widget _buildRegisterTextForm() {
    return BuildRegisterTextForm(
      textFieldKey: textFieldKey!,
      title: title,
      hintText: hintText!,
      controller: controller!,
      widgetSuffix: widgetSuffix,
      obscureText: obscure,
      isReadOnly: isReadOnly,
      onFieldTap: onFieldTap,
      borderRadius: borderRadius,
      onChange: onChange as void Function(String)?,
      isNumberOnly: isNumberOnly,
      isRequired: isRequired,
      isNext: isNext,
      focusNode: focusNode,
      maxInputLength: maxInputLength,
      bottomNote: bottomNote,
      bottomNoteVisibility: bottomNoteVisibility,
      customValidator: customValidator,
      customValidatorMessage: customValidatorMessage,
      customValidatorMethod: customValidatorMethod,
    );
  }

  Widget _buildUnderlinedTextForm() {
    return UnderlinedTextForm(
      hintText: hintText!,
      labelText: labelText!,
      prefixText: prefixText,
      focusNode: focusNode,
      textInputType: textInputType,
      defaultText: defaultText,
      obscureText: obscure,
      controller: controller,
      functionValidate: functionValidate,
      parametersValidate: parametersValidate,
      actionKeyboard: actionKeyboard,
      onSubmitField: onSubmitField,
      onFieldTap: onFieldTap,
      onChange: onChange as void Function(String)?,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      readOnly: readOnly,
    );
  }

  Widget _buildOutlinedTextForm() {
    return OutlinedTextForm(
      hintText: hintText,
      labelText: labelText,
      customLabelWidget: customLabelWidget,
      prefixText: prefixText,
      focusNode: focusNode,
      textInputType: textInputType,
      defaultText: defaultText,
      obscureText: obscure,
      controller: controller,
      functionValidate: functionValidate,
      actionKeyboard: actionKeyboard,
      onSubmitField: onSubmitField,
      onFieldTap: onFieldTap,
      onChange: onChange as void Function(String)?,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      readOnly: readOnly,
      customValidation: customValidation,
      isNumberOnly: isNumberOnly,
      isDisabled: isDisabled,
      fontSize: fontSize,
      labelSize: labelSize,
      paddingBottom: paddingBottom,
      contentPaddingHorizontal: contentPaddingHorizontal,
      labelFontFamily: labelFontFamily,
      trailing: trailing,
      maxInputLength: maxInputLength,
      isNoSpaceOnly: isNoSpaceOnly,
      parametersValidate: parametersValidate,
    );
  }

  Widget _buildCustomTextForm() {
    return CustomOutlineTextForm(
      text: title,
      controller: controller,
      widgetSuffix: widgetSuffix,
      obscureText: obscure,
      onChange: onChange as void Function(String)?,
      isRequired: isRequired,
      labelSize: labelSize,
      isNumberOnly: isNumberOnly,
    );
  }

  Widget _buildCustomTextFormWithoutLabel() {
    return CustomOutlineTextInputWithoutLabel(
      text: labelText,
      hint: hintText,
      controller: controller,
      widgetSuffix: widgetSuffix,
      obscureText: obscure,
      isReadOnly: isReadOnly,
      onFieldTap: onFieldTap,
      borderRadius: borderRadius,
      onChange: onChange as void Function(String)?,
      isNumberOnly: isNumberOnly,
      isRequired: isRequired,
      isNext: isNext,
      myKey: textFieldKey,
      focusNode: focusNode,
      customValidator: customValidator,
      customValidatorMessage: customValidatorMessage,
      customValidatorMethod: customValidatorMethod,
      maxInputLength: maxInputLength,
    );
  }
}
