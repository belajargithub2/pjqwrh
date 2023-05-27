import 'dart:convert';
import 'dart:io';

import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_network/src/network_enum.dart';
import 'package:deasy_network/src/network_refresh_token.dart';
import 'package:deasy_network/src/network_request_header_interceptor.dart';
import 'package:deasy_network/src/network_request_id_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart' as g;
import 'package:requests_inspector/requests_inspector.dart';

import 'network_logging_interceptor.dart';
import 'network_setting.dart';

enum Method { POST, GET, PUT, DELETE, PATCH, MULTIPART }

class DioClient {
  final NetworkSetting _networkSetting = NetworkSetting();

  Dio? _dio;

  DioClient({
    String? eventName,
    Map<String, dynamic>? params,
    bool isFirebase = false,
    bool isActiveRequestsInterceptor = false, // for add Accept-Language header
    bool isActiveRequestIdInterceptor = false, // for request_id to firebase
    bool isActiveLoggingInterceptor = false, // for logging request
    bool isActiveRefreshTokenInterceptor = false, // for refresh token
    bool isActiveRequestsInspectorInterceptor = false, // for request inspector
  }) {
    BaseOptions baseOptions = BaseOptions(
        receiveTimeout: flavorConfiguration?.dioReceiveTimeout ?? 180 * 1000,
        connectTimeout: flavorConfiguration?.dioConnectTimeout ?? 180 * 1000,
        receiveDataWhenStatusError: true,
        contentType: Headers.formUrlEncodedContentType);
    _dio = Dio(baseOptions);
    _dio!.interceptors.clear();
    if (isActiveRequestsInterceptor) {
      _dio!.interceptors.add(RequestsInterceptor());
    }
    if (isActiveLoggingInterceptor) {
      _dio!.interceptors.add(LoggingInterceptor());
    }
    if (isActiveRequestsInspectorInterceptor) {
      _dio!.interceptors.add(RequestsInspectorInterceptor());
    }
    if (isActiveRequestIdInterceptor) {
      _dio!.interceptors.add(RequestIdInterceptor(
          eventName: eventName, params: params, isFirebase: isFirebase));
    }
    if (isActiveRefreshTokenInterceptor) {
      _dio!.interceptors
          .add(RefreshTokenInterceptor(dio: _dio, context: g.Get.context));
    }
  }

  Future<dynamic> post(BuildContext? context, Scope scope, String url,
      Map<String, dynamic>? requestBody,
      {bool isRegister = false,
      bool isRefreshToken = false,
      bool isReturnError = false,
      VersionApi versionApi = VersionApi.V1,
      bool showSnackbar = false,
      bool getNewErrorMessage = false,
      bool isReturnJson = true,
      Map<String, dynamic>? additionalHeaders,
      }) async {
    var responseJson;
    String getUrl =
        _networkSetting.getBaseUrl(context, scope, versionApi: versionApi) +
            url;
    responseJson = await request(
      url: getUrl,
      method: Method.POST,
      context: context,
      scope: scope,
      isReturnJson: isReturnJson,
      isRegister: isRegister,
      isReturnError: isReturnError,
      requestBody: requestBody,
      showSnackbar: showSnackbar,
      additionalHeaders: additionalHeaders,
      getErrorMessage: getNewErrorMessage,
    );

    return responseJson;
  }

  Future<dynamic> multipartPost(
    BuildContext? context,
    Scope scope,
    String url,
    Map<String, dynamic> requestBody, {
    bool isRegister = false,
    bool isRefreshToken = false,
    List<int>? fileBytes,
    String? flag,
    bool isReturnError = false,
    String fileName = "",
    String filePath = "",
    method = Method.POST,
    bool showSnackbar = false,
    bool getErrorMessage = false,
  }) async {
    var responseJson;
    String getUrl = _networkSetting.getBaseUrl(context, scope) + url;
    responseJson = await request(
      url: getUrl,
      method: method,
      context: context,
      scope: scope,
      isRegister: isRegister,
      isReturnError: isReturnError,
      requestBody: requestBody,
      flag: flag,
      fileBytes: fileBytes,
      fileName: fileName,
      filePath: filePath,
      showSnackbar: showSnackbar,
      getErrorMessage: getErrorMessage,
    );

    return responseJson;
  }

