import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:isolate';
import 'package:splashscreen/splashscreen.dart';
import 'profilepage.dart';
import 'maps.dart';
import 'pills.dart';
import 'timeline.dart';
import 'add.dart';

import 'package:flutter/widgets.dart';

import 'package:local_notifications/local_notifications.dart';

import 'dart:convert';
void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new Menu(),
      title: new Text('+Saood',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0
      ),),
      imageNetwork: 'https://i.imgur.com/4kHfj6x.png',
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.00,
      onClick: ()=>print(""),
      loaderColor: Colors.cyan
    );
  }
}

class Menu extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
          primaryColor: Color.fromARGB(255, 117, 221, 255),
          secondaryHeaderColor: Color.fromARGB(255, 255, 84, 112)),
      home: new MyHomePage(title: 'saood'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;

  int _page = 0;
  @override
  void initState() {
    super.initState();

    //CHANGE LENGTH
    _pageController = new PageController(initialPage: 0);
  }

@override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.lightBlueAccent,
        currentIndex: _page,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.assignment_ind), title: new Text("Boletim")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: new Text("Timeline")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarm), title: new Text("Medicação")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.location_on), title: new Text("Mapa"))
        ],
        onTap: (index) {
          this._pageController.animateToPage(index,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeInOut);
        },
      ),
      body: new PageView(
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          new ProfilePage(),
          new Timeline(),
          new Pills(),
          new Maps()
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
AddType _currentType = AddType.AddProfile;
          if (_page == 0) {
            _currentType = AddType.AddProfile;
          } else if (_page == 1) {
            _currentType = AddType.AddTimeline;
          } else if (_page == 2) {
            _currentType = AddType.AddPills;
          } else if (_page == 3) {
            _currentType = AddType.AddMaps;
          }
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Add(_currentType)));
        },
        tooltip: 'Editar',
        child: new Icon(Icons.edit),
      ),
    );
  }
}