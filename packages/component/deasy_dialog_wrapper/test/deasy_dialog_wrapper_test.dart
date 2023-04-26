import 'package:flutter_test/flutter_test.dart';

import 'package:deasy_dialog_wrapper/deasy_dialog_wrapper.dart';
import 'package:mockito/mockito.dart';

class DialogMock extends Mock implements DeasyDialogWrapper {}

void main() {
  final dialogWrapper = DialogMock();
  test('test dialog', () {
    when(dialogWrapper.dialog(any, any)).thenAnswer((_) async => true);
  });
}
