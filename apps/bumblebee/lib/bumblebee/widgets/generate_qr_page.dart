import 'package:deasy_buttons/deasy_buttons.dart';
import 'package:flutter/material.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/text_field.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRPage extends StatefulWidget {
  static const routeName = "/generate_qr";

  @override
  _GenerateQRPageState createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  GlobalKey globalKey = new GlobalKey();
  String _dataString = "";
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate QR Code'),
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              left: 20.0,
              right: 10.0,
              bottom: 12.0,
            ),
            child: Container(
              height: 50.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: UnderlinedTextField(
                      labelText: "Masukan url/text",
                      hintText: "Contoh : www.google.com",
                      obscureText: false,
                      textInputType: TextInputType.name,
                      actionKeyboard: TextInputAction.done,
                      functionValidate: commonValidation,
                      controller: _textController,
                      parametersValidate: "This field is required.",
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(width: 110),
                      child: DeasyCustomButton(
                          text: "Generate",
                          color: Colors.blue,
                          onPressed: () {
                            if (_textController.text.isNotEmpty) {
                              setState(() {
                                _dataString = _textController.text;
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      'Harap isi url/text',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    backgroundColor: Colors.red));
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_dataString.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: _dataString,
                    size: 0.5 * bodyHeight,
                    errorStateBuilder: (context, object) {
                      print("[QR] ERROR - $object");
                      return null;
                    } as Widget Function(BuildContext, Object?)?,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
