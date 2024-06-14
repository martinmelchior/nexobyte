
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nexobyte/app/data/models/preferencias_de_usuario_model.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Tu servicio de localización esta deshabilitado.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Denegaste el permiso a la aplicación para obtener tu ubicación');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Se denegó el permiso de obtener tu ubicación para siempre.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


//*-------------------------------------------------------------------------- getLastKnownPosition
Future<Position?> getLastKnownPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Tu servicio de localización esta deshabilitado.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Denegaste el permiso a la aplicación para obtener tu ubicación');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Se denegó el permiso de obtener tu ubicación para siempre.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getLastKnownPosition();
}


//*-------------------------------------------------------------------------------------- getAddressFromLatLng
Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    String lugar = '';
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty)
    {
      Placemark place = placemarks[0];
      if (place.locality!.isNotEmpty)
      {
        lugar += place.locality!;
        PreferenciasDeUsuarioStorage.localidad = place.locality!;
      }
      if (place.postalCode!.isNotEmpty)
      {
        lugar += ', ' + place.postalCode!;
        PreferenciasDeUsuarioStorage.cp = place.postalCode!;
      }
      if (place.country!.isNotEmpty)
      {
        lugar += ', ' + place.country!;
        PreferenciasDeUsuarioStorage.pais = place.country!;
      }
    }
    return lugar;
}