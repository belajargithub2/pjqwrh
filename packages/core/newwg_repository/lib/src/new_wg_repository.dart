import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:newwg_repository/src/response/new_wg/customer_check_limit_type_response.dart';
import 'package:newwg_repository/src/response/new_wg/generate_prospect_id_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_group_categories_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_order_response.dart';
import 'package:newwg_repository/src/response/new_wg/get_white_goods_response.dart';
import 'package:newwg_repository/src/response/new_wg/human_verification_response.dart';
import 'package:newwg_repository/src/response/new_wg/submit_order_response.dart';
import 'package:newwg_repository/src/response/new_wg/verification_code_validate_response.dart';

abstract class NewWgRepository {
  Future<CutomerCheckLimitTypeResponse> checkCustomerLimitType(BuildContext context, String phoneNumber);

  Future<VerificationCodeValidateResponse> verificationCodeValidate(
      BuildContext context,
      String verificationCode,
      String phoneNumber,
      );

  Future<HumanVerificationResponse> submitHumanVerification(
      BuildContext context,
      int customerId,
      bool dataValid,
      bool selfieValid,
      bool recommendation,
      bool confirmCheck,
  );

  Future<Uint8List?> getImageCustomer(BuildContext context, String url, bool isWatermark);

  Future<GetGroupCategoryResponse> getAssetGroupCategories(BuildContext context);

  Future<GetWhiteGoodsResponse> getWhiteGoods(BuildContext context, int groupCategoryId, String search, int page, int limit);

  Future<SubmitOrderResponse> submitOrder(BuildContext context, Map<String, dynamic> requestBody, String xSourceToken);

  Future<GenerateProspectIdResponse> generateProspectId(BuildContext context, String prefix, int unique);

  Future<GetOrderResponse> getOrder(BuildContext context, Map<String, dynamic> requestBody, xSourceToken);

  Future<SubmitOrderResponse> editOrder(BuildContext context, Map<String, dynamic> requestBody, String xSourceToken);
}
