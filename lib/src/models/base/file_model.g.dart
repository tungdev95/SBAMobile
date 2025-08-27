// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      fileName: json['fileName'] as String?,
      fileDownloadUri: json['fileDownloadUri'] as String?,
      fileType: json['fileType'] as String?,
      size: json['size'] as int?,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'fileName': instance.fileName,
      'fileDownloadUri': instance.fileDownloadUri,
      'fileType': instance.fileType,
      'size': instance.size,
    };
