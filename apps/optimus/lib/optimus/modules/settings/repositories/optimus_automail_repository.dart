import 'package:get/get.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';
import 'package:kreditplus_deasy_website/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_add_recipients_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_enable_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/request/automail_update_recipient_request.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_add_recipients_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_enable_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipient_detail_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipient_type_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_recipients_response.dart';
import 'package:kreditplus_deasy_website/optimus/modules/settings/models/automail_models/response/automail_update_recipients_response.dart';

class OptimusAutomailRepository {
  DioClient _provider = DioClient();

  Future<AutomailRecipientType> getRecipientTypes() async {
    final response = await _provider.get(
        Get.context, Scope.MERCHANT, "settings/auto-mail/recipient-type", null);
    return AutomailRecipientType.fromJson(response);
  }

  Future<AutomailRecipientsResponse> getAllRecipients(
      {required String searchKey,
      required int page,
      required int limit}) async {
    final response = await _provider.get(Get.context, Scope.MERCHANT,
        "settings/auto-mail?page=$page&limit=$limit&search=$searchKey", null);
    return AutomailRecipientsResponse.fromJson(response);
  }

  Future<AutomailRecipientDetailResponse> getDetailRecipients(
      {required int id}) async {
    final response = await _provider.get(
        Get.context, Scope.MERCHANT, "settings/auto-mail/$id", null);
    return AutomailRecipientDetailResponse.fromJson(response);
  }

  Future<AutomailEnableResponse> automailEnabler(
      {required AutomailEnableRequest request}) async {
    final response = await _provider.put(Get.context, Scope.MERCHANT,
        "settings/auto-mail/is-enable", request.toJson());
    return AutomailEnableResponse.fromJson(response);
  }

  Future<AutomailUpdateRecipientsResponse> updateRecipient(
      {required AutomailUpdateRecipientsRequest request}) async {
    final response = await _provider.put(
        Get.context, Scope.MERCHANT, "settings/auto-mail", request.toJson());
    return AutomailUpdateRecipientsResponse.fromJson(response);
  }

  Future<AutomailAddRecipientsResponse> addRecipient(
      {required AutomailAddRecipientsRequest request}) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, "settings/auto-mail", request.toJson());
    return AutomailAddRecipientsResponse.fromJson(response);
  }
}
