// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'autocomplete_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoCompleteModel _$AutoCompleteModelFromJson(Map<String, dynamic> json) =>
    AutoCompleteModel(
      predictions: (json['predictions'] as List<dynamic>)
          .map((e) => PredictionsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$AutoCompleteModelToJson(AutoCompleteModel instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': instance.status,
    };

PredictionsModel _$PredictionsModelFromJson(Map<String, dynamic> json) =>
    PredictionsModel(
      description: json['description'] as String,
      matchedSubstrings: (json['matchedSubstrings'] as List<dynamic>)
          .map(
              (e) => MatchedSubstringsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['placeId'] as String,
      reference: json['reference'] as String,
      structuredFormatting: StructuredFormattingModel.fromJson(
          json['structuredFormatting'] as Map<String, dynamic>),
      terms: (json['terms'] as List<dynamic>)
          .map((e) => TermsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PredictionsModelToJson(PredictionsModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'matchedSubstrings': instance.matchedSubstrings,
      'placeId': instance.placeId,
      'reference': instance.reference,
      'structuredFormatting': instance.structuredFormatting,
      'terms': instance.terms,
      'types': instance.types,
    };

MatchedSubstringsModel _$MatchedSubstringsModelFromJson(
        Map<String, dynamic> json) =>
    MatchedSubstringsModel(
      length: json['length'] as int,
      offset: json['offset'] as int,
    );

Map<String, dynamic> _$MatchedSubstringsModelToJson(
        MatchedSubstringsModel instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

StructuredFormattingModel _$StructuredFormattingModelFromJson(
        Map<String, dynamic> json) =>
    StructuredFormattingModel(
      mainText: json['mainText'] as String,
      mainTextMatchedSubstrings:
          (json['mainTextMatchedSubstrings'] as List<dynamic>)
              .map((e) => MainTextMatchedSubstringsModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
      secondaryText: json['secondaryText'] as String,
    );

Map<String, dynamic> _$StructuredFormattingModelToJson(
        StructuredFormattingModel instance) =>
    <String, dynamic>{
      'mainText': instance.mainText,
      'mainTextMatchedSubstrings': instance.mainTextMatchedSubstrings,
      'secondaryText': instance.secondaryText,
    };

MainTextMatchedSubstringsModel _$MainTextMatchedSubstringsModelFromJson(
        Map<String, dynamic> json) =>
    MainTextMatchedSubstringsModel(
      offset: json['offset'] as int,
      length: json['length'] as int,
    );

Map<String, dynamic> _$MainTextMatchedSubstringsModelToJson(
        MainTextMatchedSubstringsModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'length': instance.length,
    };

TermsModel _$TermsModelFromJson(Map<String, dynamic> json) => TermsModel(
      offset: json['offset'] as int,
      value: json['value'] as String,
    );

Map<String, dynamic> _$TermsModelToJson(TermsModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };
