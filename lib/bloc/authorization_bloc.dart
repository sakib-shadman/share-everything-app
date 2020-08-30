import 'dart:async';

import 'package:share_everything_client/Utils.dart';
import 'package:share_everything_client/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthorizationBloc extends Bloc{

  final _isUserLoggedInController = StreamController<bool>();

  Stream<bool> get isUserLoggedInStream => _isUserLoggedInController.stream;


  void dispose() {
    _isUserLoggedInController.close();
  }

  void isUserLoggedIn() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = false;
    isLoggedIn = prefs.getBool("isUserLoggedIn");
    return _isUserLoggedInController.sink.add(isLoggedIn);

  }
}
final authBloc = AuthorizationBloc();


