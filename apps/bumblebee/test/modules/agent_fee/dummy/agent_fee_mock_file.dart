import 'dart:io';
import 'package:mockito/mockito.dart';

class MockFile extends Mock implements File {

  @override
  Future<File> writeAsBytes(List<int> bytes, {FileMode mode = FileMode.write, bool flush = false}) {
    return super.noSuchMethod(Invocation.method(#writeAsBytes, [bytes, mode, flush]), returnValue: Future.value(this));
  }
}