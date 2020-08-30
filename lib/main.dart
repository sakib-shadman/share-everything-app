import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_everything_client/HomeView.dart';
import 'package:share_everything_client/bloc/authorization_bloc.dart';

import 'LoginView.dart';

void main() => runApp(LauncherView());

/*class LauncherView extends StatefulWidget {

  LauncherViewState createState() => LauncherViewState();
}

class LauncherViewState extends State<LauncherView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  */ /*@override
  void initState() {
    isUserLoggedIn();
    super.initState();
  }*/ /*



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
}*/

class LauncherView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.isUserLoggedIn();
    return MaterialApp(
      title: 'Share Everything',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: checkAuthStatus(),
    );
  }

  checkAuthStatus() {
    return StreamBuilder<bool>(
        stream: authBloc.isUserLoggedInStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return HomeView();
          }
          return LoginView();
        });
  }
}
