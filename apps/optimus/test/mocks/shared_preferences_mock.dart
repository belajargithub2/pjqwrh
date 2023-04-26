import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class DeasyPocketMock with Mock implements DeasyPocket {
  @override
  Future<String> getToken() {
    return Future.value("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
  }
}