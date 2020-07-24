

import 'package:geolocator/geolocator.dart';

class GeoLocatorService{

final Geolocator _geo=Geolocator();

Stream<Position>getCurrentLocation(){
  LocationOptions _locationOptions=LocationOptions(
    accuracy:LocationAccuracy.high ,
    distanceFilter: 0,
  );
  return _geo.getPositionStream(_locationOptions);
}

Future<Position>getInitialLocation()async{
  return _geo.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
    locationPermissionLevel:GeolocationPermission.locationWhenInUse,
  );



}


}