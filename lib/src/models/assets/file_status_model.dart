// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'file_status_model.g.dart';

@JsonSerializable()
class FileStatusModel {
  final int filesStatusId;
  final String filesStatus;

  FileStatusModel({
    required this.filesStatusId,
    required this.filesStatus,
  });

  factory FileStatusModel.fromJson(Map<String, dynamic> json) =>
      _$FileStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileStatusModelToJson(this);
}
