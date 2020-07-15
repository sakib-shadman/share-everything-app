
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';
import 'LoggingInterceptor.dart';
class ApiClient {

  static http.Client _client;

  static http.Client getClient(){
   
    if(_client == null){
      _client = HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
    }

    return _client;
  }

}