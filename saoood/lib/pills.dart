import 'package:flutter/material.dart';

class Pills extends StatefulWidget {
  Pills({Key key}) : super(key: key);

    @override
  _PillsState createState() => new _PillsState();
}

class _PillsState extends State<Pills>
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