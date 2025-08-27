// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerModel _$CustomerModelFromJson(Map<String, dynamic> json) =>
    CustomerModel(
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      customerTypeId: json['customerTypeId'] as int?,
      customerType: json['customerType'] == null
          ? null
          : CustomerType.fromJson(json['customerType'] as Map<String, dynamic>),
      taxCode: json['taxCode'] as String?,
      personIdentification: json['personIdentification'] as String?,
      address: json['address'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      representator: json['representator'] as String?,
      position: json['position'] as String?,
      dateCreate: json['dateCreate'] == null
          ? null
          : DateTime.parse(json['dateCreate'] as String),
      dateModify: json['dateModify'] == null
          ? null
          : DateTime.parse(json['dateModify'] as String),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$CustomerModelToJson(CustomerModel instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerTypeId': instance.customerTypeId,
      'customerType': instance.customerType,
      'taxCode': instance.taxCode,
      'personIdentification': instance.personIdentification,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'representator': instance.representator,
      'position': instance.position,
      'dateCreate': instance.dateCreate?.toIso8601String(),
      'dateModify': instance.dateModify?.toIso8601String(),
      'status': instance.status,
    };

CustomerType _$CustomerTypeFromJson(Map<String, dynamic> json) => CustomerType(
      customerTypeId: json['customerTypeId'] as int?,
      customerTypeName: json['customerTypeName'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CustomerTypeToJson(CustomerType instance) =>
    <String, dynamic>{
      'customerTypeId': instance.customerTypeId,
      'customerTypeName': instance.customerTypeName,
      'description': instance.description,
    };
