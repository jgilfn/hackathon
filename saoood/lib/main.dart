import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
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
        fixedColor: Colors.black,
        currentIndex: _page,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.account_box), title: new Text("Perfil")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.access_time), title: new Text("Timeline")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarm), title: new Text("Medicação")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.access_alarm), title: new Text("Mapa"))
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
        children: <Widget> [
          new Container(decoration: new BoxDecoration(color: Colors.lightBlue),),
          new Container(decoration: new BoxDecoration(color: Colors.red)),
          new Container(decoration: new BoxDecoration(color: Colors.black)),
                    new Container(decoration: new BoxDecoration(color: Colors.teal))
        ]
        ,
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: null,
        tooltip: 'Add info',
        child: new Icon(Icons.add),
      ),
    );
  }
}
