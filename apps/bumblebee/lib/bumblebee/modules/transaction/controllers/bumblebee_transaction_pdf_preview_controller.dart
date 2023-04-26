import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/transaction/repositories/bumblebee_transaction_repository.dart';
import 'package:deasy_pocket/deasy_pocket.dart';

class BumblebeeTransactionPdfPreviewController extends GetxController {
  Map<String, String>? authorizationMap;
  final BumblebeeTransactionRepository transactionRepository;

  BumblebeeTransactionPdfPreviewController(
      {required this.transactionRepository});

  @override
  void onInit() {
    super.onInit();
    setToken();
  }

  Future<String> loadDocument({String? type, String? prospectId}) async {
    return await transactionRepository.fetchPdfUrl(
        type: type, prospectId: prospectId);
  }

  void setToken() async {
    String token = await getToken();
    authorizationMap = {"Authorization": "Bearer $token"};
  }

  Future<String> getToken() async {
    return await DeasyPocket().getToken();
  }
}
