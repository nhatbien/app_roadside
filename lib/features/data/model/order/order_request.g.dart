// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateRequest _$OrderCreateRequestFromJson(Map<String, dynamic> json) =>
    OrderCreateRequest(
      address: json['address'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$OrderCreateRequestToJson(OrderCreateRequest instance) =>
    <String, dynamic>{
      'address': instance.address,
      'note': instance.note,
    };
