import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MapZoomPanBehavior _mapZoomPanBehavior;
  //late MapShapeSource _dataSource;
  @override
  void initState() {
    _mapZoomPanBehavior = MapZoomPanBehavior(
        focalLatLng: MapLatLng(-20, 147),
        zoomLevel: 3,
        enableDoubleTapZooming: true,
        minZoomLevel: 3,
        maxZoomLevel: 6);
    //_dataSource = MapShapeSource.asset('assets/world_map.json',
    //    shapeDataField: 'continent');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  children: [
                    Container(
                      child: SfMaps(layers: [
                        MapTileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          zoomPanBehavior: _mapZoomPanBehavior,
                          onWillZoom: (MapZoomDetails zoomDetails) {
                            print('onWillZoom-ZoomLevel: ' +
                                zoomDetails.newZoomLevel.toString());
                            print('onWillZoom-FocalLatLng: ' +
                                zoomDetails.focalLatLng.toString());
                            return true;
                          },
                          onWillPan: (MapPanDetails panDetails) {
                            print('onWillPan-ZoomLevel: ' +
                                panDetails.zoomLevel.toString());
                            print('onWillPan-FocalLatLng: ' +
                                panDetails.focalLatLng.toString());
                            return true;
                          },
                        )
                        //MapShapeLayer(
                        //  source: _dataSource,
                        //  zoomPanBehavior: _mapZoomPanBehavior,
                        //),
                      ]),
                      height: 600,
                    ),
                    SizedBox(height: 5),
                    ElevatedButton(
                        onPressed: () {
                          _mapZoomPanBehavior.zoomLevel = 5;
                          _mapZoomPanBehavior.focalLatLng = MapLatLng(-20, 147);
                        },
                        child: Text('Oceania Region')),
                    SizedBox(height: 5),
                    ElevatedButton(
                        onPressed: () {
                          _mapZoomPanBehavior.reset();
                        },
                        child: Text('Reset Zoom Level'))
                  ],
                ))));
  }
}
