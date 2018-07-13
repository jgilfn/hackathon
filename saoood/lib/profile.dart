import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

    @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile>
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