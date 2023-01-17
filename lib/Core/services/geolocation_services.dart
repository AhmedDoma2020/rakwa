import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:rakwa/Core/utils/extensions.dart';

Future<Position> getLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          Exception('Location permissions are permanently denied.'));
    }

    if (permission == LocationPermission.denied) {
      return Future.error(Exception('Location permissions are denied.'));
    }
  }
  printDM("permission is => $permission");
  //LocationPermission.whileInUse
  return await Geolocator.getCurrentPosition();
}
