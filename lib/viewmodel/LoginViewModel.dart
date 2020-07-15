import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:share_everything_client/interface/LoginApi.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:scoped_model/scoped_model.dart';


class LoginViewModel extends Model {

  Future <LoginResponse> _loginResponse;

  Future <LoginResponse> get loginResponse => _loginResponse;

  set loginResponse(Future<LoginResponse> value) {
    _loginResponse = value;
    notifyListeners();
  }
  final LoginApi loginApi;

  LoginViewModel({@required this.loginApi});
  Future<LoginResponse> login(Map<String, String> loginData) async {
    loginResponse = loginApi?.login(loginData);
    return loginResponse;
  }

}