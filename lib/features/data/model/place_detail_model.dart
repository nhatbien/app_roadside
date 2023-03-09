import 'package:json_annotation/json_annotation.dart';

import 'geocoding_model.dart';
part 'place_detail_model.g.dart';

@JsonSerializable()
class PlaceDetailModel {
  final ResultModel? result;
  final String? status;

  PlaceDetailModel({this.result, this.status});

  factory PlaceDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailModelToJson(this);
}

@JsonSerializable()
class ResultModel {
  @JsonKey(name: 'place_id')
  String? placeId;
  @JsonKey(name: 'formatted_address')
  String? formattedAddress;
  @JsonKey(name: 'geometry')
  GeometryModel? geometry;
  @JsonKey(name: 'plus_code')
  PlusCodeModel? plusCode;
  @JsonKey(name: 'compound')
  CompoundModel? compound;
  String? name;
  String? url;
  List<String>? types;

  ResultModel(
      {this.placeId,
      this.formattedAddress,
      this.geometry,
      this.plusCode,
      this.compound,
      this.name,
      this.url,
      this.types});

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}

@JsonSerializable()
class CompoundModel {
  String? district;
  String? commune;
  String? province;

  CompoundModel({this.district, this.commune, this.province});

  factory CompoundModel.fromJson(Map<String, dynamic> json) =>
      _$CompoundModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompoundModelToJson(this);
}
