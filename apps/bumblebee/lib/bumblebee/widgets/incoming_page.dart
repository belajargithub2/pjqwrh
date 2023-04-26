import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:deasy_helper/deasy_helper.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/text_field.dart';

class IncomingPage extends StatefulWidget {
  static const routeName = "/incoming";

  @override
  _IncomingPageState createState() => _IncomingPageState();
}

class _IncomingPageState extends State<IncomingPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime(1990);

  final _nikController = TextEditingController();

  final _nikFocusNode = FocusNode();

  final _nameController = TextEditingController();

  final _nameFocusNode = FocusNode();

  final _dobController = TextEditingController();

  final _dobFocusNode = FocusNode();

  final _phoneNumberController = TextEditingController();

  final _phoneNumberFocusNode = FocusNode();

  final _maidenNameController = TextEditingController();

  final _maidenNameFocusNode = FocusNode();

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      _dobController.text = _selectedDate.toFormattedDate();
    } else {
      _dobController.text = _selectedDate.toFormattedDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Incoming")),
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: UnderlinedTextField(
                  hintText: "NIK",
                  labelText: "NIK",
                  obscureText: false,
                  textInputType: TextInputType.number,
                  actionKeyboard: TextInputAction.next,
                  functionValidate: commonValidation,
                  controller: _nikController,
                  focusNode: _nikFocusNode,
                  parametersValidate: "This field is required.",
                  prefixIcon: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: UnderlinedTextField(
                  hintText: "Nama",
                  labelText: "Nama",
                  obscureText: false,
                  textInputType: TextInputType.text,
                  actionKeyboard: TextInputAction.next,
                  functionValidate: commonValidation,
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  parametersValidate: "This field is required.",
                  prefixIcon: null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: UnderlinedTextField(
                  hintText: "Tanggal Lahir",
                  labelText: "Tanggal Lahir",
                  obscureText: false,
                  textInputType: null,
                  actionKeyboard: TextInputAction.next,
                  functionValidate: commonValidation,
                  controller: _dobController,
                  focusNode: _dobFocusNode,
                  onFieldTap: () {
                    _showDatePicker(context);
                  },
                  readOnly: true,
                  parametersValidate: "This field is required.",
                  prefixIcon: null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: UnderlinedTextField(
                  hintText: "Nomor Handphone",
                  labelText: "Nomor Handphone",
                  obscureText: false,
                  textInputType: TextInputType.number,
                  actionKeyboard: TextInputAction.next,
                  functionValidate: commonValidation,
                  controller: _phoneNumberController,
                  focusNode: _phoneNumberFocusNode,
                  parametersValidate: "This field is required.",
                  prefixIcon: null,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                child: UnderlinedTextField(
                  hintText: "Nama Gadis Ibu Kandung",
                  labelText: "Nama Gadis Ibu Kandung",
                  obscureText: false,
                  textInputType: TextInputType.name,
                  actionKeyboard: TextInputAction.done,
                  functionValidate: commonValidation,
                  controller: _maidenNameController,
                  focusNode: _maidenNameFocusNode,
                  parametersValidate: "This field is required.",
                  prefixIcon: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 16, bottom: 8),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: double.infinity),
                  child: DeasyCustomButton(
                      text: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Submitting Data')));
                        }
                      }),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
