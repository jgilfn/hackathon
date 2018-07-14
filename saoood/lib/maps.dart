import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

class Maps extends StatefulWidget {
  Maps({Key key}) : super(key: key);

  @override
  _MapsState createState() => new _MapsState();
}

class _MapsState extends State<Maps> {
  void openMap() {
    MapView.setApiKey("AIzaSyB27bLcA-FUFByTrUAe5ESf_X7LgDwoVZw");
    MapView mapView = new MapView();
    List<Marker> _markers = <Marker>[
      new Marker("1", "Acin", 32.679017, -17.059942, color: Colors.yellow),
      new Marker("2", "Farmácia Ribeirabravense", 32.671577, -17.064312,
          color: Colors.green),
      new Marker(
          "3", "Farmácia Quinta-sociedade Unipessoal", 32.660900, -17.017036,
          color: Colors.green),
      new Marker("4", "Centro de Saúde, Ponta do Sol", 32.685379, -17.099118,
          color: Colors.red),
      new Marker(
          "5", "Brava Dente-medicina Dentária Lda", 32.672254, -17.064143,
          color: Colors.orange),
      new Marker("6", "Policlinica Dos Dragoeiros", 32.678040, -17.059073,
          color: Colors.blue),
      new Marker("7", "Clínica Dentária Sto Amaro", 32.659363, -16.948635,
          color: Colors.orange),
      new Marker(
          "8", "Centro Medico Da Ribeira Brava, S.A.", 32.671463, -17.064776,
          color: Colors.red)
    ];

    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition:
                new CameraPosition(new Location(32.679017, -17.0599515), 15.0),
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    mapView.setMarkers(_markers);

    mapView.onMapReady.listen((_) {
      setState(() {
        mapView.setMarkers(_markers);
        mapView.zoomToFit(padding: 1000000);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(color: Colors.white),
        child: new Column(children: <Widget>[
          new RaisedButton(
            child: new Text("press me"),
            onPressed: () {
              openMap();
            },
          )
        ]));
  }
}
