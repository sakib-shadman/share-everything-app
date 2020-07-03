import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: LoginView()));

class LoginView extends StatefulWidget {
  // This widget is the root of your application.

  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool inputValidated(BuildContext context) {
    if (emailNameController.text.isEmpty) {
      //Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: new Container(
          padding: EdgeInsets.only(top: 260,right: 20,left: 20,bottom: 20),
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

  Widget textField(
      TextEditingController controller, String label, bool isRequired) {
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
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 20, right: 10),
              child: RaisedButton(
                onPressed: () {
                  if(checkValidation()){

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
            child:  new Container(
              padding: EdgeInsets.only(left: 10, right: 20),
              child: RaisedButton(
                onPressed: () {},
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

}