  Future<dynamic> delete(
    BuildContext? context,
    Scope scope,
    String url,
    Map<String, dynamic>? query, {
    bool getNewErrorMessage = false,
  }) async {
    var responseJson;

    var getUrl = _networkSetting.getBaseUrl(context, scope) + url;
    if (query != null) {
      String queryString = "";
      query.forEach((key, value) {
        queryString += "$key=$value&";
      });
      getUrl = "${_networkSetting.getBaseUrl(context, scope)}$url?$queryString";
    }
    responseJson = await request(
      url: getUrl,
      method: Method.DELETE,
      context: context,
      scope: scope,
      getErrorMessage: getNewErrorMessage,
    );

    return responseJson;
  }

  Future<dynamic> deleteWithoutQuery(BuildContext? context, Scope scope,
      String url, Map<String, dynamic>? requestBody) async {
    var responseJson;

    var getUrl = _networkSetting.getBaseUrl(context, scope) + url;
    responseJson = await request(
      url: getUrl,
      method: Method.DELETE,
      context: context,
      scope: scope,
      requestBody: requestBody,
    );

    return responseJson;
  }

  Future<dynamic> get(
    BuildContext? context,
    Scope scope,
    String url,
    Map<String, dynamic>? query, {
    VersionApi versionApi = VersionApi.V1,
    bool showSnackbar = false,
  }) async {
    var responseJson;

    String getUrl =
        _networkSetting.getBaseUrl(context, scope, versionApi: versionApi) +
            url;
    if (query != null) {
      String queryString = "";
      int i = 0;
      query.forEach((key, value) {
        queryString += "$key=$value${i == query.length - 1 ? "" : "&"}";
        i++;
      });
      getUrl =
          "${_networkSetting.getBaseUrl(context, scope, versionApi: versionApi)}$url?$queryString";
    }
    responseJson = await request(
      url: getUrl,
      versionApp: versionApi,
      method: Method.GET,
      context: context,
      scope: scope,
      showSnackbar: showSnackbar,
      requestBody: query,
    );

    return responseJson;
  }

  Future<Uint8List?> getImage(
    BuildContext? context,
    Scope scope,
    String url, {bool isFullUrl = false}
  ) async {
    var responseJson;
    var getUrl = isFullUrl ? url : _networkSetting.getBaseUrl(context, scope) + url;

    responseJson = await request(
      url: getUrl,
      method: Method.GET,
      context: context,
      scope: scope,
      isReturnJson: false,
    );
    return responseJson;
  }

  Future<dynamic> patch(
    BuildContext? context,
    Scope scope,
    String url,
    Map<String, dynamic>? requestBody, {
    bool showSnackbar = false,
  }) async {
    var responseJson;
    String getUrl = _networkSetting.getBaseUrl(context, scope) + url;
    responseJson = await request(
      url: getUrl,
      method: Method.PATCH,
      context: context,
      scope: scope,
      showSnackbar: showSnackbar,
      requestBody: requestBody,
    );

    return responseJson;
  }

  Future<dynamic> put(
    BuildContext? context,
    Scope scope,
    String url,
    Map<String, dynamic> requestBody,
    {bool showSnackbar = false,
    Map<String, dynamic>? additionalHeaders}
  ) async {
    var responseJson;
    String getUrl = _networkSetting.getBaseUrl(context, scope) + url;
    responseJson = await request(
      url: getUrl,
      method: Method.PUT,
      context: context,
      scope: scope,
      requestBody: requestBody,
      showSnackbar: showSnackbar,
      additionalHeaders: additionalHeaders
    );
    return responseJson;
  }

