
import 'package:share_everything_client/model/BaseResponse.dart';
import 'package:share_everything_client/model/LoginResponse.dart';

abstract class LoginApi {

  Future<LoginResponse> login(Map<String,String> loginRequestBody);
  Future<BaseResponse> register(Map<String,String> registerRequestBody);
}