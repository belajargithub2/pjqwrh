import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../util/hex_color.dart';

class TermConditionScreen extends StatefulWidget {
  const TermConditionScreen({Key? key}) : super(key: key);

  static const routeName = '/termcondtion';

  @override
  State<TermConditionScreen> createState() => _TermConditionScreenState();
}

class _TermConditionScreenState extends State<TermConditionScreen> {
  double webProgress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Syarat & Ketentuan Daily Check-In",
            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: HexColor.statusBarColor,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      body: Container(
        color: HexColor('#F7F7F7'),
        child: Column(
          children: [
            webProgress < 1 ? SizedBox(
              height: 5,
              child: LinearProgressIndicator(
                value: webProgress,
                color: HexColor('#FFBC00'),
                backgroundColor: HexColor('#D2D2D2'),
              ),
            ) : const SizedBox(),
            Expanded(
              child: WebView(
                initialUrl: 'https://dev-kpm-api.kreditplus.com/api/data/info/checkin-privacypolicy',
                javascriptMode: JavascriptMode.unrestricted,
                onProgress: (progress) => setState((){
                  webProgress = progress / 100;
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
