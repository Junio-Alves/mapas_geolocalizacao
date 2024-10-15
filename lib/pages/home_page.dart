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
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      print("Serviço de localização desabilitado");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        print("Permisão de localização negada");
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    initialPosition = LatLng(position.latitude, position.longitude);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperarPosicao();
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
