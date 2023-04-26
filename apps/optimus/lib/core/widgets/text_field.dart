import 'package:deasy_text/deasy_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:deasy_color/deasy_color.dart';
import 'package:kreditplus_deasy_website/core/utils/extensions.dart';

import 'decoration.dart';

/// *  textInputType - The type of information for which to optimize the text input control.
/// *  hintText - Text that suggests what sort of input the field accepts.
/// *  prefixIcon - Pass Icon if required
/// *  defaultText - If there is predefined value is there for a text field
/// *  focusNode - Currently focus node
/// *  obscureText - Is Password field?
/// *  controller - Text controller
/// *  functionValidate - Validation function(currently I have used to check empty field)
/// *  parametersValidate - Value to validate
/// *  actionKeyboard - Keyboard action eg. next, done, search, etc
/// *  onSubmitField - Done click action
/// *  onFieldTap - On focus on TextField
class UnderlinedTextField extends StatefulWidget {
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

  const UnderlinedTextField({
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
  _UnderlinedTextFieldState createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
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
      style: TextStyle(
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

class OutlinedTextField extends StatefulWidget {
  final TextInputType? textInputType;
  final String? hintText;
  final String? labelText;
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
  double fontSize;
  double? labelSize;
  double paddingBottom;
  double contentPaddingHorizontal;
  FontFamily labelFontFamily;
  Widget? trailing;
  int? maxInputLength;

  OutlinedTextField({
    this.hintText,
    this.labelText,
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
    this.labelFontFamily = FontFamily.light,
    this.trailing,
    this.maxInputLength,
    this.isNoSpaceOnly = false,
  });

  @override
  _OutlinedTextFieldState createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  double bottomPaddingToError = 12;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.labelText!,
                  style: TextStyle(
                      fontFamily: getFontFamily(widget.labelFontFamily),
                      fontSize: widget.labelSize == null
                          ? widget.fontSize
                          : widget.labelSize)),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
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
              focusedBorder: getInputBorder(color: DeasyColor.semanticInfo300),
              errorBorder: getInputBorder(color: DeasyColor.dmsF46363),
              focusedErrorBorder: getInputBorder(color: DeasyColor.dmsF46363),
              disabledBorder: getInputBorder(color: DeasyColor.neutral000),
              prefixText: widget.prefixText,
              hintText: widget.hintText,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              errorMaxLines: 2,
              errorStyle: TextStyle(
                  fontFamily: getFontFamily(FontFamily.light),
                  fontSize: 12,
                  color: DeasyColor.dmsF46363,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal),
              filled: widget.isDisabled,
              fillColor: DeasyColor.neutral400),
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

class CustomOutlineTextInput extends StatefulWidget {
  String? text;
  TextEditingController? controller;
  Widget? widgetSuffix;
  bool obscureText;
  Function? onChange;
  bool isRequired;
  double? labelSize;
  bool isNumberOnly;

  CustomOutlineTextInput(
      {this.text,
      this.widgetSuffix,
      this.controller,
      this.onChange,
      this.obscureText = false,
      this.isRequired = true,
      this.labelSize,
      this.isNumberOnly = false});

  @override
  _CustomOutlineTextInputState createState() => _CustomOutlineTextInputState();
}

class _CustomOutlineTextInputState extends State<CustomOutlineTextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: widget.labelSize),
        ),
        SizedBox(
          height: 4,
        ),
        TextFormField(
          keyboardType: widget.isNumberOnly
              ? TextInputType.phone
              : TextInputType.emailAddress,
          inputFormatters: widget.isNumberOnly
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ]
              : [],
          style: TextStyle(fontSize: 14.0),
          onChanged: (val) {
            if (widget.onChange != null) widget.onChange!(val);
          },
          validator: (value) {
            if (widget.isRequired) {
              if (value!.isEmpty) {
                return '${widget.text} tidak boleh kosong';
              }
            }
            return null;
          },
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.neutral400),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.semanticInfo300),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.dmsF46363),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.kpYellow500),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.neutral000),
            ),
            contentPadding: EdgeInsets.all(10.0),
            hintText: widget.text,
            suffixIcon:
                widget.widgetSuffix != null ? widget.widgetSuffix : Text(''),
          ),
        ),
      ],
    );
  }
}

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
    this.text,
    this.hint,
    this.widgetSuffix,
    this.isNumberOnly = false,
    this.controller,
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

