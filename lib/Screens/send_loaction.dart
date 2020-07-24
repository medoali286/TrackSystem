import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_track_location/constans.dart';
import 'package:firebase_track_location/model/locatuon.dart';
import 'package:firebase_track_location/services/geo_firebase.dart';
import 'package:firebase_track_location/services/geo_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SendLiveLocation extends StatefulWidget {
  static String id = 'SendLiveLocation';
  final Position position;
  SendLiveLocation(this.position);

  @override
  _SendLiveLocationState createState() => _SendLiveLocationState();
}

class _SendLiveLocationState extends State<SendLiveLocation> {
  GeoLocatorService _geoLocatorService;
  GeoFirebase _geoFirebase = GeoFirebase();

  double lat;
  double log;
  bool send = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _geoLocatorService = GeoLocatorService();

    lat = widget.position.latitude;
    log = widget.position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: StreamBuilder(
          stream: _geoLocatorService.getCurrentLocation(),
          builder: (
            context,
            AsyncSnapshot<Position> snapshot,
          ) {
           if(send){
             _geoFirebase.writeData(location: Location(lat: lat, log: log));
           }

            if (snapshot.hasData) {
              lat = snapshot.data.latitude;
              log = snapshot.data.longitude;
              return CenterWidget(
                lat: lat,
                log: log,
                send: () {
                 send=true;
                },
                stop: () {
                 send=false;
                },
              );
            } else {
              return CenterWidget(
                lat: lat,
                log: log,
              );
            }
          }),
    );
  }
}

class CenterWidget extends StatelessWidget {
  const CenterWidget({
    Key key,
    @required this.lat,
    @required this.log,
    this.stop,
    this.send,
  }) : super(key: key);

  final double lat;
  final double log;
  final Function stop;
  final Function send;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 2,
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width * .8,
          child: Column(
            children: <Widget>[
              Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Latitude'),
                  trailing: Text(lat.toString()),
                ),
              ),
              Card(
                elevation: 1,
                child: ListTile(
                  title: Text('Latitude'),
                  trailing: Text(log.toString()),
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  ButtonWidget(
                    text: 'stop',
                    textColor: Colors.black,
                    backgroundColor: Colors.white,
                    onTap: stop,
                  ),

                  ButtonWidget(
                    text: 'send',
                    textColor: Colors.white,
                    backgroundColor: Colors.indigo,
                    onTap: send,
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    @required this.onTap,
    @required this.backgroundColor,
    @required this.text,
    @required this.textColor,
  }) : super(key: key);

  final Function onTap;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 1,
          child: Container(
            width: MediaQuery.of(context).size.width * .3,
            height: 40,
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            ),
          ),
        ));
  }
}
