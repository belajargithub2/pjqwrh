import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/setting_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ApiProvider{
  final Dio _dio = Dio();
  final Alice _alice = Alice(showNotification: true, navigatorKey: navigatorKey);
/*  final defaultBaseURL = dotenv.env['BASE_URL'];*/

  ApiProvider(){
    _dio.interceptors.add(_alice.getDioInterceptor());
  }

  Future<SettingModel> fetchSetting(String baseUrl, String deviceCode) async{
    try{
      final url = baseUrl != '' ? baseUrl : 'https://dev-kpm-api.kreditplus.com/api/';
      final device = deviceCode != '' ? deviceCode : 'TnPDlzcfvVOYYjgRvX6IAMnX1q10y7Dxk9mqyA==';
      final Map<String, dynamic> mappingData = <String, dynamic>{};
      mappingData['device_code'] = device;
      FormData formData = FormData.fromMap(mappingData);
      Response response = await _dio.post('${url}data/setting', data: formData);
      return SettingModel.fromJson(response.data);
    } catch(error){
      return SettingModel.withError(error.toString());
    }
  }
}