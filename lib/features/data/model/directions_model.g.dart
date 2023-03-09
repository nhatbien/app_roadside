// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionsModel _$DirectionsModelFromJson(Map<String, dynamic> json) =>
    DirectionsModel(
      geocodedWaypoints: (json['geocoded_waypoints'] as List<dynamic>)
          .map(
              (e) => GeocodedWaypointsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      routes: (json['routes'] as List<dynamic>)
          .map((e) => RoutesModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DirectionsModelToJson(DirectionsModel instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes,
    };

GeocodedWaypointsModel _$GeocodedWaypointsModelFromJson(
        Map<String, dynamic> json) =>
    GeocodedWaypointsModel(
      geocoderStatus: json['geocoder_status'] as String,
      placeId: json['place_id'] as String,
    );

Map<String, dynamic> _$GeocodedWaypointsModelToJson(
        GeocodedWaypointsModel instance) =>
    <String, dynamic>{
      'geocoder_status': instance.geocoderStatus,
      'place_id': instance.placeId,
    };

RoutesModel _$RoutesModelFromJson(Map<String, dynamic> json) => RoutesModel(
      legs: (json['legs'] as List<dynamic>)
          .map((e) => LegsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      overviewPolyline: PolylineModel.fromJson(
          json['overview_polyline'] as Map<String, dynamic>),
      summary: json['summary'] as String,
      warnings: json['warnings'] as List<dynamic>,
      waypointOrder: json['waypoint_order'] as List<dynamic>,
    );

Map<String, dynamic> _$RoutesModelToJson(RoutesModel instance) =>
    <String, dynamic>{
      'legs': instance.legs,
      'overview_polyline': instance.overviewPolyline,
      'summary': instance.summary,
      'warnings': instance.warnings,
      'waypoint_order': instance.waypointOrder,
    };

LegsModel _$LegsModelFromJson(Map<String, dynamic> json) => LegsModel(
      distance:
          DistanceModel.fromJson(json['distance'] as Map<String, dynamic>),
      duration:
          DistanceModel.fromJson(json['duration'] as Map<String, dynamic>),
      endAddress: json['end_address'] as String,
      endLocation: EndLocationModel.fromJson(
          json['end_location'] as Map<String, dynamic>),
      startAddress: json['start_address'] as String,
      startLocation: EndLocationModel.fromJson(
          json['start_location'] as Map<String, dynamic>),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LegsModelToJson(LegsModel instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_address': instance.endAddress,
      'end_location': instance.endLocation,
      'start_address': instance.startAddress,
      'start_location': instance.startLocation,
      'steps': instance.steps,
    };

DistanceModel _$DistanceModelFromJson(Map<String, dynamic> json) =>
    DistanceModel(
      text: json['text'] as String,
      value: json['value'] as int,
    );

Map<String, dynamic> _$DistanceModelToJson(DistanceModel instance) =>
    <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
    };

EndLocationModel _$EndLocationModelFromJson(Map<String, dynamic> json) =>
    EndLocationModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$EndLocationModelToJson(EndLocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

StepsModel _$StepsModelFromJson(Map<String, dynamic> json) => StepsModel(
      distance:
          DistanceModel.fromJson(json['distance'] as Map<String, dynamic>),
      duration:
          DistanceModel.fromJson(json['duration'] as Map<String, dynamic>),
      endLocation: EndLocationModel.fromJson(
          json['end_location'] as Map<String, dynamic>),
      htmlInstructions: json['html_instructions'] as String,
      maneuver: json['maneuver'] as String,
      polyline:
          PolylineModel.fromJson(json['polyline'] as Map<String, dynamic>),
      startLocation: EndLocationModel.fromJson(
          json['start_location'] as Map<String, dynamic>),
      travelMode: json['travel_mode'] as String,
    );

Map<String, dynamic> _$StepsModelToJson(StepsModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_location': instance.endLocation,
      'html_instructions': instance.htmlInstructions,
      'maneuver': instance.maneuver,
      'polyline': instance.polyline,
      'start_location': instance.startLocation,
      'travel_mode': instance.travelMode,
    };

PolylineModel _$PolylineModelFromJson(Map<String, dynamic> json) =>
    PolylineModel(
      points: json['points'] as String,
    );

Map<String, dynamic> _$PolylineModelToJson(PolylineModel instance) =>
    <String, dynamic>{
      'points': instance.points,
    };
