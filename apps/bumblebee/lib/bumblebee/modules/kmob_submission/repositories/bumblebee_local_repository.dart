import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/core/source/local/hive_service.dart';

class BumblebeeLocalRepository {

  Future<void> saveOrUpdateToLocal(ResponseLocalGetKmobSubmission responseLocalGetKmobSubmission) {
    return hive.addOrUpdateBox(responseLocalGetKmobSubmission);
  }

  Future<List<ResponseLocalGetKmobSubmission>?> getLocalRecord() {
    return hive.getAllRecord();
  }

  Future<void> deleteRecord() {
    return hive.deleteRecord();
  }

}