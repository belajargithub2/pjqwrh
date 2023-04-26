import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/models/response_get_agent_fee.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/agent_fee/repositories/agent_fee_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/build_context_mock.dart';
import '../dummy/agent_fee_dummy.dart';
import 'agent_fee_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DioClient>()])
void main() {
  late AgentFeeRepository repository;
  late MockBuildContext context;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    context = MockBuildContext();
    repository = AgentFeeRepository(provider: mockDioClient);
  });

  test('should return image when postGetAgentFee is called', () async {
    // arrange
    when(mockDioClient.post(
      context,
      Scope.MERCHANT,
      "agents/reports/fees/view",
      null,
      isReturnJson: false,
    )).thenAnswer((_) async => Future.value(Uint8List(0)));

    // act
    final result = await repository.postDownloadAgentFee("post_download_agent_fee");

    // assert
    expect(result, isA<Uint8List>());
  });

  test('should return response when postGetAgentFee is called', () async {
    // arrange
    when(mockDioClient.post(
            context, Scope.MERCHANT, "agents/reports/fees", requestGetAgentFee,
            showSnackbar: true))
        .thenAnswer((_) async => Future.value(responseGetAgentFee.toJson()));

    // act
    final result = await repository.postGetAgentFee(requestGetAgentFee, "post_get_agent_fee");

    // assert
    expect(result, isA<ResponseGetAgentFee>());
  });
}
