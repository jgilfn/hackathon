import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';

import 'pills.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';

import 'package:intl/intl.dart';

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

  final inputName = TextEditingController();

  String _title = "Add ";

  String _barcode = "";
  Pill _pill;
  Widget add;

  List<Pill> pills = new List<Pill>();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    inputName.dispose();
    super.dispose();
  }

  Future save() async {
    if (_time == 0)
    {
      _time = DateTime.now().millisecondsSinceEpoch;
    }
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getString('pills') ?? 0;
    if (counter != 0 )
    {
      Pill pill = new Pill(inputName.text,  _time, int.parse(periodController.text) * 60*60*1000, int.parse(_barcode), 0);
     
     pill.getId().then((v) {
       
        prefs.setString("pills", prefs.getString('pills') + ";" + json.encode(pill) ).then( (r) {
          Navigator.pop(context);
       });
     });
    }
    else
    {
      prefs.setString("pills", json.encode(new Pill(inputName.text,  1531523024 * 1000, 24 * 60 * 60 * 1000, 0, 0)) ); 
    }
  
  }

  int _time;

  final timeFormat = DateFormat("H:mm a");

  int _periodRadioValue = 0;

  final TextEditingController periodController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget._type == AddType.AddPills) {
      add = new Container(
        
          padding: EdgeInsets.all(32.0),
          child: new Column(children: <Widget>[
            Text("Próxima"),
            new TimePickerFormField (
            format: timeFormat,
            onChanged: (time) {
              if (time.hour > DateTime.now().hour)
              {
                _time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute).millisecondsSinceEpoch;

              }
              else if (time.hour == DateTime.now().hour)
              {
                if (time.minute > DateTime.now().minute)
                {
                  _time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, time.hour, time.minute).millisecondsSinceEpoch;
                }
                else if (time.minute <= DateTime.now().minute)
                {
                  _time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1, time.hour, time.minute).millisecondsSinceEpoch;

                }
              }
              else if (time.hour < DateTime.now().hour)
              {
                _time = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1, time.hour, time.minute).millisecondsSinceEpoch;
              }
            },
          ),

          new Text("Repetição"), new Column(children: [new TextField(
            controller: periodController,
            keyboardType: TextInputType.number,
          ), new Text("Horas")]),
          
            new ButtonBar(children: [
              new RaisedButton(onPressed: scan, child: new Text("Código de Barras")),
              new RaisedButton(onPressed: (_barcode != "") ? save : null, child: new Text("Guardar"))
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
      setState(() => _barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          _barcode = "";
        });
      } else {
        setState(() => _barcode = "");
      }
    } on FormatException {
      setState(() => _barcode = "");
    } catch (e) {
      setState(() => _barcode = "");
    }

    setState(() {
      //inputName.text = pill.
    });

  }
  
}
