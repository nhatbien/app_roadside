import 'dart:async';

import 'package:geolocator/geolocator.dart';

class CurrentLocationFailure implements Exception {
  CurrentLocationFailure({
    required this.error,
  });
  final String error;
}

class LocationService {
  LocationService(this.geolocatorPlatform);

  final GeolocatorPlatform geolocatorPlatform;

  StreamSubscription<Position>? _locationSubscription;

  void cancelListenCurrentLocation() {
    if (_locationSubscription != null) {
      _locationSubscription!.cancel();
      _locationSubscription = null;
    }
  }

  Future<StreamSubscription<Position>> createNumberStream() async {
    final StreamSubscription<Position> stream;
    final serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final isEnabled = await geolocatorPlatform.openLocationSettings();
      if (!isEnabled) {
        throw CurrentLocationFailure(
          error: "You don't have location service enabled",
        );
      }
    }

    final permissionStatus = await geolocatorPlatform.requestPermission();
    if (permissionStatus == LocationPermission.denied) {
      final status = await geolocatorPlatform.requestPermission();
      if (status == LocationPermission.denied) {
        throw CurrentLocationFailure(
          error: "You don't have all the permissions granted."
              '\nYou need to activate them manually.',
        );
      }
    }

    stream = geolocatorPlatform.getPositionStream().listen((Position loc) {
      print('onLocationChanged ${loc.heading}');
    });

    return stream;
  }

  Future<Position> getCurrentLocation() async {
    final serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      final isEnabled = await geolocatorPlatform.openLocationSettings();
      if (!isEnabled) {
        throw CurrentLocationFailure(
          error: "You don't have location service enabled",
        );
      }
    }

    final permissionStatus = await geolocatorPlatform.requestPermission();
    if (permissionStatus == LocationPermission.denied) {
      final status = await geolocatorPlatform.requestPermission();
      if (status == LocationPermission.denied) {
        throw CurrentLocationFailure(
          error: "You don't have all the permissions granted."
              '\nYou need to activate them manually.',
        );
      }
    }

    late final Position locationData;
    try {
      locationData = await geolocatorPlatform.getCurrentPosition();
    } catch (_) {
      throw CurrentLocationFailure(
        error: 'Something went wrong getting your location, '
            'please try again later',
      );
    }

    return locationData;
  }
}
