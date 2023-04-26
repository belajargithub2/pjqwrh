import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/response/response_local_get_kmob_submission.dart';
import 'package:kreditplus_deasy_mobile/core/source/local/secure_storage_service.dart';
import 'package:path_provider/path_provider.dart';

final HiveService hive = HiveService.instance;

class HiveService {
  static final HiveService _instance = HiveService();

  static HiveService get instance => _instance;

  static String kmobSubmissionBox = 'kmobSubmissionBox';

  Future<void> init() async {
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocDirectory.path);
    Hive.registerAdapter<ResponseLocalGetKmobSubmission>(ResponseLocalGetKmobSubmissionAdapter());
  }

  Future<bool> addOrUpdateBox(ResponseLocalGetKmobSubmission kmobSubmissionModel) async {
    final Box box = await openBox(kmobSubmissionBox);
    int length = box.values.toList().length;
    if (length < 1) {
      await box.add(kmobSubmissionModel);
    } else {
      await box.putAt(0, kmobSubmissionModel);
    }
    await box.close();
    return true;
  }

  Future<void> deleteRecord({int index = 0}) async {
    final Box box = await openBox(kmobSubmissionBox);
    box.deleteAt(index);
    await box.close();
  }

  Future<List<ResponseLocalGetKmobSubmission>?> getAllRecord() async {
    final box = await openBox(kmobSubmissionBox);
    List<ResponseLocalGetKmobSubmission> list = box.values.toList();
    await box.close();
    return list;
  }

  Future<dynamic> openBox<E>(String boxName) async {
    final Uint8List key = await secureStorageService.getEncryptionKey();
    final HiveCipher hiveCipher = HiveAesCipher(key);
    final Box box = await Hive.openBox<ResponseLocalGetKmobSubmission>(
      boxName,
      encryptionCipher: hiveCipher,
    );
    return box;
  }
}
