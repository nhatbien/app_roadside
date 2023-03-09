part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangeAppState extends LocationEvent {
  final AppLifecycleState state;

  ChangeAppState({
    required this.state,
  });
}

class GetListLocation extends LocationEvent {}

class GetCurrentLocation extends LocationEvent {}

class StartTrackingLocation extends LocationEvent {}

class StopTrackingLocation extends LocationEvent {}

class ClearAllLocation extends LocationEvent {}

class LocationChange extends LocationEvent {
  final Position latLng;
  LocationChange(this.latLng);
}

class AddressCurrent extends LocationEvent {}

class GetAddressFormLatLng extends LocationEvent {}

class SaveDirection extends LocationEvent {
  final String placeId;
  final RideType vehicle;
  SaveDirection(this.placeId, this.vehicle);
}

class CreateLocation extends LocationEvent {
  final double lat;
  final double lng;
  final bool isBackground;
  final DateTime time;

  CreateLocation({
    required this.lat,
    required this.lng,
    required this.isBackground,
    required this.time,
  });
}
