import 'package:json_annotation/json_annotation.dart';

part 'geocoding_model.g.dart';

@JsonSerializable()
class ReverseGeocodingModel {
  @JsonKey(name: 'plus_code')
  final PlusCodeModel? plusCode;
  @JsonKey(name: 'results')
  final List<ResultsModel> results;
  @JsonKey(name: 'status')
  final String status;

  ReverseGeocodingModel(
      {this.plusCode, required this.results, required this.status});

  factory ReverseGeocodingModel.fromJson(Map<String, dynamic> json) =>
      _$ReverseGeocodingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReverseGeocodingModelToJson(this);
}

@JsonSerializable()
class ResultsModel {
  @JsonKey(name: 'address_components')
  final List<AddressComponentsModel> addressComponents;
  @JsonKey(name: 'formatted_address')
  final String formattedAddress;
  @JsonKey(name: 'geometry')
  final GeometryModel geometry;
  @JsonKey(name: 'place_id')
  final String placeId;
  @JsonKey(name: 'reference')
  final String reference;
  @JsonKey(name: 'plus_code')
  final PlusCodeModel? plusCode;
  @JsonKey(name: 'types')
  final List types;

  ResultsModel(
      {required this.addressComponents,
      required this.formattedAddress,
      required this.geometry,
      required this.placeId,
      required this.reference,
      this.plusCode,
      required this.types});

  factory ResultsModel.fromJson(Map<String, dynamic> json) =>
      _$ResultsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsModelToJson(this);
}

@JsonSerializable()
class AddressComponentsModel {
  @JsonKey(name: 'long_name')
  final String longName;
  @JsonKey(name: 'short_name')
  final String shortName;

  AddressComponentsModel({required this.longName, required this.shortName});

  factory AddressComponentsModel.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressComponentsModelToJson(this);
}

@JsonSerializable()
class GeometryModel {
  @JsonKey(name: 'location')
  final LocationModel location;

  GeometryModel({required this.location});
  factory GeometryModel.fromJson(Map<String, dynamic> json) =>
      _$GeometryModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryModelToJson(this);
}

@JsonSerializable()
class LocationModel {
  final double lat;
  final double lng;

  LocationModel({required this.lat, required this.lng});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}

@JsonSerializable()
class PlusCodeModel {
  @JsonKey(name: 'compound_code')
  final String compoundCode;
  @JsonKey(name: 'global_code')
  final String globalCode;

  PlusCodeModel({required this.compoundCode, required this.globalCode});
  factory PlusCodeModel.fromJson(Map<String, dynamic> json) =>
      _$PlusCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlusCodeModelToJson(this);
}
