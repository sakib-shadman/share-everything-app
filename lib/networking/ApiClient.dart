
import 'package:http/http.dart' as http;
class ApiClient {

  static http.Client _client;

  static http.Client getClient(){
    if(_client == null){
      _client = new http.Client();
    }

    return _client;
  }

}