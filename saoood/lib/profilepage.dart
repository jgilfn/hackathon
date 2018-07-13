import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

    @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
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

class Profile {
  int age;
  Gender gender;
  double height;
  double weight;

  double _bodyMassIndex;
  double get bodyMassIndex => _bodyMassIndex;

  void CalcBMI ()
  {
    _bodyMassIndex = weight/height;
  }

  BloodType bloodType;

  String allergies;

  String doencas;

  bool smoker;

  int physicalExercise;
  int foodHabits;

  Profile( int setAge, Gender setGender, double setHeight, double setWeight, BloodType setBloodtype, String setAllergies, String setDoencas, bool setSmoker, int setPhysicalExercise, int setFoodHabits)
  {
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

    CalcBMI();
  }
}

enum Gender {
  Male, Female, Other
}

enum BloodType {
  Ap, Am, Bp, Bm, ABp, ABm, Op, Om
}