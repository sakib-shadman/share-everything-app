
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'model/LoginResponse.dart';

class Utils {
  BuildContext context;
  ProgressDialog progressDialog;
  String authorization;

  Utils(BuildContext context){
    this.context = context;
  }

  void showProgressDialog()
  {
    progressDialog.show();
  }
  void hideProgressDialog()
  {
    //progressDialog.dismiss();
    progressDialog.hide();
  }


  void showInSnackBar(String value, GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Color.fromRGBO(29, 153, 216, 1),
      content: Text(value,
        style: TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat-Medium'
        ),
      ),

    ));

  }

  void showInSnackBarError(String value, GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
      content: new Text(value,
        style: TextStyle(
            fontSize: 12,
            fontFamily: 'Montserrat-Medium'
        ),
      ),
    ));

  }

  Future storeLoginData(LoginResponse loginResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginresponse", json.encode(loginResponse) );
    prefs.setBool("isUserLoggedIn", true);

  }

  Future removeLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("loginresponse", null );
    prefs.setBool("isUserLoggedIn", false);
  }

  Future<LoginResponse> readLoginData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var data = json.decode(prefs.getString('loginresponse'));

    Map<String, dynamic> loginData = data;
    LoginResponse loginResponse = LoginResponse.fromJson(loginData);

    return loginResponse;
  }

  Future<bool> loggedInCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = false;
    isLoggedIn = prefs.getBool("isUserLoggedIn");
    return isLoggedIn;
  }


}


