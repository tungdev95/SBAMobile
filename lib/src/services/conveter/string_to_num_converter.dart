import 'package:json_annotation/json_annotation.dart';

class StringToNumConverter implements JsonConverter<double?, dynamic> {
  const StringToNumConverter();

  @override
  double? fromJson(dynamic json) {
    if (json is double) return json;
    if (json is String) {
      return double.tryParse(json);
    }
    return null;
  }

  @override
  String? toJson(dynamic json) => json?.toString();
}

class StringToIntConverter implements JsonConverter<int?, dynamic> {
  const StringToIntConverter();

  @override
  int? fromJson(dynamic json) {
    if (json is int) return json;
    if (json is String) {
      return int.tryParse(json);
    }
    return null;
  }

  @override
  String? toJson(dynamic json) => json?.toString();
}
