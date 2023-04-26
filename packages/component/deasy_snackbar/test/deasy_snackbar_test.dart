import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('SnackBar control test', (WidgetTester tester) async {
    const String helloSnackBar = 'Hello SnackBar';
    const Key tapTarget = Key('tap-target');
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              DeasySnackBarUtil.showSnackBar(context, helloSnackBar);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              height: 100.0,
              width: 100.0,
              key: tapTarget,
            ),
          );
        }),
      ),
    ));
    expect(find.text(helloSnackBar), findsNothing);
    await tester.tap(find.byKey(tapTarget));
    expect(find.text(helloSnackBar), findsNothing);
    await tester.pump(); // schedule animation
    expect(find.text(helloSnackBar), findsOneWidget);
  });
}
