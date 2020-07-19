import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//void main() => runApp(MaterialApp(home: HomeView()));

class HomeView extends StatefulWidget {

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: new Container(
          key: _scaffoldKey,
          padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
          child: Text(
            'Home View',
            style: TextStyle(
              color: Colors.red
            ),

          ),
        ),
      ),
    );
  }

}

