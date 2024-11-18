import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:udemy_flutter_delivery/src/pages/map/map_controller.dart';
import 'package:geolocator/geolocator.dart';


class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(init: MapController(),
      builder: (controller) {
        return Scaffold(
          body: GoogleMap(
            initialCameraPosition: controller.initialCameraPosition,
            // ... otros parámetros del mapa ...
          ),
        );
      },
    );
  }
}

