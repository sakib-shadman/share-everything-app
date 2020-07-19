import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:share_everything_client/interface/LoginApi.dart';
import 'package:share_everything_client/model/BaseResponse.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:scoped_model/scoped_model.dart';


class UserViewModel extends Model {

  Future <LoginResponse> _loginResponse;
  Future<BaseResponse> _registerResponse;

  Future <LoginResponse> get loginResponse => _loginResponse;
  Future <BaseResponse> get registerResponse => _registerResponse;

  set loginResponse(Future<LoginResponse> value) {
    _loginResponse = value;
    notifyListeners();
  }

  set registerResponse(Future<BaseResponse> value) {
    _registerResponse = value;
    notifyListeners();
  }


  final LoginApi loginApi;

  UserViewModel({@required this.loginApi});

  Future<LoginResponse> login(Map<String, String> loginData) async {
    loginResponse = loginApi?.login(loginData);
    return loginResponse;
  }

  Future<BaseResponse> register(Map<String, String> registerData) async {
    registerResponse = loginApi?.register(registerData);
    return registerResponse;
  }



}