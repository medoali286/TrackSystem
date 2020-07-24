import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/constans.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class GeoFirebase {
  final _ref = FirebaseDatabase.instance.reference();

  writeData({@required Location location}) {

    Map<String,double>_location=Location(lat: location.lat,log: location.log).toMap();
    _ref.child(KLocation).set(_location);
  }


}
