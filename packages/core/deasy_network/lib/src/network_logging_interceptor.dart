import 'package:deasy_logger/deasy_logger.dart';
import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    DeasyLoggerUtil.getLogger("REQUEST[${options.method}] => ").i("${options.headers} ${options.path}");
    DeasyLoggerUtil.getLogger("REQUEST[${options.method}] BODY => ").i("${options.data}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DeasyLoggerUtil.getLogger("RESPONSE[${response.statusCode}] => ").i("${response.data}");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    DeasyLoggerUtil.getLogger("RESPONSE[${err.response?.statusCode}] => ").e("${err.requestOptions.path} ----  ${err.response!.data}");
    return super.onError(err, handler);
  }
}
