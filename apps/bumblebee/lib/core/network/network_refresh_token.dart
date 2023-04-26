import 'package:deasy_logout/deasy_logout.dart';
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:deasy_repository/deasy_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:deasy_config/deasy_config.dart';
import 'package:kreditplus_deasy_mobile/core/config/fcm_config.dart';
import 'package:deasy_encryptor/deasy_encryptor.dart';
import 'package:kreditplus_deasy_mobile/core/widgets/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RefreshTokenInterceptor extends QueuedInterceptorsWrapper {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  BuildContext? context;
  Dio? dio;

  RefreshTokenInterceptor({this.context, this.dio});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response != null) {
      return handler.next(response);
    } else {
      return null;
    }
  }

  @override
  void onError(DioError e, ErrorInterceptorHandler handler) async {
    if (e.response != null) {
      final endPoint = Uri.parse(e.requestOptions.path);
      if (e.response!.statusCode == 401) {
        if (endPoint.path == "/api/v1/auth/refresh-token") {
          DialogUtil.expiredSessionDialog(
            context: context,
            onButtonPress: () {
              DeasyLogout().logout(
                isExpired: true,
                unsubscribeFromTopic: () {
                  DeasyPocket _deasyPocket = DeasyPocket();
                  _deasyPocket.getSupplierId().then(
                    (supplierId) => fcmUnSubscribe(supplierId)
                  );
                }
              );
          });
          return null;
        } else {
          if (await _refreshToken()) {
            return handler.resolve(await _retry(e.requestOptions));
          }
        }
      } else {
        return handler.next(e);
      }
    }
    super.onError(e, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    String accessToken = await DeasyPocket().getRefreshToken();
    var options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer " + accessToken,
        "Accept": "*/*",
      },
      contentType: Headers.jsonContentType,
    );

    final result = dio!.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);

    return result;
  }

  Future<bool> _refreshToken() async {
    try {
      final SharedPreferences sharedPreferences = await _prefs;
      AuthRepository authRepository = AuthRepository();

      final refreshToken = await DeasyPocket().getRefreshToken();

      if (refreshToken != null) {
        final userRefreshToken = await authRepository
            .refreshToken(context, {"refresh_token": refreshToken});

        if (userRefreshToken != null) {
          await sharedPreferences.setString(
              "access_token",
              DeasyEncryptorUtil.encryptString(
                  userRefreshToken.data!.accessToken!));
          await sharedPreferences.setString(
              "refresh_token",
              DeasyEncryptorUtil.encryptString(
                  userRefreshToken.data!.refreshToken!));
          AnalyticConfig().sendEvent("Profile_Session_expired");
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
