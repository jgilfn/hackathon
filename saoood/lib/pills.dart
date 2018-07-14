import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Pills extends StatefulWidget {
  Pills({Key key}) : super(key: key);

  @override
  _PillsState createState() => new _PillsState();
}

class _PillsState extends State<Pills> {
  void sendNotification(Pill p, String time) async {
    await LocalNotifications.createNotification(
        title: p.name, content: "Tomar medicamento às " + time, id: 1);
  }

  List<Pill> pills;

  List<Widget> buildList() {
    List<Widget> pwidgets = new List<Widget>();

    for (Pill p in pills) {
      if (p.endTime > DateTime.now().millisecondsSinceEpoch || p.endTime == 0) {
        pwidgets.add(
          new Card(
            child: new Container(
                padding: EdgeInsets.all(32.0),
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(p.name,
                          style: new TextStyle(
                            fontSize: 32.0,
                          )),
                      new Expanded(
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                            new Text("Tomar às"),
                            new Text(p.nextIntakeTime(),
                                style: new TextStyle(fontSize: 24.0))
                          ]))
                    ]))));
      }
    }

    return pwidgets;
  }

  List<Widget> cards = new List<Widget>();

  @override
  void initState() {
    super.initState();

    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    /*pills = new List<Pill>();
    pills.add(new Pill("Brufen", 1531523024 * 1000, 24 * 60 * 60 * 1000, 0, 0));
    savePrefs();*/

    //sendNotification(pills[0], "");

    

    return new GestureDetector(onTap: () { loadPrefs();},child: new Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new ListView(
          children: cards,
        )));
  }

  Future loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getString('pills') ?? 0;

    if (counter != 0) {
      pills = new List<Pill>();
      List<String> pillsText = prefs.getString('pills').split(';');

      for (String s in pillsText) {
        pills.add(new Pill.fromJson(json.decode(s)));
      }
    }

    setState(() {
      cards = buildList();
    });
  }

  void savePrefs() async {
    final prefs = await SharedPreferences.getInstance();

    String save = "";
    for (Pill p in pills) {
      save += json.encode(p) + ";";
    }

    save = save.substring(0, save.length - 1);

    prefs.setString('pills', save);
  }
}

class Pill {
  String name;
  int startingTime;
  int endTime;

  int period;

  int alarmID;

  int barcode;

  int _id;
  int get id => _id;

  Pill(String setName, int setStartingTime, int setPeriod,
      [int setBarcode = 0, int setEndTime = 0]) {
    name = setName;
    period = setPeriod;
    startingTime = setStartingTime;
    endTime = setEndTime;
    barcode = setBarcode;
  }

  String nextIntakeTime() {
    int i = 0;
    int next = startingTime + i * period;

    int currentTime = new DateTime.now().millisecondsSinceEpoch;

    while (next < currentTime) {
      next = startingTime + i * period;
      i++;
    }

    String hour = DateTime.fromMillisecondsSinceEpoch(next).hour.toString();
    if (hour.length == 1) {
      hour = "0" + hour;
    }

    String min = DateTime.fromMillisecondsSinceEpoch(next).minute.toString();
    if (min.length == 1) {
      min = "0" + min;
    }
    return hour + "h" + min + "m";
  }

  int nextIntakeTimeUnix() {
    int i = 0;
    int next = startingTime + i * period;

    int currentTime = new DateTime.now().millisecondsSinceEpoch;

    while (next < currentTime) {
      next = startingTime + i * period;
      i++;
    }
    return next;
  }

  Pill.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        startingTime = json['startingTime'],
        endTime = json['endTime'],
        period = json['period'],
        barcode = json['barcode'];


  Map<String, dynamic> toJson() => {
        'name': name,
        'startingTime': startingTime,
        'endTime': endTime,
        'period': period,
        'barcode': barcode
      };

  void getId()
  {
    
  }

}
