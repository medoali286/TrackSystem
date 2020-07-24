import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/constans.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  Set<Marker> markers = HashSet();
  Location location=Location(lat: 0,log: 0) ;
  double zoom=10;



  getLiveLocation(StreamSubscription<Event> _stream) {
    final _ref = FirebaseDatabase.instance.reference().child(KLocation);
    _stream = _ref.onValue.listen((data) {
      location = Location.fromMap(data.snapshot.value);

        markers.clear();
        markers.add(_marker(location));



      notifyListeners();
    });
  }

  Marker _marker(Location location) {
    return Marker(
      markerId: MarkerId('0'),
      position: LatLng(location.lat, location.log),
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  zoomIn(){
    if(zoom<22){
      zoom++;
      notifyListeners();
    }
  }
  zoomOut(){
    if(zoom>0){
      zoom--;
      notifyListeners();
    }
  }



}
