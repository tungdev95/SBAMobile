import 'package:json_annotation/json_annotation.dart';

class SafeDoubleFormatConverter implements JsonConverter<double?, dynamic> {
  const SafeDoubleFormatConverter();

  @override
  double? fromJson(dynamic json) {
    if (json is String) {
      return double.tryParse(json);
    }
    try {
      return (json as num?)?.toDouble();
    } catch (e) {
      return null;
    }
  }

  @override
  double? toJson(double? json) => json;
}
