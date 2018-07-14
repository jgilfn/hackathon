import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

Profile profile;

class _ProfilePageState extends State<ProfilePage> {
  final profile = new Profile("Joaquim Guimarães", 18, Gender.Male, 1.76, 76.4,
      BloodType.ABm, "Amendoins", "Escoliose", false, 4, 3);
  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Container(
                padding: EdgeInsets.all(10.0),
                child:
                    Text("Boletim de", style: new TextStyle(fontSize: 16.0))),
            new Text(profile.name, style: new TextStyle(fontSize: 32.0)),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('Informação Geral'),
                    subtitle: Text('Idade: ' +
                        profile.age.toString() +
                        "anos\nGénero: " +
                        profile.gender.toString().replaceAll("Gender.", " ") +
                        "\nAltura: " +
                        profile.height.toString() +
                        "m\nPeso: " + profile.weight.toString() + "kg\nIMC: " + profile.bodyMassIndex.toStringAsFixed(1) )),
                  
                ],
              ),
            ),

            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.priority_high),
                    title: Text('Análises Clínicas'),
                    subtitle: Text('Grupo Sanguíneo: ' +
                        profile.bloodType.toString().replaceAll("BloodType.", "").replaceAll("p", "+").replaceAll("m", "-"))),
                  
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.priority_high),
                    title: Text('Outras informações:'),
                    subtitle: Text('Alergias: ' +
                        profile.allergies
                        +"\nFumador: " + profile.smoker.toString())),
                  
                ],
              ),
            ),
          ],
        ));
  }
}

class Profile {
  String name;

  int age;
  Gender gender;
  double height;
  double weight;

  double _bodyMassIndex;
  double get bodyMassIndex => _bodyMassIndex;

  void CalcBMI() {
    _bodyMassIndex = weight / (height*height);
  }

  BloodType bloodType;

  String allergies;

  String doencas;

  bool smoker;

  int physicalExercise;
  int foodHabits;

  Profile(
      String setName,
      int setAge,
      Gender setGender,
      double setHeight,
      double setWeight,
      BloodType setBloodtype,
      String setAllergies,
      String setDoencas,
      bool setSmoker,
      int setPhysicalExercise,
      int setFoodHabits) {
    age = setAge;
    gender = setGender;
    height = setHeight;
    weight = setWeight;
    bloodType = setBloodtype;
    allergies = setAllergies;
    doencas = setDoencas;
    smoker = setSmoker;
    physicalExercise = setPhysicalExercise;
    foodHabits = setFoodHabits;
    name = setName;

    CalcBMI();
  }
}

enum Gender { Male, Female, Other }

enum BloodType { Ap, Am, Bp, Bm, ABp, ABm, Op, Om }
