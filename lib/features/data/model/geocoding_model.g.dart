// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverseGeocodingModel _$ReverseGeocodingModelFromJson(
        Map<String, dynamic> json) =>
    ReverseGeocodingModel(
      plusCode: json['plus_code'] == null
          ? null
          : PlusCodeModel.fromJson(json['plus_code'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>)
          .map((e) => ResultsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReverseGeocodingModelToJson(
        ReverseGeocodingModel instance) =>
    <String, dynamic>{
      'plus_code': instance.plusCode,
      'results': instance.results,
      'status': instance.status,
    };

ResultsModel _$ResultsModelFromJson(Map<String, dynamic> json) => ResultsModel(
      addressComponents: (json['address_components'] as List<dynamic>)
          .map(
              (e) => AddressComponentsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      formattedAddress: json['formatted_address'] as String,
      geometry:
          GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      placeId: json['place_id'] as String,
      reference: json['reference'] as String,
      plusCode: json['plus_code'] == null
          ? null
          : PlusCodeModel.fromJson(json['plus_code'] as Map<String, dynamic>),
      types: json['types'] as List<dynamic>,
    );

Map<String, dynamic> _$ResultsModelToJson(ResultsModel instance) =>
    <String, dynamic>{
      'address_components': instance.addressComponents,
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'plus_code': instance.plusCode,
      'types': instance.types,
    };

AddressComponentsModel _$AddressComponentsModelFromJson(
        Map<String, dynamic> json) =>
    AddressComponentsModel(
      longName: json['long_name'] as String,
      shortName: json['short_name'] as String,
    );

Map<String, dynamic> _$AddressComponentsModelToJson(
        AddressComponentsModel instance) =>
    <String, dynamic>{
      'long_name': instance.longName,
      'short_name': instance.shortName,
    };

GeometryModel _$GeometryModelFromJson(Map<String, dynamic> json) =>
    GeometryModel(
      location:
          LocationModel.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryModelToJson(GeometryModel instance) =>
    <String, dynamic>{
      'location': instance.location,
    };

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

PlusCodeModel _$PlusCodeModelFromJson(Map<String, dynamic> json) =>
    PlusCodeModel(
      compoundCode: json['compound_code'] as String,
      globalCode: json['global_code'] as String,
    );

Map<String, dynamic> _$PlusCodeModelToJson(PlusCodeModel instance) =>
    <String, dynamic>{
      'compound_code': instance.compoundCode,
      'global_code': instance.globalCode,
    };
