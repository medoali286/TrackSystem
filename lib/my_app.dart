import 'package:firebase_track_location/Provider/location_privider.dart';
import 'package:firebase_track_location/services/geo_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'Screens/get_live_location.dart';
import 'Screens/main_screen.dart';
import 'Screens/send_loaction.dart';

class MyApp extends StatelessWidget {
  final geoService=GeoLocatorService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context){
        return geoService.getInitialLocation();
      },
      child: MaterialApp(
          initialRoute: MainScreen.id,
          routes: {
            SendLiveLocation.id:(context){
              return Consumer<Position>(
                  builder: (context,position,widget){
                    if(position!=null){
                      return SendLiveLocation(position);
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            },
            MainScreen.id:(context)=>MainScreen(),
            GetLiveLocation.id:(context)=>ChangeNotifierProvider(
                create: (_){return LocationProvider();},
            child: GetLiveLocation(),),

          },

          title: 'geo',

        ),


    );
  }
}