import 'package:json_annotation/json_annotation.dart';
part 'autocomplete_model.g.dart';

@JsonSerializable()
class AutoCompleteModel {
  final List<PredictionsModel> predictions;
  final String status;

  const AutoCompleteModel({required this.predictions, required this.status});

  factory AutoCompleteModel.fromJson(Map<String, dynamic> json) =>
      _$AutoCompleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$AutoCompleteModelToJson(this);
}

@JsonSerializable()
class PredictionsModel {
  final String description;
  final List<MatchedSubstringsModel> matchedSubstrings;
  final String placeId;
  final String reference;
  final StructuredFormattingModel structuredFormatting;
  final List<TermsModel> terms;
  final List<String> types;

  const PredictionsModel(
      {required this.description,
      required this.matchedSubstrings,
      required this.placeId,
      required this.reference,
      required this.structuredFormatting,
      required this.terms,
      required this.types});

  factory PredictionsModel.fromJson(Map<String, dynamic> json) =>
      _$PredictionsModelFromJson(json);

  /// Connect the generated [_$PredictionsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PredictionsModelToJson(this);
}

@JsonSerializable()
class MatchedSubstringsModel {
  final int length;
  final int offset;

  const MatchedSubstringsModel({required this.length, required this.offset});
  factory MatchedSubstringsModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringsModelFromJson(json);

  /// Connect the generated [_$MatchedSubstringsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MatchedSubstringsModelToJson(this);
}

@JsonSerializable()
class StructuredFormattingModel {
  final String mainText;
  final List<MainTextMatchedSubstringsModel> mainTextMatchedSubstrings;
  final String secondaryText;

  const StructuredFormattingModel(
      {required this.mainText,
      required this.mainTextMatchedSubstrings,
      required this.secondaryText});
  factory StructuredFormattingModel.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingModelFromJson(json);

  /// Connect the generated [_$StructuredFormattingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StructuredFormattingModelToJson(this);
}

@JsonSerializable()
class MainTextMatchedSubstringsModel {
  final int offset;
  final int length;

  const MainTextMatchedSubstringsModel(
      {required this.offset, required this.length});
  factory MainTextMatchedSubstringsModel.fromJson(Map<String, dynamic> json) =>
      _$MainTextMatchedSubstringsModelFromJson(json);

  /// Connect the generated [_$MainTextMatchedSubstringsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MainTextMatchedSubstringsModelToJson(this);
}

@JsonSerializable()
class TermsModel {
  final int offset;
  final String value;

  const TermsModel({required this.offset, required this.value});

  factory TermsModel.fromJson(Map<String, dynamic> json) =>
      _$TermsModelFromJson(json);

  /// Connect the generated [_$TermsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TermsModelToJson(this);
}
