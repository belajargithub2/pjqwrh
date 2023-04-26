import 'package:deasy_color/deasy_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomOutlineTextForm extends StatefulWidget {
  String? text;
  TextEditingController? controller;
  Widget? widgetSuffix;
  bool obscureText;
  Function? onChange;
  bool isRequired;
  double? labelSize;
  bool isNumberOnly;

  CustomOutlineTextForm(
      {this.text,
      this.widgetSuffix,
      this.controller,
      this.onChange,
      this.obscureText = false,
      this.isRequired = true,
      this.labelSize,
      this.isNumberOnly = false});

  @override
  _CustomOutlineTextFormState createState() => _CustomOutlineTextFormState();
}

class _CustomOutlineTextFormState extends State<CustomOutlineTextForm> {
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
              borderSide: BorderSide(color: Color(0xFF01A3DE)),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF46363)),
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
