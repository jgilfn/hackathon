import 'package:flutter/material.dart';

class Pills extends StatefulWidget {
  Pills({Key key}) : super(key: key);

  @override
  _PillsState createState() => new _PillsState();
}

class _PillsState extends State<Pills> {
  List<Pill> pills;

  List<Widget> buildList() {
    List<Widget> pwidgets = new List<Widget>();

    for (Pill p in pills) {
      pwidgets.add(new Card(
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
                    new Expanded (child: new Column (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Text("Tomar às"),
                        new Text(p.nextIntakeTime(), style: new TextStyle(fontSize: 24.0))
                      ]
                    ))
                  ]))));
    }

    return pwidgets;
  }

  @override
  Widget build(BuildContext context) {
    pills = new List<Pill>();

    pills.add(new Pill("Brufen", 1531523024*1000, 24*60*60*1000));
    
    return new Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new ListView(
          children: buildList(),
        ));
  }
}

class Pill {
  String name;
  int startingTime;
  int endTime;

  int period;

  Pill(String setName, int setStartingTime, int setPeriod) {
    name = setName;
    period = setPeriod;
    startingTime = setStartingTime;
  }

  String nextIntakeTime () {

    int i = 0;
    int next =startingTime + i*period;

    int currentTime = new DateTime.now().millisecondsSinceEpoch;

    while (next < currentTime)
    {
      next = startingTime + i*period;
      i++;
    }

    String hour = DateTime.fromMillisecondsSinceEpoch(next).hour.toString();
    if (hour.length == 1)
    {
      hour = "0" + hour;
    }

    String min = DateTime.fromMillisecondsSinceEpoch(next).minute.toString();
    if (min.length == 1)
    {
      min = "0" + min;
    }
    return hour + "h" + min + "m";
  }
}
