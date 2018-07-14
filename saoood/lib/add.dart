import 'package:flutter/material.dart';

enum AddType { AddProfile, AddPills, AddTimeline, AddMaps }

class Add extends StatefulWidget {
  AddType _type;

  @override
  Add(AddType newType) {
    _type = newType;
  }

  @override
  _AddState createState() => new _AddState();
}

class _AddState extends State<Add> {
  String _title = "Add ";

    Widget addPills;

  @override
  Widget build(BuildContext context) {

    if (widget._type == AddType.AddPills)
    {
      addPills = new Container(
        child: new Column(
          children: [
            TextFormField(
  decoration: InputDecoration(
    labelText: 'Nome do medicamento'
  ),
),

          ]
        )
      );
    }
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add " + widget._type.toString().replaceFirst("AddType.Add", "")),
        ),
        body: new Container(
            decoration: new BoxDecoration(color: Colors.white),
            child: new Column(
              children: <Widget>[
                new Text(widget._type.toString()),
              ],
             )
        )
      );
  }

}
