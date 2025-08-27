// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'legal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LegalModel _$LegalModelFromJson(Map<String, dynamic> json) => LegalModel(
      assetId: json['assetId'] as String?,
      legalInformationTypeId: json['legalInformationTypeId'] as int?,
      legalInformationNumber: json['legalInformationNumber'] as String?,
      issueUnit: json['issueUnit'] as String?,
      issueDate: json['issueDate'] == null
          ? null
          : DateTime.parse(json['issueDate'] as String),
      owner: json['owner'] as String?,
      details: json['details'] as String?,
      legalDocumentType: json['legalDocumentType'] == null
          ? null
          : LegalInformationType.fromJson(
              json['legalDocumentType'] as Map<String, dynamic>),
      investor: json['investor'] as String?,
      orderBy: json['orderBy'] as int?,
    );

Map<String, dynamic> _$LegalModelToJson(LegalModel instance) =>
    <String, dynamic>{
      'assetId': instance.assetId,
      'legalInformationTypeId': instance.legalInformationTypeId,
      'legalInformationNumber': instance.legalInformationNumber,
      'issueUnit': instance.issueUnit,
      'issueDate': instance.issueDate?.toIso8601String(),
      'owner': instance.owner,
      'details': instance.details,
      'investor': instance.investor,
      'legalDocumentType': legalInfoToJson(instance.legalDocumentType),
      'orderBy': instance.orderBy,
    };

LegalInformationType _$LegalInformationTypeFromJson(
        Map<String, dynamic> json) =>
    LegalInformationType(
      legalDocumentTypeId: json['legalDocumentTypeId'] as int?,
      name: json['name'] as String?,
      assetLevelTwoId: json['assetLevelTwoId'] as int?,
    );

Map<String, dynamic> _$LegalInformationTypeToJson(
        LegalInformationType instance) =>
    <String, dynamic>{
      'legalDocumentTypeId': instance.legalDocumentTypeId,
      'name': instance.name,
      'assetLevelTwoId': instance.assetLevelTwoId,
    };
