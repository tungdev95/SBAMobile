// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_value_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeyValueModel _$KeyValueModelFromJson(Map<String, dynamic> json) =>
    KeyValueModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      value: json['value'] as String?,
      key: json['key'] as String?,
      otherField: json['otherField'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$KeyValueModelToJson(KeyValueModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'value': instance.value,
      'key': instance.key,
      'otherField': instance.otherField,
    };
