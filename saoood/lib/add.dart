import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

import 'pills.dart';

import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  initState() {
    super.initState();
  }

  String barcode = "";
  final inputName = TextEditingController();

  String _title = "Add ";

  Widget add;

  List<Pill> pills = new List<Pill>();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputName.dispose();
    super.dispose();
  }

  Future save() async {

    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getString('pills') ?? 0;
    if (counter != 0 )
    {
     prefs.setString("pills", prefs.getString('pills') + ";" + json.encode(new Pill(inputName.text,  1531523024 * 1000, 24 * 60 * 60 * 1000, 0, 0)) ); 
    }
    else
    {
      prefs.setString("pills", json.encode(new Pill(inputName.text,  1531523024 * 1000, 24 * 60 * 60 * 1000, 0, 0)) ); 
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget._type == AddType.AddPills) {
      add = new Container(
          padding: EdgeInsets.all(32.0),
          child: new Column(children: [
            TextField(controller: inputName,
              decoration: InputDecoration(labelText: 'Nome do medicamento'),
            ),
            new ButtonBar(children: [
              new RaisedButton(onPressed: scan, child: new Text("Código de Barras")),
              new RaisedButton(onPressed: save, child: new Text("Guardar"))
            ])
          ]));
    } else {
      add = new Container();
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
              "Add " + widget._type.toString().replaceFirst("AddType.Add", "")),
        ),
        body: add);
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.barcode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}
