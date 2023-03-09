import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/resource/datastate.dart';
import '../../../../service/location_service.dart';
import '../../../data/model/directions_model.dart';
import '../../../data/model/geocoding_model.dart';
import '../../../domain/entity/type.dart';
import '../../../domain/repository/map_repository.dart';

export 'package:google_polyline_algorithm/google_polyline_algorithm.dart'
    show decodePolyline;

part 'location_state.dart';
part 'location_event.dart';

extension PolylineExt on List<List<num>> {
  List<LatLng> unpackPolyline() =>
      map((p) => LatLng(p[0].toDouble(), p[1].toDouble())).toList();
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;
  final MapRepository _mapRepository;
  LocationBloc(this._locationService, this._mapRepository)
      : super(const LocationState()) {
    on<GetCurrentLocation>(
      getCurrentLocation,
    );
    on<StartTrackingLocation>(
      startTracking,
    );
    on<StopTrackingLocation>(
      stopTracking,
    );
    on<LocationChange>(
      saveCurrentLocation,
    );

    on<AddressCurrent>(
      saveCurrentAddress,
    );
    on<SaveDirection>(
      saveDirection,
    );
    on<GetAddressFormLatLng>(
      getAddressFormLatLng,
    );
  }

  StreamSubscription<Position>? _positionSubscription;

/* 
  void changeAppState(ChangeAppState event, Emitter<LocationState> emit) async {
    emit(state.copyWith(event.state, null, null, null));
  } */

  void saveDirection(SaveDirection event, Emitter<LocationState> emit) async {
    final pointsss = <LatLng>[];
    emit(state.copyWith(
      selectionRide: event.vehicle,
    ));
    /* final placeDetail = await _getPlaceDetailById.execute(event.placeId);

    if (placeDetail is DataSuccess) {
      final LatLng destination = LatLng(
          placeDetail.data!.result!.geometry!.location.lat,
          placeDetail.data!.result!.geometry!.location.lng);
      final LatLng origin = LatLng(
          state.currentLocation.latitude, state.currentLocation.longitude);

      final data = await _getDirectionUsecase.execute(ParamsGetDirection(
          origin: origin, destination: destination, vehicle: event.vehicle));

      if (data is DataSuccess) {
        pointsss.addAll(
            decodePolyline(data.data!.routes[0].overviewPolyline.points)
                .unpackPolyline());
        emit(state.copyWith(
            bounds: getBounds(pointsss),
            status: LocationStatus.loaded,
            directionData: data.data,
            des: destination,
            polylineListPoints: pointsss));
      }
    } */
  }

  LatLngBounds getBounds(List<LatLng> markers) {
    var lngs = markers.map<double>((m) => m.longitude).toList();
    var lats = markers.map<double>((m) => m.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      LatLng(rightMost, topMost),
      LatLng(leftMost, bottomMost),
    );

    return bounds;
  }

  void getAddressFormLatLng(
      GetAddressFormLatLng event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
      status: LocationStatus.loaded,
    ));
    final data = await _mapRepository.getAddressFromLatLn(
      LatLng(state.currentLocation!.latitude, state.currentLocation!.longitude),
    );

    if (data is DataSuccess) {
      emit(state.copyWith(
        currentAddressLocation: data.data,
        status: LocationStatus.loaded,
      ));
    }
  }

  void saveCurrentAddress(
      AddressCurrent event, Emitter<LocationState> emit) async {
    /*  final currentLocation = await _getCurrentLocationUseCase.execute(NoParam());

    final data = await _getAddressCurrentLocation
        .execute(LatLng(currentLocation.latitude, currentLocation.longitude));
    if (data is DataSuccess) {
      emit(state.copyWith(currentAddressLocation: data.data));
    } */
  }

  void getCurrentLocation(
      LocationEvent event, Emitter<LocationState> emit) async {
    /* final currentLocation = await _getCurrentLocationUseCase.execute(NoParam());

    emit(
      state.copyWith(
        status: LocationStatus.loaded,
        currentLocation: CurrentUserLocationEntity(
            latitude: currentLocation.latitude,
            longitude: currentLocation.longitude),
      ),
    ); */
  }

  void startTracking(LocationEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(
      status: LocationStatus.loading,
    ));
    _positionSubscription?.cancel();
    _positionSubscription = await _locationService.createNumberStream();
    _positionSubscription?.onData((data) {
      if (state.currentLocation?.latitude != data.latitude &&
          state.currentLocation?.longitude != data.longitude) {
        add(LocationChange(data));
      }
    });
    _positionSubscription?.onError((data) {
      _positionSubscription?.cancel();
    });
    emit(state.copyWith(
      status: LocationStatus.loaded,
    ));
  }

  void stopTracking(LocationEvent event, Emitter<LocationState> emit) async {
    _positionSubscription!.cancel();
  }

  void saveCurrentLocation(
      LocationChange event, Emitter<LocationState> emit) async {
    emit(state.copyWith(currentLocation: event.latLng));
  }

/* 
  void create(CreateLocation event, Emitter<LocationState> emit) async {
    var newCurrent = await _createLocationUseCase.execute(
      event.lat,
      event.lng,
      event.isBackground,
      event.time,
    );

    var list = await _getLocationListUseCase.execute();

    emit(
      state.copyWith(
        null,
        null,
        list,
        newCurrent,
      ),
    );
  }

  void deleteAll(ClearAllLocation event, Emitter<LocationState> emit) async {
    await _deleteAllLocationUseCase.execute();

    emit(state.empty());
  }

  void trackingCallback(CurrentUserLocationEntity loc) {
    add(
      CreateLocation(
        isBackground: state.appState == AppLifecycleState.inactive ||
            state.appState == AppLifecycleState.paused,
        lat: loc.latitude,
        lng: loc.longitude,
        time: DateTime.now(),
      ),
    );
  } */
}