  Future<dynamic> request({
    required String url,
    required Method method,
    BuildContext? context,
    Scope? scope,
    bool isRegister = false,
    bool isReturnError = false,
    Map<String, dynamic>? requestBody,
    List<int>? fileBytes,
    String? flag = "",
    bool isReturnJson = true,
    VersionApi? versionApp,
    bool showSnackbar = false,
    bool getErrorMessage = false,
    String fileName = "",
    String filePath = "",
    Map<String, dynamic>? additionalHeaders,
  }) async {
    Response response;
    try {
      if (method == Method.POST) {
        if (flag!.isNotEmpty) {
          var formData = FormData.fromMap(requestBody!);

          switch (flag) {
            case "bast":
              formData.files.add(MapEntry(
                  'file',
                  MultipartFile.fromBytes(fileBytes!,
                      filename: 'bast.jpg',
                      contentType: MediaType('image', 'jpeg'))));
              break;
            case "imei":
              formData.files.add(MapEntry(
                  'imei',
                  MultipartFile.fromBytes(fileBytes!,
                      filename: 'imei.jpg',
                      contentType: MediaType('image', 'jpeg'))));
              break;
            case "customer":
              formData.files.add(MapEntry(
                  'customer_receipt_photo',
                  MultipartFile.fromBytes(fileBytes!,
                      filename: 'customer_receipt_photo.jpg',
                      contentType: MediaType('image', 'jpeg'))));
              break;
            case "newwg":
              formData.files.add(MapEntry(
                  fileName,
                  MultipartFile.fromBytes(fileBytes!,
                      filename: '$fileName.jpg',
                      contentType: MediaType('image', 'jpeg'))));
              break;
            default:
          }

          response = await _dio!.post(url,
              data: formData,
              options: Options(
                  headers: await _networkSetting.getHeader(context, scope, isRegister: isRegister,
                      additionalHeaders: additionalHeaders)));
        } else {
          response = await _dio!.post(url,
              data: jsonEncode(requestBody),
              options: Options(
                  headers: await _networkSetting.getHeader(context, scope,
                      isRegister: isRegister, additionalHeaders: additionalHeaders),
                  responseType:
                      isReturnJson ? ResponseType.json : ResponseType.bytes));
        }
      } else if (method == Method.DELETE) {
        response = await _dio!.delete(url,
            options: Options(
                headers: await _networkSetting.getHeader(context, scope)));
      } else if (method == Method.MULTIPART) {
        var formData = FormData.fromMap(requestBody!);
        formData.files.add(MapEntry(
          fileName,
          MultipartFile.fromFileSync(filePath,
              contentType: MediaType('image', 'jpeg')),
        ));

        response = await _dio!.post(url,
            data: formData,
            options: Options(
                headers: await _networkSetting.getHeader(context, scope,
                    isRegister: isRegister)));
      } else if (method == Method.PUT) {
        response = await _dio!.put(
          url,
          options:
              Options(headers: await _networkSetting.getHeader(context, scope, additionalHeaders: additionalHeaders)),
          data: jsonEncode(requestBody),
        );
      } else if (method == Method.PATCH) {
        response = await _dio!.patch(
          url,
          options:
              Options(headers: await _networkSetting.getHeader(context, scope)),
          data: jsonEncode(requestBody),
        );
      } else if (!isReturnJson) {
        response = await _dio!
            .get<Uint8List>(url,
                options: Options(
                    headers: await _networkSetting.getHeader(context, scope),
                    responseType: ResponseType.bytes))
            .then((value) {
          return value;
        });
      } else {
        response = await _dio!.get(url,
            options: Options(
                headers: await _networkSetting.getHeader(context, scope)));
      }

      var responseJson = response.data;
      return responseJson;
    } on SocketException catch (_) {
      throw Exception("Not Internet Connection");
    } on FormatException catch (_) {
      throw Exception("Bad response format");
    } on DioError catch (e) {
      throw _networkSetting.handleError(
        e,
        context,
        isRegister: isRegister,
        getAllResponseError: isReturnError,
        showSnackbar: showSnackbar,
        getErrorMessage: getErrorMessage,
      );
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}