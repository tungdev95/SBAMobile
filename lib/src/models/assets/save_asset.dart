// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'save_asset.g.dart';

@JsonSerializable()
class SaveAssetResponse {
  SaveAssetBody? body;
  SaveAssetResponse({
    required this.body,
  });

  factory SaveAssetResponse.fromJson(Map<String, dynamic> json) =>
      _$SaveAssetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SaveAssetResponseToJson(this);
}

@JsonSerializable()
class SaveAssetBody {
  int code;
  String message;
  SaveAssetBody({
    this.code = 200,
    this.message = '',
  });

  factory SaveAssetBody.fromJson(Map<String, dynamic> json) =>
      _$SaveAssetBodyFromJson(json);
  Map<String, dynamic> toJson() => _$SaveAssetBodyToJson(this);
}
