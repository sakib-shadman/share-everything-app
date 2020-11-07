import 'package:firebase_messaging/firebase_messaging.dart';
class FireBaseManager {

  FirebaseMessaging _firebaseMessaging ;
  static final FireBaseManager _instance = FireBaseManager._internal();

  factory FireBaseManager() {
    return _instance;
  }
  FireBaseManager._internal() {
    // initialization logic
    _firebaseMessaging = FirebaseMessaging();
  }

  Future<String> getFirebaseDeviceToken() async{
    String token = await _firebaseMessaging.getToken();
    print(token);
    return token;
  }

}