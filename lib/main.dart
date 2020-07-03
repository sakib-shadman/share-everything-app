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
  //final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool inputValidated(BuildContext context){

    if(emailNameController.text.isEmpty){

      //Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: new Center(
        child: new Container(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 200, right: 24),
                child: new Row(
                  children: <Widget>[
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Share Everything',
                          style: TextStyle(
                              fontSize: 28.0,
                              color: Color.fromRGBO(169, 169, 169, 1.0),
                              fontFamily: 'Montserrat-Medium',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 5,
                  bottom: 20,
                  right: 20,
                ),
                child: new TextField(
                  controller: emailNameController,
                  decoration: new InputDecoration(
                      labelText: 'Email',
                      contentPadding: EdgeInsets.only(
                        left: 8,
                        right: 0,
                        bottom: 8,
                      ),
                      labelStyle: new TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Montserrat-Light',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: new TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: new InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.only(
                        left: 8,
                        right: 0,
                        bottom: 8,
                      ),
                      labelStyle: new TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Montserrat-Light',
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                child: RaisedButton(
                  onPressed: () {

                    Builder(
                      builder: (BuildContext context){
                        final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
                        Scaffold.of(context).showSnackBar(snackBar);
                        return snackBar;
                      }
                    );

                    //inputValidated(context);
                    //Navigator.of(context).push(_createRoute());
                    //LoginService().getLoginResponse(userNameController.text, passwordController.text);
                    //Navigator.push(context, new MaterialPageRoute(builder: (context) => new MyApp(),),);
                    //Navigator.of(context).push(_createRoute());
                  },
                  color: Colors.blue,
                  disabledColor: Colors.blue,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Montserrat-Medium'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }*/
}


