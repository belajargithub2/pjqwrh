import 'package:deasy_config/deasy_config.dart';
import 'package:deasy_models/deasy_models.dart';
import 'package:deasy_network/src/network_enum.dart';
import 'package:deasy_snackbar/deasy_snackbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:deasy_pocket/deasy_pocket.dart';
import 'package:newwg/config/network_config.dart';

import 'network_custom_exception.dart';

class NetworkSetting {

  Future<String> getAccessToken() async {
    return DeasyPocket().getToken();
  }

  Future<bool> isUserLoggedIn() async {
    return DeasyPocket().isUserLoggedIn();
  }

  Future<Map<String, String>> getHeader(BuildContext? context, Scope? scope,
      {bool isRegister = false, Map<String, dynamic>? additionalHeaders}) async {
    switch (scope) {
      case Scope.MERCHANT:
        if (await isUserLoggedIn()) {
          return <String, String>{
            'Content-Type': 'application/json',
            'Authorization': isRegister
                ? flavorConfiguration!.flavorName == "prod" ||
                        flavorConfiguration!.flavorName == "staging"
                    ? flavorConfiguration!.appMerchantClientKey
                    : flavorConfiguration!.appMerchantAuthKey
                : "Bearer ${await getAccessToken()}",
          };
        } else {
          return <String, String>{
            'Content-Type': 'application/json',
            'client-key': flavorConfiguration!.flavorName == "prod" ||
                    flavorConfiguration!.flavorName == "staging"
                ? flavorConfiguration!.appMerchantClientKey
                : flavorConfiguration!.appMerchantAuthKey,
            'Authorization': getAuthKey(context, scope),
          };
        }

      case Scope.MARKETING:
        return <String, String>{
          'Content-Type': 'application/json',
          'Authorization': getAuthKey(context, scope),
        };

      case Scope.E_COMMERCE:
        return <String, String>{
          'Content-Type': 'application/json',
          'Authorization': getAuthKey(context, scope),
        };

      case Scope.MEDIA:
        return <String, String>{
          'Content-Type': 'image/*',
          'Authorization': getAuthKey(context, scope),
        };

      case Scope.DEEP_LINK:
        return <String, String>{
          'Content-Type': 'application/json',
        };

      case Scope.NEW_WG:
        Map<String, String> newWgHeaders = {
          'Content-Type': 'application/json',
          'Authorization' : NetworkConfig.instance.authKey
        };

        return additionalHeaders != null
            ? {...newWgHeaders, ...additionalHeaders}
            : newWgHeaders;

      case Scope.PLATFORM:
        return <String, String>{
          'Content-Type': 'application/json',
          'Authorization': NetworkConfig.instance.clientKeyPlatform,
        };

      default:
        return <String, String>{
          'Content-Type': 'application/json',
        };
    }
  }

  String getBaseUrl(BuildContext? context, Scope scope,
      {VersionApi versionApi = VersionApi.V1}) {
    switch (scope) {
      case Scope.MERCHANT:
        return versionApi == VersionApi.V1
            ? flavorConfiguration!.appMerchantBaseUrlV1
            : flavorConfiguration!.appMerchantBaseUrlV2;

      case Scope.MARKETING:
        return flavorConfiguration!.appMarketingBaseUrl;

      case Scope.E_COMMERCE:
        return flavorConfiguration!.appECommerceBaseUrl;

      case Scope.DEEP_LINK:
        return flavorConfiguration!.deepLinkUrl;

      case Scope.NEW_WG:
        return NetworkConfig.instance.baseUrl;

      case Scope.ASIA_SOUTHEAST2:
        return NetworkConfig.instance.platformUrlEncryption;

      default:
        return "";
    }
  }

  String getAuthKey(BuildContext? context, Scope? scope) {
    switch (scope) {
      case Scope.MERCHANT:
        return flavorConfiguration!.appMerchantAuthKey;

      case Scope.MARKETING:
        return flavorConfiguration!.appMarketingAuthKey;

      case Scope.E_COMMERCE:
        return flavorConfiguration!.appECommerceAuthKey;

      case Scope.MEDIA:
        return flavorConfiguration!.appMediaAuthKey;

      default:
        return "";
    }
  }

  String handleError(
    DioError error,
    BuildContext? context, {
    bool isRegister = false,
    bool getAllResponseError = false,
    bool showSnackbar = false,
    getErrorMessage = false,
  }) {
    String errorDescription = "";
    switch (error.type) {
      case DioErrorType.cancel:
        errorDescription = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        errorDescription = "Connection timeout with API server";
        break;
      case DioErrorType.other:
        errorDescription =
            "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        errorDescription = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        errorDescription = setErrorByResponse(
            error.response!.statusCode, error.response,
            isRegister: isRegister,
            getAllResponseError: getAllResponseError,
            showSnackbar: showSnackbar,
            getNewErrorMessage: getErrorMessage);
        break;
      case DioErrorType.sendTimeout:
        break;
    }
    return errorDescription;
  }

  String setErrorByResponse(
    int? statusCode,
    Response? response, {
    bool getAllResponseError = false,
    bool isRegister = false,
    BuildContext? context,
    showSnackbar = false,
    getNewErrorMessage = false,
  }) {
    switch (statusCode) {
      case 400:
        DeasyPocket().isUserLoggedIn().then((isLoggedIn) {
          if (!isLoggedIn) {
            Navigator.of(getx.Get.context!).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
          }
        });
        if (showSnackbar) {
          showSnackBar(response!);
        }
        if (getAllResponseError) {
          throw response!.data;
        }
        if (getNewErrorMessage) {
          throw BadRequestException(errorMessage(response!));
        }

        throw BadRequestException(
            isRegister ? response!.data["error"] : response!.data["message"]);
      case 401:
        if (showSnackbar) showSnackBar(response!);
        throw UnauthorisedException(response!.data["message"]);
      case 403:
        if (showSnackbar) showSnackBar(response!);
        Navigator.of(getx.Get.context!).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        throw ForbiddenException(response!.data["message"]);
      case 404:
        if (showSnackbar) showSnackBar(response!);
        if (getNewErrorMessage) {
          throw BadRequestException(errorMessage(response!));
        }
        if (getAllResponseError) {
          throw response!.data;
        }
        throw NotFoundException(
            isRegister ? response!.data["error"] : response!.data["message"]);
      case 429:
        if (showSnackbar) showSnackBar(response!);
        throw ToManyRequestException(response!.data.toString());
      case 405:
        if (showSnackbar) showSnackBar(response!);
        throw NotAllowedException(response!.data.toString());
      case 500:
        if (showSnackbar) showSnackBar(response!);
        throw InternalServerErrorException(response!.data["message"]);
      case 503:
        if (showSnackbar) showSnackBar(response!);
        throw InternalServerErrorException(response!.data['message']);
      default:
        throw FetchDataException("Tidak ada koneksi internet");
    }
  }

  void showSnackBar(Response response) {
    DeasySnackBarUtil.showFlushBarError(
        getx.Get.context!, errorMessage(response));
  }

  String? errorMessage(Response response) {
    ErrorResponse errorResponse = ErrorResponse.fromJson(response.data);
    const errorApiDefault =
        'Maaf, sedang terjadi pemeliharaan pada sistem kami.';

    if (errorResponse.errors is List) {
      return errorResponse.errors.first.message.toString().capitalizeFirst;
    } else if (errorResponse.errors.runtimeType == Error) {
      return errorResponse.errors.message.toString().capitalizeFirst;
    } else {
      return errorResponse.errors.toString().capitalizeFirst ?? errorApiDefault;
    }
  }
}