class _CustomOutlineTextInputWithoutLabelState
    extends State<CustomOutlineTextInputWithoutLabel> {
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
      key: widget.myKey == null
          ? Key('${widget.text!.toLowerCase().trim()}')
          : widget.myKey,
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
          borderSide: BorderSide(color: DeasyColor.semanticInfo300),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral300),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.dmsF46363),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.semanticInfo300),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DeasyColor.neutral300),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        contentPadding: EdgeInsets.all(10.0),
        hintText: widget.hint ?? widget.text,
        suffixIcon: widget.widgetSuffix,
      ),
      onTap: () {
        if (widget.onFieldTap != null) widget.onFieldTap!();
      },
    );
  }
}

class EditTextWidget extends StatefulWidget {
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
  final double paddingBottom;
  final bool isReadOnly;
  final bool isEnabled;
  final bool isSelectable;
  final Color? extraTextColor;
  final double borderRadius;
  final Widget? widgetSuffix;
  final TextEditingController controller;
  final double fontSize;
  final double extraFontSize;

  EditTextWidget({
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
    this.paddingBottom = 2,
    this.isSelectable = false,
    this.extraTextColor,
    this.fontSize = 0,
    this.extraFontSize = 0,
  });

  @override
  State<EditTextWidget> createState() => _EditTextWidgetState();
}

class _EditTextWidgetState extends State<EditTextWidget> {
  bool isError = false;
  String? errorMessage = "data ini tidak boleh kosong";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        DeasyTextView(
          text: widget.title,
          fontSize: widget.fontSize == 0 ? 11.sp : widget.fontSize,
          isSelectable: widget.isSelectable,
          fontFamily: FontFamily.medium,
        ),
        SizedBox(height: 8.0),
        TextFormField(
          style: TextStyle(
              fontSize: widget.fontSize == 0 ? 11.sp : widget.fontSize),
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
                fontSize: widget.fontSize == 0 ? 11.sp : widget.fontSize),
            errorStyle: TextStyle(height: 0.01),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.semanticInfo300),
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
              borderSide: BorderSide(color: DeasyColor.semanticInfo300),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: DeasyColor.neutral300),
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
            contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                isSelectable: widget.isSelectable,
                fontFamily: FontFamily.light,
                fontSize:
                    widget.extraFontSize == 0 ? 10.sp : widget.extraFontSize,
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
                isSelectable: widget.isSelectable,
                fontFamily: FontFamily.light,
                fontSize:
                    widget.extraFontSize == 0 ? 10.sp : widget.extraFontSize,
                fontColor: widget.extraTextColor ?? DeasyColor.kpBlue600,
              ),
            )),
        SizedBox(
          height: widget.paddingBottom,
        ),
      ],
    );
  }
}

String? commonValidation(String value, String messageError) {
  var required = requiredValidator(value, messageError);
  if (required != null) {
    return required;
  }
  return null;
}

String? requiredValidator(value, messageError) {
  if (value.isEmpty) {
    return messageError;
  }
  return null;
}

bool isValidPhoneNumber(String value) {
  if (value == null || value.isEmpty) {
    return false;
  }

  const pattern = r'(?:[0]9)?[0-9]{9,14}$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return false;
  }

  return true;
}

bool isValidIdNumber(String value) {
  if (value == null || value.isEmpty) return false;

  const pattern =
      r'^[0-9]{6}((0[1-9]|[12][0-9]|3[01])|(4[1-9]|5[0-9]|6[0-9]|7[1|0]))(0[1-9]|1[012])([0-9]{2})([0-9]{4})*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(value)) {
    return false;
  }

  return true;
}

void changeFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
