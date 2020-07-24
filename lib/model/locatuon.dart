import 'package:firebase_track_location/constans.dart';

class Location{

  double lat;
  double log;
  Location({this.lat,this.log});

  Location.fromMap(Map<dynamic,dynamic>map){

this.lat=map[KLatitude]as double;
this.log=map[KLongitude]as double;

  }

Map<String,double> toMap(){
  Map<String,double>map=Map<String,double>();
  map[KLatitude]=this.lat;
  map[KLongitude]=this.lat;
  return map;

}

}