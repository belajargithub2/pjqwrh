import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_get_detail_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_get_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/draft/model/response/response_save_to_draft.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/bumblebee_kmob_submission_model.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_enum.dart';
import 'package:kreditplus_deasy_mobile/core/network/network_with_dio.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/kmob_submission/models/mapper/bumblebee_kmob_mapper.dart';

class BumblebeeDraftRepository {
  DioClient _provider = DioClient();

  Future<ResponseGetDrafts> getDrafts(BuildContext? context, {Map<String, dynamic>? requestBody}) async {
    final response = await _provider.get(context, Scope.MERCHANT, _EndPoint.GET_DRAFTS, requestBody);
    return ResponseGetDrafts.fromJson(response);
  }

  Future<Uint8List?> getImageDraft(Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        Get.context, Scope.MERCHANT, _EndPoint.GET_IMAGE_DRAFT, requestBody, isReturnJson: false);
    return response;
  }

  Future<KmobSubmissionModel> getDetailDraft(
      BuildContext? context, {Map<String, dynamic>? requestBody, required String prospectId}) async {
    final response = await _provider.get(
        context, Scope.MERCHANT, _EndPoint.GET_DETAIL_DRAFT + prospectId, requestBody);
    return ResponseGetDetailDraft.fromJson(response).toDomain();
  }

  Future<ResponseSaveToDraft> saveToDraft(BuildContext? context, Map<String, dynamic> requestBody) async {
    final response = await _provider.post(
        context,
        Scope.MERCHANT,
        _EndPoint.POST_SAVE_TO_DRAFT,
        requestBody,
        showSnackbar: true);
    return ResponseSaveToDraft.fromJson(response);
  }
}

class _EndPoint {
  static const String GET_DRAFTS = "agents/drafts";
  static const String GET_DETAIL_DRAFT = "agents/drafts/";
  static const String POST_SAVE_TO_DRAFT = "agents/drafts/create";
  static const String GET_IMAGE_DRAFT = "documents/preview";
}
