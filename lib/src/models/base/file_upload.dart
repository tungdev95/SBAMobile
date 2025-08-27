import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';
part 'file_upload.g.dart';

@JsonSerializable()
class FileUploadModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  XFile? localFile;
  String? nameFile;
  String? link;
  int? typeFile;
  String? minutesId;
  String? created;
  String? updated;
  dynamic createdBy;
  dynamic updatedBy;
  bool? deleted;
  bool? active;
  int? sortOrder;
  String? fileTypeName;
  String? fileType;
  String? code;
  //Dùng cho MMTB, để biết ảnh thuộc mmtb nào
  String? groupName;
  @JsonKey(name: 'Id')
  String? iD;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Uint8List? base64Image;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? uploaded;

  ///Item đang hiện tại đang long click để đổi vị trí
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isItemActiveChangePosision;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isChangingPosition;

  FileUploadModel({
    this.iD,
    this.localFile,
    this.nameFile,
    this.link,
    this.typeFile,
    this.minutesId,
    this.created,
    this.updated,
    this.createdBy,
    this.updatedBy,
    this.deleted,
    this.active,
    this.sortOrder,
    this.fileType,
    this.fileTypeName,
    this.code,
    this.base64Image,
    this.uploaded,
    this.groupName,
    this.isItemActiveChangePosision,
    this.isChangingPosition,
  });

  FileUploadModel.initWithLocal(this.localFile);

  String? get name {
    //localFile?.name ?? nameFile;
    return nameFile;
  }

  factory FileUploadModel.fromJson(dynamic json) =>
      _$FileUploadModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileUploadModelToJson(this);

  bool? isUploaded() {
    return link != null || uploaded == true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FileUploadModel &&
        other.localFile == localFile &&
        other.nameFile == nameFile &&
        other.link == link &&
        other.typeFile == typeFile &&
        other.minutesId == minutesId &&
        other.created == created &&
        other.updated == updated &&
        other.createdBy == createdBy &&
        other.updatedBy == updatedBy &&
        other.deleted == deleted &&
        other.active == active &&
        other.sortOrder == sortOrder &&
        other.fileTypeName == fileTypeName &&
        other.fileType == fileType &&
        other.code == code &&
        other.groupName == groupName &&
        other.iD == iD &&
        other.base64Image == base64Image &&
        other.uploaded == uploaded &&
        other.isItemActiveChangePosision == isItemActiveChangePosision &&
        other.isChangingPosition == isChangingPosition;
  }

  @override
  int get hashCode {
    return localFile.hashCode ^
        nameFile.hashCode ^
        link.hashCode ^
        typeFile.hashCode ^
        minutesId.hashCode ^
        created.hashCode ^
        updated.hashCode ^
        createdBy.hashCode ^
        updatedBy.hashCode ^
        deleted.hashCode ^
        active.hashCode ^
        sortOrder.hashCode ^
        fileTypeName.hashCode ^
        fileType.hashCode ^
        code.hashCode ^
        groupName.hashCode;
  }
}
