import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const CustomDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null || (json).isEmpty) return null;
    var newJson = json;
    // newJson = newJson.replaceFirst(RegExp(r'-\d\d:\d\d'), '');
    newJson = newJson.replaceFirst(RegExp(r'\+\d\d:\d\d'), '');
    if (newJson.contains('Z') == false && newJson.contains('+') == false) {
      newJson = '${newJson}Z';
    }
    return DateTime.tryParse(newJson);
  }

  @override
  String? toJson(DateTime? json) => json?.toIso8601String();
}

