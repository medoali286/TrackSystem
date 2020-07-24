import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/Provider/location_privider.dart';
import 'package:firebase_track_location/Widgets/map_widget.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../constans.dart';

class GetLiveLocation extends StatefulWidget {
  static String id = 'GetLiveLocation';
  @override
  _GetLiveLocationState createState() => _GetLiveLocationState();
}

class _GetLiveLocationState extends State<GetLiveLocation> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    double zoom=Provider.of<LocationProvider>(context).zoom;
    return Scaffold(
      key: _key,
      body: Stack(
        children: <Widget>[
          MapWidget(),
          Positioned(
            right: 15,
            top: MediaQuery.of(context).size.height * .7,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.add,
                    color: Colors.indigo,
                    size: 40,
                  ),
                  onTap: () {
                    print('add');
                    Provider.of<LocationProvider>(context, listen: false)
                        .zoomIn();


                  },
                ),
                Text(zoom.toInt().toString(),style: TextStyle(fontSize: 20),),




                GestureDetector(
                  child: Icon(
                    Icons.remove,
                    color: Colors.indigo,
                    size: 40,
                  ),
                  onTap: () {
                    Provider.of<LocationProvider>(context, listen: false)
                        .zoomOut();



                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
