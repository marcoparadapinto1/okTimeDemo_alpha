import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(-33.5095152, -70.757588), // Posición inicial por defecto
    zoom: 14.4746,
  );

  GoogleMapController? googleMapController;
  Position? _currentPosition; // Variable para almacenar la ubicación actual
  Set<Marker> markers = {}; // Set para almacenar los marcadores

  @override
  void onInit() {
    super.onInit();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Comprueba si los servicios de ubicación están habilitados.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Los servicios de ubicación no están habilitados.
        return Future.error('Los servicios de ubicación están deshabilitados.');
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Se denegó el permiso de ubicación.
          return Future.error('Se denegó el permiso de ubicación.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Se denegó el permiso de ubicación permanentemente.
        return Future.error(
            'El permiso de ubicación se denegó permanentemente, no podemos solicitar permisos.');
      }

      // Cuando llegamos aquí, los permisos están otorgados y podemos
      // continuar accediendo a la posición del dispositivo.
      _currentPosition = await Geolocator.getCurrentPosition();

      // Actualiza la posición inicial de la cámara
      initialCameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.4746,
      );

      // Agrega un marcador en la ubicación actual
      markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: InfoWindow(title: 'Mi ubicación'),
        ),
      );

      update(); // Actualiza la vista para mostrar el marcador y mover la cámara
    } catch (e) {
      // Maneja errores en la inicialización del mapa
      Get.snackbar('Error', 'No se pudo inicializar el mapa.');
    }
  }
}