// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      title: json['title'] as String?,
      mediaType: json['mediaType'] as String?,
      appraisalFileId: json['appraisalFileId'] as String?,
      ecmId: json['ecmId'] as String?,
      type: $enumDecodeNullable(_$ImageTypeEnumMap, json['type'],
          unknownValue: ImageType.location),
      description: json['description'] as String?,
      filename: json['filename'] as String?,
      whoUpload: json['whoUpload'] as String?,
      dateUpload: json['dateUpload'] == null
          ? null
          : DateTime.parse(json['dateUpload'] as String),
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('title', instance.title);
  writeNotNull('filename', instance.filename);
  writeNotNull('appraisalFileId', instance.appraisalFileId);
  writeNotNull('ecmId', instance.ecmId);
  writeNotNull('description', instance.description);
  writeNotNull('type', _$ImageTypeEnumMap[instance.type]);
  writeNotNull('whoUpload', instance.whoUpload);
  writeNotNull('dateUpload', instance.dateUpload?.toIso8601String());
  writeNotNull('mediaType', instance.mediaType);
  return val;
}

const _$ImageTypeEnumMap = {
  ImageType.info: 2,
  ImageType.diagram: 5,
  ImageType.appendix: 1,
  ImageType.location: 3,
  ImageType.zoning: 4,
  ImageType.dinhVi: 8,
};
