import 'package:deasy_config/deasy_config.dart';
import 'package:mockito/mockito.dart';

class AnalyticsConfigMock extends Mock implements AnalyticConfig {
  @override
  Future<void> sendEvent(String eventName,
      {Map<String, dynamic>? parameters}) async {}
}
