import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//void main() => runApp(MaterialApp(home: HomeView()));

class HomeView extends StatefulWidget {

  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: new Center(),
      ),
    );
  }

}

