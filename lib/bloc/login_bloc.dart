import 'dart:async';

import 'package:share_everything_client/bloc/bloc.dart';
import 'package:share_everything_client/model/LoginResponse.dart';
import 'package:share_everything_client/service/LoginService.dart';

class LoginBLoc extends Bloc {

  Stream<LoginResponse> get loginResponse => _controller.stream;

  final _controller = StreamController<LoginResponse>();

  final _client = LoginService();

  void submitLoginRequest(Map<String, String> loginRequestBody) async {
    final results = await _client.login(loginRequestBody);
    _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }

}