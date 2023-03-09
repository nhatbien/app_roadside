class AutoCompleteGoong {
  List<Predictions>? predictions;
  String? executionTime;
  String? status;

  AutoCompleteGoong({this.predictions, this.executionTime, this.status});

  AutoCompleteGoong.fromJson(Map<String, dynamic> json) {
    if (json['predictions'] != null) {
      predictions = <Predictions>[];
      json['predictions'].forEach((v) {
        predictions!.add(Predictions.fromJson(v));
      });
    }
    executionTime = json['execution_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (predictions != null) {
      data['predictions'] = predictions!.map((v) => v.toJson()).toList();
    }
    data['execution_time'] = executionTime;
    data['status'] = status;
    return data;
  }
}

class Predictions {
  String? description;
  List? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  bool? hasChildren;
  PlusCode? plusCode;
  Compound? compound;
  List<Terms>? terms;
  List<String>? types;
  Null? distanceMeters;

  Predictions(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.hasChildren,
      this.plusCode,
      this.compound,
      this.terms,
      this.types,
      this.distanceMeters});

  Predictions.fromJson(Map<String, dynamic> json) {
    description = json['description'];

    placeId = json['place_id'];
    reference = json['reference'];
    structuredFormatting = json['structured_formatting'] != null
        ? StructuredFormatting.fromJson(json['structured_formatting'])
        : null;
    hasChildren = json['has_children'];
    plusCode =
        json['plus_code'] != null ? PlusCode.fromJson(json['plus_code']) : null;
    compound =
        json['compound'] != null ? Compound.fromJson(json['compound']) : null;
    if (json['terms'] != null) {
      terms = <Terms>[];
      json['terms'].forEach((v) {
        terms!.add(Terms.fromJson(v));
      });
    }
    types = json['types'].cast<String>();
    distanceMeters = json['distance_meters'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['place_id'] = placeId;
    data['reference'] = reference;
    if (structuredFormatting != null) {
      data['structured_formatting'] = structuredFormatting!.toJson();
    }
    data['has_children'] = hasChildren;
    if (plusCode != null) {
      data['plus_code'] = plusCode!.toJson();
    }
    if (compound != null) {
      data['compound'] = compound!.toJson();
    }
    if (terms != null) {
      data['terms'] = terms!.map((v) => v.toJson()).toList();
    }
    data['types'] = types;
    data['distance_meters'] = distanceMeters;
    return data;
  }
}

class StructuredFormatting {
  String? mainText;
  List<Null>? mainTextMatchedSubstrings;
  String? secondaryText;
  List<Null>? secondaryTextMatchedSubstrings;

  StructuredFormatting(
      {this.mainText,
      this.mainTextMatchedSubstrings,
      this.secondaryText,
      this.secondaryTextMatchedSubstrings});

  StructuredFormatting.fromJson(Map<String, dynamic> json) {
    mainText = json['main_text'];
    secondaryText = json['secondary_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['main_text'] = mainText;
    data['secondary_text'] = secondaryText;
    return data;
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['compound_code'] = compoundCode;
    data['global_code'] = globalCode;
    return data;
  }
}

class Compound {
  String? district;
  String? commune;
  String? province;

  Compound({this.district, this.commune, this.province});

  Compound.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    commune = json['commune'];
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['district'] = district;
    data['commune'] = commune;
    data['province'] = province;
    return data;
  }
}

class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});

  Terms.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['offset'] = offset;
    data['value'] = value;
    return data;
  }
}
