  import 'dart:async';

  import 'package:flutter/material.dart';
  import 'package:google_maps_flutter/google_maps_flutter.dart';
  import 'package:geolocator/geolocator.dart';

  class HomePage extends StatefulWidget {
    const HomePage({super.key});

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    GoogleMapController? _controller;
    LatLng? userLocation;
    StreamSubscription<Position>? positionStream;

    onMapCreated(GoogleMapController controller) {
      _controller = controller;
    }
    /*
    recuperarPosicao() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
    });
    }
    */

    adicionarListenerLocalizacao(){
      LocationSettings locationSettings = const LocationSettings(accuracy: LocationAccuracy.high,distanceFilter: 0,);
      positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) { setState(() {
        userLocation = LatLng(position.latitude, position.longitude,);
      },);});

      if(_controller != null){
        _controller!.animateCamera(CameraUpdate.newLatLng(userLocation!),);
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      adicionarListenerLocalizacao();
    }
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      positionStream?.cancel();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Mapas"),
        ),
        body: userLocation == null ? const Center(child: CircularProgressIndicator(),): GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: userLocation!,
            zoom: 15,
          ),
          onMapCreated: onMapCreated,
          myLocationEnabled: true,
        ),
      );
    }
  }
