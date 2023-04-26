import 'package:dio/dio.dart';
import 'package:kreditplus_deasy_website/core/config/analytic_config.dart';
import 'package:uuid/uuid.dart';

class RequestIdInterceptor extends Interceptor {
  String? eventName;
  Map<String, dynamic>? params;
  bool? isFirebase;
  RequestIdInterceptor({
    this.eventName,
    this.params,
    this.isFirebase
  });
  var uuid = Uuid();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!isFirebase!) {
      String requestId = uuid.v4();
      options.headers.addAll({"X-Request-ID": requestId});
      if (eventName != null) {
        final requestIdParam = <String, String>{"request_id": requestId};
        params!.addEntries(requestIdParam.entries);
        await AnalyticConfig().sendEventStart(eventName!, requestBody: params);
      }
    }
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
