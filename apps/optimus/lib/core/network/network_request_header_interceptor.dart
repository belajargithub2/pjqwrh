import 'package:dio/dio.dart';
import 'package:kreditplus_deasy_website/core/network/network_enum.dart';

class RequestsInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({ "Accept-Language": AcceptLanguage.ID.name.toLowerCase() });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

}