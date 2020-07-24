import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/Provider/location_privider.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../constans.dart';


class MapWidget extends StatefulWidget {

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();
  final _ref = FirebaseDatabase.instance.reference().child(KLocation);
  StreamSubscription<Event> _stream;
  Location location;
  double zoom=10;


  @override
  void initState() {
    super.initState();
    location=Location(lat: 0,log: 0);


    _stream = _ref.onValue.listen((data) {

      location = Location.fromMap(data.snapshot.value);
      _centerScreen(location);

    });


  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocationProvider>(context).getLiveLocation(_stream);
    Set<Marker> markers = Provider.of<LocationProvider>(context).markers;
    zoom=Provider.of<LocationProvider>(context).zoom;

return GoogleMap(

  initialCameraPosition:
  _cameraPosition(location),
  markers: markers,
  onMapCreated: onMapCreated,
  zoomControlsEnabled: false,


);


  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

    controller.getZoomLevel().then((data){
      print(data);
    });

  }

  Future<void> _centerScreen(Location location) async {
    final GoogleMapController controller = await _controller.future;
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition(location)),
    );

  }


  CameraPosition _cameraPosition(Location location) {
    return CameraPosition(target: LatLng(location.lat, location.log), zoom: zoom);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stream.cancel();
  }



}
