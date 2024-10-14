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
  LatLng initialPosition = const LatLng(-15.793889, -47.882778);

  onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }

  recuperarPosicao() async {
    //permissao
    Position position = await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mapas"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: initialPosition,
          zoom: 11,
        ),
        onMapCreated: onMapCreated,
      ),
    );
  }
}
