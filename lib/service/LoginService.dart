import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:share_everything_client/interface/LoginApi.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:share_everything_client/networking/ApiClient.dart';
import 'package:share_everything_client/strings.dart';

class LoginService extends LoginApi {

 /* http.Client _client = http.Client();

  set client(http.Client value) => _client = value;*/

  static final LoginService _internal = LoginService.internal();

  factory LoginService() => _internal;

  LoginService.internal();

  Future<LoginResponse> login(Map<String, String> loginRequestBody) async {

    final url = "${strings().url}sign-in";

    debugPrint("Sign-in url : $url");
    debugPrint("Login request : $loginRequestBody");


    var response = await ApiClient.getClient().post('$url',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginRequestBody));

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 500) {
      var data = json.decode(response.body);
      Map<String, dynamic> responseData = data;

      LoginResponse loginResponse = LoginResponse.fromJson(responseData);

      debugPrint("Log in response: $loginResponse");
      return loginResponse;
    } else {
      throw Exception('There is some error,please try again later!');
    }
  }
}
