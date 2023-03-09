import 'package:json_annotation/json_annotation.dart';

part 'directions_model.g.dart';

@JsonSerializable()
class DirectionsModel {
  DirectionsModel({required this.geocodedWaypoints, required this.routes});

  @JsonKey(name: 'geocoded_waypoints')
  final List<GeocodedWaypointsModel> geocodedWaypoints;
  @JsonKey(name: 'routes')
  final List<RoutesModel> routes;

  factory DirectionsModel.fromJson(Map<String, dynamic> json) =>
      _$DirectionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DirectionsModelToJson(this);
}

@JsonSerializable()
class GeocodedWaypointsModel {
  @JsonKey(name: 'geocoder_status')
  final String geocoderStatus;
  @JsonKey(name: 'place_id')
  final String placeId;

  GeocodedWaypointsModel({required this.geocoderStatus, required this.placeId});

  factory GeocodedWaypointsModel.fromJson(Map<String, dynamic> json) =>
      _$GeocodedWaypointsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodedWaypointsModelToJson(this);
}

@JsonSerializable()
class RoutesModel {
  @JsonKey(name: 'legs')
  final List<LegsModel> legs;
  @JsonKey(name: 'overview_polyline')
  final PolylineModel overviewPolyline;
  @JsonKey(name: 'summary')
  final String summary;
  @JsonKey(name: 'warnings')
  final List warnings;
  @JsonKey(name: 'waypoint_order')
  final List waypointOrder;

  RoutesModel(
      {required this.legs,
      required this.overviewPolyline,
      required this.summary,
      required this.warnings,
      required this.waypointOrder});

  factory RoutesModel.fromJson(Map<String, dynamic> json) =>
      _$RoutesModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutesModelToJson(this);
}

@JsonSerializable()
class LegsModel {
  @JsonKey(name: 'distance')
  final DistanceModel distance;
  @JsonKey(name: 'duration')
  final DistanceModel duration;
  @JsonKey(name: 'end_address')
  final String endAddress;
  @JsonKey(name: 'end_location')
  final EndLocationModel endLocation;
  @JsonKey(name: 'start_address')
  final String startAddress;
  @JsonKey(name: 'start_location')
  final EndLocationModel startLocation;
  @JsonKey(name: 'steps')
  final List<StepsModel> steps;

  LegsModel(
      {required this.distance,
      required this.duration,
      required this.endAddress,
      required this.endLocation,
      required this.startAddress,
      required this.startLocation,
      required this.steps});

  factory LegsModel.fromJson(Map<String, dynamic> json) =>
      _$LegsModelFromJson(json);

  Map<String, dynamic> toJson() => _$LegsModelToJson(this);
}

@JsonSerializable()
class DistanceModel {
  final String text;
  final int value;

  DistanceModel({required this.text, required this.value});

  factory DistanceModel.fromJson(Map<String, dynamic> json) =>
      _$DistanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceModelToJson(this);
}

@JsonSerializable()
class EndLocationModel {
  final double lat;
  final double lng;

  EndLocationModel({required this.lat, required this.lng});
  factory EndLocationModel.fromJson(Map<String, dynamic> json) =>
      _$EndLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$EndLocationModelToJson(this);
}

@JsonSerializable()
class StepsModel {
  final DistanceModel distance;
  final DistanceModel duration;
  @JsonKey(name: 'end_location')
  final EndLocationModel endLocation;
  @JsonKey(name: 'html_instructions')
  final String htmlInstructions;
  @JsonKey(name: 'maneuver')
  final String maneuver;
  @JsonKey(name: 'polyline')
  final PolylineModel polyline;
  @JsonKey(name: 'start_location')
  final EndLocationModel startLocation;
  @JsonKey(name: 'travel_mode')
  final String travelMode;

  StepsModel(
      {required this.distance,
      required this.duration,
      required this.endLocation,
      required this.htmlInstructions,
      required this.maneuver,
      required this.polyline,
      required this.startLocation,
      required this.travelMode});
  factory StepsModel.fromJson(Map<String, dynamic> json) =>
      _$StepsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StepsModelToJson(this);
}

@JsonSerializable()
class PolylineModel {
  final String points;

  PolylineModel({required this.points});
  factory PolylineModel.fromJson(Map<String, dynamic> json) =>
      _$PolylineModelFromJson(json);

  Map<String, dynamic> toJson() => _$PolylineModelToJson(this);
}
