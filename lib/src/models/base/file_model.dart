import 'package:json_annotation/json_annotation.dart';
part 'file_model.g.dart';

@JsonSerializable()
class FileModel {
  String? fileName;
  String? fileDownloadUri;
  String? fileType;
  int? size;
  FileModel({
    this.fileName,
    this.fileDownloadUri,
    this.fileType,
    this.size,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
