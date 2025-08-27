/// Helper class for serialization to and from json
class Serializer {
  /// Takes unknown json keys and puts them in the `extra_data` key
  static Map<String, dynamic> moveToExtraDataFromRoot(
    Map<String, dynamic> json,
    List<String> topLevelFields,
  ) {
    final jsonClone = Map<String, dynamic>.from(json);

    final extraDataMap = Map<String, dynamic>.from(json)
      ..removeWhere(
        (key, value) => topLevelFields.contains(key),
      );
    final rootFields = jsonClone
      ..removeWhere((key, value) => extraDataMap.keys.contains(key));
    return rootFields
      ..addAll({
        'extraData': extraDataMap,
      });
  }

  /// Takes values in `extra_data` key and puts them on the root level of
  /// the json map
  static Map<String, dynamic> moveFromExtraDataToRoot(
    Map<String, dynamic> json,
  ) {
    final jsonClone = Map<String, dynamic>.from(json);
    return jsonClone
      ..addAll({
        if (json['extraData'] != null) ...json['extraData'],
      })
      ..remove('extraData');
  }
}
