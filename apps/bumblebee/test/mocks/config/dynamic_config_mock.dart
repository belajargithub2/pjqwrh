import 'package:deasy_repository/deasy_repository.dart';
import 'package:kreditplus_deasy_mobile/core/config/deep_link_config.dart';
import 'package:mockito/mockito.dart';

class DynamicLinkConfigMock with Mock implements DynamicLinkConfig {
  @override
  Future<String> createDynamicLink(
      String? token,
      DeepLinkRepository deepLinkRepository,
      String? email,
      String flag,
      String route) {
    return Future.value("https://deasy.page.link/fk9cm52Nr3EQMseY7");
  }
}
