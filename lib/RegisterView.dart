import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:share_everything_client/LoginView.dart';
import 'package:share_everything_client/model/BaseResponse.dart';
import 'package:share_everything_client/service/LoginService.dart';
import 'package:share_everything_client/viewmodel/UserViewModel.dart';

class RegisterView extends StatefulWidget {
  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final firstNameController = TextEditingController();
  final lastNameController  = TextEditingController();
  final emailController  = TextEditingController();
  final passwordController = TextEditingController();
  final mobileNoController = TextEditingController();
  ProgressDialog progressDialog;
  UserViewModel registerViewModel;

  @override
  void initState() {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: new Center(
          child: SingleChildScrollView(
            child: new Container(
              padding:
                  EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: new Container(
                                padding: EdgeInsets.only(right: 5),
                                child: textField(
                                    firstNameController, 'First Name', true))),
                        Expanded(
                            child: new Container(
                                padding: EdgeInsets.only(left: 5),
                                child: textField(
                                    lastNameController, 'Last Name', true))),
                      ],
                    ),
                  ),
                  textField(emailController, 'Email', true),
                  textField(passwordController, 'Password', true),
                  textField(mobileNoController, 'Mobile No', true),
                  button()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkValidation() {
    if (firstNameController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("PLease enter your first name!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (lastNameController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter your last name!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }

    if (emailController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter your email!"),
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

    if (mobileNoController.text.isEmpty) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter your mobile no!"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return true;
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
                    debugPrint("Added text field: $newVal");
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
                    debugPrint("Added text field: $newVal");
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
      width: double.infinity,
      padding: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
      child: RaisedButton(
        onPressed: () {
          if (checkValidation()) {
            var registerRequestBody = {
              "firstName": firstNameController.text ?? "",
              "lastName": lastNameController.text ?? "",
              "email": emailController.text ?? "",
              "password": passwordController.text ?? "",
              "mobileNumber": mobileNoController.text ?? ""
            };
            progressDialog.show().then((value) {
              userRegister(registerRequestBody);
            });
          }
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
    );
  }

  void userRegister(Map<String, String> registerRequestBody) {
    registerViewModel = UserViewModel(loginApi: LoginService());
    registerViewModel
        .register(registerRequestBody)
        .then((BaseResponse registerResponse) {
      progressDialog.hide().then((value) {
        if (registerResponse.responseStatus != null &&
            registerResponse.responseStatus == "FAILED") {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(registerResponse.message),
            backgroundColor: Colors.red,
          ));
        } else {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(registerResponse.message.toString()),
            backgroundColor: Colors.blueAccent,
          ));
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => LoginView()),
              (Route<dynamic> route) => false);
        }
      });
    }).catchError((onError) {
      debugPrint("Error is occurred in login api calling. $onError");
      progressDialog.hide().then((value) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(onError.toString()),
          backgroundColor: Colors.red,
        ));
      });
    });
  }
}
