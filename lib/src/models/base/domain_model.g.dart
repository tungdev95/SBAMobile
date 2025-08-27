// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'domain_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DomainModel _$DomainModelFromJson(Map<String, dynamic> json) => DomainModel(
      name: json['name'] as String?,
      value: json['value'] as String?,
      isCheck: json['isCheck'] as bool? ?? false,
    );

Map<String, dynamic> _$DomainModelToJson(DomainModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'isCheck': instance.isCheck,
    };
