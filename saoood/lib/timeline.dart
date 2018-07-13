import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  Timeline({Key key}) : super(key: key);

    @override
  _TimelineState createState() => new _TimelineState();
}

class _TimelineState extends State<Timeline>
{
  @override
  Widget build(BuildContext context)
  {
    return new Container(
       decoration: new BoxDecoration(color: Colors.white),
       child: new Column(children: <Widget>[],)
    );
  }
}