import 'package:kreditplus_deasy_website/optimus/modules/dashboard/repositories/transaction_repository.dart';
import 'package:mockito/mockito.dart';

class TransactionRepositoryMock with Mock implements TransactionRepository {

  @override
  Future<String> fetchPdfUrl({String? type, String? prospectId}) {
    return Future.value("https://dev-merchant-api.kreditplus.com/reports/bast/KPM-TST-DGS8901610/view");
  }

}
