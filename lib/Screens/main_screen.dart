import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/Screens/get_live_location.dart';
import 'package:firebase_track_location/Screens/send_loaction.dart';
import 'package:firebase_track_location/constans.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:firebase_track_location/services/geo_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static String id = 'MainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ref = FirebaseDatabase.instance.reference().child(KLocation);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<DataSnapshot> _snapshot;

  @override
  void initState() {
    super.initState();
    _snapshot = ref.once();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text(_location.lat.toString()),

            FlatButton.icon(
              label: Text('send live location'),
              icon: Icon(
                Icons.send,
                size: 40,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SendLiveLocation.id);
              },
            ),

            FlatButton.icon(
              label: Text('get live location'),
              icon: Icon(
                Icons.location_on,
                size: 40,
                color: Colors.blue,
              ),
              onPressed: () async {
                Navigator.of(context)
                    .pushNamed(GetLiveLocation.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
