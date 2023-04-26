import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:mockito/mockito.dart';

class TransactionRepositoryMock
    with Mock
    implements BumblebeeTransactionRepository {
  @override
  Future<String> fetchPdfUrl({String? type, String? prospectId}) {
    return Future.value(
        "https://dev-merchant-api.kreditplus.com/reports/bast/KPM-TST-DGS8901610/view");
  }
}
