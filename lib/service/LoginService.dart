import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:share_everything_client/interface/LoginApi.dart';
import 'package:share_everything_client/model/BaseResponse.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:share_everything_client/networking/ApiClient.dart';
import 'package:share_everything_client/strings.dart';

class LoginService extends LoginApi {


  static final LoginService _internal = LoginService.internal();

  factory LoginService() => _internal;

  LoginService.internal();

  Future<LoginResponse> login(Map<String, String> loginRequestBody) async {

    final url = "${strings().url}sign-in";
    var response = await ApiClient.getClient().post('$url',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginRequestBody));

    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500) {
      var data = json.decode(response.body);
      Map<String, dynamic> responseData = data;

      LoginResponse loginResponse = LoginResponse.fromJson(responseData);
      return loginResponse;
    } else {
      throw Exception('There is some error,please try again later!');
    }
  }

  @override
  Future<BaseResponse> register(Map<String, String> registerRequestBody) async {

    final url = "${strings().url}sign-up";
    var response = await ApiClient.getClient().post('$url',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(registerRequestBody));

    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500) {
      var data = json.decode(response.body);
      Map<String, dynamic> responseData = data;

      BaseResponse registerResponse = BaseResponse.fromJson(responseData);
      return registerResponse;
    } else {
      throw Exception('There is some error,please try again later!');
    }

  }
}
