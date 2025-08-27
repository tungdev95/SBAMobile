// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadModel _$FileUploadModelFromJson(Map<String, dynamic> json) =>
    FileUploadModel(
      iD: json['Id'] as String?,
      nameFile: json['nameFile'] as String?,
      link: json['link'] as String?,
      typeFile: json['typeFile'] as int?,
      minutesId: json['minutesId'] as String?,
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      deleted: json['deleted'] as bool?,
      active: json['active'] as bool?,
      sortOrder: json['sortOrder'] as int?,
      fileType: json['fileType'] as String?,
      fileTypeName: json['fileTypeName'] as String?,
      code: json['code'] as String?,
      groupName: json['groupName'] as String?,
    );

Map<String, dynamic> _$FileUploadModelToJson(FileUploadModel instance) =>
    <String, dynamic>{
      'nameFile': instance.nameFile,
      'link': instance.link,
      'typeFile': instance.typeFile,
      'minutesId': instance.minutesId,
      'created': instance.created,
      'updated': instance.updated,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'deleted': instance.deleted,
      'active': instance.active,
      'sortOrder': instance.sortOrder,
      'fileTypeName': instance.fileTypeName,
      'fileType': instance.fileType,
      'code': instance.code,
      'groupName': instance.groupName,
      'Id': instance.iD,
    };
