// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class CurrentLocationFailure implements Exception {
  CurrentLocationFailure({
    required this.error,
  });
  final String error;
}

/// {@template device_location_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class DeviceLocationRepository {
  /// {@macro device_location_repository}
  DeviceLocationRepository({
    Location? location,
  }) : _location = location ?? Location();

  final Location _location;

  StreamSubscription<LocationData>? _subscription;

  void cancelListenCurrentLocation() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  void listenCurrentLocation(Function callback) async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      final isEnabled = await _location.requestService();
      if (!isEnabled) {
        throw CurrentLocationFailure(
          error: "You don't have location service enabled",
        );
      }
    }

    final permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      final status = await _location.requestPermission();
      if (status != PermissionStatus.granted) {
        throw CurrentLocationFailure(
          error: "You don't have all the permissions granted."
              '\nYou need to activate them manually.',
        );
      }
    }

    _location.enableBackgroundMode(enable: true);

    _subscription = _location.onLocationChanged.listen((LocationData loc) {
      callback(LatLng(
        loc.latitude!,
        loc.longitude!,
      ));
    });
  }

  Future<LatLng> getCurrentLocation() async {
    final serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      final isEnabled = await _location.requestService();
      if (!isEnabled) {
        throw CurrentLocationFailure(
          error: "You don't have location service enabled",
        );
      }
    }

    final permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      final status = await _location.requestPermission();
      if (status != PermissionStatus.granted) {
        throw CurrentLocationFailure(
          error: "You don't have all the permissions granted."
              '\nYou need to activate them manually.',
        );
      }
    }

    late final LocationData locationData;
    try {
      locationData = await _location.getLocation();
    } catch (_) {
      throw CurrentLocationFailure(
        error: 'Something went wrong getting your location, '
            'please try again later',
      );
    }

    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      throw CurrentLocationFailure(
        error: 'Something went wrong getting your location, '
            'please try again later',
      );
    }

    return LatLng(
      latitude,
      longitude,
    );
  }
}
