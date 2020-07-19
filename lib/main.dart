import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share_everything_client/HomeView.dart';
import 'package:share_everything_client/Utils.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:share_everything_client/service/LoginService.dart';
import 'package:share_everything_client/viewmodel/UserViewModel.dart';

import 'LoginView.dart';

void main() => runApp(MaterialApp(home: LauncherView()));

class LauncherView extends StatefulWidget {

  LauncherViewState createState() => LauncherViewState();
}

class LauncherViewState extends State<LauncherView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    isUserLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: new Container(
          padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
          child: Text(
            'Share Everything',
            style: TextStyle(
                color: Colors.red
            ),

          ),
        ),
      ),
    );

  }

  void isUserLoggedIn(){

    Utils(context).loggedInCheck().then((value) {
      if(value != null){
        if(value){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeView()),
                  (Route<dynamic> route) => false);
        }

      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginView()),
                (Route<dynamic> route) => false);
      }
    });
  }



}

Route _createRouteHome() {
  return PageRouteBuilder(
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
  );
}

