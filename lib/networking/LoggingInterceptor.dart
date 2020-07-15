import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http_interceptor.dart';
class LoggingInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    debugPrint("Request log:");
    debugPrint(data.baseUrl);
    debugPrint(data.body);
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    debugPrint("Response log:");
    debugPrint(data.url);
    debugPrint(data.statusCode.toString());
    debugPrint(data.body);
    return data;
  }


}