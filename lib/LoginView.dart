import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share_everything_client/HomeView.dart';
import 'package:share_everything_client/RegisterView.dart';
import 'package:share_everything_client/Utils.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:share_everything_client/service/LoginService.dart';
import 'package:share_everything_client/viewmodel/UserViewModel.dart';


class LoginView extends StatefulWidget {

  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailNameController = TextEditingController();
  final passwordController = TextEditingController();
  ProgressDialog progressDialog;
  UserViewModel loginViewModel;
  bool isLoggedIn;


  @override
  void initState() {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    //isUserLoggedIn();
  }

  @override
  void dispose() {
    emailNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.only(top: 260, right: 20, left: 20, bottom: 20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              textField(emailNameController, 'Email', true),
              textField(passwordController, 'Password', true),
              button(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField(TextEditingController controller, String label,
      bool isRequired) {
    return new Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: new Row(
              children: <Widget>[
                Text(
                  '$label ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(112, 112, 112, 1.0)),
                ),
                isRequired == true
                    ? Text(
                  '*',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(112, 112, 112, 1.0)),
                )
                    : new Container()
              ],
            ),
          ),
          new Container(
            height: 50,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0),
              border: new Border.all(
                color: Color.fromRGBO(129, 129, 129, 1.0),
                width: 0.5,
              ),
            ),
            child: new Container(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                child: controller == passwordController
                    ? new TextField(
                  controller: controller,
                  obscureText: true,
                  onChanged: (newVal) {
                  },
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintText: '',
                    border: InputBorder.none,
                  ),
                )
                    : new TextField(
                  controller: controller,
                  onChanged: (newVal) {
                  },
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.start,
                  decoration: new InputDecoration(
                    hintText: '',
                    border: InputBorder.none,
                  ),
                )),
          )
        ],
      ),
    );
  }

  Widget button() {
    return new Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: RaisedButton(
                onPressed: () {
                  if (checkValidation()) {
                    var loginRequestBody = {
                      "email" : emailNameController.text ?? "",
                      "password" : passwordController.text ?? ""
                    };
                    progressDialog.show().then((value) {
                      userLogin(loginRequestBody);
                    });
                  }
                },
                color: Colors.blueAccent,
                disabledColor: Colors.blueGrey,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
          Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => RegisterView()),
                          (Route<dynamic> route) => false);
                },
                color: Colors.blueAccent,
                disabledColor: Colors.blueGrey,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool checkValidation() {
    if (emailNameController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("PLease enter your email!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (passwordController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter your password!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
  }

  void userLogin(Map<String, String> loginRequestBody) {
    loginViewModel = UserViewModel(loginApi: LoginService());
    loginViewModel.login(loginRequestBody).then((LoginResponse loginResponse) {

      progressDialog.hide().then((value) {
        if(loginResponse.responseStatus != null && loginResponse.responseStatus == "FAILED"){
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(loginResponse.message),
            backgroundColor: Colors.red,
          ));
        } else{
          Utils(context).storeLoginData(loginResponse).then((value) {
            _createRouteHome(context);
          });

        }
      });

    }
    ).catchError((onError){
      debugPrint("Error is occurred in login api calling. $onError");
      progressDialog.hide().then((value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(onError.toString()),
          backgroundColor: Colors.red,
        ));
      });
    });
  }

  void isUserLoggedIn(){

    Utils(context).loggedInCheck().then((value) {
      if(value != null){

        // _createRouteHome();

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeView()),
                (Route<dynamic> route) => false);
        /* setState(() {
          isLoggedIn = value ?? false;
        });*/
      }
    });
  }



}

void _createRouteHome(BuildContext context) {
 /* return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => HomeView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0.0);
      var end = Offset.zero;
      var tween = Tween(begin: begin, end: end);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );*/
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomeView()),
          (Route<dynamic> route) => false);
}

