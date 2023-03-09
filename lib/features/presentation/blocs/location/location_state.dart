part of 'location_bloc.dart';

enum LocationStatus { initial, starting, started, loading, loaded, stop, clear }

class LocationState extends Equatable {
  const LocationState({
    this.newAppState = AppLifecycleState.resumed,
    this.status = LocationStatus.initial,
    this.des,
    this.currentLocation,
    this.currentAddressLocation,
    this.directionData,
    this.zoom = 15,
    this.polylineListPoints = const [],
    this.selectionRide,
    this.bounds,
  });

  final AppLifecycleState newAppState;
  final LocationStatus status;
  final Position? currentLocation;
  final LatLng? des;
  final List<LatLng> polylineListPoints;
  final RideType? selectionRide;
  final DirectionsModel? directionData;
  final ReverseGeocodingModel? currentAddressLocation;
  final double zoom;
  final LatLngBounds? bounds;

  LocationState copyWith({
    AppLifecycleState? newAppState,
    LocationStatus? status,
    Position? currentLocation,
    LatLng? des,
    ReverseGeocodingModel? currentAddressLocation,
    List<LatLng>? polylineListPoints,
    DirectionsModel? directionData,
    double? zoom,
    RideType? selectionRide,
    LatLngBounds? bounds,
  }
      /* LocationList? newList,
    Location? newCurrent, */
      ) {
    return LocationState(
      newAppState: newAppState ?? this.newAppState,
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      des: des ?? this.des,
      currentAddressLocation:
          currentAddressLocation ?? this.currentAddressLocation,
      polylineListPoints: polylineListPoints ?? this.polylineListPoints,
      directionData: directionData ?? this.directionData,
      zoom: zoom ?? this.zoom,
      selectionRide: selectionRide ?? this.selectionRide,
      bounds: bounds ?? this.bounds,
      /*  list: newList ?? list,
      current: newCurrent != null ? newCurrent.copyWith() : current, */
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentLocation,
        des,
        currentAddressLocation,
        directionData,
        polylineListPoints,
        zoom,
        selectionRide,
        bounds
      ];
}
