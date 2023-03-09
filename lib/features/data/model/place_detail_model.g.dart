// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailModel _$PlaceDetailModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailModel(
      result: json['result'] == null
          ? null
          : ResultModel.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PlaceDetailModelToJson(PlaceDetailModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
      placeId: json['place_id'] as String?,
      formattedAddress: json['formatted_address'] as String?,
      geometry: json['geometry'] == null
          ? null
          : GeometryModel.fromJson(json['geometry'] as Map<String, dynamic>),
      plusCode: json['plus_code'] == null
          ? null
          : PlusCodeModel.fromJson(json['plus_code'] as Map<String, dynamic>),
      compound: json['compound'] == null
          ? null
          : CompoundModel.fromJson(json['compound'] as Map<String, dynamic>),
      name: json['name'] as String?,
      url: json['url'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'plus_code': instance.plusCode,
      'compound': instance.compound,
      'name': instance.name,
      'url': instance.url,
      'types': instance.types,
    };

CompoundModel _$CompoundModelFromJson(Map<String, dynamic> json) =>
    CompoundModel(
      district: json['district'] as String?,
      commune: json['commune'] as String?,
      province: json['province'] as String?,
    );

Map<String, dynamic> _$CompoundModelToJson(CompoundModel instance) =>
    <String, dynamic>{
      'district': instance.district,
      'commune': instance.commune,
      'province': instance.province,
    };
