# Deasy Text Form
Collection of textForm with easy style

## Table of Contents
- [Getting Started](#getting-started)
- [Demo](#demo)
- [Usage](#usage)

## Getting Started
add import:

```dart
import 'package:deasy_text_form/deasy_text_form.dart';
```

## Demo
![WhatsApp Image 2023-01-17 at 14 06 51](https://user-images.githubusercontent.com/91040581/212832551-6dab6bc9-17c8-413f-b3f1-5c4248e2cb17.jpeg)


## Usage
### underLineTextForm
```dart
DeasyTextForm.underlinedTextForm(
  hintText: "Underlined Text Form",
  labelText: "Underlined Text Form"
),
```

parameters :
- labelText (String|required)
- hintText (String|required)
- prefixText (String|optional)
- focusNode (FocusNode|optional)
- textInputType (TextInputType|optional)
- defaultText (String|optional)
- obscure (bool|optional)
- controller (TextEditingController|optional)
- functionValidate (String|optional)
- parametersValidate (String|optional)
- actionKeyboard (TextInputAction|optional)
- onSubmitField (Function|optional)
- onFieldTap (Function|optional)
- onChange (Function|optional)
- prefixIcon (Widget|optional)
- suffixIcon (Widget|optional)
- readOnly (bool|optional)

### registerTextForm
```dart
DeasyTextForm.registerTextForm(
  title: "Register Text Form",
  hintText: "Register Text Form",
  textFieldKey: Key('ket'),
  controller: controller,
  bottomNote: "tes",
  bottomNoteVisibility: false,
),
```

parameters :
- title (String|required)
- hintText (String|required)
- controller (TextEditingController|required)
- bottomNote (String|required)
- bottomNoteVisibility (bool|required)
- textFieldKey (Key|optional)
- onFieldTap (Function|optional)
- widgetSuffix (Widget|optional)
- obscure (bool|optional)
- isReadOnly (bool|optional)
- borderRadius.0 (double|optional)
- onChange (Function|optional)
- isNumberOnly (bool|optional)
- isRequired (bool|optional)
- isNext (bool|optional)
- customValidator (bool|optional)
- customValidatorMessage (String|optional)
- customValidatorMethod (Function|optional)
- focusNode (FocusNode|optional)
- maxInputLength (int|optional)

### customTextForm
```dart
DeasyTextForm.customTextForm(
  title: "Custom Text Form",
  controller: controller,
),
```

parameters :
- title (String|required)
- controller (TextEditingController|required)
- widgetSuffix (Widget|optional)
- obscure (bool|optional)
- onChange (Function|optional)
- isRequired (bool|optional)
- labelSize (double|optional)
- isNumberOnly (bool|optional)

## outlinedTextForm
```dart
DeasyTextForm.outlinedTextForm(
  hintText: "Outlined Text Form",
  labelText: "Outlined Text Form",
  controller: controller,
),
```

parameters :
- hintText (String|required)
- labelText (String|required)
- controller (TextEditingController|required)
- prefixText (String|optional)
- focusNode (FocusNode|optional)
- textInputType (TextInputType|optional)
- defaultText (String|optional)
- obscure (bool|optional)
- functionValidate (String|optional)
- parametersValidate (String|optional)
- actionKeyboard (TextInputAction|optional)
- onSubmitField (Function|optional)
- onFieldTap (Function|optional)
- onChange (Function|optional)
- prefixIcon (Widget|optional)
- suffixIcon (Widget|optional)
- readOnly (bool|optional)
- customValidation (bool|optional)
- isNumberOnly (bool|optional)
- isDisabled (bool|optional)
- fontSize (double|optional)
- labelSize (double|optional)
- paddingBottom (double|optional)
- contentPaddingHorizontal (double|optional)
- labelFontFamily (String|optional)
- trailing (Widget|optional)
- maxInputLength (int|optional)
- isNoSpaceOnly (bool|optional)

## customTextFormWithoutLabel
```dart
DeasyTextForm.customTextFormWithoutLabel(),
```

parameters :
- labelText (String|optional)
- hintText (String|optional)
- widgetSuffix (Widget|optional)
- isNumberOnly (bool|optional)
- controller (TextEditingController|optional)
- onChange (Function|optional)
- isRequired (bool|optional)
- textFieldKey (Key|optional)
- focusNode (FocusNode|optional)
- onFieldTap (Function|optional)
- isNext (bool|optional)
- isReadOnly (bool|optional)
- borderRadius (double|optional)
- obscure (bool|optional)
- customValidator (bool|optional)
- customValidatorMessage (String|optional)
- customValidatorMethod (Function|optional)
- maxInputLength (int|optional)