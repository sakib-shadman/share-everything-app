import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_everything_client/HomeView.dart';
import 'package:share_everything_client/bloc/authorization_bloc.dart';
import 'package:share_everything_client/generics/firebase_manager.dart';

import 'LoginView.dart';

void main() => runApp(LauncherView());

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
    print(FireBaseManager().getFirebaseDeviceToken());
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
